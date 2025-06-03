<?php

use app\index\command\Goods;
use app\index\command\Store;
use app\index\command\Talent;
use think\Console;

if (app()->request->isCli()) {
    Console::starting(function (Console $console) {
        $console->addCommands([Goods::class, Talent::class, Store::class]);
    });
}
