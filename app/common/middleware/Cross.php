<?php

declare(strict_types=1);

namespace app\common\middleware;

use Closure;
use think\Request;
use think\Response;

/**
 * 跨域处理
 */
class Cross
{
    public function handle(Request $request, Closure $next)
    {
        //OPTIONS请求返回200请求
        if ($request->method(true) === 'OPTIONS') {
            Response::create()->code(200);
        }
        // $origin = $_SERVER['HTTP_ORIGIN'] ?? '*';
        $origin = '*';
        header('Access-Control-Allow-Methods: GET,POST,OPTIONS');
        header('Access-Control-Allow-Credentials: true');
        header('Access-Control-Allow-Origin: ' . $origin);
        header('Access-Control-Allow-Headers: Authorization, Content-Type, If-Match, If-Modified-Since, If-None-Match, If-Unmodified-Since, X-CSRF-TOKEN, X-Requested-With, sign, Token, Api-Type');
        return $next($request);
    }
}
