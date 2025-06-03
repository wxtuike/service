<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 联系我们
 * Class Contact
 * @package app\data\controller\car
 */
class Contact extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkContact';

    /**
     * 联系我们管理
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '联系我们管理';
        $query = $this->_query($this->table);
        $query->order('id ASC')->page();
    }
    /**
     * 列表数据处理
     * @param array $data
     */
    protected function _index_page_filter(array &$data)
    {
        foreach ($data as &$vo) {
            $vo['imgs'] = explode('|', $vo['imgs']);
        }
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
     * 编辑
     * @auth true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function edit()
    {
        $this->title = '编辑';
        $this->_form($this->table, 'form');
    }

    /**
     * 删除
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function remove()
    {
        $this->_delete($this->table);
    }
}
