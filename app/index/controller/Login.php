<?php

namespace app\index\controller;

use app\index\service\UserService;
use app\index\service\WeappService;

class Login extends Base
{
    protected $middleware = [
        'check', //验证签名
        'auth' => ['except' => ['index', 'contact']], //验证登录,不包含数组里面的方法
    ];

    /**
     * 联系我们
     *
     * @return void
     */
    public function contact()
    {
        $data = UserService::instance()->getContact();
        success($data);
    }
    public function team()
    {
        $team = UserService::instance()->getTeam($this->userId);
        success($team);
    }
    /**
     * 登录
     */
    public function index()
    {
        $code = input('code', '');
        $mid = input('mid', '');
        if (empty($code)) {
            fail('code不能为空！');
        }
        $openid = WeappService::instance()->getOpenid($code);
        if (empty($openid)) {
            fail("未获取到用户信息1！");
        }
        $res = UserService::instance()->login($openid, $mid);
        success($res);
    }

    /**
     * 绑定上级
     */
    public function bind()
    {
        $uid = input('uid', '');
        if (empty($uid)) {
            fail('uid不能为空！');
        }
        $tid = UserService::instance()->bind($this->userId, $uid);
        success(['tid' => $tid]);
    }

    /**
     * 获取手机号
     */
    public function mobile()
    {
        $code = input('code', '');
        if (empty($code)) {
            fail('code不能为空！');
        }
        UserService::instance()->bindMobile($this->userId, $code);
        success();
    }
}
