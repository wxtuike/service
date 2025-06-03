<?php

declare(strict_types=1);

namespace app\common\service;

use think\admin\Service;
use think\facade\Db;

/** 优惠券相关 */
class ApiCouponService extends Service
{
    /**
     * 同步所有优惠券
     */
    public function syncAll()
    {
        // 1、公开券
        $ids1 = $this->getCouponList();
        // 2、定向券
        $ids2 = $this->getCooperativeCouponList();
        $ids = array_merge($ids1, $ids2);
        $count = count($ids);
        if ($count > 0) {
            $update = Db::name('TkCoupon')
                ->whereNotIn('coupon_id', $ids)
                ->update(['show' => 0]);
        }
        return ['count' => $count, 'update' => $update];
    }

    /**
     * 定向券
     */
    private function getCooperativeCouponList()
    {
        $ret = [];
        $list = ApiService::getCooperativeCouponList();
        if ($list) {
            foreach ($list as $t) {
                $couponId = $t['coupon_id'] ?? '';
                if (!empty($couponId)) {
                    $detail = $this->getDetail($couponId);
                    if ($detail) {
                        $ret[] = $detail;
                    }
                }
            }
        }
        return $ret;
    }


    // 获取所有公开优惠券
    private function getCouponList()
    {
        $sql = 'select DISTINCT shop_appid from tk_goods';
        $list = Db::query($sql);
        $ret = [];
        foreach ($list as $v) {
            $res = ApiService::getCouponList($v['shop_appid']);
            $res = $res['coupons'] ?? [];
            if ($res) {
                foreach ($res as $t) {
                    $couponId = $t['coupon_id'] ?? '';
                    if (!empty($couponId)) {
                        $detail = $this->getDetail($couponId);
                        if ($detail) {
                            $ret[] = $detail;
                        }
                    }
                }
            }
        }
        return $ret;
    }


    /**
     * 获取优惠券详情
     *
     * @param [type] $couponId
     */
    private function getDetail($couponId)
    {
        $coupon = ApiService::getCouponDetail($couponId);
        $coupon = $coupon['coupon'] ?? [];
        if ($coupon) {
            $data = [
                'coupon_id' => $coupon['coupon_id'],
                'name' => $coupon['coupon_info']['name'] ?? '',
                'shop_appid' => $coupon['shop_appid'],
                'type' => $coupon['type'],
                'status' => $coupon['status'],
                'start_time' => $coupon['coupon_info']['receive_info']['start_time'] ?? 0,
                'end_time' => $coupon['coupon_info']['receive_info']['end_time'] ?? 0,
                'total_num' => $coupon['coupon_info']['receive_info']['total_num'] ?? 0,
                'limit_num_one_person' => $coupon['coupon_info']['receive_info']['limit_num_one_person'] ?? 1,
                'issued_num' => $coupon['stock_info']['issued_num'] ?? 0,
                'discount_num' => $coupon['coupon_info']['discount_info']['discount_num'] ?? 0,
                'discount_fee' => $coupon['coupon_info']['discount_info']['discount_fee'] ?? 0,
                'product_cnt' => $coupon['coupon_info']['discount_info']['discount_condition']['product_cnt'] ?? 0,
                'product_price' => $coupon['coupon_info']['discount_info']['discount_condition']['product_price'] ?? 0,
            ];
            $productIds = $coupon['coupon_info']['discount_info']['discount_condition']['product_ids'] ?? '';
            if (!empty($productIds)) {
                $data['product_ids'] = json_encode($productIds, JSON_UNESCAPED_UNICODE);
            }
            $type = $coupon['type'];
            $discountNum = round($data['discount_num'] / 1000, 2);
            $discountFee = round($data['discount_fee'] / 100, 2);
            $productCnt = $data['product_cnt'];
            $productPrice = round($data['product_price'] / 100, 2);
            /*
            1	商品条件折券, discount_condition.product_ids, discount_condition.product_cnt, discount_info.discount_num 必填
            2	商品满减券, discount_condition.product_ids, discount_condition.product_price, discount_info.discount_fee 必填
            3	商品统一折扣券, discount_condition.product_ids, discount_info.discount_num必填
            4	商品直减券, 如果小于可用的商品中的最小价格会提醒(没有商品时超过50w提醒）, discount_condition.product_ids, discount_fee 必填
            101	店铺条件折扣券, discount_condition.product_cnt, discount_info.discount_num必填
            102	店铺满减券, discount_condition.product_price, discount_info.discount_fee 必填
            103	店铺统一折扣券, discount_info.discount_num 必填
            104	店铺直减券, 如果小于可用的商品中的最小价格会提醒(没有商品时超过50w提醒）, discount_fee 必填
            */
            $title = $condition = '';
            $discount = 0; //折扣/减价 值
            $discountType = 0; //0 折扣券 1 减价券
            $isAll = 0; //0指定商品 1 全店
            switch ($type) {
                case 1:
                    $discount = $discountNum;
                    $discountType = 0;
                    $title = sprintf('指定商品满%s件%s折', $productCnt, $discountNum);
                    $condition = sprintf('指定商品满%s件', $productCnt);
                    break;
                case 2:
                    $discount = $discountFee;
                    $discountType = 1;
                    $title = sprintf('指定商品满%s元减%s元', $productPrice, $discountFee);
                    $condition = sprintf('指定商品满%s元', $productPrice);
                    break;
                case 3:
                    $discount = $discountNum;
                    $discountType = 0;
                    $title = sprintf('指定商品%s折', $discountNum);
                    $condition = '指定商品';
                    break;
                case 4:
                    $discount = $discountFee;
                    $discountType = 1;
                    $title = sprintf('指定商品立减%s元', $discountFee);
                    $condition = '指定商品';
                    break;
                case 101:
                    $isAll = 1;
                    $discount = $discountNum;
                    $discountType = 0;
                    $title = sprintf('全店满%s件%s折', $productCnt, $discountNum);
                    $condition = sprintf('指定商品满%s件', $productCnt);
                    break;
                case 102:
                    $isAll = 1;
                    $discount = $discountFee;
                    $discountType = 1;
                    $title = sprintf('全店满%s元减%s元', $productPrice, $discountFee);
                    $condition = sprintf('全店满%s元', $$productPrice);
                    break;
                case 103:
                    $isAll = 1;
                    $discount = $discountNum;
                    $discountType = 0;
                    $title = sprintf('全店%s折', $discountNum);
                    $condition = '全店';
                    break;
                case 104:
                    $isAll = 1;
                    $discount = $discountFee;
                    $discountType = 1;
                    $title = sprintf('全店立减%s元', $discountFee);
                    $condition = '全店';
                    break;
            }
            $data['discount'] = $discount;
            $data['discount_type'] = $discountType;
            $data['title'] = $title;
            $data['condition'] = $condition;
            $data['is_all'] = $isAll;
            $data['show'] = 1;
            $row = Db::name('TkCoupon')->field('id,coupon_id')->where('coupon_id', $couponId)->find();
            if ($row) {
                Db::name('TkCoupon')->where('id', $row['id'])->update($data);
            } else {
                Db::name('TkCoupon')->insert($data);
            }
            return $couponId;
        }
    }
}
