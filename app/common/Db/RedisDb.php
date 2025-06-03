<?php

namespace app\common\Db;

use Redis;

/**
 * Redis操作类
 */
class RedisDb
{
    public static $instancesMap;

    private $host = '';

    private $port = '';

    private $timeOut = 0;

    private $dbName = '';

    //连接类型 1普通连接 2长连接
    private $cType = '';

    /**
     * @var static \Redis
     */
    public $redisLink = null;

    private $transcation = null;

    private $password = '';

    protected $prefix = '';

    public function __construct($opt = 'redis')
    {
        $this->host = config('redis.host');
        $this->port = config('redis.port');
        $this->timeOut = 1;
        $this->cType = config('redis.type');
        $this->password = config('redis.password');

        if (!isset($this->redisLink)) {
            $this->redisLink = new \Redis();
            $this->connect($this->host, $this->port, $this->timeOut, $this->cType);
        }
    }

    protected function connect($host, $port, $timeOut, $type)
    {
        switch ($type) {
            case 1:
                $this->redisLink->connect($host, $port, $timeOut);
                break;
            case 2:
                $this->redisLink->pconnect($host, $port, $timeOut);
                break;
            default:
                $this->redisLink->connect($host, $port, $timeOut);
                break;
        }
        if (!empty($this->password)) {
            $this->redisLink->auth($this->password);
        }
    }

    /**
     * @param string $opt
     * @return RedisDb;
     */
    public static function getInstance($opt = 'redis')
    {
        if (!isset(self::$instancesMap[$opt])) {
            self::$instancesMap[$opt] = new self($opt);
        }
        self::$instancesMap[$opt]->prefix = '';
        return self::$instancesMap[$opt];
    }

    /**
     * 设置key前缀
     * @param $prefix
     * @return $this
     */
    public function setPrefix($prefix)
    {
        $this->prefix = $prefix;
        return $this;
    }

    /**
     * 新增键值（键名不存在才会成功添加，可用于获取锁）
     * @param $key
     * @param $value
     * @param int $expire
     * @return bool
     */
    public function add($key, $value, $expire = 5)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->set($key, $value, ['nx', 'ex' => $expire]);
    }

    /**
     * 写入key-value
     * @param $key string 要存储的key名
     * @param $value mixed 要存储的值
     * @param $time int  过期时间(S)
     * @param $type int 写入方式 0:不添加到现有值后面 1:添加到现有值的后面 默认0
     * @param $repeat int 0:不判断重复 1:判断重复
     * @param $old int 返回旧的value 默认0
     * @return bool|int|null|string
     */
    public function set($key, $value, $time = 0, $type = 0, $repeat = 0, $old = 0)
    {
        $key = $this->prefix . $key;
        $return = null;
        if ($type) {
            $return = $this->redisLink->append($key, $value);
        } else {
            if ($old) {
                $return = $this->redisLink->getSet($key, $value);
            } else {
                if ($repeat) {
                    $return = $this->redisLink->setnx($key, $value);
                } else {
                    if ($time && is_numeric($time)) {
                        $return = $this->redisLink->setex($key, $time, $value);
                    } else {
                        $return = $this->redisLink->set($key, $value);
                    }
                }
            }
        }
        return $return;
    }

    /**
     * 获取某个key值 如果指定了start end 则返回key值的start跟end之间的字符
     * @param string|array $key 要获取的key或者key数组
     * @param int $start 开始index
     * @param int $end 结束index
     * @return array|bool|null|string
     */
    public function get($key = null, $start = null, $end = null)
    {
        $key = $this->prefix . $key;
        $return = null;

        if (is_array($key) && !empty($key)) {
            $return = $this->redisLink->getMultiple($key);
        } else {
            if (isset($start) && isset($end)) {
                $return = $this->redisLink->getRange($key);
            } else {
                $return = $this->redisLink->get($key);
            }
        }
        return $return;
    }
    //===========加锁解锁========

    /**
     * 获取锁
     * @param String $key 锁标识
     * @param Int $expire 锁过期时间
     * @return Boolean
     */
    public function mylock($key, $expire = 5)
    {
        $is_lock = $this->redisLink->setnx($key, time() + $expire);

        // 不能获取锁
        if (!$is_lock) {

            // 判断锁是否过期
            $lock_time = $this->redisLink->get($key);

            // 锁已过期，删除锁，重新获取
            if (time() > $lock_time) {
                $this->unmylock($key);
                $is_lock = $this->redisLink->setnx($key, time() + $expire);
            }
        }
        $is_lock && $this->redisLink->expire($key, $expire);
        return $is_lock ? true : false;
    }

    /**
     * 释放锁
     * @param String $key 锁标识
     * @return Boolean
     */
    public function unmylock($key)
    {
        return $this->redisLink->del($key);
    }


    //========================

    /**
     * 适用高并发情况下的获取，在到期前只有一个请求独占方式更新数据
     * #### 实际过期时间为参数值的2倍，中间加有时间锁更新
     * @param $key
     * @param null $fun
     * @param int $expire 更新频率
     * @param int $lockExpire 更新锁时间
     * @param array $out 引用变量
     * @return mixed|boolean
     */
    public function getByLock($key, $fun = null, $expire = 0, $lockExpire = 5, &$out = null)
    {
        $cacheData = $this->get($key);
        $expire = max($expire, 0);
        $realExpire = $expire > 0 ? $expire * 2 : 0;
        $checkTime = $expire > 0 ? $expire : 86400; //永不过期，则默认1天更新一次
        $prefix = $this->prefix;
        $useCache = true;

        if ($cacheData === false) {
            if ($fun !== null) {
                $useCache = false;
                //设置锁
                $keyLock = $key . '_lock';
                $addOk = $this->add($keyLock, mt_rand(0, 1000), $lockExpire);
                if ($addOk === true) { //锁获取成功，允许设置
                    $data = call_user_func($fun, $key);
                    $this->setPrefix($prefix); //回调后重置前缀，避免回调中使用redis覆盖
                    $cacheData = ['set_time' => TIMESTAMP, 'data' => $data];
                    $this->set($key, json_encode($cacheData), $realExpire);
                    $this->delete($keyLock);
                }
            }
        } else {
            $cacheData = json_decode($cacheData, true);
            //检查是否需要更新
            $lastSetTime = $cacheData['set_time'];
            if ($lastSetTime !== false && TIMESTAMP - $lastSetTime > $checkTime) {
                //设置更新锁
                $keyLock = $key . '_lock';
                $addOk = $this->add($keyLock, mt_rand(0, 1000), $lockExpire);
                if ($addOk === true) { //锁获取成功，允许更新
                    $useCache = false;
                    $data = call_user_func($fun, $key);
                    $this->setPrefix($prefix); //回调后重置前缀，避免回调中使用redis覆盖
                    $cacheData = ['set_time' => TIMESTAMP, 'data' => $data];
                    $this->set($key, json_encode($cacheData), $realExpire);
                    $this->delete($keyLock);
                }
            }
        }
        if ($out !== null) {
            $out = array('is_use_cache' => $useCache);
        }

        return isset($cacheData['data']) ? $cacheData['data'] : false;
    }

    /**
     * 移除key
     * @param $key
     * @return bool
     */
    public function delete($key)
    {
        $key = $this->prefix . $key;
        $return = $this->redisLink->del($key);
        return $return;
    }

    public function del($key)
    {
        $key = $this->prefix . $key;
        $return = $this->redisLink->del($key);
        return $return;
    }

    /**
     * 判断key是否存在
     * @param $key
     * @return bool
     */
    public function exists($key)
    {
        $key = $this->prefix . $key;
        $return = $this->redisLink->exists($key);
        return $return;
    }

    /**
     * 同时将多个 field-value (字段-值)对设置到哈希表中
     * @param $hashKey String hash键名
     * @param $values array 值的数组
     * @return bool
     */
    public function hmset($hashKey, $values)
    {
        $key = $this->prefix . $hashKey;
        return $this->redisLink->hmset($key, $values);
    }

    /**
     *返回哈希表中，一个或多个给定字段的值
     * @param $mainKey String hash键名
     * @param $subKeyArr array key字段数组
     * @return array
     */
    public function hmget($mainKey, $subKeyArr)
    {
        $key = $this->prefix . $mainKey;
        return $this->redisLink->hmget($key, $subKeyArr);
    }

    /**
     * Increments the value of a member from a hash by a given amount.
     * @param $key
     * @param $hashKey
     * @param $value
     * @return int
     */
    public function hIncrBy($key, $hashKey, $value)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->hIncrBy($key, $hashKey, $value);
    }

    /**
     * 返回哈希表中，所有的字段和值
     * @param $mainKey String hash键名
     * @return array
     */
    public function hgetall($mainKey)
    {
        $key = $this->prefix . $mainKey;
        return $this->redisLink->hgetall($key);
    }

    /**
     * 增加map
     * @param $mainKey string
     * @param $subKey string 子key
     * @param $value string 子值
     * @return int
     */
    public function incMapValue($mainKey, $subKey, $value)
    {
        $key = $this->prefix . $mainKey;
        return $this->redisLink->hIncrBy($key, $subKey, $value);
    }

    /**
     * 删除map成员数据
     * @param $key
     * @param $memberKeyArr
     * @return mixed
     */
    public function hDels($key, $memberKeyArr)
    {
        $key = $this->prefix . $key;
        $paramArr = array_merge([$key], $memberKeyArr);
        return call_user_func_array([$this->redisLink, 'hDel'], $paramArr);
    }

    /**
     * 遍历hash类型数据
     * @param $key
     * @param $perNum
     * @param $callFun
     */
    public function hScan($key, $perNum, $callFun)
    {
        $key = $this->prefix . $key;
        $it = null;
        /* Don't ever return an empty array until we're done iterating */
        $this->redisLink->setOption(Redis::OPT_SCAN, Redis::SCAN_RETRY);
        while ($arrKeys = $this->redisLink->hScan($key, $it, '', $perNum)) {
            foreach ($arrKeys as $strField => $strValue) {
                call_user_func_array($callFun, [$strField, $strValue]);
            }
        }
    }

    /**
     * 设置过期时间
     * @param $key
     * @param $expire int 秒数
     */
    public function setExpire($key, $expire)
    {
        $key = $this->prefix . $key;
        $this->redisLink->expire($key, $expire);
    }

    /**
     * 给有序集合中的member元素增加$value，成功则返回影响后的value；
     * 默认都会成功，除非redis连接问题
     * @param $key String
     * @param $value float 大于0，增加；小于0，减少
     * @param $member
     * @return float
     */
    public function incZScore($key, $value, $member)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zIncrBy($key, $value, $member);
    }

    /**
     * 设置有序集合
     * @param $key
     * @param $value
     * @param $member
     * @return int 之前不存在，返回1；之前存在，返回0
     */
    public function setZScore($key, $value, $member)
    {
        return $this->redisLink->zAdd($key, $value, $member);
    }

    /**
     * 返回有序集合中的member元素的value，没有设置返回false
     * @param $key
     * @param $member
     * @return float|false
     */
    public function getZScore($key, $member)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zScore($key, $member);
    }

    /**
     * 根据下标获取有序集合数据
     * @param $key
     * @param $start
     * @param $end
     * @param bool $withScores
     * @return array
     */
    public function getZSet($key, $start, $end, $withScores = false)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zRange($key, $start, $end, $withScores);
    }

    /**
     * 根据下标移除有序集合数据
     * @param $key
     * @param $start
     * @param $end
     * @return int
     */
    public function removeZSet($key, $start, $end)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zRemRangeByRank($key, $start, $end);
    }

    /**
     * 获取集合下面元素数量
     * @param $key
     * @return int
     */
    public function zCard($key)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zCard($key);
    }

    /**
     * 获取hash值
     * @param $key
     * @param $field
     * @return string
     */
    public function hGet($key, $field)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->hGet($key, $field);
    }

    public function hSet($key, $hashKey, $value)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->hSet($key, $hashKey, $value);
    }

    /**
     * 获取set型 集合下面的元素个数
     * @param $key
     * @return int
     */
    public function sCard($key)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->sCard($key);
    }

    /**
     * 有序集合 取区间
     * @param $key
     * @param $start
     * @param $end
     * @return array
     *
     */
    public function zRange($key, $start, $end)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zRange($key, $start, $end, $withscores = null);
    }

    public function zRevRange($key, $start, $end, $withscore = null)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zRevRange($key, $start, $end, $withscore);
    }

    /**
     * 有序集合并集
     * @param $Output
     * @param $ZSetKeys
     * @param array|null $Weights
     * @param string $aggregateFunction
     * @return int
     */
    public function zUnion($Output, $ZSetKeys, array $Weights = null, $aggregateFunction = 'SUM')
    {
        return $this->redisLink->zUnion($Output, $ZSetKeys, $Weights, $aggregateFunction);
    }

    public function zRemRangeByScore($key, $start, $end)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zRemRangeByScore($key, $start, $end);
    }

    public function zRem($key, $value)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zRem($key, $value);
    }

    public function incr($key)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->incr($key);
    }

    public function incrBy($key, $val)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->incrBy($key, $val);
    }

    public function decr($key)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->decr($key);
    }

    public function decrBy($key, $val)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->decrBy($key, $val);
    }

    public function pipeLine()
    {
        return $this->redisLink->multi(Redis::PIPELINE);
    }

    public function multi()
    {
        return $this->redisLink->multi();
    }

    public function exec()
    {
        return $this->redisLink->exec();
    }

    public function zRank($key, $member)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->zRank($key, $member);
    }

    /**
     * 将一个元素加入到集合 key 当中
     */
    public function sadd($key, $value)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->sAdd($key, $value);
    }

    /**
     * 移除并返回集合中的一个随机元素
     */
    public function spop($key)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->sPop($key);
    }


    /**
     * 左进
     * @param $key
     * @param $value
     * @return bool|int
     */
    public function lPush($key, $value)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->lPush($key, $value);
    }

    /**
     * 获取队列长度
     */
    public function lLen($key)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->lLen($key);
    }

    /**
     * 通过索引获取列表中的元素
     */
    public function lindex($key, $index)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->lindex($key, $index);
    }

    /**
     * 通过索引来设置元素的值
     */
    public function lSet($key, $index, $value)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->lSet($key, $index, $value);
    }

    /**
     * 右出
     * @param $key
     * @return string
     */
    public function rPop($key)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->rPop($key);
    }

    public function pttl($key)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->pttl($key);
    }

    public function lPop($key)
    {
        $key = $this->prefix . $key;
        return $this->redisLink->lPop($key);
    }
}
