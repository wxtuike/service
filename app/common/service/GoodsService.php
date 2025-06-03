<?php

declare(strict_types=1);

namespace app\common\service;

use app\common\code\GoodsCode;
use app\common\service\ApiService;
use think\admin\Service;

class GoodsService extends Service
{
    /** 同步所有小店信息 */
    public function syncAllShop()
    {
        $count = $insert = $update = 0;
        $ids = [];
        $list = ApiService::shopListAll('', []);
        foreach ($list as $item) {
            $count++;
            $id = $item['base_info']['appid'] ?? '';
            if (!empty($id)) {
                $ids[] = $id;
                $d = $item['base_info'];
                $d['status'] = $item['status'];
                $row = $this->app->db->name('TkShop')->where(['appid' => $id])->find();
                if (!$row) {
                    $insert++;
                    $this->app->db->name('TkShop')->insert($d);
                } else {
                    $update++;
                    $this->app->db->name('TkShop')->where(['appid' => $id])->update($d);
                }
            }
        }
        //解绑
        $unbind = $this->app->db->name('TkShop')->whereNotIn('appid', $ids)->update(['bind' => 0]);
        return compact('count', 'insert', 'update', 'unbind');
    }

    /**
     * 同步最新商品
     */
    public function syncAllGoods($planType = 1, $page = 3)
    {
        $list = ApiService::getAllGoods($planType, $page);
        foreach ($list as $data) {
            $this->updateGoods($data['product_id'], $data['shop_appid'], $planType);
        }
        return true;
    }

    /**
     * 通过订阅列表接口全量更新商品
     */
    public function syncAllGoods2()
    {
        $list = ApiService::getSubscribe();
        foreach ($list as $data) {
            $this->updateGoods2($data['product_id'], $data['shop_appid']);
        }
        return count($list);
    }

    /**
     * 全量更新商品
     */
    public function updateAllGoods()
    {
        $list = $this->app->db->name('TkGoods')->where('goods_status', 5)->field('id,product_id,plan_type,shop_appid')->select();
        foreach ($list as $data) {
            $planType = intval($data['plan_type']);
            $this->updateGoods($data['product_id'], $data['shop_appid'], $planType);
        }
        return true;
    }

    /**
     * 更新商品
     *
     * @param [type] $productId
     * @param [type] $shopAppId
     * @param boolean $forceUpdate 是否强制更新
     */
    public function updateGoods2($productId, $shopAppId, $forceUpdate = false)
    {
        $find = $this->app->db->name('TkGoods')->field('id')->where(['product_id' => $productId, 'shop_appid' => $shopAppId])->find();
        if ($find && !$forceUpdate) {
            return false;
        }
        $goods = ApiService::getGoodsInfo2($productId, $shopAppId);
        $planType = $goods['plan_type'] ?? 0;
        $goodsId = sprintf('%s_%s_%s', $shopAppId, $productId, $planType);
        $product = $goods['product'] ?? [];
        if (!empty($product)) {
            $productInfo = $product['product_info'];
            $commissionInfo = $product['commission_info'];
            $goodsStatus = $productInfo['status'] ?? 1;
            $commissionStatus = $commissionInfo['status'] ?? 0;
            //异常状态商品不同步
            if ($goodsStatus != 5 || !in_array($commissionStatus, [1, 3])) {
                return false;
            }
            $headImgs = $productInfo['head_imgs'];
            $descInfo = $productInfo['desc_info'];
            $catsV2 = $productInfo['cats_v2'];
            $skus = $productInfo['skus'];
            $price = [];
            foreach ($skus as $sku) {
                $price[] = $sku['sale_price'];
            }
            $price = min($price);
            $commissionRate = bcdiv($commissionInfo['service_ratio'] . '', 1000000 . '', 2);
            $commission = bcmul($price . '', $commissionRate . '');
            $catId = $catsV2[0]['cat_id'];
            $update = [
                'goods_id' => $goodsId,
                'product_id' => $productId,
                'shop_appid' => $shopAppId,
                'plan_type' => $planType,
                'title' => $productInfo['title'],
                'sub_title' => $productInfo['sub_title'],
                'cat_id' => $catId,
                'cate_id' => GoodsCode::CATE_DIC[$catId] ?? 0,
                'thumb' => $headImgs[0] ?? '',
                'price' => $price,
                'commission' => $commission,
                'commission_rate' => $commissionRate,
                'end_time' => $commissionInfo['end_time'],
                'start_time' => $commissionInfo['start_time'],
                'goods_status' => $goodsStatus,
                'commission_status' => $commissionStatus,
                'update_time' => time()
            ];
            $goodsData = $this->app->db->name('TkGoods')->field('id')->where(['goods_id' => $goodsId])->find();
            $id = $goodsData['id'] ?? 0;
            if (empty($goodsData)) {
                $id = $this->app->db->name('TkGoods')->insertGetId($update);
            } else {
                $this->app->db->name('TkGoods')->where(['goods_id' => $goodsId])->update($update);
            }
            $detail = [
                'goods_id' => $id,
                'head_imgs' => json_encode($headImgs, JSON_UNESCAPED_UNICODE),
                'desc_info' => json_encode($descInfo, JSON_UNESCAPED_UNICODE),
                'content' => json_encode($goods, JSON_UNESCAPED_UNICODE)
            ];
            $row = $this->app->db->name('TkGoodsDetail')->field('goods_id')->where('goods_id', $id)->find();
            if (!empty($row)) {
                $this->app->db->name('TkGoodsDetail')->where('goods_id', $id)->update($detail);
            } else {
                $this->app->db->name('TkGoodsDetail')->insert($detail);
            }
        }
        return true;
    }

    private function updateGoods($productId, $shopAppId, $planType)
    {
        $goodsId = sprintf('%s_%s_%s', $shopAppId, $productId,  $planType);
        $goods = ApiService::getGoodsInfo($productId, $shopAppId, $planType);
        $product = $goods['product'] ?? [];
        if (!empty($product)) {
            $productInfo = $product['product_info'];
            $commissionInfo = $product['commission_info'];
            $goodsStatus = $productInfo['status'] ?? 1;
            $commissionStatus = $commissionInfo['status'] ?? 0;
            //异常状态商品不同步
            if ($goodsStatus != 5 || !in_array($commissionStatus, [1, 3])) {
                return false;
            }
            $headImgs = $productInfo['head_imgs'];
            $descInfo = $productInfo['desc_info'];
            $catsV2 = $productInfo['cats_v2'];
            $skus = $productInfo['skus'];
            $price = [];
            foreach ($skus as $sku) {
                $price[] = $sku['sale_price'];
            }
            $price = min($price);
            $commissionRate = bcdiv($commissionInfo['service_ratio'] . '', 1000000 . '', 2);
            $commission = bcmul($price . '', $commissionRate . '');
            $catId = $catsV2[0]['cat_id'];
            $update = [
                'goods_id' => $goodsId,
                'product_id' => $productId,
                'shop_appid' => $shopAppId,
                'plan_type' => $planType,
                'title' => $productInfo['title'],
                'sub_title' => $productInfo['sub_title'],
                'cat_id' => $catId,
                'cate_id' => GoodsCode::CATE_DIC[$catId] ?? 0,
                'thumb' => $headImgs[0] ?? '',
                'price' => $price,
                'commission' => $commission,
                'commission_rate' => $commissionRate,
                'end_time' => $commissionInfo['end_time'],
                'start_time' => $commissionInfo['start_time'],
                'goods_status' => $goodsStatus,
                'commission_status' => $commissionStatus,
                'update_time' => time()
            ];
            $goodsData = $this->app->db->name('TkGoods')->field('id')->where(['goods_id' => $goodsId])->find();
            $id = $goodsData['id'] ?? 0;
            if (empty($goodsData)) {
                $id = $this->app->db->name('TkGoods')->insertGetId($update);
            } else {
                $this->app->db->name('TkGoods')->where(['goods_id' => $goodsId])->update($update);
            }
            $detail = [
                'goods_id' => $id,
                'head_imgs' => json_encode($headImgs, JSON_UNESCAPED_UNICODE),
                'desc_info' => json_encode($descInfo, JSON_UNESCAPED_UNICODE),
                'content' => json_encode($goods, JSON_UNESCAPED_UNICODE)
            ];
            $row = $this->app->db->name('TkGoodsDetail')->field('goods_id')->where('goods_id', $id)->find();
            if (!empty($row)) {
                $this->app->db->name('TkGoodsDetail')->where('goods_id', $id)->update($detail);
            } else {
                $this->app->db->name('TkGoodsDetail')->insert($detail);
            }
        }
        return true;
    }
}
