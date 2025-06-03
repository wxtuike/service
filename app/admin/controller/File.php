<?php

declare(strict_types=1);

namespace app\admin\controller;

use finfo;
use think\admin\Controller;
use think\admin\helper\QueryHelper;
use think\admin\model\SystemFile;
use think\admin\service\AdminService;
use think\admin\Storage;

/**
 * 系统文件管理
 * @class File
 * @package app\admin\controller
 */
class File extends Controller
{
    /**
     * 存储类型
     * @var array
     */
    protected $types;

    /**
     * 控制器初始化
     * @return void
     */
    protected function initialize()
    {
        $this->types = Storage::types();
    }

    /**
     * 系统文件管理
     * @auth true
     * @menu true
     * @throws \think\db\exception\DataNotFoundException
     * @throws \think\db\exception\DbException
     * @throws \think\db\exception\ModelNotFoundException
     */
    public function index()
    {
        SystemFile::mQuery()->layTable(function () {
            $this->title = '系统文件管理';
            $this->xexts = SystemFile::mk()->distinct()->column('xext');
        }, static function (QueryHelper $query) {
            $query->like('name,hash,xext')->equal('type')->dateBetween('create_at');
            $query->where(['issafe' => 0, 'status' => 2, 'uuid' => AdminService::getUserId()]);
        });
    }

    /**
     * 数据列表处理
     * @param array $data
     * @return void
     */
    protected function _page_filter(array &$data)
    {
        foreach ($data as &$vo) {
            $vo['ctype'] = $this->types[$vo['type']] ?? $vo['type'];
        }
    }

    /**
     * 编辑系统文件
     * @auth true
     * @return void
     */
    public function edit()
    {
        SystemFile::mForm('form');
    }

    /**
     * 删除系统文件
     * @auth true
     * @return void
     */
    public function remove()
    {
        if (!AdminService::isSuper()) {
            $where = ['uuid' => AdminService::getUserId()];
        }
        SystemFile::mDelete('', $where ?? []);
    }

    /**
     * 清理重复文件
     * @auth true
     * @return void
     * @throws \think\db\exception\DbException
     */
    public function distinct()
    {
        $map = ['issafe' => 0, 'uuid' => AdminService::getUserId()];
        $subQuery = SystemFile::mk()->fieldRaw('MAX(id) AS id')->where($map)->group('type, xkey')->buildSql();
        SystemFile::mk()->where($map)->whereRaw("id NOT IN ({$subQuery})")->delete();
        $this->success('清理重复文件成功！');
    }

    /**
     * 远程图片显示
     */
    public function img()
    {
        $imageUrl = input('url', '');
        if (!empty($imageUrl)) {
            $imageUrl = urldecode($imageUrl);
            $ch = curl_init($imageUrl);
            curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true); // 跟随重定向
            curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false); // 如果是 HTTPS 但不验证证书
            $imageData = curl_exec($ch);
            $mimeType = curl_getinfo($ch, CURLINFO_CONTENT_TYPE); // 获取 Content-Type
            curl_close($ch);
            if ($imageData !== false) {
                header("Content-Type: $mimeType");
                echo $imageData;
                exit();
            }
        }
        header("Content-Type: image/png");
        readfile("error.png"); // 备用图片
        exit();
        $imageUrl = input('url', '');
        if (!empty($imageUrl)) {
            // 获取图片内容
            $imageData = file_get_contents($imageUrl);
            if ($imageData !== false) {
                // 获取图片的 MIME 类型（如 image/jpeg, image/png）
                $finfo = new finfo(FILEINFO_MIME_TYPE);
                $mimeType = $finfo->buffer($imageData);
                // 设置正确的 Content-Type 并输出图片
                header("Content-Type: $mimeType");
                echo $imageData;
                exit();
            }
        }
        // 如果获取失败，显示错误或默认图片
        header("Content-Type: image/png");
        readfile(syspath("public/empty.png")); // 本地备用图片
        exit();
    }
}
