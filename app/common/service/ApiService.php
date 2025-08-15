<?php

declare(strict_types=1);

namespace app\common\service;

use think\admin\Service;

/**
 * 推客接口服务
 * @class ApiService
 * @package app\common\service
 */
class ApiService extends Service
{
    const IS_DEBUG = true;

    /***
     * 获取券ID对应的详情内容
     */
    public static function getCouponDetail($coupon_id)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_coupon_detail?access_token=' . self::getToken();
        $params = [
            'coupon_id' => $coupon_id
        ];
        return self::post($url, $params);
    }
    /***
     * 获取公开券ID列表
     */
    public static function getCouponList($shopAppid, $next_key = '', $pageSize = 200)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_public_coupon_list?access_token=' . self::getToken();
        $params = [
            'shop_appid' => $shopAppid,
            'next_key' => $next_key,
            'page_size' => $pageSize,
        ];
        return self::post($url, $params);
    }

    /***
     * 获取定向券ID列表
     */
    public static function getCooperativeCouponList($next_key = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_cooperative_coupon_list?access_token=' . self::getToken();
        $params = [
            'next_key' => $next_key,
            'page_size' => 200
        ];
        $res = self::post($url, $params);
        $slist = $res['coupons'] ?? [];
        $nextKey = $res['next_key'] ?? '';
        $hasMore = $listRes['has_more'] ?? false;
        if (count($slist) > 0) {
            $list = array_merge($list, $slist);
        }
        unset($res);
        unset($slist);
        if ($nextKey != '' && $hasMore) {
            return self::getCooperativeCouponList($nextKey, $list);
        }
        return $list;
    }

    /***
     * 生成小店关联账号的短视频内嵌短视频卡片需要的 feedtoken
     */
    public static function getShopFeedPromotionInfo($shop_appid, $promoter_id, $feed_list, $sharer_appid)
    {
        $miniAppid = sysconf('weapp.appid');
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_feed_promotion_info?access_token=' . self::getToken();
        $params = [
            "feed_list" => $feed_list,
            "mini_program_appid" => $miniAppid,
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1,
            'sharer_appid' => $sharer_appid
        ];
        return self::post($url, $params);
    }

    /***
     * 获取某个小店关联账号的短视频列表
     */
    public static function getShopFeedList($shop_appid, $promoter_id, $next_key = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_feed_list?access_token=' . self::getToken();
        $params = [
            "next_key" => $next_key,
            "page_size" => 10,
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1
        ];
        return self::post($url, $params);
    }
    /***
     * 获取某个小店所有关联账号的短视频列表
     */
    public static function getAllShopFeedList($shop_appid, $promoter_id, $next_key = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_feed_list?access_token=' . self::getToken();
        $params = [
            "next_key" => $next_key,
            "page_size" => 10,
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1
        ];
        $res = self::post($url, $params);
        $slist = $res['feed_list'] ?? [];
        if (count($slist) > 0) {
            $list = array_merge($list, $slist);
        }
        $nextKey = $res['next_key'] ?? '';
        $hasMore = $res['has_more'] ?? false;
        unset($res);
        unset($slist);
        if ($nextKey != '' && $hasMore) {
            return self::getAllShopFeedList($shop_appid, $promoter_id, $nextKey, $list);
        }
        return $list;
    }
    /***
     * 获取小店关联账号的当前直播的带货商品列表
     */
    public static function getShopLiveCommissionProductList($shop_appid, $promoter_id, $next_key = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_live_commission_product_list?access_token=' . self::getToken();
        $params = [
            "next_key" => $next_key,
            "page_size" => 10,
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1
        ];
        return self::post($url, $params);
    }
    /***
     * 获取小店关联账号的当前直播的带货商品列表
     */
    public static function getAllShopLiveCommissionProductList($shop_appid, $promoter_id, $next_key = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_live_commission_product_list?access_token=' . self::getToken();
        $params = [
            "next_key" => $next_key,
            "page_size" => 10,
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1
        ];
        $res = self::post($url, $params);
        $slist = $res['product_list'] ?? [];
        if (count($slist) > 0) {
            $list = array_merge($list, $slist);
        }
        $nextKey = $res['next_key'] ?? '';
        $hasMore = $res['has_more'] ?? false;
        unset($res);
        unset($slist);
        if ($nextKey != '' && $hasMore) {
            return self::getAllShopLiveCommissionProductList($shop_appid, $promoter_id, $nextKey, $list);
        }
        return $list;
    }
    /***
     * 为某个推客生成单个直播预约的推广二维码
     */
    public static function getShopLiveNoticeRecordQrCode($shop_appid, $promoter_id, $export_id, $sharer_appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_live_notice_record_qr_code?access_token=' . self::getToken();
        $params = [
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1,
            "notice_id" => $export_id,
            "sharer_appid" => $sharer_appid
        ];
        return self::post($url, $params);
    }

    /***
     *  为某个推客生成单个小店直播的推广二维码
     */
    public static function getShopLiveRecordQrCode($shop_appid, $promoter_id, $export_id, $sharer_appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_live_record_qr_code?access_token=' . self::getToken();
        $params = [
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1,
            "export_id" => $export_id,
            "sharer_appid" => $sharer_appid
        ];
        return self::post($url, $params);
    }
    /***
     *  获取小店关联账号的预约直播列表
     */
    public static function getShopLiveNoticeRecordList($shop_appid, $promoter_id)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_live_notice_record_list?access_token=' . self::getToken();
        $params = [
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1
        ];
        return self::post($url, $params);
    }
    /***
     * 获取内容合作小店关联帐号直播列表
     */
    public static function getShopLiveRecordList($shop_appid, $promoter_id, $sharer_appid = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_live_record_list?access_token=' . self::getToken();
        $params = [
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1,
            "mini_program_appid" => sysconf('weapp.appid')
        ];
        if (!empty($sharer_appid)) {
            $params['sharer_appid'] = $sharer_appid;
        }
        return self::post($url, $params);
    }
    /***
     * 获取内容合作小店关联帐号列表
     */
    public static function getBindShopPromoterList($shop_appid, $next_key = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_bind_shop_promoter_list?access_token=' . self::getToken();
        $params = [
            'shop_appid' => $shop_appid,
            'next_key' => $next_key,
            'page_size' => 10
        ];
        return self::post($url, $params);
    }

    /***
     * 获取内容合作小店所有关联帐号列表
     */
    public static function getAllBindShopPromoterList($shop_appid, $next_key = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_bind_shop_promoter_list?access_token=' . self::getToken();
        $params = [
            'shop_appid' => $shop_appid,
            'next_key' => $next_key,
            'page_size' => 10
        ];
        $res = self::post($url, $params);
        $slist = $res['promoter_list'] ?? [];
        if (count($slist) > 0) {
            $list = array_merge($list, $slist);
        }
        $nextKey = $res['next_key'] ?? '';
        $hasMore = $res['has_more'] ?? false;
        unset($res);
        unset($slist);
        if ($nextKey != '' && $hasMore) {
            return self::getAllBindShopPromoterList($shop_appid, $nextKey, $list);
        }
        return $list;
    }
    /***
     * 获取内容合作小店列表
     */
    public static function getBindShopList($next_key = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_bind_shop_list?access_token=' . self::getToken();
        $params = [
            'next_key' => $next_key,
            'page_size' => 10
        ];
        return self::post($url, $params);
    }

    /***
     * 获取所有内容合作小店列表
     */
    public static function getAllBindShopList($next_key = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_bind_shop_list?access_token=' . self::getToken();
        $params = [
            'next_key' => $next_key,
            'page_size' => 10
        ];
        $res = self::post($url, $params);
        $slist = $res['shop_list'] ?? [];
        if (count($slist) > 0) {
            $list = array_merge($list, $slist);
        }
        $nextKey = $res['next_key'] ?? '';
        $hasMore = $res['has_more'] ?? false;
        unset($res);
        unset($slist);
        if ($nextKey != '' && $hasMore) {
            return self::getAllBindShopList($nextKey, $list);
        }
        return $list;
    }

    /***
     * 获取某个小店关联账号的公众号文章列表
     */
    public static function getShopMpArticleList($shop_appid, $promoter_id, $sharer_appid, $next_key = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_shop_mp_article_list?access_token=' . self::getToken();
        $params = [
            "page_size" => 10,
            "shop_appid" => $shop_appid,
            "promoter_id" => $promoter_id,
            "promoter_type" => 1,
            'sharer_appid' => $sharer_appid,
            'next_key' => $next_key
        ];
        return self::post($url, $params);
    }

    /**
     * 获取订阅的商品列表
     */
    public static function getSubscribe($nextKey = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/subscription/getsubscribe?access_token=' . self::getToken();
        $params = [
            'next_key' => $nextKey,
            'page_size' => 999,
        ];
        $res = self::post($url, $params);
        $slist = $res['subscribe_info_list'] ?? [];
        if (count($slist) > 0) {
            $list = array_merge($list, $slist);
        }
        $nextKey = $res['next_key'] ?? '';
        $hasMore = $res['has_more'] ?? false;
        unset($res);
        unset($slist);
        if ($nextKey != '' && $hasMore) {
            return self::getSubscribe($nextKey, $list);
        }
        return $list;
    }

    /**
     * 获取时间段的订单列表
     *
     * @param integer $startTime 开始时间
     * @param boolean $isUpdate true更新时间，false创建时间
     */
    public static function getOrders($startTime, $isUpdate = false)
    {
        $time = time() - 15;
        $res = [];
        $nextKey = '';
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/order/list/get?access_token=' . self::getToken();
        do {
            $params = [
                'next_key' => $nextKey,
                'page_size' => 30,
            ];
            if ($isUpdate) {
                $params['update_time_range'] = [
                    'start_time' => $startTime,
                    'end_time' => $time,
                ];
            } else {
                $params['create_time_range'] = [
                    'start_time' => $startTime,
                    'end_time' => $time,
                ];
            }
            $listRes = self::post($url, $params);
            $list = $listRes['list'] ?? [];
            $nextKey = $listRes['next_key'] ?? '';
            foreach ($list as $g) {
                $key = sprintf('%s_%s', $g['order_id'], $g['sku_id']);
                $res[$key] = $g;
            }
            $hasMore = $listRes['has_more'] ?? 0;
        } while (!empty($nextKey) && !empty($hasMore));
        return $res;
    }

    /**
     * 获取所有商品列表id
     *
     * @param int $planType 1定向推广商品
     * @param int $page 获取页数
     */
    public static function getAllGoods($planType = 1, $page = 1)
    {
        $i = 0;
        $res = [];
        $nextKey = '';
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_promote_product_list?access_token=' . self::getToken();
        do {
            $params = [
                'plan_type' => $planType,
                'next_key' => $nextKey,
                'page_size' => 20,
            ];
            $listRes = self::post($url, $params);
            $list = $listRes['product_list'] ?? [];
            $nextKey = $listRes['next_key'] ?? '';
            foreach ($list as $g) {
                $key = sprintf('%s_%s_%s', $g['shop_appid'], $g['product_id'], $planType);
                unset($g['head_supplier_appid']);
                $g['goods_id'] = $key;
                $res[$key] = $g;
            }
            $i++;
            if ($i >= $page) {
                break;
            }
        } while (!empty($list) && !empty($nextKey));
        return $res;
    }

    /**
     * 店铺列表
     *
     * @param string $next_key
     */
    public static function shopListAll($next_key = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/shop/list/get?access_token=' . self::getToken();
        $params = [
            'next_key' => $next_key,
            'page_size' => 30,
        ];
        $res = self::post($url, $params);
        $shopList = $res['shop_list'] ?? [];
        if (count($shopList) > 0) {
            $list = array_merge($list, $shopList);
        }
        $hasMore = $res['has_more'] ?? 0;
        $next_key = $res['next_key'] ?? '';
        if ($hasMore && $next_key != '') {
            return self::shopListAll($next_key, $list);
        }
        return $list;
    }
    /***
     * 获取合作小店详情
     */
    public static function shopInfo($appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/shop/get?access_token=' . self::getToken();
        $params = [
            'appid' => $appid,
        ];
        return self::post($url, $params);
    }
    /**
     * 店铺列表
     *
     * @param string $next_key
     */
    public static function shopList($next_key = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/shop/list/get?access_token=' . self::getToken();
        $params = [
            'next_key' => $next_key,
            'page_size' => 30,
        ];
        return self::post($url, $params);
    }
    /**
     * 生成某个达人平台的某些短视频内嵌短视频卡片需要的feedtoken
     *
     * @param string $talent_appid 达人appid
     * @param array $feed_list export_id数组，需要生成 token 的短视频列表信息
     * @param string $sharer_appid 推客appid
     * @return void
     */
    public static function getFeedPromotion($talent_appid, $feed_list, $sharer_appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_feed_promotion_info?access_token=' . self::getToken();
        $params = [
            'mini_program_appid' => sysconf('weapp.appid'),
            'talent_appid' => $talent_appid,
            'feed_list' => $feed_list,
            'sharer_appid' => $sharer_appid,
        ];
        return self::post($url, $params);
    }

    /**
     * 达人橱窗授权状态
     */
    public static function authStatus($finderId)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/windowauth/status/get?access_token=' . self::getToken();
        $params = [
            'finder_id' => $finderId,
        ];
        return self::post($url, $params);
    }
    /**
     * 获取达人橱窗授权链接
     */
    public static function auth($finderId)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/windowauth/get?access_token=' . self::getToken();
        $params = [
            'finder_id' => $finderId,
        ];
        return self::post($url, $params);
    }
    /**
     * 获取某个达人平台当前直播的所有带货商品列表
     */
    public static function getAllLiveProduct($talent_appid)
    {
        $res = [];
        $nextKey = '';
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_live_commission_product_list?access_token=' . self::getToken();
        do {
            $params = [
                'talent_appid' => $talent_appid,
                'next_key' => $nextKey,
                'page_size' => 10,
            ];
            $listRes = self::post($url, $params);
            $list = $listRes['product_list'] ?? [];
            $hasMore = $listRes['has_more'] ?? false;
            $nextKey = $listRes['next_key'] ?? '';
            foreach ($list as $g) {
                $res[] = $g;
            }
        } while (!empty($nextKey) && !empty($hasMore));
        return $res;
    }
    /**
     * 获取某个达人平台当前直播的带货商品列表
     */
    public static function getLiveProduct($talent_appid, $next_key = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_live_commission_product_list?access_token=' . self::getToken();
        $params = [
            'talent_appid' => $talent_appid,
            'next_key' => $next_key,
            'page_size' => 10,
        ];
        return self::post($url, $params);
    }
    /**
     * 为某个推客生成单个直播预约的推广二维码
     */
    public static function liveNoticeQrcode($notice_id, $talent_appid, $sharer_appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_live_notice_record_qr_code?access_token=' . self::getToken();
        $params = [
            'notice_id' => $notice_id,
            'talent_appid' => $talent_appid,
            'sharer_appid' => $sharer_appid
        ];
        return self::post($url, $params);
    }
    /**
     * 为某个推客生成单个直播的推广二维码
     */
    public static function liveQrcode($export_id, $talent_appid, $sharer_appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_live_record_qr_code?access_token=' . self::getToken();
        $params = [
            'export_id' => $export_id,
            'talent_appid' => $talent_appid,
            'sharer_appid' => $sharer_appid
        ];
        return self::post($url, $params);
    }
    /**
     * 达人直播预约列表
     */
    public static function liveNoticeList($talent_appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_live_notice_record_list?access_token=' . self::getToken();
        $params = [
            'talent_appid' => $talent_appid,
            'mini_program_appid' => sysconf('weapp.appid')
        ];
        return self::post($url, $params);
    }
    /**
     * 达人直播列表
     */
    public static function liveList($talent_appid, $sharer_appid = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_live_record_list?access_token=' . self::getToken();
        $params = [
            'talent_appid' => $talent_appid,
            'mini_program_appid' => sysconf('weapp.appid')
        ];
        if (!empty($sharer_appid)) {
            $params['sharer_appid'] = $sharer_appid;
        }
        return self::post($url, $params);
    }
    /**
     * 获取达人平台推广的所有短视频信息（循环）
     */
    public static function getAllFeed($talent_appid)
    {
        $res = [];
        $nextKey = '';
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_feed_list?access_token=' . self::getToken();
        do {
            $params = [
                'talent_appid' => $talent_appid,
                'next_key' => $nextKey,
                'page_size' => 10,
            ];
            $listRes = self::post($url, $params);
            $list = $listRes['feed_list'] ?? [];
            $hasMore = $listRes['has_more'] ?? false;
            $nextKey = $listRes['next_key'] ?? '';
            foreach ($list as $g) {
                $res[] = $g;
            }
        } while (!empty($nextKey) && !empty($hasMore));
        return $res;
    }

    /**
     * 达人短视频
     */
    public static function feedList($talent_appid = '', $next_key = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_feed_list?access_token=' . self::getToken();
        $params = [
            'talent_appid' => $talent_appid,
            'next_key' => $next_key,
            'page_size' => 10
        ];
        return self::post($url, $params);
    }
    /**
     * 获取合作的所有达人平台列表
     */
    public static function allTalentList()
    {
        $res = [];
        $nextKey = '';
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_bind_talent_list?access_token=' . self::getToken();
        do {
            $params = [
                'next_key' => $nextKey,
                'page_size' => 10,
            ];
            $listRes = self::post($url, $params);
            $list = $listRes['talent_list'] ?? [];
            $hasMore = $listRes['has_more'] ?? false;
            $nextKey = $listRes['next_key'] ?? '';
            foreach ($list as $g) {
                $res[] = $g;
            }
        } while (!empty($nextKey) && !empty($hasMore));
        return $res;
    }
    /**
     * 获取合作的达人平台列表
     */
    public static function talentList()
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_bind_talent_list?access_token=' . self::getToken();
        $params = [
            'next_key' => '',
            'page_size' => 10
        ];
        return self::post($url, $params);
    }
    /**
     * 订单信息
     *
     * @param [type] $orderId
     * @param [type] $skuId
     * @return void
     */
    public static function orderInfo($orderId, $skuId)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/order/get?access_token=' . self::getToken();
        $params = [
            'order_id' => $orderId,
            'sku_id' => $skuId
        ];
        return self::post($url, $params);
    }
    /**
     * 订单列表
     */
    public static function orderList($next_key)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/order/list/get?access_token=' . self::getToken();
        $params = [
            'next_key' => $next_key,
            'page_size' => 30
        ];
        return self::post($url, $params);
    }

    /**
     * 获取机构绑定的推客信息
     *
     */
    public static function sharerList($sharer_openid = '', $sharer_appid = '', $next_key = '')
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_bind_sharer_list?access_token=' . self::getToken();
        $params = [
            'next_key' => $next_key,
            'page_size' => 20
        ];
        if (!empty($sharer_appid)) {
            $params['sharer_appid'] = $sharer_appid;
        }
        if (!empty($sharer_openid)) {
            $params['sharer_openid'] = $sharer_openid;
        }
        return self::post($url, $params);
    }

    public static function isBind($openId)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_promoter_register_and_bind_status?access_token=' . self::getToken();
        $params = [
            'sharer_openid' => $openId,
            'is_simple_register' => true
        ];
        return self::post($url, $params);
    }
    /**
     * 获取商品列表
     * @param string $keyword
     * @param string $nextKey
     * @param string $planType 商品的计划类型 1：定向计划 2：公开计划 3: 机构定向计划 4: 机构普通计划
     */
    public static function getGoodsList($keyword = '', $nextKey = '', $planType = 1)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_promote_product_list?access_token=' . self::getToken();
        $params = [
            'plan_type' => $planType,
            'next_key' => $nextKey,
            'page_size' => 20,
        ];
        if (!empty($keyword)) {
            $params['keyword'] = $keyword;
        }
        $listRes = self::post($url, $params);
        $list = $listRes['product_list'] ?? [];
        unset($listRes);
        $goods = [];
        foreach ($list as $g) {
            $goodsInfo = self::getGoodsInfo($g['product_id'], $g['shop_appid'], $planType);
            $goods[] = $goodsInfo['product'] ?? $g;
        }
        unset($list);
        return $goods;
    }

    /**
     * 获取某个推客某个商品的内嵌商品卡片product_promotion_link
     */
    public static function getProductPromotionLink($sharer_appid, $product_id, $shop_appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_promoter_single_product_promotion_info?access_token=' . self::getToken();
        $params = [
            'sharer_appid' => $sharer_appid,
            'product_id' => $product_id,
            'shop_appid' => $shop_appid,
        ];
        return self::post($url, $params);
    }
    /**
     * 获取推客对某个商品的推广二维码
     */
    public static function getProductQrcode($sharer_appid, $product_id, $shop_appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_product_promotion_qrcode_info?access_token=' . self::getToken();
        $params = [
            'sharer_appid' => $sharer_appid,
            'product_id' => $product_id,
            'shop_appid' => $shop_appid,
        ];
        return self::post($url, $params);
    }
    /**
     * 获取推客对某个商品的推广短链
     */
    public static function getProductShortLink($sharer_appid, $product_id, $shop_appid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_product_promotion_link_info?access_token=' . self::getToken();
        $params = [
            'sharer_appid' => $sharer_appid,
            'product_id' => $product_id,
            'shop_appid' => $shop_appid,
        ];
        return self::post($url, $params);
    }
    /**
     * 获取商品详情
     */
    public static function getGoodsInfo($productId, $shopAppId, $planType)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/promoter/get_promote_product_detail?access_token=' . self::getToken();
        $params = [
            'product_id' => $productId,
            'shop_appid' => $shopAppId,
            'plan_type' => $planType,
            'get_available_coupon' => true
        ];
        return self::post($url, $params);
    }

    /**
     * 获取商品详情（不传playType,默认1，定向，如果1取不到商品，则用2公开）
     */
    public static function getGoodsInfo2($productId, $shopAppId)
    {
        $planType = 1;
        $res = self::getGoodsInfo($productId, $shopAppId, $planType);
        $errcode = $res['errcode'] ?? -1;
        if ($errcode != 0) {
            //如果定向取不到，就取公开的
            $planType = 2;
            $res = self::getGoodsInfo($productId, $shopAppId, $planType);
        }
        $res['plan_type'] = $planType;
        return $res;
    }

    /**
     * 获取小程序的手机号
     *
     * @param string $code
     */
    public static function getMobile($code)
    {
        $url = 'https://api.weixin.qq.com/wxa/business/getuserphonenumber?access_token=' . self::getWeAppToken();
        return self::post($url, ['code' => $code]);
    }


    /** 获取小程序的openid */
    public static function getOpenId($code)
    {
        $appid = sysconf('weapp.appid');
        $appsecret = sysconf('weapp.appsecret');
        $url = sprintf(
            'https://api.weixin.qq.com/sns/jscode2session?appid=%s&secret=%s&js_code=%s&grant_type=authorization_code',
            $appid,
            $appsecret,
            $code
        );
        $res = self::get($url);
        return $res['openid'] ?? '';
    }

    /**
     * 获取小程序码（永久有效）
     * 接口B：适用于需要的码数量极多的业务场景
     * @param string $scene 最大32个可见字符，只支持数字
     * @param string $page 必须是已经发布的小程序存在的页面
     * @param integer $width 二维码的宽度
     * @param bool $autoColor 自动配置线条颜色，如果颜色依然是黑色，则说明不建议配置主色调
     * @param null|array $lineColor auto_color 为 false 时生效
     * @param bool $isHyaline 是否需要透明底色
     * @param null|string $outType 输出类型
     * @param array $extra 其他参数
     * @return array|string
     * @throws \WeChat\Exceptions\InvalidResponseException
     * @throws \WeChat\Exceptions\LocalCacheException
     */
    public static function createMiniScene($scene, $page = '', $width = 430, $autoColor = false, $lineColor = null, $isHyaline = true, $outType = null, array $extra = [])
    {
        $url = 'https://api.weixin.qq.com/wxa/getwxacodeunlimit?access_token=' . self::getWeAppToken();
        $lineColor = empty($lineColor) ? ["r" => "0", "g" => "0", "b" => "0"] : $lineColor;
        $data = ['scene' => $scene, 'width' => $width, 'page' => $page, 'auto_color' => $autoColor, 'line_color' => $lineColor, 'is_hyaline' => $isHyaline, 'check_path' => false];
        if (empty($page)) unset($data['page']);
        $json = array_merge($data, $extra);
        return self::post($url, $json, false);
    }

    /**
     * 获取小程序access_token
     */
    public static function getWeAppToken()
    {
        $key = 'weapp_access_token';
        $token = cache($key);
        if (!empty($token)) {
            return $token;
        }
        $appid = sysconf('weapp.appid');
        $appsecret = sysconf('weapp.appsecret');
        $url = sprintf('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s', $appid, $appsecret);
        $data = self::get($url);
        $token = $data['access_token'] ?? '';
        if (!empty($token)) {
            cache($key, $token, 7000);
            return $token;
        }
        throw new \Exception('获取token失败');
    }

    /** 获取推客access_token */
    private static function getToken()
    {
        $key = 'tuike_access_token';
        $accessToken = cache($key);
        if (!empty($accessToken)) {
            return $accessToken;
        }
        $appid = sysconf('tuike.appid');
        $appsecret = sysconf('tuike.appsecret');
        $url = sprintf('https://api.weixin.qq.com/cgi-bin/token?grant_type=client_credential&appid=%s&secret=%s', $appid, $appsecret);
        $data = self::get($url);
        $token = $data['access_token'] ?? '';
        if (!empty($token)) {
            cache($key, $token, 7000);
            return $token;
        }
        throw new \Exception('获取token失败');
    }

    private static function get($url)
    {
        $curl = curl_init();
        curl_setopt_array($curl, array(
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_ENCODING => '',
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'GET',
        ));
        $response = curl_exec($curl);
        curl_close($curl);
        return json_decode($response, true);
    }

    private static function post($url, $params, $isDecode = true)
    {
        $curl = curl_init();
        $fields = json_encode($params);
        curl_setopt_array($curl, array(
            CURLOPT_URL => $url,
            CURLOPT_RETURNTRANSFER => true,
            CURLOPT_MAXREDIRS => 10,
            CURLOPT_TIMEOUT => 0,
            CURLOPT_FOLLOWLOCATION => true,
            CURLOPT_HTTP_VERSION => CURL_HTTP_VERSION_1_1,
            CURLOPT_CUSTOMREQUEST => 'POST',
            CURLOPT_POSTFIELDS => $fields,
        ));
        $response = curl_exec($curl);
        curl_close($curl);
        if ($isDecode) {
            return json_decode($response, true);
        }
        return $response;
    }
}
