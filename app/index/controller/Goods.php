<?php

namespace app\index\controller;

use app\index\service\GoodsService;
use app\index\service\LiveService;

class Goods extends Base
{
    protected $middleware = [
        'check', //验证签名
        // 'auth'
    ];

    /** 首页 */
    public function home()
    {
        $lives = LiveService::instance()->list('', 0, 1, 4);
        $cate = GoodsService::instance()->cate();
        $banner = GoodsService::instance()->banner();
        success(['lives' => $lives, 'cate' => $cate, 'banner' => $banner]);
    }
    /** 列表 */
    public function list()
    {
        $cate = input('cate_id', '');
        $keyword = input('keyword', '');
        $data = GoodsService::instance()->list($this->userId, $cate, $keyword);
        success($data);
    }

    /** 商品详情 */
    public function detail()
    {
        $id =  input('id');
        $data = GoodsService::instance()->detail($id, $this->userId);
        $data['is_bind_wxtk'] = $this->isBindTk();
        success($data);
    }
}
