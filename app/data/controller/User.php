<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 用户管理
 * Class User
 * @package app\data\controller
 */
class User extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkUser';

    /**
     * 会员列表
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '会员列表';
        $query = $this->_query($this->table);
        $query->equal('code,mobile,role_id')->like('nickname');
        $query->dateBetween('create_at')->order('id desc')->page();
    }
}
