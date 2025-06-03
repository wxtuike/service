<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 海报图管理
 * Class Card
 * @package app\data\controller\car
 */
class Card extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkCard';

    /**
     * 海报图管理
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '海报图列表';
        $query = $this->_query($this->table);
        $query->order('id desc')->page();
    }

    /**
     * 添加海报图
     * @auth true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function add()
    {
        $this->title = '添加海报图';
        $this->_form($this->table, 'form');
    }

    /**
     * 删除海报图
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function remove()
    {
        $this->_delete($this->table);
    }
}
