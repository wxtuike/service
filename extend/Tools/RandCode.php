<?php

declare(strict_types=1);

namespace Tools;

class RandCode
{
    const charMapper = 'ABCDEFGHJKLMNPQRSTUVWXYZ';

    public static function code()
    {
        $start = rand(1, strlen(self::charMapper) - 1);
        $letter = substr(self::charMapper, $start, 1);
        $num = self::genNum();
        return $letter . $num;
    }

    private static function genNum()
    {
        $num = mt_rand(1000, 9999) . '';
        /*
        if (preg_match("/([\x80-\xff].|.)\\1{3,}/", $num)) {
            return self::genNum();
        }
        */
        return $num;
    }
}
