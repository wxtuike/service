<?php

return [
    'alias' => [
        'cross'  => app\common\middleware\Cross::class,
        'check'  => app\common\middleware\ApiSign::class,
        'auth'  => app\common\middleware\Auth::class,
    ]
];
