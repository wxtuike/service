<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 首页轮播管理
 * Class Banner
 * @package app\data\controller\car
 */
class Banner extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkBanner';

    /**
     * 轮播图管理
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '轮播图管理';
        $query = $this->_query($this->table);
        $query->order('sort desc,id desc')->page();
    }

    /**
     * 添加轮播图
     * @auth true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function add()
    {
        $this->title = '添加轮播图';
        $this->_form($this->table, 'form');
    }

    /**
     * 删除轮播图
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function remove()
    {
        $this->_delete($this->table);
    }
}
