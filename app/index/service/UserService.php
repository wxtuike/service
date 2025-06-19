<?php

declare(strict_types=1);

namespace app\index\service;

use think\admin\Service;
use app\common\Db\RedisDb;
use Tools\ApiCheck;
use app\common\code\RedisCode;
use app\common\Exception\ServiceException;
use app\common\service\ApiService;
use think\facade\Db;

/**
 * 用户服务
 * @class UserService
 * @package app\index\service
 */
class UserService extends Service
{
    const ROLE_NAME = [
        '0' => '普通用户',
        '1' => '推客',
        '2' => 'VIP'
    ];

    /**
     * 根据身份获取佣金（返回单位元）
     *
     * @param int $roleId
     * @param float $commission 单位(分)
     */
    public function commissionByRoleId($roleId, $commission)
    {
        $rates = [
            '1' => 0.5, // 推客50%
            '2' => 0.8 //Vip 80%
        ];
        $rate = $rates[$roleId . ''] ?? 0.5;
        $commission = round($commission / 100 * $rate, 2);
        return $commission;
    }
    /**
     * 获取当前用户的佣金（返回单位元）
     *
     * @param int $userId
     * @param float $commission 单位(分)
     */
    public function commission($userId, $commission)
    {
        $rates = [
            '1' => 0.5, // 推客50%
            '2' => 0.8 //Vip 80%
        ];
        $rate = 0.5;
        if (empty($userId)) {
            $role = Db::name('TkUser')->where('id', $userId)->value('role_id');
            $rate = $rates[$role . ''] ?? 0.5;
        }
        $commission = round($commission / 100 * $rate, 2);
        return $commission;
    }
    /** 我的上级及顾问 */
    public function share($userId)
    {
        $user = Db::name('TkUser')->field('id,tid,sid,nickname,head_img_url,code')->where('id', $userId)->find();
        $tid = $user['tid'] ?? 0;
        $share = [];
        if ($tid > 0) {
            $share = Db::name('TkUser')->field('nickname,head_img_url,code')->where('id', $tid)->find();
            $share['head_img_url'] = avatar($share['head_img_url']);
        }
        $sid = $user['sid'] ?? 0;
        $service = [];
        if ($sid > 0) {
            $service = Db::name('TkUser')->field('nickname,head_img_url,code,mobile')->where('id', $sid)->find();
            $service['head_img_url'] = avatar($service['head_img_url']);
            $service['m_mobile'] = hideMobile($service['mobile']);
        }
        return ['share' => $share, 'service' => $service];
    }

    /**
     * 海报
     */
    public function card($userId)
    {
        $card = Db::name('TkCard')->field('url')->where('status', 1)->select();
        $user = Db::name('TkUser')->field('nickname,head_img_url,code')->where('id', $userId)->find();
        $qrUrl = sprintf('%sqrcode/%s.png', url('/', [], false, true), $user['code']);
        return ['url' => $qrUrl, 'card' => $card, 'user' => $user];
    }
    /**
     * 粉丝数量
     */
    public function fans($userId)
    {
        $count = Db::name('TkUser')->where('tid', $userId)->count();
        $count1 = Db::name('TkUser')->where('tid', $userId)->where('role_id', '>', 0)->count();
        return [
            'count' => $count,
            'count1' => $count1,
        ];
    }
    /** 粉丝列表 */
    public function fansList($userId)
    {
        $query = $this->app->db->name('TkUser')
            ->field('code,nickname,head_img_url,role_id,create_at')
            ->where('tid', $userId)
            ->order('id desc');
        $list = $query->paginate(20)->toArray();
        $data = $list['data'];
        $data = array_map(function ($v) {
            $v['head_img_url'] = avatar($v['head_img_url']);
            $v['role_name'] = self::ROLE_NAME[$v['role_id']] ?? '';
            return $v;
        }, $data);
        $list['data'] = $data;
        return $list;
    }
    /** 资金流水 */
    public function commissionList($userId, $type)
    {
        if ($type == '0') {
            $query = $this->app->db->name('TkMoneyLog')
                ->where('user_id', $userId)
                ->order('id desc');
            $list = $query->paginate(20)->toArray();
            $data = $list['data'];
            $data = array_map(function ($v) {
                $v['create_time'] = date('Y-m-d H:i:s', $v['create_time']);
                return $v;
            }, $data);
            $list['data'] = $data;
            return $list;
        }
        return [];
    }
    /** 资金信息 */
    public function commissionInfo($userId)
    {
        $commission = Db::name('TkUser')->where('id', $userId)->value('commission');
        $commission = formatMoney2($commission); //可提现金额
        return [
            'commission' => $commission,
        ];
    }
    /**
     * 推客绑定回调
     *
     * @param array $data
     */
    public function bindNotify($data)
    {
        //记录绑定日志
        Db::name('TkBindLog')->insert($data);
        $bindStatus = $data['bind_status'] ?? 0;
        if ($bindStatus == 1) {
            $sharerAppid = $data['sharer_appid'] ?? '';
            $user = Db::name('TkUser')->field('id,sharer_appid,sharer_openid')->where('sharer_appid', $sharerAppid)->find();
            if (!empty($user)) {
                //保存机构sharer_openid
                if (empty($user['sharer_openid'])) {
                    Db::name('TkUser')->where('id', $user['id'])->update(['sharer_openid' => $data['sharer_openid']]);
                }
            }
        }
        return true;
    }
    /**
     * 推客绑定
     */
    public function bindtk($userId)
    {
        $user = Db::name('TkUser')->field('id,openid,sharer_appid,role_id')->where('id', $userId)->find();
        $appid = $user['sharer_appid'] ?? '';
        $openid = $user['openid'] ?? '';
        if (empty($appid) && !empty($openid)) {
            $res = ApiService::sharerList($openid);
            $head_img_url = $res['sharer_info_list'][0]['head_img_url'] ?? '';
            $nickname = $res['sharer_info_list'][0]['nickname'] ?? '';
            $sharer_appid = $res['sharer_info_list'][0]['sharer_appid'] ?? '';
            $bind_time = $res['sharer_info_list'][0]['bind_time'] ?? '';
            if (!empty($sharer_appid)) {
                $roleId = $user['role_id'] > 0 ? $user['role_id'] : 1;
                Db::name('TkUser')->where('id', $userId)->update([
                    'head_img_url' => $head_img_url,
                    'nickname' => $nickname,
                    'sharer_appid' => $sharer_appid,
                    'bind_time' => $bind_time,
                    'role_id' => $roleId
                ]);
            }
        }
        return true;
    }
    /**
     * 绑定手机号
     *
     * @param int $userId
     * @param string $code
     */
    public function bindMobile($userId, $code)
    {
        $res = ApiService::getMobile($code);
        $mobile = $res['phone_info']['purePhoneNumber'] ?? '';
        if (!empty($mobile)) {
            Db::name('TkUser')->where('id', $userId)->update(['mobile' => $mobile]);
        }
        return true;
    }
    /**
     * 个人中心用户信息
     */
    public function my($userId)
    {
        $fields = 'code,mobile,nickname,head_img_url,commission,commission_got,sharer_appid,role_id';
        $user = Db::name('TkUser')->field($fields)->where('id', $userId)->find();
        if (empty($user)) {
            throw new ServiceException('用户不存在');
        }
        $user['head_img_url'] = avatar($user['head_img_url']);
        $user['total_commission'] = $user['commission'] + $user['commission_got'];
        $user['total_commission'] = formatMoney2($user['total_commission']);
        $user['commission'] = formatMoney2($user['commission']); //可提现金额
        $user['commission_got'] = formatMoney2($user['commission_got']); //已提现金额
        $waitCommission = Db::name('TkOrderCommission')->where(['user_id' => $userId, 'status' => 0])->sum('commission');
        $user['wait_commission'] = $waitCommission ?? 0;
        $user['tk_bind'] = empty($user['sharer_appid']) ?  0 : 1;
        $user['mobile'] = empty($user['mobile']) ? '' : hideMobile($user['mobile']);
        $user['mobile_bind'] = empty($user['mobile']) ? 0 : 1;
        $user['role_name'] = self::ROLE_NAME[$user['role_id']] ?? '';
        $service = [
            [
                'title' => '我的订单',
                'icon' => 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/6816e6a300082ad80e77681b9960b01e000000a100004f50',
                'badge' => [
                    'dot' => false
                ],
                'link' => 'order',
                'jump_type' => 'navigate-to',
                'url' => '/pages/income/order'
            ],
            [
                'title' => '我的好友',
                'icon' => 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/6816e6d20002794b0c9d2cf67d65b01e000000a100004f50',
                'badge' => [
                    'dot' => false
                ],
                'link' => 'friend',
                'jump_type' => 'navigate-to',
                'url' => '/pages/friend/list'
            ],
            [
                'title' => '邀请好友',
                'icon' => 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/6816e6ec00065174110f960fea7e0d15000000a100004f50',
                'badge' => [
                    'dot' => false
                ],
                'link' => 'invite',
                'jump_type' => 'navigate-to',
                'url' => '/pages/friend/index'
            ]
        ];
        $user['service'] = $service;
        $other = [];
        $verified = [
            'title' => '授权推广',
            'icon' => 'verified',
            'link' => 'verified',
        ];
        if (empty($user['mobile_bind'])) {
            $verified['label'] = 'btnMobile';
        } else {
            if (empty($user['tk_bind'])) {
                $verified['label'] = 'btnTuike';
            }
        }
        $other[] = $verified;
        $other[] = [
            'title' => '联系客服',
            'icon' => 'service',
            'link' => 'btnContact',
            'label' => 'btnContact'
        ];
        $other[] = [
            'title' => '帮助中心',
            'icon' => 'chat-bubble-help',
            'link' => 'help',
        ];
        // $other[] = [
        //     'title' => '帐号平移',
        //     'icon' => 'user-list',
        //     'link' => 'usergroup',
        // ];
        $other[] = [
            'title' => '商务合作',
            'icon' => 'cooperate',
            'link' => 'cooperate',
        ];
        $other[] = [
            'title' => '投诉反馈',
            'icon' => 'edit-2',
            'link' => 'btnFeedback',
            'label' => 'btnFeedback'
        ];
        $other[] = [
            'title' => '设置',
            'icon' => 'setting',
            'link' => 'btnSetting',
            'label' => 'btnSetting'
        ];
        $user['other'] = $other;
        WeappService::instance()->getQrCode($user['code']);
        return $user;
    }

    /**
     * 获取团队信息
     */
    public function getTeam($userId)
    {
        $sid = Db::name('TkUser')->where('id', $userId)->value('sid');
        $team = Db::name('TkPartners')->where('id', $sid)->find();
        return [
            'name' => $team['name'] ?? '星火',
            'logo' => $team['logo'] ?? '',
            'wechat' => $team['wechat'] ?? ''
        ];
    }

    /** 获取联系我们信息 */
    public function getContact()
    {
        $list = Db::name('TkContact')->order('id ASC')->select()->toArray();
        $list = array_map(function ($item) {
            $item['imgs'] = explode('|', $item['imgs']);
            return $item;
        }, $list);
        return $list;
    }
    /**
     * 登录
     *
     * @param $openid openid
     * @param string $mid 分享人的code
     */
    public function login($openid, $mid)
    {
        //加锁
        $lockKey = 'user_login_' . $openid;
        $redisDb = RedisDb::getInstance();
        if (!$redisDb->mylock($lockKey, 5)) {
            throw new ServiceException('您动作太频繁了，5秒后再试');
        }
        $user = Db::name('TkUser')->field('id,sid,tid,code')->where(['openid' => $openid])->find();
        $tid = $user['tid'] ?? 0;
        $code = $user['code'] ?? '';
        if ($user) {
            //已经登录过
            $userId = $user['id'];
        } else {
            $code = $this->genCode();
            //新注册
            $user = [
                'openid' => $openid,
                'code' => $code,
                'nickname' => sprintf('用户_%s', $code)
            ];
            $userId = Db::name('TkUser')->insertGetId($user);
        }
        if (!empty($mid) && $tid == 0) {
            $tid = $this->bind($userId, $code);
        }
        $res = [
            'code' => $code,
            'token' => $this->getToken($userId),
            'tid' => empty($tid) ? 0 : 1 //是否绑定上级
        ];
        return $res;
    }

    /**
     * 绑定上级
     *
     * @param int $userId
     * @param string $code
     */
    public function bind($userId, $code)
    {
        //上级信息
        $shareUser = Db::name('TkUser')->field('id,sid,tid')->where('code', $code)->find();
        if (empty($shareUser)) {
            return 0;
        }
        if (empty($shareUser['tid'])) {
            //自己没有上级，不能有下级
            return 0;
        }
        $user = Db::name('TkUser')->field('id,sid,tid')->where('id', $userId)->find();
        if (empty($user)) {
            return 0;
        }
        if (!empty($user['tid'])) {
            //有上级了
            return 0;
        }
        $tid = $shareUser['id'];
        $update = [
            'tid' => $tid,
            'sid' => $shareUser['sid']
        ];
        Db::name('TkUser')->where('id', $userId)->update($update);
        return $tid;
    }

    /**
     * 获取token
     */
    private function getToken($userId)
    {
        $table = 'tk_user_token';
        $old = Db::table($table)->where('user_id', $userId)->find();
        if (empty($old)) {
            $token = ApiCheck::getToken($userId);
        } else {
            $token = $old['token'];
        }
        $redisObj = RedisDb::getInstance()->setPrefix(RedisCode::USER_TOKEN_PREFIX);
        $redisObj->add($token, $userId, RedisCode::USER_TOKEN_EXPIRE);
        $data = [
            'user_id' => $userId,
            'token' => $token,
            'create_time' => TIMESTAMP
        ];
        if (empty($old)) {
            Db::table($table)->insert($data);
        } else {
            $redisObj->delete($old['token']);
            Db::table($table)->where('user_id', $userId)->update($data);
        }
        return $token;
    }
    /**
     * 生成新的邀请码
     *
     * @return string
     */
    private function genCode()
    {
        $code = \Tools\RandCode::code();
        $has = $this->app->db->name('TkUser')->where('code', $code)->count();
        if ($has) {
            return $this->genCode();
        }
        return $code;
    }
}
