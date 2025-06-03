<?php

namespace app\data\controller;

use app\data\model\TkLive;
use think\admin\Controller;
use app\common\service\ApiService;

/**
 * 达人直播管理
 * Class Live
 * @package app\data\controller
 */
class Live extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkLive';

    /**
     * 直播列表
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '直播列表';
        $query = TkLive::mQuery();
        $query->with(['bindTalents']);
        $query->equal('type,live_status,status,talent_appid')->like('description');
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
     * 直播商品
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function goods()
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
     * 同步直播
     * @auth true
     * @throws \think\db\exception\DbException
     */
    public function update()
    {
        $appid = input('talent_appid', '');
        if (empty($appid)) {
            $this->error('请选择达人');
        }
        $count = 0;
        //直播内容
        $res = ApiService::liveList($appid);
        $list = $res['live_record_list'] ?? [];
        $ids = [];
        foreach ($list as $item) {
            $id = $item['export_id'];
            $row = $this->app->db->name('TkLive')->where(['live_id' => $id, 'talent_appid' => $appid, 'type' => 1])->find();
            if (!$row) {
                $d = [
                    'talent_appid' => $appid,
                    'live_id' => $id,
                    'type' => 1,
                    'description' => $item['description'],
                    'promoter_share_link' => $item['promoter_share_link'],
                    'live_status' => 1
                ];
                $ids[] = $id;
                $count++;
                $this->app->db->name('TkLive')->insert($d);
            }
        }
        if (count($ids) > 0) {
            $this->app->db->name('TkLive')
                ->where(['talent_appid' => $appid, 'type' => 1])
                ->whereNotIn('live_id', $ids)
                ->update(['live_status' => 0]);
        }
        //预约直播
        $res = ApiService::liveNoticeList($appid);
        $list = $res['live_notice_record_list'] ?? [];
        $ids = [];
        foreach ($list as $item) {
            $id = $item['notice_id'];
            $row = $this->app->db->name('TkLive')->where(['live_id' => $id, 'talent_appid' => $appid, 'type' => 0])->find();
            if (!$row) {
                $d = [
                    'talent_appid' => $appid,
                    'live_id' => $id,
                    'type' => 0,
                    'description' => $item['description'],
                    'start_time' => $item['start_time'],
                    'live_status' => 1
                ];
                $count++;
                $this->app->db->name('TkLive')->insert($d);
            }
        }
        if (count($ids) > 0) {
            $this->app->db->name('TkLive')
                ->where(['talent_appid' => $appid, 'type' => 0])
                ->whereNotIn('live_id', $ids)
                ->update(['live_status' => 0]);
        }
        $this->success('执行成功！新增' . $count . '条');
    }
}
