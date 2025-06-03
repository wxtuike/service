<?php
declare (strict_types=1);

namespace app\data\model;

use think\admin\Model;
use think\model\relation\HasOne;

class TkFeed extends Model
{
    /**
     * 关联达人数据
     * @return \think\model\relation\HasOne
     */
    public function talents(): HasOne
    {
        return $this->hasOne(TkTalent::class, 'talent_appid', 'talent_appid');
    }

    /**
     * 绑定达人数据
     * @return \think\model\relation\HasOne
     */
    public function bindTalents(): HasOne
    {
        return $this->talents()->bind([
            'talent_head_img'  => 'talent_head_img',
            'talent_nickname' => 'talent_nickname',
        ]);
    }
}