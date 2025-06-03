<?php

namespace app\index\command;

use app\common\service\ApiCouponService;
use app\common\service\ApiStoreService;
use think\admin\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\Output;

/**
 * 店播数据同步
 * Class Store
 * @package app\index\command
 */
class Store extends Command
{
    protected function configure()
    {
        $this->setName('store')
            ->setDescription('店播数据同步处理')
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
     * 同步所有合作小店
     *
     */
    public function syncAllStore()
    {
        $this->setQueueProgress('同步所有合作小店', 0);
        $res = ApiStoreService::instance()->syncAllStore();
        $this->setQueueProgress('同步所有合作小店完成,数量：' . $res['count'], 100);
        return true;
    }

    /**
     * 同步店播所有关联帐号列表
     *
     */
    public function syncAllPromoter()
    {
        $this->setQueueProgress('同步店播所有关联帐号列表', 0);
        $res = ApiStoreService::instance()->syncAllPromoter();
        $this->setQueueProgress('同步店播所有关联帐号列表完成,数量：' . $res['count'], 100);
        return true;
    }

    /**
     * 同步店播预约直播
     */
    public function syncPreLive()
    {
        $this->setQueueProgress('同步店播预约直播', 0);
        $res = ApiStoreService::instance()->syncPreLive();
        $this->setQueueProgress('同步预约直播完成,数量：' . $res['count'], 100);
        return true;
    }

    /**
     * 同步店播直播
     */
    public function syncNewLive()
    {
        $this->setQueueProgress('同步店播直播', 0);
        $res = ApiStoreService::instance()->syncNewLive();
        $this->setQueueProgress('同步直播完成,数量：' . $res['count'], 100);
        return true;
    }

    /**
     * 同步店播直播商品
     */
    public function syncLiveProduct()
    {
        $this->setQueueProgress('同步店播直播商品', 0);
        $res = ApiStoreService::instance()->syncLiveProduct();
        $this->setQueueProgress('同步直播完成商品,数量：' . $res['count'], 100);
        return true;
    }


    /**
     * 同步优惠券
     */
    public function syncCoupon()
    {
        $this->setQueueProgress('同步优惠券', 0);
        $res = ApiCouponService::instance()->syncAll();
        $this->setQueueProgress('同步优惠券成功,数量：' . $res['count'], 100);
        return true;
    }
}
