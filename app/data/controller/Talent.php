<?php

namespace app\data\controller;

use think\admin\Controller;

/**
 * 达人管理
 * Class Talent
 * @package app\data\controller
 */
class Talent extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkTalent';

    /**
     * 达人管理
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '达人管理';
        $query = $this->_query($this->table);
        $query->equal('status,talent_appid,is_bind')->like('talent_nickname');
        $query->dateBetween('create_at')->order('id desc')->page();
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
     * 同步达人
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function update()
    {
        $this->_queue('同步达人', "talent syncTalent", 0, [], 1);
    }
    /**
     * 同步直播商品
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function upProduct()
    {
        $this->_queue('同步直播商品', "talent syncLiveProduct", 0, [], 1);
    }


    /**
     * 同步直播和预约直播内容
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function live()
    {
        $this->_queue('同步直播和预约直播', "talent syncLive", 0, [], 1);
    }

    /**
     * 同步短视频
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function feed()
    {
        $this->_queue('同步短视频', "talent syncFeed", 0, [], 1);
    }
    /**
     * 直播商品查看
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function product()
    {
        $this->title = '直播商品查看';
        $map = $this->_vali(['id.require' => 'ID不能为空！']);
        $id = $map['id'] ?? 0;
        $query = $this->_query('TkLiveProduct');
        $query->where(['status' => 1, 'talent_appid' => $id])
            ->order('id desc')
            ->page();
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
     * 后台备注
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function remark()
    {
        $this->title = '添加备注';
        $data = $this->_vali([
            'id.require'   => 'id不能为空！'
        ]);
        if ($this->request->isGet()) {
            $order = $this->app->db->name($this->table)->where('id', $data['id'])->find();
            $this->order = $order;
            $this->_form($this->table);
        } else {
            $order = $this->app->db->name($this->table)->where(['id' => $data['id']])->find();
            if (!$order) {
                $this->error('数据错误，请返回');
            }
            $update['memo'] = input('remark', '');
            $this->app->db->name($this->table)->where(['id' => $data['id']])->update($update);
            $this->success('操作成功！');
        }
    }
    /**
     * 直播文案
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function share()
    {
        $this->title = '添加直播文案';
        $data = $this->_vali([
            'id.require'   => 'id不能为空！'
        ]);
        if ($this->request->isGet()) {
            $order = $this->app->db->name($this->table)->where('id', $data['id'])->find();
            $this->order = $order;
            $this->_form($this->table);
        } else {
            $order = $this->app->db->name($this->table)->where(['id' => $data['id']])->find();
            if (!$order) {
                $this->error('数据错误，请返回');
            }
            $update['share_text'] = input('share', '');
            $this->app->db->name($this->table)->where(['id' => $data['id']])->update($update);
            $this->success('操作成功！');
        }
    }
}
