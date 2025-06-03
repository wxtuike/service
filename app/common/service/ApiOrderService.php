<?php

declare(strict_types=1);

namespace app\common\service;

use app\common\service\ApiService;
use think\admin\Service;

class ApiOrderService extends Service
{
    /**
     * 全量同步订单
     */
    public function syncAllOrders()
    {
        //取前一天更新的订单
        $yesterday = date('Y-m-d', strtotime('-1 day'));
        $time = strtotime($yesterday);
        $list = ApiService::getOrders($time);
        foreach ($list as $data) {
            $this->updateOrder($data['order_id'], $data['sku_id']);
        }
        return true;
    }

    /**
     * 更新订单
     *
     * @param [type] $orderId
     * @param [type] $skuId
     */
    public function updateOrder($orderId, $skuId)
    {
        $orderDetailRes = ApiService::orderInfo($orderId, $skuId);
        $orderDetail = $orderDetailRes['commssion_order'] ?? [];
        if (!empty($orderDetail)) {
            $orderId = $orderDetail['order_id'];
            $skuId = $orderDetail['sku_id'];
            $createTime = $orderDetail['create_time'];
            $updateTime = $orderDetail['update_time'];
            $orderStatus = $orderDetail['status'];
            $productTitle = $orderDetail['order_detail']['product_info']['title'];
            $productId = $orderDetail['order_detail']['product_info']['product_id'];
            $productImg = $orderDetail['order_detail']['product_info']['thumb_img'];
            $amount = $orderDetail['order_detail']['product_info']['actual_payment'];
            $shopAppId = $orderDetail['order_detail']['shop_info']['appid'] ?? '';
            $shareAppId = $orderDetail['order_detail']['commission_info']['sharer_info']['sharer_appid'] ?? '';
            $nickname = $orderDetail['order_detail']['commission_info']['sharer_info']['nickname'] ?? '';
            $serviceRatio = $orderDetail['order_detail']['commission_info']['promoter_agency_info']['ratio'] ?? 0;
            // $serviceRatio = $serviceRatio > 0 ? round($serviceRatio / 10000) : 0; //百分比
            $serviceAmount = $orderDetail['order_detail']['commission_info']['promoter_agency_info']['amount'] ?? 0; //佣金单位分
            //服务费结算时间
            $finishedAt = $orderDetail['order_detail']['commission_info']['promoter_agency_info']['profit_sharding_suc_time'] ?? 0;
            $channelType = $orderDetail['order_detail']['commission_info']['promotion_info']['channel_type'] ?? '';
            $buyerOpenid = $orderDetail['order_detail']['buyer_info']['open_id'] ?? '';
            $buyerUnionid = $orderDetail['order_detail']['buyer_info']['union_id'] ?? '';
            $talentNickname = $orderDetail['order_detail']['commission_info']['talent_info']['nickname'] ?? '';
            $talentAppid = $orderDetail['order_detail']['commission_info']['talent_info']['talent_appid'] ?? '';
            if (empty($talentNickname)) {
                $talentNickname = $orderDetail['order_detail']['commission_info']['promotion_info']['finder_info']['nickname'] ?? '';
            }
            $finder_id = $orderDetail['order_detail']['commission_info']['promotion_info']['finder_info']['finder_id'] ?? '';
            $data = [
                'order_id' => $orderId,
                'sku_id' => $skuId,
                'create_time' => $createTime,
                'update_time' => $updateTime,
                'order_status' => $orderStatus,
                'product_title' => $productTitle,
                'product_img' => $productImg,
                'product_id' => $productId,
                'amount' => $amount,
                'shop_app_id' => $shopAppId,
                'sharer_appid' => $shareAppId,
                'nickname' => $nickname,
                'service_ratio' => $serviceRatio,
                'service_amount' => $serviceAmount,
                'finished_at' => $finishedAt,
                'channel_type' => $channelType,
                'buyer_open_id' => $buyerOpenid,
                'buyer_union_id' => $buyerUnionid,
                'talent_appid' => $talentAppid,
                'talent_nickname' => $talentNickname,
                'finder_id' => $finder_id,
            ];
            $data['is_own'] = $this->isOwn($data); //是否自购
            $commissionStatus = 0;
            switch ($orderStatus) {
                case 20:
                    $commissionStatus = 0; //待结算
                    break;
                case 100:
                    $commissionStatus = 1; //已结算
                    break;
                case 200:
                    $commissionStatus = 2; //取消
                    break;
                default:
                    $commissionStatus = 0;
                    break;
            }
            $data['commission_status'] = $commissionStatus;
            $data['status'] = $commissionStatus;
            $id = 0;
            $orderData = $this->app->db->name('TkOrder')->field('id')->where(['order_id' => $orderId, 'sku_id' => $skuId])->find();
            $id = $orderData['id'] ?? 0;
            $detail = [
                'order_id' => $id,
                'detail' => json_encode($orderDetail, JSON_UNESCAPED_UNICODE),
            ];
            if (empty($orderData)) {
                $user = $this->app->db->name('TkUser')->field('id,role_id')->where(['sharer_appid' => $shareAppId])->find();
                $userId = $user['id'] ?? 0;
                $roleId = $user['role_id'] ?? 0;
                $data['user_id'] = $userId;
                //todo:这里要处理订单佣金数据 commission，commission_status
                $data['commission'] = $data['service_amount'];
                $id = $this->app->db->name('TkOrder')->insertGetId($data);
                $detail['order_id'] = $id;
                $this->app->db->name('TkOrderDetail')->insert($detail);
            } else {
                $detail['order_id'] = $id;
                $this->app->db->name('TkOrder')->where(['id' => $id])->update($data);
                $this->app->db->name('TkOrderDetail')->where('order_id', $id)->update($detail);
            }
        }
        return true;
    }

    /**
     * 是否自购
     *
     * @param array $data
     */
    private function isOwn($data)
    {
        return 0;
    }
}
