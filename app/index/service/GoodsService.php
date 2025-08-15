<?php

declare(strict_types=1);

namespace app\index\service;

use think\admin\Service;
use app\common\Exception\ServiceException;
use app\common\service\ApiService;
use think\facade\Db;

/**
 * 商品服务
 * @class GoodsService
 * @package app\index\service
 */
class GoodsService extends Service
{
    /** ai文案 */
    public function ai($id)
    {
        $list = Db::name('TkGoodsAi')->where('goods_id', $id)->limit(5)->select();
        return $list;
    }

    /**
     * 保存AI文案
     */
    public function saveAi($id, $content)
    {
        Db::name('TkGoodsAi')->insert(['goods_id' => $id, 'content' => $content]);
        return true;
    }
    public function banner()
    {
        $list = Db::name('TkBanner')->select()->order('sort desc, id desc');
        $res = [];
        foreach ($list as $item) {
            $res[] = [
                'value' => $item['img'],
                'ariaLabel' => $item['id'],
                'id' => $item['product_id'],
            ];
        }
        return $res;
    }
    public function cate()
    {
        $list = Db::name('TkCate')->where('status', 1)->select();
        $res[] = ['text' => '精选推荐', 'key' => 0];
        foreach ($list as $vo) {
            $res[] = [
                'text' => $vo['name'],
                'key' => $vo['id']
            ];
        }
        return $res;
    }
    public function list($userId, $cateId = '', $keyword = '')
    {
        $query = Db::name('TkGoods')
            ->field('id,goods_id,title,sub_title,price,thumb,commission')
            ->order('id desc');
        if (!empty($keyword)) {
            $query->whereLike('title', "%{$keyword}%");
        }
        if (!empty($cateId)) {
            $query->where('cate_id', $cateId);
        }
        $list = $query->paginate(20)->toArray();
        $data = $list['data'];
        $role = Db::name('TkUser')->where('id', $userId)->value('role_id');
        foreach ($data as $k => $item) {
            $item['price'] = formatMoney2($item['price']);
            $commission = UserService::instance()->commissionByRoleId($role, $item['commission']);
            $item['commission'] = $commission;
            $item['commission_tip'] = sprintf('省/赚￥%s', $item['commission']);
            $data[$k] = $item;
        }
        $list['data'] = $data;
        return $list;
    }
    public function detail($id, $userId)
    {
        $query = Db::name('TkGoods')->field('id,goods_id,product_id,plan_type,shop_appid,title,sub_title,thumb,price,commission');
        if (is_numeric($id)) {
            $query->where(['id' => $id]);
        } else {
            $query->where(['goods_id' => $id]);
        }
        $goodsInfo = $query->find();
        if ($goodsInfo) {
            $goodsDetail = Db::name('TkGoodsDetail')
                ->field('head_imgs,desc_info')
                ->where(['goods_id' => $goodsInfo['id']])
                ->find();
            $headImgs = json_decode($goodsDetail['head_imgs'], true);
            $desc = json_decode($goodsDetail['desc_info'], true);
            $goodsInfo['head_imgs'] = $headImgs;
            $goodsInfo['desc_imgs'] = $desc['imgs'] ?? '';
            $commission = UserService::instance()->commission($userId, $goodsInfo['commission']);
            $goodsInfo['commission'] = $commission;
            $goodsInfo['price'] = formatMoney2($goodsInfo['price']);
            // $store_product = $this->getGoodsShareInfo($goodsInfo['id'], $userId);
            // unset($store_product['user_id']);
            // unset($store_product['goods_id']);
            // return ['goods_info' => $goodsInfo, 'store_product' => $store_product];
            return ['goods_info' => $goodsInfo];
        }
        throw new ServiceException('商品不存在');
    }

    /** 商品分享推客分享相关 */
    public function share($id, $userId)
    {
        $query = Db::name('TkGoods')->field('id,goods_id');
        if (is_numeric($id)) {
            $query->where(['id' => $id]);
        } else {
            $query->where(['goods_id' => $id]);
        }
        $goodsInfo = $query->find();
        if ($goodsInfo) {
            $store_product = $this->getGoodsShareInfo($goodsInfo['id'], $userId);
            unset($store_product['user_id']);
            unset($store_product['goods_id']);
            return ['store_product' => $store_product];
        }
        throw new ServiceException('商品不存在');
    }

    /**
     * 为某个推客生成单个商品的推广二维码
     */
    public function getGoodsShareInfo($goodsId, $userId)
    {
        if (empty($userId)) {
            $userId = 3;
        }
        $userGoods = Db::name('TkUserGoods')->where(['goods_id' => $goodsId, 'user_id' => $userId])->find();
        if (!empty($userGoods)) {
            return $userGoods;
        }
        $res = $this->getGoodsShareData($goodsId, $userId);
        return $res;
    }

    /**
     * 从接口获取二维码
     */
    public function getGoodsShareData($goodsId, $userId)
    {
        $goods = Db::name('TkGoods')->field('id,goods_id,product_id,plan_type,shop_appid')->where(['id' => $goodsId])->find();
        $sharerAppid = Db::name('TkUser')->where(['id' => $userId])->value('sharer_appid');
        $productId = intval($goods['product_id']);
        $shopAppid = $goods['shop_appid'];
        if (empty($sharerAppid) || empty($productId) || empty($shopAppid)) {
            return [];
        }
        $link = ApiService::getProductPromotionLink($sharerAppid, $productId, $shopAppid);
        $product_short_link = $link['product_promotion_link'] ?? '';
        $qrcode = ApiService::getProductQrcode($sharerAppid, $productId, $shopAppid);
        $qrcode_url = $qrcode['qrcode_url'] ?? '';
        $shortLink = ApiService::getProductShortLink($sharerAppid, $productId, $shopAppid);
        $short_link = $shortLink['short_link'] ?? '';
        if (!empty($short_link) && !empty($qrcode_url) && !empty($product_short_link)) {
            $data = [
                'goods_id' => $goodsId,
                'user_id' => $userId,
                'product_id' => $productId,
                'shop_appid' => $shopAppid,
                'short_link' => $short_link,
                'qrcode_url' => $qrcode_url,
                'product_promotion_link' => $product_short_link,
            ];
            Db::name('TkUserGoods')->insert($data);
            return $data;
        }
        return [];
    }
}
