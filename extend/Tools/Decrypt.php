<?php

declare(strict_types=1);

namespace Tools;

/** 推客解密 */
class Decrypt
{
    protected $Token = '';
    protected $Key = '';

    function __construct()
    {
        $this->Token = sysconf('tuike.token');
        $this->Key = sysconf('tuike.encodingaeskey');
    }

    /**
     * 获取解密数据
     */
    public function getReceive()
    {
        $timestamp = $_GET["timestamp"] ?? '';
        $nonce = $_GET["nonce"] ?? '';
        $msgSign = $_GET["msg_signature"] ?? '';
        $postStr = file_get_contents('php://input');
        $postInfo = json_decode($postStr, true);
        $_encrypt = $postInfo['Encrypt'] ?? '';
        if (!empty($_encrypt)) { //判断是否要解密
            $params = [
                'timestamp' => $timestamp,
                'nonce' => $nonce,
                'msg_signature' => $msgSign,
                'encrypt' => $_encrypt,
            ];
            $sha1 = $this->getSHA1($params);
            if ($sha1 != $postInfo['msg_signature']) {
                return false;
            }
            $encryptMsg = $this->decrypt($params['encrypt']);
            if (empty($encryptMsg)) {
                return false;
            }
            return json_decode($encryptMsg, true);
        }
        return false;
    }

    private function getSHA1($data)
    {
        $timestamp = $data['timestamp'] ?? '';
        $nonce = $data['nonce'] ?? '';
        $encrypt = $data['encrypt'] ?? '';
        //排序
        try {
            $array = array($encrypt, $this->Token, $timestamp, $nonce);
            sort($array, SORT_STRING);
            $str = implode($array);
            return sha1($str);
        } catch (\Exception $e) {
            return false;
        }
    }

    private function decrypt($encrypt)
    {
        // Step 1: Generate AESKey
        $aesKey = base64_decode($this->Key . "=");
        if (strlen($aesKey) != 32) {
            return '';
        }
        // Step 2: Base64 decode Encrypt
        $tmpMsg = base64_decode($encrypt);

        // Step 3: AES decrypt
        $iv = substr($aesKey, 0, 16); // IV is first 16 bytes of AESKey
        $fullStr = openssl_decrypt(
            $tmpMsg,
            'AES-256-CBC',
            $aesKey,
            OPENSSL_RAW_DATA | OPENSSL_ZERO_PADDING,
            $iv
        );

        if ($fullStr === false) {
            return '';
        }
        $msgLen = unpack("N", substr($fullStr, 16, 4))[1]; // 4B msg_len (network byte order)
        $msg = substr($fullStr, 20, $msgLen); // msg
        return $msg;
    }
}
