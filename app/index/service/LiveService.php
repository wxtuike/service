<?php

declare(strict_types=1);

namespace app\index\service;

use think\admin\Service;
use app\common\Exception\ServiceException;
use app\common\service\ApiService;
use think\facade\Db;

/**
 * 直播服务
 * @class LiveService
 * @package app\index\service
 */
class LiveService extends Service
{
    /** 直播详情 */
    public function detail($appid, $userId)
    {
        $sql = <<<SQL
SELECT l.live_id,l.talent_appid,l.type,l.description as invite_desc,l.start_time,l.live_status,t.talent_nickname as title,t.talent_head_img as thumb,t.share_text,t.rate
FROM tk_live l
LEFT JOIN tk_talent t ON l.talent_appid=t.talent_appid
WHERE l.talent_appid=:id AND l.live_status=1 ORDER BY l.start_time ASC LIMIT 1
SQL;
        $res = Db::query($sql, ['id' => $appid]);
        $live = $res[0] ?? false;
        if ($live) {
            $live['share_text'] = empty($live['share_text']) ? $live['invite_desc'] : $live['share_text'];
            $live['start_time'] = empty($live['start_time']) ? '' : date('n月j日 H:i:s开播', $live['start_time']);
            $live['commission_rate'] = $live['rate'] . '%';
            $live['goods_list'] = $this->getProduct($appid, $userId);
            $liveData = $this->getLiveShareInfo($live['live_id'], $userId);
            $live['qrcode_url'] = $liveData['qrcode_url'] ?? '';
            $live['promoter_share_link'] = $liveData['promoter_share_link'] ?? '';
            return $live;
        }
        throw new ServiceException('直播不存在');
    }

    /**
     * 获取直播列表
     *
     * @param string $keyword
     * @param integer $cate
     * @param integer $page
     * @return array
     */
    public function list($keyword = '', $cate = 0, $page = 1, $paegSize = 20)
    {
        $sql = <<<SQL
SELECT l.talent_appid,l.live_id,l.description as invite_desc,l.start_time,l.type,t.talent_nickname as title,t.talent_head_img as thumb,t.sort,l.live_status,t.rate
FROM tk_talent t
JOIN tk_live l 
ON l.talent_appid=t.talent_appid
AND l.start_time = (
    SELECT MIN(start_time)
    FROM tk_live
    WHERE talent_appid = l.talent_appid
    AND live_status = 1
)
WHERE t.`status`=1 AND l.live_status=1 
SQL;
        $params = [];
        if (!empty($cate)) {
            if ($cate == 1) {
                $sql .= ' AND t.`is_shop`=0';
            } else {
                $sql .= ' AND t.`is_shop`=1';
            }
        }
        if (!empty($keyword)) {
            $sql .= ' AND t.`talent_nickname` LIKE :name';
            $params['name'] = "%{$keyword}%";
        }
        $sql .= ' ORDER BY t.sort DESC,l.type DESC';
        //分页
        $page = $page > 0 ? $page : 1;
        $offset = ($page - 1) * $paegSize;
        $sql .= sprintf(' LIMIT %d,%d', $offset, $paegSize);
        $list = Db::query($sql, $params);
        $list = array_map(function ($item) {
            $item['start_time'] = date('n月j日 H:i:s开播', $item['start_time']);
            $item['commission_rate'] = $item['rate'] . '%';
            return $item;
        }, $list);
        return $list;
    }

    public function getProduct($appid, $userId)
    {
        $list = Db::name('TkLiveProduct')
            ->where(['talent_appid' => $appid, 'status' => 1])
            ->select()
            ->toArray();
        $role = Db::name('TkUser')->where('id', $userId)->value('role_id');
        $list = array_map(function ($item) use ($role) {
            $item['thumb'] = $item['product_img_url'];
            $item['title'] = $item['product_name'];
            $item['product_price'] = formatMoney2($item['product_price']);
            //这里要处理身份问题
            $item['predict_commission_amount'] =  UserService::instance()->commissionByRoleId($role, $item['predict_commission_amount']);
            $item['price'] = $item['product_price'];
            $item['share_commission'] = $item['predict_commission_amount'];
            return $item;
        }, $list);
        return $list;
    }


    /**
     * 为某个推客生成单个直播的推广二维码
     */
    public function getLiveShareInfo($liveId, $userId)
    {
        if (empty($userId)) {
            $userId = 3;
        }
        $userLive = Db::name('TkUserLive')->where(['live_id' => $liveId, 'user_id' => $userId])->find();
        if ($userLive) {
            return [
                'qrcode_url' => $userLive['content'],
                'promoter_share_link' => $userLive['promoter_share_link']
            ];
        }
        $res = $this->getLiveQrcode($liveId, $userId);
        return $res;
    }

    /**
     * 从接口获取二维码
     */
    public function getLiveQrcode($liveId, $userId)
    {
        $live = Db::name('TkLive')->where(['live_id' => $liveId])->find();
        $sharerAppid = Db::name('TkUser')->where(['id' => $userId])->value('sharer_appid');
        $type = $live['type']; //0预约，1直播
        $talent_appid = $live['talent_appid'];
        if (empty($sharerAppid) || empty($talent_appid)) {
            return [];
        }
        $res = [];
        $qrUrl = $promoter_share_link = '';
        $isShop = $live['is_shop'];
        $shop_appid = $live['shop_appid'];
        $promoter_id = $live['talent_appid'];
        $export_id = $live['live_id'];
        if ($type == 0) {
            if ($isShop == 0) {
                $res = ApiService::liveNoticeQrcode($liveId, $talent_appid, $sharerAppid);
                $linkRes = ApiService::getLiveNoticePromotersharelink($liveId, $talent_appid, $sharerAppid);
                $promoter_share_link = $linkRes['promoter_share_link'] ?? '';
            } else {
                $res = ApiService::getShopLiveNoticeRecordQrCode($shop_appid, $promoter_id, $export_id, $sharerAppid);
                $linkRes = ApiService::getShopLiveNoticePromotersharelink($shop_appid, $promoter_id, $export_id, $sharerAppid);
                $promoter_share_link = $linkRes['promoter_share_link'] ?? '';
            }
        } else {
            if ($isShop == 0) {
                $res = ApiService::liveQrcode($liveId, $talent_appid, $sharerAppid);
                $liveRes = ApiService::liveList($talent_appid, $sharerAppid);
                $liveRes = $liveRes['live_record_list'][0] ?? [];
                $promoter_share_link = $liveRes['promoter_share_link'] ?? '';
            } else {
                $res = ApiService::getShopLiveRecordQrCode($shop_appid, $promoter_id, $export_id, $sharerAppid);

                $liveRes = ApiService::getShopLiveRecordList($shop_appid, $promoter_id, $sharerAppid);
                $liveRes = $liveRes['live_record_list'][0] ?? [];
                $promoter_share_link = $liveRes['promoter_share_link'] ?? '';
            }
        }
        $qrUrl = $res['qrcode_url'] ?? '';
        if (!empty($qrUrl)) {
            Db::name('TkUserLive')->insert([
                'live_id' => $liveId,
                'user_id' => $userId,
                'content' => $qrUrl,
                'type' => $type,
                'promoter_share_link' => $promoter_share_link
            ]);
        }
        return ['qrcode_url' => $qrUrl, 'promoter_share_link' => $promoter_share_link];
    }
}
