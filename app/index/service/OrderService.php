<?php

declare(strict_types=1);

namespace app\index\service;

use think\admin\Service;
use think\facade\Db;

/**
 * 订单服务
 * @class OrderService
 * @package app\index\service
 */
class OrderService extends Service
{
    /** 订单状态 */
    const ORDER_STATUS = [
        '0' => '待返佣',
        '1' => '已结算',
        '2' => '已失效',
    ];
    /**
     * 获取订单列表
     */
    public function list($userId, $status)
    {
        $query = $this->app->db->name('TkOrder')
            ->field('id,order_id,product_title,product_id,product_img,shop_app_id,amount,commission,create_time,status,talent_nickname')
            ->where('user_id', $userId)
            ->order('id desc');
        if ($status != '') {
            $query->where('status', $status);
        }
        $list = $query->paginate(20)->toArray();
        $data = $list['data'];
        $ids = array_unique(array_column($data, 'product_id'));
        $productKeys = $this->getProducts($ids);
        $roleId = Db::name('TkUser')->where('id', $userId)->value('role_id');
        $data = array_map(function ($v) use ($productKeys, $roleId) {
            $v['create_time'] = format_date($v['create_time'], 'Y-m-d H:i');
            $v['talent_nickname'] = empty($v['talent_nickname']) ? '商品卡' : $v['talent_nickname'];
            $v['status_name'] = self::ORDER_STATUS[$v['status']] ?? '';
            $v['goods_id'] = $productKeys[$v['product_id']]['goods_id'] ?? '';
            $v['amount'] = formatMoney2($v['amount']);
            $v['commission'] = UserService::instance()->commissionByRoleId($roleId, $v['commission']);
            return $v;
        }, $data);
        $list['data'] = $data;
        return $list;
    }

    /**
     * 获取正在售卖的商品key=>value
     */
    private function getProducts($ids)
    {
        if (empty($ids)) return [];
        $sql = <<<SQL
SELECT t1.goods_id,t1.product_id,t1.plan_type,t1.shop_appid
FROM tk_goods t1
INNER JOIN (
    SELECT product_id, MIN(plan_type) AS p_type
    FROM tk_goods
    WHERE product_id IN (%s) AND `status` = 1
    GROUP BY product_id
) t2 ON t1.product_id = t2.product_id AND t1.plan_type = t2.p_type
SQL;
        $ids = array_map(function ($v) {
            return "'{$v}'";
        }, $ids);
        $ids = implode(',', $ids);
        $sql = sprintf($sql, $ids);
        $list = Db::query($sql);
        $res = [];
        foreach ($list as $row) {
            $res[$row['product_id'] . ''] = $row;
        }
        return $res;
    }
}
