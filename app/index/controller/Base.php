<?php

namespace app\index\controller;

use think\App;
use think\facade\Db;
use think\facade\Cookie;
use think\facade\Request;
use think\admin\helper\ValidateHelper;
use app\common\Db\RedisDb;
use app\common\code\RedisCode;

/**
 * 接口基类
 * Class Base
 * @package app\index\controller
 */
abstract class Base extends \stdClass
{
    /**
     * 应用容器
     * @var App
     */
    public $app;

    /**
     * 请求参数对象
     * @var Request
     */
    public $request;

    /**
     * 当前用户编号
     * @var integer
     */
    protected $userId;

    /**
     * 访问的客户端类型
     * @var integer
     */
    protected $clientType = 1;

    public function __construct(App $app)
    {
        $this->app = $app;
        $this->request = $this->app->request;
        $this->initialize();
    }

    /**
     * 控制器初始化
     */
    protected function initialize()
    {
        $this->getClientType();
        $this->userId = $this->getUserId();
        $this->request->user_id = $this->userId;
    }

    private function getClientType()
    {
        $client = $this->request->header('Client-Type', 'weapp');
        $clientArr = [
            'h5', //h5
            'weapp', //小程序
        ];
        $client = strtolower($client); //转小写
        $this->clientType = in_array($client, $clientArr) ? $client : 'h5'; //默认h5
        return $this->clientType;
    }

    private function getUserId()
    {
        $token = input('Authorization') ?: $this->request->header('Authorization');
        $token = empty($token) ? Cookie::get('Authorization', '') : $token;
        if (empty($token)) {
            return 0;
        }
        $userId = $this->getIdByToken($token);
        if ($userId !== false) {
            return intval($userId);
        }
        return 0;
    }

    /**
     * 快捷输入并验证（ 支持 规则 # 别名 ）
     * @param array $rules 验证规则（ 验证信息数组 ）
     * @param string|array $type 输入方式 ( post. 或 get. )
     * @param callable|null $callable 异常处理操作
     * @return array
     */
    protected function _vali(array $rules, $type = '', ?callable $callable = null): array
    {
        return ValidateHelper::instance()->init($rules, $type, $callable);
    }

    /**
     * 返回视图内容
     * @param string $tpl 模板名称
     * @param array $vars 模板变量
     * @param null|string $node 授权节点
     */
    public function fetch(string $tpl = '', array $vars = [], ?string $node = null): void
    {
        foreach ($this as $name => $value) {
            $vars[$name] = $value;
        }
        throw new \think\exception\HttpResponseException(view($tpl, $vars));
    }

    /**
     * 根据token获取用户id
     */
    private function getIdByToken($token)
    {
        $table = 'tk_user_token';
        $redisObj = RedisDb::getInstance()->setPrefix(RedisCode::USER_TOKEN_PREFIX);
        $userId = $redisObj->get($token);
        if ($userId === false) {
            $userId = Db::table($table)->where('token', $token)->value('user_id');
            if (empty($userId)) {
                return false;
            }
            $userId = Db::name('TkUser')->where(['id' => $userId])->value('id');
            if (empty($userId)) {
                return false;
            }
            $redisObj->add($token, $userId, RedisCode::USER_TOKEN_EXPIRE);
        }
        return $userId;
    }

    /**
     * 是否绑定推客
     *
     * @return boolean
     */
    public function isBindTk()
    {
        $userId = $this->userId;
        if (empty($userId)) {
            return -1;
        }
        $user = Db::name('TkUser')->field('mobile,sharer_appid')->where(['id' => $this->userId])->find();
        $mobile = $user['mobile'] ?? '';
        $sharer_appid = $user['sharer_appid'] ?? '';
        if (empty($mobile)) {
            return -1;
        }
        if (empty($sharer_appid)) {
            return 0;
        }
        return 1;
    }
}
