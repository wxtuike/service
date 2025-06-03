<?php

namespace app\common\code;

class RedisCode
{
    //-------公共前缀-------
    const PREFIX = 'tk_v1_';

    //-------短信-------
    //短信频控
    const SMS_LIMIT_PREFIX = self::PREFIX . 'sms_limit_';
    const SMS_LIMIT_EXPIRE = 60;

    //短信验证码
    const SMS_CHECK_CODE_PREFIX = self::PREFIX . 'sms_check_code_';
    const SMS_CHECK_CODE_EXPIRE = 300;

    //-------用户缓存-------
    //会员TOKEN数据缓存
    const USER_TOKEN_PREFIX = self::PREFIX . 'user_token_';
    const USER_TOKEN_EXPIRE = 600;
    //会员登陆数据缓存
    const USER_MIN_INFO_PREFIX = self::PREFIX . 'user_min_info_';
    const USER_MIN_INFO_EXPIRE = 600;
}
