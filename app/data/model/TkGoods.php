<?php

declare(strict_types=1);

namespace app\data\model;

use think\admin\Model;
use think\model\relation\HasOne;

class TkGoods extends Model
{
    /**
     * 关联店铺
     * @return \think\model\relation\HasOne
     */
    public function shop(): HasOne
    {
        return $this->hasOne(TkShop::class, 'appid', 'shop_appid');
    }

    /**
     * 关联类目
     * @return \think\model\relation\HasOne
     */
    public function cate(): HasOne
    {
        return $this->hasOne(TkCate::class, 'id', 'cate_id');
    }

    /**
     * 绑定店铺数据
     * @return \think\model\relation\HasOne
     */
    public function bindShop(): HasOne
    {
        return $this->shop()->bind([
            'shop_headimg_url'  => 'headimg_url',
            'shop_nickname' => 'nickname',
        ]);
    }

    /**
     * 绑定分类数据
     * @return \think\model\relation\HasOne
     */
    public function bindCate(): HasOne
    {
        return $this->cate()->bind([
            'cate_name'  => 'name',
        ]);
    }
}
