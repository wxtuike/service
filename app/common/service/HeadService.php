<?php

declare(strict_types=1);

namespace app\common\service;

use think\admin\Service;

/**
 * 达人相关接口服务
 * @class HeadService
 * @package app\common\service
 */
class HeadService extends ApiService
{
    /**
     * 达人橱窗授权状态
     */
    public static function authStatus($opentalentid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/windowauth/status/get?access_token=' . self::getToken();
        $params = [
            'opentalentid' => $opentalentid,
        ];
        return self::post($url, $params);
    }
    /**
     * 获取达人橱窗授权链接
     */
    public static function auth($openid)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/windowauth/get?access_token=' . self::getToken();
        $params = [
            'openid' => $openid,
        ];
        return self::post($url, $params);
    }

    /***
     * 添加机构商品到橱窗
     */
    public static function addWindow($product_id, $openfinderid, $product_link)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/window/add?access_token=' . self::getToken();
        $params = [
            "product_id" => $product_id,
            "openfinderid" => $openfinderid,
            "product_link" => $product_link
        ];
        return self::post($url, $params);
    }

    /***
     * 机构添加合作商品
     */
    public static function addCooperativeItem($head_supplier_item_link)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/cooperativeitem/add?access_token=' . self::getToken();
        $params = [
            "head_supplier_item_link" => $head_supplier_item_link
        ];
        return self::post($url, $params);
    }

    /***
     * 获取机构选品广场商品列表
     */
    public static function listSelectionProducts($next_key = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/selectionproducts/list/get?access_token=' . self::getToken();
        $params = [
            "plan_type" => 1,
            'spu_source' => 1,
            'page_size' => 20,
            'next_key' => $next_key,
            'spu_item_condition' => [
                'service_fee_rate_range' => [
                    'min' => 200000, // 20%服务费率
                    'max' => 1000000,
                ]
            ],
        ];
        $listRes = self::post($url, $params);
        $slist = $listRes['product_list'] ?? [];
        $nextKey = $listRes['next_key'] ?? '';
        if (count($slist) > 0) {
            $list = array_merge($list, $slist);
        }
        unset($listRes);
        unset($slist);
        if ($nextKey != '') {
            return self::listSelectionProducts($nextKey, $list);
        }
        return $list;
    }

    /***
     * 获取商品推广参数详情
     */
    public static function getItemPromotionDetail($head_supplier_item_link)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/item/promotiondetail/get?access_token=' . self::getToken();
        $params = [
            "head_supplier_item_link" => $head_supplier_item_link
        ];
        return self::post($url, $params);
    }

    /**
     * 配置达人佣金率
     *
     * @param int $cooperative_item_id 机构合作计划id
     * @param int $ratio 达人佣金率[0, 90]%，【二选一】
     */
    public static function addSubItem($cooperative_item_id, $ratio)
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/subitem/add?access_token=' . self::getToken();
        $params = [
            "cooperative_item_id" => $cooperative_item_id,
            'ratio' => $ratio
        ];
        return self::post($url, $params);
    }

    /***
     * 获取机构配置达人佣金计划列表
     */
    public static function getSubItemList($cooperative_item_id, $next_key = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/subitem/list/get?access_token=' . self::getToken();
        $params = [
            "cooperative_item_id" => $cooperative_item_id,
            'page_size' => 20,
            'next_key' => $next_key,
        ];
        $listRes = self::post($url, $params);
        $slist = $listRes['list'] ?? [];
        $nextKey = $listRes['next_key'] ?? '';
        if (count($slist) > 0) {
            $list = array_merge($list, $slist);
        }
        unset($listRes);
        unset($slist);
        if ($nextKey != '') {
            return self::getSubItemList($cooperative_item_id, $nextKey, $list);
        }
        return $list;
    }

    /***
     * 获取合作商品列表
     */
    public static function getCooperativeItemList($startTime, $next_key = '', $list = [])
    {
        $url = 'https://api.weixin.qq.com/channels/ec/league/headsupplier/cooperativeitem/list/get?access_token=' . self::getToken();
        $params = [
            "commission_type" => 1,
            'page_size' => 20,
            'next_key' => $next_key,
            'listing_time_range' => [
                'min' => $startTime, //strtotime('yesterday'), // 昨日0点
                'max' => time(),
            ],
        ];
        $listRes = self::post($url, $params);
        $slist = $listRes['list'] ?? [];
        $nextKey = $listRes['next_key'] ?? '';
        if (count($slist) > 0) {
            $list = array_merge($list, $slist);
        }
        unset($listRes);
        unset($slist);
        if ($nextKey != '') {
            return self::getCooperativeItemList($startTime, $nextKey, $list);
        }
        return $list;
    }
}
