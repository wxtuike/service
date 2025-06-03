<?php

namespace app\index\controller;

use app\index\service\OrderService;

class Order extends Base
{
    protected $middleware = [
        'check', //验证签名
        'auth'
    ];

    /** 我的订单列表 */
    public function list()
    {
        $status = input('status', 0);
        $list = OrderService::instance()->list($this->userId, $status);
        success($list);
    }
}
