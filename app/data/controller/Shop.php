<?php

namespace app\data\controller;

use app\data\model\TkFeed;
use think\admin\Controller;
use app\common\service\ApiService;

/**
 * 小店管理
 * Class Shop
 * @package app\data\controller
 */
class Shop extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkShop';

    /**
     * 小店列表
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '小店列表';
        $query = $this->_query($this->table);
        $query->equal('status,appid')->like('nickname');
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
     * 全量更新店铺
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function update()
    {
        $this->_queue('同步合作小店', "goods syncShop", 0, [], 1);
    }
}
