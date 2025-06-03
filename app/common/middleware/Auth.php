<?php

declare(strict_types=1);

namespace app\common\middleware;

use Closure;
use think\Request;

/**
 * 验证登录
 */
class Auth
{
    public function handle(Request $request, Closure $next)
    {
        //Base基类里面已经取得了user_id
        if (empty($request->user_id)) {
            fail('请登录', 203);
        }
        return $next($request);
    }
}
