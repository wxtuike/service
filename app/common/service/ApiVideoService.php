<?php

declare(strict_types=1);

namespace app\common\service;

use think\admin\Service;
use think\facade\Db;

class ApiVideoService extends Service
{
    /** 同步所有达人 */
    public function syncTalent()
    {
        $list = ApiService::allTalentList();
        $count = $insert = $update = 0;
        if (count($list) > 0) {
            $ids = [];
            foreach ($list as $item) {
                $count++;
                $appid = $item['talent_appid'];
                $data = [
                    'talent_appid' => $item['talent_appid'],
                    'bind_time' => $item['bind_time'],
                    'talent_nickname' => $item['talent_nickname'],
                    'talent_head_img' => $item['talent_head_img'],
                ];
                $exportname = $item['related_finder_exportname_list'] ?? '';
                if (!empty($exportname)) {
                    $data['related_finder_exportname_list'] = json_encode($exportname);
                }
                $mpbiz = $item['related_mp_biz_appid_list'] ?? '';
                if (!empty($exportname)) {
                    $data['related_mp_biz_appid_list'] = json_encode($mpbiz);
                }
                $ids[] = $appid;
                $row = Db::name('TkTalent')->where(['talent_appid' => $appid])->find();
                if (!$row) {
                    $insert++;
                    Db::name('TkTalent')->insert($data);
                } else {
                    Db::name('TkTalent')->where(['talent_appid' => $appid])->update($data);
                }
            }
            if (count($ids) > 0) {
                $update = $this->app->db->name('TkTalent')
                    ->whereNotIn('talent_appid', $ids)
                    ->where('is_shop', 0)
                    ->update(['is_bind' => 0, 'status' => 0]);
            }
        }
        return ['count' => $count, 'insert' => $insert, 'update' => $update];
    }
    /**
     * 同步所有短视频
     */
    public function syncVideo()
    {
        $list = Db::name('TkTalent')
            ->field('talent_appid')
            ->where('status', 1)
            ->where('is_shop', 0)
            ->whereIn('type', [2, 3]) //1直播，2短视频，3两者
            ->select();
        $count = $insert = $update = 0;
        foreach ($list as $talent) {
            $appid = $talent['talent_appid'];
            $rlist = ApiService::getAllFeed($appid);
            $ids = [];
            foreach ($rlist as $item) {
                $id = $item['export_id'];
                $ids[] = $id;
                $count++;
                $row = $this->app->db->name('TkFeed')->where(['export_id' => $id, 'talent_appid' => $appid])->find();
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
                    $insert++;
                    $this->app->db->name('TkFeed')->insert($d);
                }
            }
            if (count($ids) > 0) {
                $update += $this->app->db->name('TkFeed')
                    ->where(['talent_appid' => $appid, 'is_shop' => 0])
                    ->whereNotIn('export_id', $ids)
                    ->update(['status' => 0]);
            }
        }
        return ['count' => $count, 'insert' => $insert, 'update' => $update];
    }
}
