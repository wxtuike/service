<?php

declare(strict_types=1);

namespace app\index\service;

use app\common\service\ApiService;
use think\admin\Service;

/**
 * 微信小程序相关服务
 * @class WeappService
 * @package app\index\service
 */
class WeappService extends Service
{

    protected $config = [];

    /**
     * 控制器初始化
     */
    protected function initialize()
    {
        $this->config = config('weapp');
    }

    /**
     * 根据code 获取openid
     *
     * @param string $code
     */
    public function getOpenId($code)
    {
        return ApiService::getOpenId($code);
    }

    /**
     * 生成小程序二维码
     * @param [type] $code
     */
    public function getQrCode($code)
    {
        // todo::分布式环境要考虑放在云存储上,这里放在本地存储
        $path = sprintf("%spublic/qrcode/%s.png", $this->app->getRootPath(), $code);
        if (file_exists($path)) {
            return true;
        }
        $res = ApiService::createMiniScene('mid=' . $code);
        if ($res) {
            file_put_contents($path, $res);
        }
        return true;
    }
}
