<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 商品管理
 * Class Goods
 * @package app\data\controller
 */
class Goods extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkGoods';

    /**
     * 商品列表
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '商品列表';
        $query = $this->_query($this->table);
        $query->equal('product_id,shop_appid,status,plan_type')->like('title');
        $query->dateBetween('create_at')->order('id desc')->page();
    }

    /**
     * 修改状态
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function state()
    {
        $this->_save($this->table, $this->_vali([
            'status.in:0,1'  => '状态值范围异常！',
            'status.require' => '状态值不能为空！',
        ]));
    }

    /**
     * 同步商品
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function sync()
    {
        $this->_queue('同步商品', "goods syncAllGoods", 0, [], 1);
    }

    /**
     * 同步订单
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function syncOrder()
    {
        $this->_queue('同步订单', "goods syncOrders", 0, [], 1);
    }
}
