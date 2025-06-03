<?php

namespace app\index\command;

use app\common\service\ApiOrderService;
use app\common\service\GoodsService;
use think\admin\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\Output;

/**
 * 商品同步
 * Class Goods
 * @package app\index\command
 */
class Goods extends Command
{
    protected function configure()
    {
        $this->setName('goods')
            ->setDescription('商品处理')
            ->addArgument('action', Argument::OPTIONAL, "执行方法");
    }

    protected function execute(Input $input, Output $output)
    {
        $action = trim($input->getArgument('action'));
        if (empty($action)) {
            return $output->writeln("请输入执行方法");
        }
        $this->$action();
        $this->setQueueSuccess('执行成功');
    }

    /**
     * 同步最近合作的定向商品，10页200条
     *
     */
    public function syncAllGoods()
    {
        $this->setQueueProgress('同步所有订阅商品', 0);
        $count = GoodsService::instance()->syncAllGoods2();
        $this->setQueueProgress('同步所有订阅商品完成,数量：' . $count, 100);
        return true;
    }

    /**
     * 全量更新商品
     */
    public function updateAllGoods()
    {
        $this->setQueueProgress('全量更新商品开始...', 0);
        GoodsService::instance()->updateAllGoods();
        $this->setQueueProgress('全量更新商品完成', 100);
        return true;
    }

    /**
     * 更新订单
     */
    public function syncOrders()
    {
        $this->setQueueProgress('同步昨天到今天的订单', 0);
        ApiOrderService::instance()->syncAllOrders();
        $this->setQueueProgress('同步订单完成', 100);
        return true;
    }

    /**
     * 同步所有合作中的小店
     */
    public function syncShop()
    {
        $this->setQueueProgress('同步所有合作中的小店', 0);
        $res = GoodsService::instance()->syncAllShop();
        $str = sprintf("同步所有合作中的小店完成，总数：%s,新增:%s,更新:%s,解绑:%s", $res['count'], $res['insert'], $res['update'], $res['unbind']);
        $this->setQueueProgress($str, 100);
        return true;
    }
}
