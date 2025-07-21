<?php

declare(strict_types=1);

namespace app\common\service;

use think\admin\Service;
use think\facade\Db;

/** 店播 */
class ApiStoreService extends Service
{
    /** 同步店播小店信息 */
    public function syncAllStore()
    {
        $count = $insert = $update = 0;
        $ids = [];
        $list = ApiService::getAllBindShopList();
        foreach ($list as $item) {
            $id = $item['shop_appid'];
            $ids[] = $id;
            $count++;
            $d = [
                'shop_appid' => $item['shop_appid'],
                'bind_time' => round($item['bind_time'] / 1000),
                'shop_nickname' => $item['shop_nickname'],
                'shop_head_img' => $item['shop_head_img']
            ];
            $row = Db::name('TkStore')->where(['shop_appid' => $id])->find();
            if (!$row) {
                $insert++;
                Db::name('TkStore')->insert($d);
            } else {
                $update++;
                Db::name('TkStore')->where(['shop_appid' => $id])->update($d);
            }
        }
        //解绑
        $unbind = Db::name('TkStore')->whereNotIn('shop_appid', $ids)->update(['bind' => 0]);
        return compact('count', 'insert', 'update', 'unbind');
    }

    /** 同步店播所有关联帐号列表 */
    public function syncAllPromoter()
    {
        $ids = [];
        $count = 0;
        $stores = Db::name('TkStore')->where(['bind' => 1])->select()->toArray();
        foreach ($stores as $store) {
            $promoters = ApiService::getAllBindShopPromoterList($store['shop_appid']);
            foreach ($promoters as $promoter) {
                $data = [
                    'shop_appid' => $store['shop_appid'],
                    'talent_appid' => $promoter['promoter_id'],
                    'talent_nickname' => $promoter['promoter_name'],
                    'talent_head_img' => $promoter['avatar_image_url'],
                    'promoter_type' => $promoter['promoter_type'],
                    'bind_time' => $store['bind_time'],
                    'is_shop' => 1
                ];
                $exportname = $promoter['related_finder_exportname_list'] ?? '';
                if (!empty($exportname)) {
                    $data['related_finder_exportname_list'] = json_encode($exportname);
                }
                $mpbiz = $promoter['related_mp_biz_appid_list'] ?? '';
                if (!empty($exportname)) {
                    $data['related_mp_biz_appid_list'] = json_encode($mpbiz);
                }
                $ids[] = $promoter['promoter_id'];
                $count++;
                $row = Db::name('TkTalent')->where(['talent_appid' => $promoter['promoter_id'], 'shop_appid' => $store['shop_appid']])->find();
                if (!$row) {
                    $data['type'] = 3;
                    Db::name('TkTalent')->insert($data);
                } else {
                    Db::name('TkTalent')->where(['talent_appid' => $promoter['promoter_id'], 'shop_appid' => $store['shop_appid']])->update($data);
                }
            }
        }
        $update = 0;
        if (count($ids) > 0) {
            $update = $this->app->db->name('TkTalent')
                ->whereNotIn('talent_appid', $ids)
                ->where('is_shop', 1)
                ->update(['is_bind' => 0, 'status' => 0]);
        }
        return ['count' => $count, 'update' => $update];
    }

    /**
     * 同步预约直播
     */
    public function syncPreLive()
    {
        $list = Db::name('TkTalent')
            ->field('talent_appid,shop_appid')
            ->where('status', 1)
            ->where('is_shop', 1)
            ->where('promoter_type', 1) //店播关联账号类型【1：视频号；4：公众号；5：服务号】
            ->whereIn('type', [1, 3]) //1直播，2短视频，3两者
            ->select();
        $count = $insert = $update = 0;
        $ids = [];
        foreach ($list as $talent) {
            $shop_appid = $talent['shop_appid'];
            $appid = $talent['talent_appid'];
            //预约直播
            $res = ApiService::getShopLiveNoticeRecordList($shop_appid, $appid);
            $rlist = $res['live_notice_record_list'] ?? [];
            foreach ($rlist as $item) {
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
                        'live_status' => 1,
                        'is_shop' => 1,
                        'shop_appid' => $shop_appid,
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
                ->where(['type' => 0])
                ->where(['is_shop' => 1])
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
            ->field('talent_appid,shop_appid')
            ->where('is_shop', 1)
            ->where('status', 1)
            ->where('promoter_type', 1)
            ->whereIn('type', [1, 3]) //1直播，2短视频，3两者
            ->select();
        $count = $insert = $update = 0;
        $ids = [];
        foreach ($list as $talent) {
            $shop_appid = $talent['shop_appid'];
            $appid = $talent['talent_appid'];
            //直播内容
            $res = ApiService::getShopLiveRecordList($shop_appid, $appid);
            $rlist = $res['live_record_list'] ?? [];
            foreach ($rlist as $item) {
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
                        'live_status' => 1,
                        'is_shop' => 1,
                        'shop_appid' => $shop_appid,
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
                ->where(['type' => 1, 'is_shop' => 1])
                ->whereNotIn('live_id', $ids)
                ->update(['live_status' => 0]);
        }
        return ['count' => $count, 'insert' => $insert, 'update' => $update];
    }

    /** 同步直播产品 */
    public function syncLiveProduct()
    {
        $list = Db::name('TkTalent')
            ->field('talent_appid,shop_appid')
            ->where('status', 1)
            ->where('is_shop', 1)
            ->whereIn('type', [1, 3]) //1直播，2短视频，3两者
            ->select();
        $count = $insert = $update = 0;
        $ids = [];
        foreach ($list as $talent) {
            $shop_appid = $talent['shop_appid'];
            $appid = $talent['talent_appid'];
            $rlist = ApiService::getAllShopLiveCommissionProductList($shop_appid, $appid);
            if (count($rlist) == 0) {
                //如果没有产品，则跳过
                continue;
            }
            foreach ($rlist as $item) {
                $id = $item['product_id'];
                $ids[] = $id;
                $count++;
                $data = [
                    'talent_appid' => $appid,
                    'product_id' => $id,
                    'product_name' => $item['product_name'],
                    'product_img_url' => $item['product_img_url'],
                    'product_price' => $item['product_price'],
                    'predict_commission_amount' => $item['predict_commission_amount'],
                    'status' => 1
                ];
                $row = $this->app->db->name('TkLiveProduct')->where(['product_id' => $id, 'talent_appid' => $appid])->find();
                if (!$row) {
                    $this->app->db->name('TkLiveProduct')->insert($data);
                    $insert++;
                } else {
                    $this->app->db->name('TkLiveProduct')->where('id', $row['id'])->update($data);
                    $update++;
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


    /**
     * 同步店播短视频
     */
    public function syncVideo()
    {
        $list = Db::name('TkTalent')
            ->field('talent_appid,shop_appid')
            ->where('status', 1)
            ->where('is_shop', 1)
            ->whereIn('type', [2, 3]) //1直播，2短视频，3两者
            ->select();
        $count = $insert = $update = 0;
        foreach ($list as $talent) {
            $shop_appid = $talent['shop_appid'];
            $appid = $talent['talent_appid'];
            $rlist = ApiService::getAllShopFeedList($shop_appid, $appid);
            $ids = [];
            foreach ($rlist as $item) {
                $id = $item['export_id'];
                $ids[] = $id;
                $count++;
                $row = $this->app->db->name('TkFeed')->field('id,export_id')->where(['export_id' => $id, 'talent_appid' => $appid])->find();
                $d = [
                    'talent_appid' => $appid,
                    'shop_appid' => $shop_appid,
                    'is_shop' => 1,
                    'export_id'    => $id,
                    'commission_amount' => $item['predict_commission_amount'],
                    'product_info' => json_encode($item['product_info']),
                    'product_id' => $item['product_info']['product_id'] ?? 0,
                    'product_name' => $item['product_info']['product_name'] ?? '',
                    'product_img_url' => $item['product_info']['product_img_url'] ?? '',
                    'product_mini_price' => $item['product_info']['product_mini_price'] ?? 0,
                ];
                if (!$row) {
                    $insert++;
                    $this->app->db->name('TkFeed')->insert($d);
                } else {
                    $this->app->db->name('TkFeed')->where('id', $row['id'])->update($d);
                }
            }
            if (count($ids) > 0) {
                $update += $this->app->db->name('TkFeed')
                    ->where(['talent_appid' => $appid, 'is_shop' => 1])
                    ->whereNotIn('export_id', $ids)
                    ->update(['status' => 0]);
            }
        }
        return ['count' => $count, 'insert' => $insert, 'update' => $update];
    }
}
