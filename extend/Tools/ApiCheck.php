<?php

namespace Tools;

/**
 * 接口验证
 */
class ApiCheck
{
    protected $app_secret = 'tk-20250510';
    const DIST = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';

    function __construct($secret = '')
    {
        if (!empty($secret)) {
            $this->app_secret = $secret;
        }
    }

    /**
     * 获取实例
     * @param string $secret
     * @return ApiAuth
     */
    public static function getInstance($secret = '')
    {
        return new self($secret);
    }

    /**
     * 验证签名
     *
     * @param array $params 请求参数数组，数组中必须有noncestr,timestamp,sign三个参数
     * @param string $msg 错误信息
     * @return boolean 验证结果
     */
    public function verifySign($params, &$msg)
    {
        $noncestr  = $params['noncestr'] ?? '';
        $checkSign = $params['sign'] ?? '';
        $timestamp = $params['timestamp'] ?? 0;
        if (empty($checkSign)) {
            $msg = '签名sign不能为空';
            return false;
        }
        if (empty($timestamp)) {
            $msg = '签名时间戳不能为空';
            return false;
        }
        if (empty($noncestr)) {
            $msg = '签名随机数不能为空';
            return false;
        }
        unset($params['sign']);
        $sign = $this->getSign($params);
        if ($sign !== $checkSign) {
            $msg = '签名错误';
            return false;
        }
        return true;
    }

    /**
     * 获取用户id
     *
     * @param string $token
     * @return integer userId
     */
    public static function getUserIdByToken($token)
    {
        if (!ctype_alnum($token)) { //只有字母和数字
            return false;
        }
        if (strlen($token) < 11) { //长度要大于10
            return false;
        }
        return self::from62(substr($token, 4, -6));
    }

    /**
     * 获取用户token
     *
     * @param integer $userId
     * @return string token
     */
    public static function getToken(int $userId)
    {
        return md5('tk' . $userId . TIMESTAMP);
    }

    /**
     * 生成签名
     *
     * @param array $params 参数
     * @return string 签名
     */
    public function getSign($params)
    {
        // 对数组的值按key排序
        ksort($params);
        // 生成url的形式
        // $params = http_build_query($params);
        $kvList = [];
        foreach ($params as $key => $val) {
            $kvList[] = $key . '=' . $val;
        }
        $params = implode('&', $kvList);
        // 生成sign
        $sign = md5(sprintf('%s%s', $params, $this->app_secret));
        return $sign;
    }

    private static function to62($num)
    {
        $to = 62;
        $ret = '';
        do {
            $ret = self::DIST[bcmod($num, $to)] . $ret; //bcmod取得高精确度数字的余数。
            $num = bcdiv($num, $to);  //bcdiv将二个高精确度数字相除。
        } while ($num > 0);
        return $ret;
    }

    private static function from62($num)
    {
        $from = 62;
        $num = strval($num);
        $len = strlen($num);
        $dec = 0;
        for ($i = 0; $i < $len; $i++) {
            $pos = strpos(self::DIST, $num[$i]);
            $dec = bcadd(bcmul(bcpow($from, $len - $i - 1), $pos), $dec);
        }
        return $dec;
    }
}
