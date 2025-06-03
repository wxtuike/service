<?php

namespace app\index\controller;

use app\index\service\UserService;

class User extends Base
{
    protected $middleware = [
        'check', //验证签名
        'auth'
    ];

    /**
     * 个人中心
     */
    public function index()
    {
        $user = UserService::instance()->my($this->userId);
        success($user);
    }

    public function bindtk()
    {
        $data = UserService::instance()->bindtk($this->userId);
        success($data);
    }

    /**
     * 资金
     */
    public function commissionInfo()
    {
        $data = UserService::instance()->commissionInfo($this->userId);
        success($data);
    }

    /**
     * 资金列表
     */
    public function commissionList()
    {
        $type = input('type', 0);
        $data = UserService::instance()->commissionList($this->userId, $type);
        success($data);
    }

    /**
     * 粉丝列表
     */
    public function fansList()
    {
        $data = UserService::instance()->fansList($this->userId);
        success($data);
    }

    public function fans()
    {
        $data = UserService::instance()->fans($this->userId);
        success($data);
    }

    public function card()
    {
        $data = UserService::instance()->card($this->userId);
        success($data);
    }

    /** 我的上级及顾问 */
    public function share()
    {
        $data = UserService::instance()->share($this->userId);
        success($data);
    }
}
