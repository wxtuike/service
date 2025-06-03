<?php

namespace app\index\command;

use app\common\service\ApiLiveService;
use app\common\service\ApiStoreService;
use app\common\service\ApiVideoService;
use think\admin\Command;
use think\console\Input;
use think\console\input\Argument;
use think\console\Output;

/**
 * 达人数据同步
 * Class Talent
 * @package app\index\command
 */
class Talent extends Command
{
    protected function configure()
    {
        $this->setName('talent')
            ->setDescription('达人相关数据同步')
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
     * 同步所有达人
     */
    public function syncTalent()
    {
        $this->setQueueProgress('同步所有达人', 0);
        $res = ApiVideoService::instance()->syncTalent();
        $str = sprintf("同步所有达人完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 50);
        $this->setQueueProgress('正在同步合作店播', 55);
        $res = ApiStoreService::instance()->syncAllStore();
        $str = sprintf("同步合作店播完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 80);
        $res = ApiStoreService::instance()->syncAllPromoter();
        $str = sprintf("同步店播所有关联帐号列表，总数：%s,更新:%s", $res['count'], $res['update']);
        $this->setQueueProgress($str, 99);
        $this->setQueueProgress('所有更新已经完成', 100);
        return true;
    }

    /**
     * 同步短视频
     */
    public function syncFeed()
    {
        $this->setQueueProgress('同步短视频', 0);
        $res = ApiVideoService::instance()->syncVideo();
        $str = sprintf("同步短视频完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 50);

        $res = ApiStoreService::instance()->syncVideo();
        $str = sprintf("同步店播短视频完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 100);
        return true;
    }

    /**
     * 同步预约直播
     */
    public function syncPreLive()
    {
        $this->setQueueProgress('同步预约直播', 0);
        $res = ApiLiveService::instance()->syncPreLive();
        $str = sprintf("同步预约直播完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 100);
        return true;
    }

    /**
     * 同步进行中的直播
     */
    public function syncNewLive()
    {
        $this->setQueueProgress('同步进行中的直播', 0);
        $res = ApiLiveService::instance()->syncNewLive();
        $str = sprintf("同步进行中的直播，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 100);
        return true;
    }

    /**
     * 同步进行中的直播
     */
    public function syncLive()
    {
        $this->setQueueProgress('同步预约中的直播', 0);
        $res = ApiLiveService::instance()->syncPreLive();
        $str = sprintf("同步预约中的直播完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 25);
        $res = ApiStoreService::instance()->syncPreLive();
        $str = sprintf("同步店播预约中的直播完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 50);
        $res = ApiLiveService::instance()->syncNewLive();
        $str = sprintf("同步所有直播完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 75);
        $res = ApiStoreService::instance()->syncNewLive();
        $str = sprintf("同步店播所有直播完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 100);
        return true;
    }


    /**
     * 同步直播商品
     */
    public function syncLiveProduct()
    {
        $this->setQueueProgress('同步直播产品', 0);
        $res = ApiLiveService::instance()->syncLiveProduct();
        $str = sprintf("同步直播产品完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 50);
        $res = ApiStoreService::instance()->syncLiveProduct();
        $str = sprintf("同步店播直播产品完成，总数：%s,新增:%s,更新:%s", $res['count'], $res['insert'], $res['update']);
        $this->setQueueProgress($str, 100);
        return true;
    }
}
