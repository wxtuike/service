<?php

return [
    'host'     => env('CACHE_REDIS_HOST', '127.0.0.1'),
    'port'     => env('CACHE_REDIS_PORT', 6379),
    'select'   => env('CACHE_REDIS_SELECT', 0),
    'type'     => 1,
    'password' => env('CACHE_REDIS_PASSWORD', ''),
];
