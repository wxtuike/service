<?php

namespace app\index\controller;

use app\index\service\LiveService;
use app\index\service\VideoService;

class Live extends Base
{
    protected $middleware = [
        'check', //验证签名
        // 'auth'
    ];

    /** 直播列表 */
    public function index()
    {
        $page = input('page', 1);
        $cate = input('cate', 0);
        $keyword = input('keyword', '');
        $data = LiveService::instance()->list($keyword, $cate, $page);
        success($data);
    }

    /** 直播详情 */
    public function detail()
    {
        $appid =  input('id');
        $data = LiveService::instance()->detail($appid, $this->userId);
        $data['is_bind_wxtk'] = $this->isBindTk();
        success($data);
    }

    /** 短视频列表 */
    public function video()
    {
        $cate = input('cate', 0);
        $data = VideoService::instance()->list($this->userId, $cate);
        success($data);
    }
}
