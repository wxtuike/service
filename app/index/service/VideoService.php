<?php

declare(strict_types=1);

namespace app\index\service;

use think\admin\Service;
use app\common\service\ApiService;
use think\facade\Db;

/**
 * 短视频服务
 * @class VideoService
 * @package app\index\service
 */
class VideoService extends Service
{
    /** 短视频列表 */
    public function list($userId, $cate, $pageSize = 10)
    {
        $query = Db::name('TkFeed')
            ->field('id,export_id,talent_appid,commission_amount,product_name,product_mini_price,is_shop,shop_appid')
            ->where('status', 1)
            ->order('sort desc,id desc');
        if (!empty($cate)) {
            if ($cate == 1) {
                $query->where('is_shop', 0);
            } else {
                $query->where('is_shop', 1);
            }
        }
        $list = $query->paginate($pageSize)->toArray();
        $data = $list['data'];
        $roleId = Db::name('TkUser')->where('id', $userId)->value('role_id');
        foreach ($data as $k => $item) {
            $item['price'] = formatMoney2($item['product_mini_price']);
            $item['commission'] = UserService::instance()->commissionByRoleId($roleId, $item['commission_amount']);
            $item['title'] = $item['product_name'];
            unset($item['product_mini_price']);
            unset($item['commission_amount']);
            $data[$k] = $item;
        }
        $data = $this->getShareInfo($data, $userId);
        $list['data'] = $data;
        return $list;
    }

    /**
     * 获取分享信息
     */
    private function getShareInfo($list, $userId)
    {
        $retMap = [];
        if (count($list) == 0) {
            return [];
        }
        $feedList = [];
        foreach ($list as $item) {
            $feedList[$item['id']] = $item;
        }
        //先查本地记录
        $localList = Db::name('TkUserFeed')
            ->where('user_id', $userId)
            ->whereIn('feed_id', array_keys($feedList))
            ->select()
            ->toArray();
        foreach ($localList as $find) {
            $retMap[$find['feed_id']] = [
                'feed_token' => $find['feed_token'],
                'promoter_share_link' => $find['promoter_share_link']
            ];
            unset($feedList[$find['feed_id']]);
        }
        $shopFeeds = $feeds = [];
        //剩下的按分店播和达人
        foreach ($feedList as $feed) {
            if ($feed['is_shop'] == 1) {
                $shopFeeds[$feed['talent_appid']][$feed['export_id']] = $feed;
            } else {
                $feeds[$feed['talent_appid']][$feed['export_id']] = $feed;
            }
        }
        if (!empty($shopFeeds)) {
            $res = $this->shopFeed($shopFeeds, $userId);
            foreach ($res as $i => $s) {
                $retMap[$i] = $s;
            }
        }
        if (!empty($feeds)) {
            $ret = $this->feed($feeds, $userId);
            foreach ($ret as $k => $f) {
                $retMap[$k] = $f;
            }
        }
        $result = [];
        foreach ($list as $v) {
            $id = $v['id'];
            if (isset($retMap[$id])) {
                $v['feed_token'] = $retMap[$id]['feed_token'] ?? '';
                $v['promoter_share_link'] = $retMap[$id]['promoter_share_link'] ?? '';
                $result[] = $v;
            }
        }
        return $result;
    }

    /** 店播的短视频处理 */
    private function shopFeed($shopFeeds, $userId)
    {
        $sharerAppid = Db::name('TkUser')->where(['id' => $userId])->value('sharer_appid');
        if (empty($sharerAppid)) {
            return [];
        }
        $retMap = [];
        foreach ($shopFeeds as $promoterId => $videos) {
            $feed_list = [];
            $shopAppid = '';
            foreach ($videos as $video) {
                $feed_list[] = [
                    'export_id' => $video['export_id']
                ];
                $shopAppid = $video['shop_appid'];
            }
            $res = ApiService::getShopFeedPromotionInfo($shopAppid, $promoterId, $feed_list, $sharerAppid);
            $feedList = $res['feed_list'] ?? [];
            unset($res);
            foreach ($feedList as $f) {
                $exportId = $f['export_id'];
                $v = $videos[$exportId] ?? [];
                if ($v) {
                    $data = [
                        'feed_id' => $v['id'],
                        'user_id' => $userId,
                        'feed_token' => $f['feed_token'] ?? '',
                        'promoter_share_link' => $f['promoter_share_link'] ?? '',
                    ];
                    $find = Db::name('TkUserFeed')->field('id')->where(['feed_id' => $v['id'], 'user_id' => $userId])->find();
                    if ($find) {
                        Db::name('TkUserFeed')->where(['id' => $find['id']])->update($data);
                    } else {
                        Db::name('TkUserFeed')->insert($data);
                    }
                    $retMap[$v['id']] = [
                        'feed_token' => $f['feed_token'] ?? '',
                        'promoter_share_link' => $f['promoter_share_link'] ?? '',
                    ];
                }
            }
        }
        return $retMap;
    }

    /** 达人短视频处理 */
    private function feed($feeds, $userId)
    {
        $sharerAppid = Db::name('TkUser')->where(['id' => $userId])->value('sharer_appid');
        if (empty($sharerAppid)) {
            return [];
        }
        $retMap = [];
        foreach ($feeds as $talentAppid => $videos) {
            $feed_list = [];
            foreach ($videos as $video) {
                $feed_list[] = [
                    'export_id' => $video['export_id']
                ];
            }
            $res = ApiService::getFeedPromotion($talentAppid, $feed_list, $sharerAppid);
            $feedList = $res['feed_list'] ?? [];
            unset($res);
            foreach ($feedList as $f) {
                $exportId = $f['export_id'];
                $v = $videos[$exportId] ?? [];
                if ($v) {
                    $data = [
                        'feed_id' => $v['id'],
                        'user_id' => $userId,
                        'feed_token' => $f['feed_token'] ?? '',
                        'promoter_share_link' => $f['promoter_share_link'] ?? '',
                    ];
                    $find = Db::name('TkUserFeed')->field('id')->where(['feed_id' => $v['id'], 'user_id' => $userId])->find();
                    if ($find) {
                        Db::name('TkUserFeed')->where(['id' => $find['id']])->update($data);
                    } else {
                        Db::name('TkUserFeed')->insert($data);
                    }
                    $retMap[$v['id']] = [
                        'feed_token' => $f['feed_token'] ?? '',
                        'promoter_share_link' => $f['promoter_share_link'] ?? '',
                    ];
                }
            }
        }
        return $retMap;
    }
}
