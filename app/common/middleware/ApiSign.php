<?php

declare(strict_types=1);

namespace app\common\middleware;

use Closure;
use think\Request;
use Tools\ApiCheck;

/**
 * 接口验签
 */
class ApiSign
{
    public function handle(Request $request, Closure $next)
    {
        $signStr = input('sign') ?: $request->header('sign', '');
        if (isDebug() && empty($signStr)) {
            return $next($request);
        }
        if (empty($signStr)) {
            fail('签名不能为空！');
        }
        $signArr = explode('-', $signStr);
        if (count($signArr) !== 3) {
            fail('签名格式错误！');
        }
        $params = [
            'noncestr'  => $signArr[0] ?? '',
            'timestamp' => $signArr[1] ?? 0,
            'sign'      => $signArr[2] ?? ''
        ];
        $check = new ApiCheck();
        $params['s'] = $_REQUEST['s'] ?? ''; //接口名称
        $msg = '验签失败！';
        if ($check->verifySign($params, $msg) === false) {
            fail($msg, 400);
        }
        return $next($request);
    }
}
