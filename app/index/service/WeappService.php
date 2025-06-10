<?php

declare(strict_types=1);

namespace app\index\service;

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
        $config = [
            'appid' => sysconf('weapp.appid'),
            'appsecret' => sysconf('weapp.appsecret'),
        ];
        $wxamp = new \WeMini\Crypt($config);
        $result = $wxamp->session($code);
        return $result['openid'] ?? '';
    }

    /**
     * 生成小程序二维码
     * @param [type] $code
     */
    public function getQrCode($code)
    {
        $path = sprintf("%spublic/qrcode/%s.png", $this->app->getRootPath(), $code);
        if (file_exists($path)) {
            return true;
        }
        $config = [
            'appid' => config('weapp.appid'), // 'wx6a53c9538e0c5734',
            'appsecret' => config('weapp.appsecret'), //'c0a9ecbfc9fa6acfa8dd4071e742df9c'
        ];
        $wxamp = new \WeMini\Qrcode($config);
        $res = $wxamp->createMiniScene('mid=' . $code);
        if ($res) {
            file_put_contents($path, $res);
        }
        return true;
    }
}
