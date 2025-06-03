<?php

namespace app\data\controller;

use app\data\model\TkFeed;
use think\admin\Controller;
use app\common\service\ApiService;

/**
 * 达人短视频管理
 * Class Feed
 * @package app\data\controller
 */
class Feed extends Controller
{
    /**
     * 绑定数据表
     * @var string
     */
    private $table = 'TkFeed';

    /**
     * 达人短视频列表
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        $this->title = '达人短视频列表';
        $query = TkFeed::mQuery();
        $query->with(['bindTalents']);
        $query->equal('status,talent_appid')->like('product_name');
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
     * 同步短视频
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
        $res = ApiService::feedList($appid);
        $list = $res['feed_list'] ?? [];
        foreach ($list as $item) {
            $id = $item['export_id'];
            $row = $this->app->db->name('TkFeed')->where(['export_id' => $id])->find();
            if (!$row) {
                $d = [
                    'talent_appid' => $appid,
                    'export_id'    => $id,
                    'commission_amount' => $item['predict_commission_amount'],
                    'product_info' => json_encode($item['product_info']),
                    'product_id' => $item['product_info']['product_id'] ?? 0,
                    'product_name' => $item['product_info']['product_name'] ?? '',
                    'product_img_url' => $item['product_info']['product_img_url'] ?? '',
                    'product_mini_price' => $item['product_info']['product_mini_price'] ?? 0,
                ];
                $count++;
                $this->app->db->name('TkFeed')->insert($d);
            }
        }
        $this->success('执行成功！新增' . $count . '条');
    }
}
