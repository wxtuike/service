<?php

declare(strict_types=1);

namespace app\index\controller;

use app\common\service\ApiOrderService;
use app\common\service\GoodsService;
use app\index\service\UserService;
use think\admin\Controller;

/**
 * 微信推客回调通知处理
 * @class Notify
 * @package app\index\controller
 */
class Notify extends Controller
{
    /**
     * 消息推送处理接口
     */
    public function index()
    {
        $echoStr = $_GET['echostr'] ?? '';
        if (!empty($echoStr)) {
            exit($echoStr);
        } else {
            $receive = (new \Tools\Decrypt())->getReceive();
            if ($receive) {
                $event = $info['Event'] ?? '';
                if (method_exists($this, $event)) {
                    $this->$event($receive);
                }
            }
        }
        exit("success");
    }

    /**
     * 团长商品变更通知
     * https://developers.weixin.qq.com/doc/store/leagueheadsupplier/API/callback/head_supplier_item_update.html
     */
    private function head_supplier_item_update($receive)
    {
        $itemInfo = $receive['item_info'] ?? false;
        if ($itemInfo) {
            $productId =   $itemInfo['product_id'] ?? '';
            $shopAppId =   $itemInfo['appid'] ?? '';
            if (!empty($productId) && !empty($shopAppId)) {
                try {
                    GoodsService::instance()->updateGoods2($productId, $shopAppId, true);
                } catch (\Exception $exception) {
                    p($exception);
                }
            }
        }
        return true;
    }
    /**
     * 团长佣金单变更回调(订单状态变更)
     * https://developers.weixin.qq.com/doc/store/leagueheadsupplier/API/callback/head_supplier_commission_order_update.html
     */
    private function head_supplier_commission_order_update($receive)
    {
        $orderInfo = $receive['order_info'] ?? false;
        if ($orderInfo) {
            $orderId =   $itemInfo['order_id'] ?? '';
            $skuId =   $itemInfo['sku_id'] ?? '';
            if (!empty($orderId) && !empty($skuId)) {
                try {
                    ApiOrderService::instance()->updateOrder($orderId, $skuId);
                } catch (\Exception $exception) {
                    p($exception);
                }
            }
        }
        return true;
    }

    /**
     * 订阅商品基础信息变更通知
     * https://developers.weixin.qq.com/doc/store/leagueheadsupplier/API/callback/head_supplier_subscribe_baseinfo_update.html
     */
    private function head_supplier_subscribe_product_baseinfo_update($receive)
    {
        $this->head_supplier_item_update($receive);
        return true;
    }

    /**
     * 订阅商品计划信息变更通知
     * https://developers.weixin.qq.com/doc/store/leagueheadsupplier/API/callback/head_supplier_subscribe_planinfo_update.html
     */
    private function head_supplier_subscribe_product_planinfo_update($receive)
    {
        $this->head_supplier_item_update($receive);
        return true;
    }

    /**
     * 推客绑定机构的回调
     * https://developers.weixin.qq.com/doc/store/leagueheadsupplier/API/callback/promoter_bind_event.html
     */
    private function promoter_bind_result($receive)
    {
        $data = [
            'bind_status' => $receive['bind_status'] ?? 0,
            'sharer_appid' => $receive['sharer_appid'] ?? '',
            'sharer_openid' => $receive['sharer_openid'] ?? '',
            'sharer_unionid' => $receive['sharer_unionid'] ?? '',
        ];
        $bindStatus = $data['bind_status'] ?? 0;
        if (!empty($bindStatus)) {
            UserService::instance()->bindNotify($data);
        }
        return true;
    }
}
