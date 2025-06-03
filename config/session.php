<?php

return [
    // 字段名称
    'name'   => env('SESSION_NAME', 'ssid'),
    // 驱动方式
    'type'   => env('SESSION_TYPE', 'file'),
    // 存储连接
    'store'  => env('SESSION_STORE', ''),
    // 过期时间
    'expire' => env('SESSION_EXPIRE', 7200),
    // 文件前缀
    'prefix' => env('SESSION_PREFIX', ''),
];
