<?php
define('TIMESTAMP', $_SERVER['REQUEST_TIME']);
define('CLIENT_IP', \think\facade\Request::ip());
define('CLIENT_UA', \think\facade\Request::header('user-agent'));
if (!function_exists('arrayReKeys')) {
    function arrayReKeys($array, $key)
    {
        $array = array_filter($array);
        if (empty($array)) {
            return [];
        }
        $iterator = function () use ($array, $key) {
            foreach ($array as $item) {
                $item = (array)$item;
                yield ($item[$key] ?? '') => $item;
            }
        };
        return iterator_to_array($iterator(), true);
    }
}

if (!function_exists('avatar')) {
    function avatar($url)
    {
        if (empty($url)) {
            return 'https://tuike.rlma.cn/logo.png';
        } else {
            return $url;
        }
    }
}

if (!function_exists('format_img')) {
    /**
     * 打印输出数据到文件
     * @param mixed $data 输出的数据
     * @param boolean $new 强制替换文件
     * @param ?string $file 保存文件名称
     * @return false|int
     */
    function format_img($url)
    {
        return url('admin/file/img') . '?url=' . urlencode($url);
    }
}

if (!function_exists('format_date')) {
    /**
     * 日期格式标准输出
     * @param int|string $datetime 输入日期
     * @param string $format 输出格式
     * @return string
     */
    function format_date($datetime, string $format = 'Y年m月d日'): string
    {
        if (empty($datetime)) return '-';
        if (is_numeric($datetime)) {
            return date($format, $datetime);
        } else {
            return date($format, strtotime($datetime));
        }
    }
}
if (!function_exists('format_week')) {
    /**
     * 日期格式标准输出
     * @param int|string $datetime 输入日期
     * @param string $format 输出格式
     * @return string
     */
    function format_week($datetime): string
    {
        if (empty($datetime)) return '';
        $weekArray = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
        if (is_numeric($datetime)) {
            $week = date('w', $datetime);
            return $weekArray[$week];
        } else {
            $datetime = strtotime($datetime);
            $week = date('w', $datetime);
            return $weekArray[$week];
        }
    }
}
if (!function_exists('get_week')) {
    function get_week($time)
    {
        $week = date('w', $time);
        $weekArray = ['星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六'];
        return $weekArray[$week];
    }
}

if (!function_exists('to62')) {
    function to62($num)
    {
        $to = 62;
        $dict = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $ret = '';
        do {
            $ret = $dict[bcmod($num, $to)] . $ret; //bcmod取得高精确度数字的余数。
            $num = bcdiv($num, $to);  //bcdiv将二个高精确度数字相除。
        } while ($num > 0);
        return $ret;
    }
}
if (!function_exists('from62')) {
    //62进制10进制
    function from62($num)
    {
        $from = 62;
        $num = strval($num);
        $dict = '0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
        $len = strlen($num);
        $dec = 0;
        for ($i = 0; $i < $len; $i++) {
            $pos = strpos($dict, $num[$i]);
            $dec = bcadd(bcmul(bcpow($from, $len - $i - 1), $pos), $dec);
        }
        return $dec;
    }
}

if (!function_exists('fail')) {
    /**
     * 返回错误json
     *
     * @param string $info 消息内容
     * @param integer $code 返回代码 412 Precondition Failed 未满足前提条件
     * @param array $data 返回数据
     */
    function fail($info = 'error', $code = 222, $data = [])
    {
        success($data, $info, $code);
    }
}
if (!function_exists('success')) {
    /**
     * 返回json
     * 
     * @param array $data 返回数据
     * @param string $info 消息内容
     * @param integer $code 返回代码
     */
    function success($data = [], $info = 'success', $code = 200)
    {
        if (!$data) $data = new \stdClass();
        $result = ['code' => $code, 'info' => $info, 'data' => $data];
        json($result, $code)->send();
    }
}
if (!function_exists('formatTimeToDesc')) {
    /**
     * 时间转描述
     * @param $time
     * @param string $defaultFormat
     * @return false|string
     */
    function formatTimeToDesc($time, $defaultFormat = 'Y-m-d H:i:s')
    {
        if (!preg_match('#^[0-9]+$#', $time)) {
            $time = strtotime($time);
        }
        $dur = time() - $time;
        if ($dur < 0) {
            return date($defaultFormat, $time);
        } else {
            if ($dur < 60 * 3) {
                return '刚刚';
            } elseif ($dur < 3600) {
                return floor($dur / 60) . '分钟前';
            } elseif ($dur < 86400) {
                return floor($dur / 3600) . '小时前';
            } elseif ($dur < 86400 * 4) { //n天内
                return floor($dur / 86400) . '天前';
            } elseif ($dur < 86400 * 8) {
                return '一周内';
            } else {
                return date($defaultFormat, $time);
            }
        }
    }
}
if (!function_exists('longUnixTime')) {
    /**
     * 获取毫秒级时间戳
     * @return int
     */
    function longUnixTime()
    {
        return round(microtime(true) * 1000);
    }
}

if (!function_exists('genPwd')) {
    function genPwd($len, $charNum = 0, $specialNum = 0)
    {
        $charLib = 'abcdefghjkmnpqrstwxy';
        $libLen = strlen($charLib);
        $specialLib = '+=-@#~,.[]()!%^*$';
        $specialLen = strlen($specialLib);

        $str = '';
        for ($i = 0; $i < $len; $i++) {
            $str .= mt_rand(0, 9);
        }
        for ($j = 0; $j < $charNum; $j++) {
            $_pos = mt_rand(0, $len - 1);
            $_char = $charLib[mt_rand(0, $libLen - 1)];
            $str[$_pos] = $_char;
        }
        for ($j = 0; $j < $specialNum; $j++) {
            $_pos = mt_rand(0, $len - 1);
            $_char = $specialLib[mt_rand(0, $specialLen - 1)];
            $str[$_pos] = $_char;
        }
        return $str;
    }
}
if (!function_exists('getUserCode')) {
    /** 获取用户在聊天IM唯一码 */
    function getUserCode($id)
    {
        return strval($id * 62 + 106);
    }
}
if (!function_exists('userCode2Id')) {
    function userCode2Id($code)
    {
        $code = floatval($code) - 106;
        if ($code > 0) {
            return round($code / 62);
        }
        return 0;
    }
}

if (!function_exists('formatMoney')) {
    /** 显示金额(分转元) */
    function formatMoney($value)
    {
        if ($value != 0) {
            return sprintf('%0.4f', $value / 100);
        }
        return $value;
    }
}

if (!function_exists('formatMoney2')) {
    /** 显示金额(分转元)保留两位小数 */
    function formatMoney2($value)
    {
        empty($value) && $value = 0;
        if ($value != 0) {
            return round($value / 100, 2);
        }
        return $value;
    }
}



if (!function_exists('order_sn')) {
    /** 订单编码 */
    function order_sn($id = '')
    {
        return sprintf('%s%s', $id, date('ymdHis'));
    }
}

if (!function_exists('addYear')) {
    /** 时间加N年 */
    function addYear($year = 1, $time = 0)
    {
        if (!$time) $time = time();
        $currentDate = date('Y-m-d', $time); // 获取当前日期
        $timeStr = sprintf('+%s year', $year);
        $nextYearDate = strtotime($timeStr, strtotime($currentDate)); // 将当前日期加一年
        return $nextYearDate + 86400; // 输出加一年后的日期,多加一天
    }
}

if (!function_exists('hideMobile')) {
    /** 隐藏手机号中间4位 */
    function hideMobile($mobile)
    {
        if (preg_match('/^1[3456789]\d{9}$/', $mobile)) {
            return substr_replace($mobile, '****', 3, 4);
        }
        return $mobile;
    }
}

if (!function_exists('iOSCheck')) {
    /** 检测iOS是否审核版本 0不是iOS或者不是审核版本，1是审核版本 */
    function iOSCheck()
    {
        // 取一下applestore的版本号todo::要改成从applestore取
        $appleStoreVersion = '1.0.1';
        $arr = explode('/', CLIENT_UA);
        $typeName = $arr[0] ?? '';
        $version = $arr[1] ?? '';
        $typeName = strtolower($typeName);
        if ($typeName != 'ios' || empty($version)) {
            return 0;
        }
        //当前版本号大于applestore版本号，就是审核版本
        $res = version_compare($version, $appleStoreVersion, '>');
        return $res ? 1 : 0;
    }
}
if (!function_exists('isMobile')) {
    /** 是否手册号 */
    function isMobile($str)
    {
        if (preg_match('/^1[3456789]\d{9}$/', $str)) {
            return true;
        }
        return false;
    }
}
if (!function_exists('orderStatusName')) {
    function orderStatusName($status)
    {
        $map = [
            0 => '待结算',
            1 => '已结算',
            2 => '取消',
        ];
        return $map[$status] ?? '';
    }
}

if (!function_exists('roleName')) {
    function roleName($roleId)
    {
        $map = [
            0 => '未授权',
            1 => '推客',
            2 => 'VIP',
        ];
        return $map[$roleId] ?? '';
    }
}
