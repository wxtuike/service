<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 优惠券管理
 * Class Coupon
 * @package app\data\controller
 */
class Coupon extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkCoupon';

    /**
     * 优惠券列表
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '优惠券列表';
        $query = $this->_query($this->table);
        $query->equal('shop_appid')->like('product_ids');
        $query->order('create_time desc,id desc')->page();
    }

    /**
     * 全量更新优惠券
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function coupon()
    {
        $this->_queue('同步所有优惠券', "store syncCoupon", 0, [], 1);
    }
}
