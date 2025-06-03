<?php

declare(strict_types=1);

namespace app\common\service;

use think\admin\Service;
use think\facade\Db;

class ApiLiveService extends Service
{
    /**
     * 同步预约直播
     */
    public function syncPreLive()
    {
        $list = Db::name('TkTalent')
            ->field('talent_appid')
            ->where('status', 1)
            ->where('is_shop', 0)
            ->whereIn('type', [1, 3]) //1直播，2短视频，3两者
            ->select();
        $count = $insert = $update = 0;
        $ids = [];
        foreach ($list as $talent) {
            $appid = $talent['talent_appid'];
            //预约直播
            $res = ApiService::liveNoticeList($appid);
            $list = $res['live_notice_record_list'] ?? [];
            foreach ($list as $item) {
                $id = $item['notice_id'];
                $ids[] = $id;
                $count++;
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
                    $insert++;
                    $this->app->db->name('TkLive')->insert($d);
                } else {
                    $d = [
                        'description' => $item['description'],
                        'start_time' => $item['start_time'],
                    ];
                    $this->app->db->name('TkLive')->where('id', $row['id'])->update($d);
                }
            }
        }
        if (count($ids) > 0) {
            $update = $this->app->db->name('TkLive')
                ->where(['type' => 0, 'is_shop' => 0])
                ->whereNotIn('live_id', $ids)
                ->update(['live_status' => 0]);
        }
        return ['count' => $count, 'insert' => $insert, 'update' => $update];
    }

    /**
     * 同步新直播
     */
    public function syncNewLive()
    {
        $list = Db::name('TkTalent')
            ->field('talent_appid')
            ->where('is_shop', 0)
            ->where('status', 1)
            ->whereIn('type', [1, 3]) //1直播，2短视频，3两者
            ->select();
        $count = $insert = $update = 0;
        $ids = [];
        foreach ($list as $talent) {
            $appid = $talent['talent_appid'];
            //直播内容
            $res = ApiService::liveList($appid);
            $list = $res['live_record_list'] ?? [];
            foreach ($list as $item) {
                $id = $item['export_id'];
                $ids[] = $id;
                $count++;
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
                    $insert++;
                    $this->app->db->name('TkLive')->insert($d);
                } else {
                    $d = [
                        'description' => $item['description'],
                        'promoter_share_link' => $item['promoter_share_link'],
                    ];
                    $this->app->db->name('TkLive')->where('id', $row['id'])->update($d);
                }
            }
        }
        if (count($ids) > 0) {
            $update = $this->app->db->name('TkLive')
                ->where(['type' => 1, 'is_shop' => 0])
                ->whereNotIn('live_id', $ids)
                ->update(['live_status' => 0]);
        }
        return ['count' => $count, 'insert' => $insert, 'update' => $update];
    }

    /** 同步直播产品 */
    public function syncLiveProduct()
    {
        $list = Db::name('TkTalent')
            ->field('talent_appid')
            ->where('status', 1)
            ->where('is_shop', 0)
            ->whereIn('type', [1, 3]) //1直播，2短视频，3两者
            ->select();
        $count = $insert = $update = 0;
        $ids = [];
        foreach ($list as $talent) {
            $appid = $talent['talent_appid'];
            $list = ApiService::getAllLiveProduct($appid);
            if (count($list) == 0) {
                //如果没有产品，则跳过
                continue;
            }
            foreach ($list as $item) {
                $id = $item['product_id'];
                $ids[] = $id;
                $count++;
                $row = $this->app->db->name('TkLiveProduct')->where(['product_id' => $id, 'talent_appid' => $appid])->find();
                if (!$row) {
                    $item['talent_appid'] = $appid;
                    $item['status'] = 1;
                    $this->app->db->name('TkLiveProduct')->insert($item);
                    $insert++;
                }
            }
            if (count($ids) > 0) {
                $update += $this->app->db->name('TkLiveProduct')
                    ->where(['talent_appid' => $appid])
                    ->whereNotIn('product_id', $ids)
                    ->update(['status' => 0]);
            }
        }
        return ['count' => $count, 'insert' => $insert, 'update' => $update];
    }
}
