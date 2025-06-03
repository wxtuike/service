<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 订单管理
 * Class Order
 * @package app\data\controller
 */
class Order extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkOrder';

    /**
     * 订单列表
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '订单列表';
        $query = $this->_query($this->table);
        // 列表选项卡
        if (is_numeric($this->type = trim(input('type', 'ta'), 't'))) {
            if ($this->type != 'a') {
                $query->where(['status' => $this->type]);
            }
        }
        $query->equal('order_id,sku_id,product_id,shop_app_id,user_id')->like('product_title,talent_nickname');
        $query->dateBetween('create_time')->order('id desc')->page();
    }
}
