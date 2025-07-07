/*
 Source Server Type    : MySQL
 Source Server Version : 50735

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for system_auth
-- ----------------------------
DROP TABLE IF EXISTS `system_auth`;
CREATE TABLE `system_auth` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(100) DEFAULT '' COMMENT '权限名称',
  `utype` varchar(50) DEFAULT '' COMMENT '身份权限',
  `desc` varchar(500) DEFAULT '' COMMENT '备注说明',
  `sort` bigint(20) DEFAULT '0' COMMENT '排序权重',
  `status` int(1) DEFAULT '1' COMMENT '权限状态(1使用,0禁用)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `i73a781d61_sort` (`sort`),
  KEY `i73a781d61_title` (`title`),
  KEY `i73a781d61_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统-权限';

-- ----------------------------
-- Table structure for system_auth_node
-- ----------------------------
DROP TABLE IF EXISTS `system_auth_node`;
CREATE TABLE `system_auth_node` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `auth` bigint(20) DEFAULT '0' COMMENT '角色',
  `node` varchar(200) DEFAULT '' COMMENT '节点',
  PRIMARY KEY (`id`),
  KEY `i4cd9aaff6_auth` (`auth`),
  KEY `i4cd9aaff6_node` (`node`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统-授权';

-- ----------------------------
-- Table structure for system_base
-- ----------------------------
DROP TABLE IF EXISTS `system_base`;
CREATE TABLE `system_base` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT '' COMMENT '数据类型',
  `code` varchar(100) DEFAULT '' COMMENT '数据代码',
  `name` varchar(500) DEFAULT '' COMMENT '数据名称',
  `content` text COMMENT '数据内容',
  `sort` bigint(20) DEFAULT '0' COMMENT '排序权重',
  `status` int(1) DEFAULT '1' COMMENT '数据状态(0禁用,1启动)',
  `deleted` int(1) DEFAULT '0' COMMENT '删除状态(0正常,1已删)',
  `deleted_at` varchar(20) DEFAULT '' COMMENT '删除时间',
  `deleted_by` bigint(20) DEFAULT '0' COMMENT '删除用户',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `i2a29c450f_type` (`type`),
  KEY `i2a29c450f_code` (`code`),
  KEY `i2a29c450f_name` (`name`),
  KEY `i2a29c450f_sort` (`sort`),
  KEY `i2a29c450f_status` (`status`),
  KEY `i2a29c450f_deleted` (`deleted`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统-字典';

-- ----------------------------
-- Table structure for system_config
-- ----------------------------
DROP TABLE IF EXISTS `system_config`;
CREATE TABLE `system_config` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT '' COMMENT '配置分类',
  `name` varchar(100) DEFAULT '' COMMENT '配置名称',
  `value` varchar(2048) DEFAULT '' COMMENT '配置内容',
  PRIMARY KEY (`id`),
  KEY `i48e345b98_type` (`type`),
  KEY `i48e345b98_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COMMENT='系统-配置';

-- ----------------------------
-- Records of system_config
-- ----------------------------
BEGIN;
INSERT INTO `system_config` VALUES (1, 'base', 'app_name', '推客系统');
INSERT INTO `system_config` VALUES (2, 'base', 'app_version', 'beta');
INSERT INTO `system_config` VALUES (3, 'base', 'editor', 'ckeditor5');
INSERT INTO `system_config` VALUES (4, 'base', 'login_name', '系统管理');
INSERT INTO `system_config` VALUES (5, 'base', 'site_copy', '©版权所有 2014-2025 wander');
INSERT INTO `system_config` VALUES (6, 'base', 'site_icon', '');
INSERT INTO `system_config` VALUES (7, 'base', 'site_name', '推客系统');
INSERT INTO `system_config` VALUES (8, 'base', 'site_theme', 'default');
INSERT INTO `system_config` VALUES (9, 'storage', 'allow_exts', 'doc,gif,ico,jpg,mp3,mp4,p12,pem,png,zip,rar,xls,xlsx');
INSERT INTO `system_config` VALUES (10, 'storage', 'type', 'local');
INSERT INTO `system_config` VALUES (11, 'wechat', 'type', 'api');
INSERT INTO `system_config` VALUES (12, 'base', 'site_host', 'https://tuike.cn');
INSERT INTO `system_config` VALUES (13, 'storage', 'link_type', 'none');
INSERT INTO `system_config` VALUES (14, 'storage', 'name_type', 'xmd5');
INSERT INTO `system_config` VALUES (15, 'storage', 'local_http_protocol', 'follow');
COMMIT;

-- ----------------------------
-- Table structure for system_data
-- ----------------------------
DROP TABLE IF EXISTS `system_data`;
CREATE TABLE `system_data` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT '' COMMENT '配置名',
  `value` text COMMENT '配置值',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `icbccedc16_name` (`name`),
  KEY `icbccedc16_create_time` (`create_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统-数据';

-- ----------------------------
-- Table structure for system_file
-- ----------------------------
DROP TABLE IF EXISTS `system_file`;
CREATE TABLE `system_file` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(20) DEFAULT '' COMMENT '上传类型',
  `hash` varchar(32) DEFAULT '' COMMENT '文件哈希',
  `tags` varchar(50) DEFAULT '' COMMENT '文件标签',
  `name` varchar(180) DEFAULT '' COMMENT '文件名称',
  `xext` varchar(100) DEFAULT '' COMMENT '文件后缀',
  `xurl` varchar(500) DEFAULT '' COMMENT '访问链接',
  `xkey` varchar(500) DEFAULT '' COMMENT '文件路径',
  `mime` varchar(100) DEFAULT '' COMMENT '文件类型',
  `size` bigint(20) DEFAULT '0' COMMENT '文件大小',
  `uuid` bigint(20) DEFAULT '0' COMMENT '用户编号',
  `unid` bigint(20) DEFAULT '0' COMMENT '会员编号',
  `isfast` int(1) DEFAULT '0' COMMENT '是否秒传',
  `issafe` int(1) DEFAULT '0' COMMENT '安全模式',
  `status` int(1) DEFAULT '1' COMMENT '上传状态(1悬空,2落地)',
  `create_at` datetime DEFAULT NULL COMMENT '创建时间',
  `update_at` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `i738a363ca_type` (`type`),
  KEY `i738a363ca_hash` (`hash`),
  KEY `i738a363ca_uuid` (`uuid`),
  KEY `i738a363ca_xext` (`xext`),
  KEY `i738a363ca_unid` (`unid`),
  KEY `i738a363ca_tags` (`tags`),
  KEY `i738a363ca_name` (`name`),
  KEY `i738a363ca_status` (`status`),
  KEY `i738a363ca_issafe` (`issafe`),
  KEY `i738a363ca_isfast` (`isfast`),
  KEY `i738a363ca_create_at` (`create_at`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='系统-文件';

-- ----------------------------
-- Table structure for system_menu
-- ----------------------------
DROP TABLE IF EXISTS `system_menu`;
CREATE TABLE `system_menu` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pid` bigint(20) DEFAULT '0' COMMENT '上级ID',
  `title` varchar(100) DEFAULT '' COMMENT '菜单名称',
  `icon` varchar(100) DEFAULT '' COMMENT '菜单图标',
  `node` varchar(100) DEFAULT '' COMMENT '节点代码',
  `url` varchar(400) DEFAULT '' COMMENT '链接节点',
  `params` varchar(500) DEFAULT '' COMMENT '链接参数',
  `target` varchar(20) DEFAULT '_self' COMMENT '打开方式',
  `sort` bigint(20) DEFAULT '0' COMMENT '排序权重',
  `status` int(1) DEFAULT '1' COMMENT '状态(0:禁用,1:启用)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `i29b9da675_pid` (`pid`),
  KEY `i29b9da675_sort` (`sort`),
  KEY `i29b9da675_status` (`status`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8mb4 COMMENT='系统-菜单';

-- ----------------------------
-- Records of system_menu
-- ----------------------------
BEGIN;
INSERT INTO `system_menu` VALUES (1, 0, '系统管理', '', '', '#', '', '_self', 2, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (2, 1, '系统配置', '', '', '#', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (3, 2, '系统参数配置', 'layui-icon layui-icon-set', 'admin/config/index', 'admin/config/index', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (4, 2, '系统任务管理', 'layui-icon layui-icon-log', 'admin/queue/index', 'admin/queue/index', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (5, 2, '系统日志管理', 'layui-icon layui-icon-form', 'admin/oplog/index', 'admin/oplog/index', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (6, 2, '数据字典管理', 'layui-icon layui-icon-code-circle', 'admin/base/index', 'admin/base/index', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (7, 2, '系统文件管理', 'layui-icon layui-icon-carousel', 'admin/file/index', 'admin/file/index', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (8, 2, '系统菜单管理', 'layui-icon layui-icon-layouts', 'admin/menu/index', 'admin/menu/index', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (9, 1, '权限管理', '', '', '#', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (10, 9, '系统权限管理', 'layui-icon layui-icon-vercode', 'admin/auth/index', 'admin/auth/index', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (11, 9, '系统用户管理', 'layui-icon layui-icon-username', 'admin/user/index', 'admin/user/index', '', '_self', 0, 1, '2025-04-26 15:05:13');
INSERT INTO `system_menu` VALUES (13, 1, '微信管理', '', '', '#', '', '_self', 0, 1, '2025-04-26 15:05:14');
INSERT INTO `system_menu` VALUES (14, 13, '推客接口配置', 'layui-icon layui-icon-lock', 'admin/config/tuike', 'admin/config/tuike', '', '_self', 1, 1, '2025-05-27 17:16:15');
INSERT INTO `system_menu` VALUES (25, 0, '推客管理', '', '', '#', '', '_self', 100, 1, '2025-04-26 15:48:16');
INSERT INTO `system_menu` VALUES (26, 25, '达人管理', '', '', '#', '', '_self', 0, 1, '2025-04-26 15:50:08');
INSERT INTO `system_menu` VALUES (27, 26, '合作达人', 'layui-icon layui-icon-fire', 'data/talent/index', 'data/talent/index', '', '_self', 0, 1, '2025-04-26 15:51:12');
INSERT INTO `system_menu` VALUES (28, 26, '短视频', 'layui-icon layui-icon-theme', 'data/feed/index', 'data/feed/index', '', '_self', 0, 1, '2025-04-27 10:19:54');
INSERT INTO `system_menu` VALUES (29, 26, '直播', 'layui-icon layui-icon-edge', 'data/live/index', 'data/live/index', '', '_self', 0, 1, '2025-04-27 11:12:16');
INSERT INTO `system_menu` VALUES (30, 25, '商品管理', '', '', '#', '', '_self', 0, 1, '2025-04-29 13:02:04');
INSERT INTO `system_menu` VALUES (31, 30, '店铺列表', 'layui-icon layui-icon-light', 'data/shop/index', 'data/shop/index', '', '_self', 0, 1, '2025-04-29 13:02:28');
INSERT INTO `system_menu` VALUES (32, 30, '商品列表', 'layui-icon layui-icon-rmb', 'data/goods/index', 'data/goods/index', '', '_self', 0, 1, '2025-05-10 13:16:06');
INSERT INTO `system_menu` VALUES (33, 25, '订单管理', '', '', '#', '', '_self', 0, 1, '2025-05-27 13:27:58');
INSERT INTO `system_menu` VALUES (34, 33, '订单列表', 'layui-icon layui-icon-align-center', 'data/order/index', 'data/order/index', '', '_self', 0, 1, '2025-05-27 13:28:23');
INSERT INTO `system_menu` VALUES (35, 25, '用户管理', '', '', '#', '', '_self', 0, 1, '2025-05-27 14:28:15');
INSERT INTO `system_menu` VALUES (36, 35, '用户列表', 'layui-icon layui-icon-username', 'data/user/index', 'data/user/index', '', '_self', 0, 1, '2025-05-27 14:28:36');
INSERT INTO `system_menu` VALUES (38, 40, '轮播图', 'layui-icon layui-icon-test', 'data/banner/index', 'data/banner/index', '', '_self', 0, 1, '2025-05-29 16:01:12');
INSERT INTO `system_menu` VALUES (39, 30, '优惠券', 'layui-icon layui-icon-tabs', 'data/coupon/index', 'data/coupon/index', '', '_self', 0, 1, '2025-05-30 10:19:41');
INSERT INTO `system_menu` VALUES (40, 25, '基础管理', '', '', '#', '', '_self', 10, 1, '2025-06-02 15:14:39');
INSERT INTO `system_menu` VALUES (41, 40, '海报管理', 'layui-icon layui-icon-gift', 'data/card/index', 'data/card/index', '', '_self', 0, 1, '2025-06-02 15:15:46');
INSERT INTO `system_menu` VALUES (42, 40, '联系我们', 'layui-icon layui-icon-headset', 'data/contact/index', 'data/contact/index', '', '_self', 0, 1, '2025-06-02 15:16:23');
COMMIT;

-- ----------------------------
-- Table structure for system_oplog
-- ----------------------------
DROP TABLE IF EXISTS `system_oplog`;
CREATE TABLE `system_oplog` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `node` varchar(200) NOT NULL DEFAULT '' COMMENT '当前操作节点',
  `geoip` varchar(15) NOT NULL DEFAULT '' COMMENT '操作者IP地址',
  `action` varchar(200) NOT NULL DEFAULT '' COMMENT '操作行为名称',
  `content` varchar(1024) NOT NULL DEFAULT '' COMMENT '操作内容描述',
  `username` varchar(50) NOT NULL DEFAULT '' COMMENT '操作人用户名',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `id7cb1c775_create_at` (`create_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统-日志';

-- ----------------------------
-- Table structure for system_queue
-- ----------------------------
DROP TABLE IF EXISTS `system_queue`;
CREATE TABLE `system_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(20) NOT NULL DEFAULT '' COMMENT '任务编号',
  `title` varchar(100) NOT NULL DEFAULT '' COMMENT '任务名称',
  `command` varchar(500) DEFAULT '' COMMENT '执行指令',
  `exec_pid` bigint(20) DEFAULT '0' COMMENT '执行进程',
  `exec_data` text COMMENT '执行参数',
  `exec_time` bigint(20) DEFAULT '0' COMMENT '执行时间',
  `exec_desc` varchar(500) DEFAULT '' COMMENT '执行描述',
  `enter_time` decimal(20,4) DEFAULT '0.0000' COMMENT '开始时间',
  `outer_time` decimal(20,4) DEFAULT '0.0000' COMMENT '结束时间',
  `loops_time` bigint(20) DEFAULT '0' COMMENT '循环时间',
  `attempts` bigint(20) DEFAULT '0' COMMENT '执行次数',
  `message` text COMMENT '最新消息',
  `rscript` int(1) DEFAULT '1' COMMENT '任务类型(0单例,1多例)',
  `status` int(1) DEFAULT '1' COMMENT '任务状态(1新任务,2处理中,3成功,4失败)',
  `create_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `if64376974_code` (`code`),
  KEY `if64376974_title` (`title`),
  KEY `if64376974_status` (`status`),
  KEY `if64376974_rscript` (`rscript`),
  KEY `if64376974_create_at` (`create_at`),
  KEY `if64376974_exec_time` (`exec_time`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='系统-任务';

-- ----------------------------
-- Table structure for system_user
-- ----------------------------
DROP TABLE IF EXISTS `system_user`;
CREATE TABLE `system_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `usertype` varchar(20) DEFAULT '' COMMENT '用户类型',
  `username` varchar(50) DEFAULT '' COMMENT '用户账号',
  `password` varchar(32) DEFAULT '' COMMENT '用户密码',
  `nickname` varchar(50) DEFAULT '' COMMENT '用户昵称',
  `headimg` varchar(255) DEFAULT '' COMMENT '头像地址',
  `authorize` varchar(255) DEFAULT '' COMMENT '权限授权',
  `contact_qq` varchar(20) DEFAULT '' COMMENT '联系QQ',
  `contact_mail` varchar(20) DEFAULT '' COMMENT '联系邮箱',
  `contact_phone` varchar(20) DEFAULT '' COMMENT '联系手机',
  `login_ip` varchar(255) DEFAULT '' COMMENT '登录地址',
  `login_at` varchar(20) DEFAULT '' COMMENT '登录时间',
  `login_num` bigint(20) DEFAULT '0' COMMENT '登录次数',
  `describe` varchar(255) DEFAULT '' COMMENT '备注说明',
  `sort` bigint(20) DEFAULT '0' COMMENT '排序权重',
  `status` int(1) DEFAULT '1' COMMENT '状态(0禁用,1启用)',
  `is_deleted` int(1) DEFAULT '0' COMMENT '删除(1删除,0未删)',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `i34b957835_sort` (`sort`),
  KEY `i34b957835_status` (`status`),
  KEY `i34b957835_username` (`username`),
  KEY `i34b957835_is_deleted` (`is_deleted`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=utf8mb4 COMMENT='系统-用户';

-- ----------------------------
-- Records of system_user
-- ----------------------------
BEGIN;
INSERT INTO `system_user` VALUES (10000, '', 'admin', 'd1b8fe52c2d3da7d77718b2cbaeffca1', '超级管理员', 'https://thinkadmin.top/static/img/head.png', '', '', '', '', '101.69.251.46', '2025-06-03 12:06:27', 49, '', 0, 1, 0, '2025-04-26 15:05:13');
COMMIT;

-- ----------------------------
-- Table structure for tk_banner
-- ----------------------------
DROP TABLE IF EXISTS `tk_banner`;
CREATE TABLE `tk_banner` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `product_id` int(11) unsigned DEFAULT '0',
  `img` varchar(256) DEFAULT '',
  `sort` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tk_banner
-- ----------------------------
BEGIN;
INSERT INTO `tk_banner` VALUES (1, 1, 'https://tdesign.gtimg.com/miniprogram/template/retail/home/v2/banner2.png', 0);
INSERT INTO `tk_banner` VALUES (2, 2, 'https://tdesign.gtimg.com/miniprogram/template/retail/home/v2/banner3.png', 1);
INSERT INTO `tk_banner` VALUES (3, 3, 'https://tdesign.gtimg.com/miniprogram/template/retail/home/v2/banner4.png', 0);
INSERT INTO `tk_banner` VALUES (4, 4, 'https://tdesign.gtimg.com/miniprogram/template/retail/home/v2/banner5.png', 0);
COMMIT;

-- ----------------------------
-- Table structure for tk_bind_log
-- ----------------------------
DROP TABLE IF EXISTS `tk_bind_log`;
CREATE TABLE `tk_bind_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `sharer_appid` varchar(32) DEFAULT '',
  `sharer_openid` varchar(32) DEFAULT '',
  `sharer_unionid` varchar(32) DEFAULT '',
  `bind_status` tinyint(1) unsigned DEFAULT '0',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='推客绑定回调记录';

-- ----------------------------
-- Table structure for tk_card
-- ----------------------------
DROP TABLE IF EXISTS `tk_card`;
CREATE TABLE `tk_card` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `url` varchar(128) DEFAULT '',
  `status` tinyint(1) unsigned DEFAULT '1',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tk_card
-- ----------------------------
BEGIN;
INSERT INTO `tk_card` VALUES (1, 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/683d490800062daa00a4338d46ee1b15000000a100004f50', 1, '2025-05-17 14:56:40');
INSERT INTO `tk_card` VALUES (2, 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/683d4926000a90ad287438c5b0e11b15000000a100004f50', 1, '2025-05-17 14:57:16');
INSERT INTO `tk_card` VALUES (3, 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/683d49430004405f23e3f67fd43a1f15000000a100004f50', 1, '2025-05-17 14:57:42');
COMMIT;

-- ----------------------------
-- Table structure for tk_cat
-- ----------------------------
DROP TABLE IF EXISTS `tk_cat`;
CREATE TABLE `tk_cat` (
  `cat_id` int(11) unsigned NOT NULL DEFAULT '0',
  `name` varchar(64) NOT NULL DEFAULT '',
  `f_cat_id` int(11) unsigned DEFAULT '0',
  `level` tinyint(1) unsigned DEFAULT NULL,
  `leaf` tinyint(1) unsigned DEFAULT '0',
  PRIMARY KEY (`cat_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tk_cat
-- ----------------------------
BEGIN;
INSERT INTO `tk_cat` VALUES (1003, '假牙清洁', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1004, '其它口腔护理产品', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1005, '口腔喷剂', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1006, '口腔护理套装', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1007, '漱口水', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1008, '牙刷', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1009, '牙粉', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1010, '牙线/牙签', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1011, '牙缝刷', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1012, '牙膏', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1013, '牙贴', 10000002, 3, 1);
INSERT INTO `tk_cat` VALUES (1016, '卫生巾', 10000003, 3, 1);
INSERT INTO `tk_cat` VALUES (1017, '卫生护垫', 10000003, 3, 1);
INSERT INTO `tk_cat` VALUES (1018, '卫生棉条', 10000003, 3, 1);
INSERT INTO `tk_cat` VALUES (1019, '女性护理套装', 10000003, 3, 1);
INSERT INTO `tk_cat` VALUES (1021, '裤型卫生巾', 10000003, 3, 1);
INSERT INTO `tk_cat` VALUES (1023, '其它洗护发产品', 10000004, 3, 1);
INSERT INTO `tk_cat` VALUES (1024, '发膜', 10000004, 3, 1);
INSERT INTO `tk_cat` VALUES (1025, '护发精华', 10000004, 3, 1);
INSERT INTO `tk_cat` VALUES (1026, '护发素', 10000004, 3, 1);
INSERT INTO `tk_cat` VALUES (1027, '洗发水', 10000004, 3, 1);
INSERT INTO `tk_cat` VALUES (1028, '洗护套装', 10000004, 3, 1);
INSERT INTO `tk_cat` VALUES (1029, '营养水', 10000004, 3, 1);
INSERT INTO `tk_cat` VALUES (1031, '其它假发', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1032, '其它美发/造型产品', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1033, '刘海假发', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1034, '发套假发', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1035, '发胶', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1036, '发蜡/泥', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1037, '啫喱膏/水', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1038, '弹力素', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1039, '摩丝', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1040, '染发产品', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1041, '烫发产品', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1042, '美发工具', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1043, '蓬蓬粉', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1044, '造型喷雾/乳', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1045, '马尾假发', 10000005, 3, 1);
INSERT INTO `tk_cat` VALUES (1048, '手膜', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1049, '护手霜', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1050, '护理工具', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1051, '护足霜', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1052, '沐浴露', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1053, '洗手液', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1054, '浴盐', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1055, '身体乳/油', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1057, '精油', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1058, '纤体塑形', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1059, '胸部护理', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1060, '脱毛工具', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1061, '花露水', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1062, '走珠/止汗露', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1063, '足浴粉/足浴盐', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1064, '足膜', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1065, '足贴', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1066, '身体护理套装', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1067, '颈部护理', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1068, '香皂', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (1072, '养蜂器具', 10000008, 3, 1);
INSERT INTO `tk_cat` VALUES (1073, '兽医器具', 10000008, 3, 1);
INSERT INTO `tk_cat` VALUES (1074, '水产器具', 10000008, 3, 1);
INSERT INTO `tk_cat` VALUES (1075, '牛羊器具', 10000008, 3, 1);
INSERT INTO `tk_cat` VALUES (1076, '猪用器具', 10000008, 3, 1);
INSERT INTO `tk_cat` VALUES (1077, '禽类器具', 10000008, 3, 1);
INSERT INTO `tk_cat` VALUES (1083, '农用篷布', 10000010, 3, 1);
INSERT INTO `tk_cat` VALUES (1084, '农用薄膜', 10000010, 3, 1);
INSERT INTO `tk_cat` VALUES (1085, '温室大棚支架', 10000010, 3, 1);
INSERT INTO `tk_cat` VALUES (1086, '铁丝网', 10000010, 3, 1);
INSERT INTO `tk_cat` VALUES (1087, '防虫网/遮阳网', 10000010, 3, 1);
INSERT INTO `tk_cat` VALUES (1098, '农业机械/工具', 10000012, 3, 1);
INSERT INTO `tk_cat` VALUES (1099, '农机整机', 10000012, 3, 1);
INSERT INTO `tk_cat` VALUES (1100, '农机配件', 10000012, 3, 1);
INSERT INTO `tk_cat` VALUES (1101, '割草机', 10000012, 3, 1);
INSERT INTO `tk_cat` VALUES (1102, '喷雾器', 10000012, 3, 1);
INSERT INTO `tk_cat` VALUES (1103, '园林机械', 10000012, 3, 1);
INSERT INTO `tk_cat` VALUES (1104, '小型农机具', 10000012, 3, 1);
INSERT INTO `tk_cat` VALUES (1105, '微耕机', 10000012, 3, 1);
INSERT INTO `tk_cat` VALUES (1107, '园艺工具', 10000013, 3, 1);
INSERT INTO `tk_cat` VALUES (1108, '园艺肥料/营养液', 10000013, 3, 1);
INSERT INTO `tk_cat` VALUES (1110, '园艺辅材', 10000013, 3, 1);
INSERT INTO `tk_cat` VALUES (1111, '基质/营养土', 10000013, 3, 1);
INSERT INTO `tk_cat` VALUES (1112, '灌溉设备', 10000013, 3, 1);
INSERT INTO `tk_cat` VALUES (1113, '篱笆栅栏/爬藤架', 10000013, 3, 1);
INSERT INTO `tk_cat` VALUES (1114, '花瓶花盆花器', 10000013, 3, 1);
INSERT INTO `tk_cat` VALUES (1116, '花卉/蔬果/草坪种子', 10000014, 3, 1);
INSERT INTO `tk_cat` VALUES (1117, '种球', 10000014, 3, 1);
INSERT INTO `tk_cat` VALUES (1119, '林木类种子', 10000014, 3, 1);
INSERT INTO `tk_cat` VALUES (1120, '菌类种子', 10000014, 3, 1);
INSERT INTO `tk_cat` VALUES (1122, '土壤调理剂', 10000015, 3, 1);
INSERT INTO `tk_cat` VALUES (1123, '复合肥', 10000015, 3, 1);
INSERT INTO `tk_cat` VALUES (1124, '微生物肥料', 10000015, 3, 1);
INSERT INTO `tk_cat` VALUES (1125, '有机肥', 10000015, 3, 1);
INSERT INTO `tk_cat` VALUES (1126, '氮/磷/钾肥', 10000015, 3, 1);
INSERT INTO `tk_cat` VALUES (1127, '水溶/叶面肥', 10000015, 3, 1);
INSERT INTO `tk_cat` VALUES (1128, '钙镁/硅肥', 10000015, 3, 1);
INSERT INTO `tk_cat` VALUES (1130, '多肉植物', 10000016, 3, 1);
INSERT INTO `tk_cat` VALUES (1131, '大型绿植', 10000016, 3, 1);
INSERT INTO `tk_cat` VALUES (1132, '花艺/仿真花/永生花', 10000016, 3, 1);
INSERT INTO `tk_cat` VALUES (1137, '全价料', 10000017, 3, 1);
INSERT INTO `tk_cat` VALUES (1138, '浓缩料', 10000017, 3, 1);
INSERT INTO `tk_cat` VALUES (1139, '预混料', 10000017, 3, 1);
INSERT INTO `tk_cat` VALUES (1140, '饲料原料', 10000017, 3, 1);
INSERT INTO `tk_cat` VALUES (1141, '饲料添加剂', 10000017, 3, 1);
INSERT INTO `tk_cat` VALUES (1144, '刀具套装', 10000019, 3, 1);
INSERT INTO `tk_cat` VALUES (1145, '剪刀', 10000019, 3, 1);
INSERT INTO `tk_cat` VALUES (1146, '多功能刀', 10000019, 3, 1);
INSERT INTO `tk_cat` VALUES (1148, '瓜果刀/刨', 10000019, 3, 1);
INSERT INTO `tk_cat` VALUES (1149, '砧板/菜板', 10000019, 3, 1);
INSERT INTO `tk_cat` VALUES (1150, '菜刀', 10000019, 3, 1);
INSERT INTO `tk_cat` VALUES (1153, '厨房DIY/小工具', 10000020, 3, 1);
INSERT INTO `tk_cat` VALUES (1154, '厨房储物器皿', 10000020, 3, 1);
INSERT INTO `tk_cat` VALUES (1155, '厨房秤', 10000020, 3, 1);
INSERT INTO `tk_cat` VALUES (1156, '厨房储物架/厨房置物架', 10000020, 3, 1);
INSERT INTO `tk_cat` VALUES (1159, '调料器皿', 10000020, 3, 1);
INSERT INTO `tk_cat` VALUES (1160, '饭盒/提锅', 10000020, 3, 1);
INSERT INTO `tk_cat` VALUES (1162, '咖啡具套装', 10000021, 3, 1);
INSERT INTO `tk_cat` VALUES (1163, '咖啡具配件', 10000021, 3, 1);
INSERT INTO `tk_cat` VALUES (1164, '咖啡壶', 10000021, 3, 1);
INSERT INTO `tk_cat` VALUES (1165, '咖啡杯', 10000021, 3, 1);
INSERT INTO `tk_cat` VALUES (1166, '咖啡滤纸', 10000021, 3, 1);
INSERT INTO `tk_cat` VALUES (1167, '打奶器', 10000021, 3, 1);
INSERT INTO `tk_cat` VALUES (1168, '磨豆机', 10000021, 3, 1);
INSERT INTO `tk_cat` VALUES (1182, '奶锅', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1183, '平底锅/煎锅', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1184, '水壶', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1185, '汤锅', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1186, '火锅', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1187, '炒锅', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1189, '砂锅', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1190, '蒸锅', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1191, '锅具套装', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1192, '高压锅', 10000023, 3, 1);
INSERT INTO `tk_cat` VALUES (1196, '酒店水具', 10000024, 3, 1);
INSERT INTO `tk_cat` VALUES (1197, '酒店餐具', 10000024, 3, 1);
INSERT INTO `tk_cat` VALUES (1200, '刀/叉/勺', 10000025, 3, 1);
INSERT INTO `tk_cat` VALUES (1201, '果盘/果篮', 10000025, 3, 1);
INSERT INTO `tk_cat` VALUES (1203, '盘/碟', 10000025, 3, 1);
INSERT INTO `tk_cat` VALUES (1204, '碗', 10000025, 3, 1);
INSERT INTO `tk_cat` VALUES (1205, '筷子', 10000025, 3, 1);
INSERT INTO `tk_cat` VALUES (1207, '餐具套装', 10000025, 3, 1);
INSERT INTO `tk_cat` VALUES (1212, '狗主食罐', 10000027, 3, 1);
INSERT INTO `tk_cat` VALUES (1213, '狗干粮', 10000027, 3, 1);
INSERT INTO `tk_cat` VALUES (1214, '猫主食罐', 10000027, 3, 1);
INSERT INTO `tk_cat` VALUES (1215, '猫干粮', 10000027, 3, 1);
INSERT INTO `tk_cat` VALUES (1217, '狗零食', 10000028, 3, 1);
INSERT INTO `tk_cat` VALUES (1218, '猫零食', 10000028, 3, 1);
INSERT INTO `tk_cat` VALUES (1220, '护毛素', 10000029, 3, 1);
INSERT INTO `tk_cat` VALUES (1221, '浴液', 10000029, 3, 1);
INSERT INTO `tk_cat` VALUES (1222, '美容用具', 10000029, 3, 1);
INSERT INTO `tk_cat` VALUES (1223, '美容电器', 10000029, 3, 1);
INSERT INTO `tk_cat` VALUES (1225, '外出用品', 10000030, 3, 1);
INSERT INTO `tk_cat` VALUES (1226, '宠物配饰', 10000030, 3, 1);
INSERT INTO `tk_cat` VALUES (1227, '其他宠物服饰及配饰品', 10000030, 3, 1);
INSERT INTO `tk_cat` VALUES (1228, '牵引绳/胸背带', 10000030, 3, 1);
INSERT INTO `tk_cat` VALUES (1229, '航空箱/便携包', 10000030, 3, 1);
INSERT INTO `tk_cat` VALUES (1230, '训练器/止吠器', 10000030, 3, 1);
INSERT INTO `tk_cat` VALUES (1233, '尿垫', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (1234, '清洁除味', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (1235, '狗厕所', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (1236, '猫狗沙发/柜', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (1237, '猫狗窝', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (1238, '猫砂', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (1239, '猫砂盆', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (1240, '笼子/围栏', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (1241, '食具水具', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (1243, '狗玩具', 10000032, 3, 1);
INSERT INTO `tk_cat` VALUES (1244, '猫抓板', 10000032, 3, 1);
INSERT INTO `tk_cat` VALUES (1245, '猫爬架', 10000032, 3, 1);
INSERT INTO `tk_cat` VALUES (1246, '猫玩具', 10000032, 3, 1);
INSERT INTO `tk_cat` VALUES (1249, '书架', 10000034, 3, 1);
INSERT INTO `tk_cat` VALUES (1250, '书柜', 10000034, 3, 1);
INSERT INTO `tk_cat` VALUES (1251, '书桌', 10000034, 3, 1);
INSERT INTO `tk_cat` VALUES (1252, '升降桌', 10000034, 3, 1);
INSERT INTO `tk_cat` VALUES (1254, '电竞桌', 10000034, 3, 1);
INSERT INTO `tk_cat` VALUES (1255, '电竞椅', 10000034, 3, 1);
INSERT INTO `tk_cat` VALUES (1256, '电脑桌', 10000034, 3, 1);
INSERT INTO `tk_cat` VALUES (1257, '电脑椅', 10000034, 3, 1);
INSERT INTO `tk_cat` VALUES (1258, '连体书桌柜', 10000034, 3, 1);
INSERT INTO `tk_cat` VALUES (1260, '储物/收纳用品', 10000035, 3, 1);
INSERT INTO `tk_cat` VALUES (1261, '墙面搁架', 10000035, 3, 1);
INSERT INTO `tk_cat` VALUES (1262, '层架/置物架', 10000035, 3, 1);
INSERT INTO `tk_cat` VALUES (1264, '衣帽架', 10000035, 3, 1);
INSERT INTO `tk_cat` VALUES (1265, '鞋架', 10000035, 3, 1);
INSERT INTO `tk_cat` VALUES (1266, '餐边手推架', 10000035, 3, 1);
INSERT INTO `tk_cat` VALUES (1268, '儿童书桌', 10000036, 3, 1);
INSERT INTO `tk_cat` VALUES (1269, '儿童家具配件', 10000036, 3, 1);
INSERT INTO `tk_cat` VALUES (1270, '儿童床', 10000036, 3, 1);
INSERT INTO `tk_cat` VALUES (1271, '儿童床垫', 10000036, 3, 1);
INSERT INTO `tk_cat` VALUES (1272, '儿童桌椅套装', 10000036, 3, 1);
INSERT INTO `tk_cat` VALUES (1273, '儿童椅凳', 10000036, 3, 1);
INSERT INTO `tk_cat` VALUES (1274, '儿童沙发', 10000036, 3, 1);
INSERT INTO `tk_cat` VALUES (1275, '儿童衣柜', 10000036, 3, 1);
INSERT INTO `tk_cat` VALUES (1276, '儿童餐椅', 10000036, 3, 1);
INSERT INTO `tk_cat` VALUES (1278, '定制衣柜', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1279, '床', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1280, '床垫', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1281, '床头柜', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1282, '斗柜', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1283, '梳妆台/凳', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1284, '榻榻米', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1286, '穿衣镜', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1287, '简易衣柜', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1288, '衣柜', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1289, '顶箱柜', 10000037, 3, 1);
INSERT INTO `tk_cat` VALUES (1291, '会议台/桌', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1292, '办公前台/收银台', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1293, '办公桌', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1294, '办公椅', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1295, '办公沙发', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1296, '功夫茶桌', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1297, '化学品柜', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1299, '单身公寓家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1300, '双层铁床', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1301, '发廊/美容家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1302, '吸烟亭', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1303, '员工宿舍家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1304, '售报亭', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1305, '唱吧亭', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1306, '多媒体讲台', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1307, '娱乐/酒吧/KTV家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1308, '学生公寓家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1309, '密集架', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1310, '屏风工位', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1311, '展柜', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1312, '康复家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1313, '手机屏蔽柜', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1314, '文件柜/办公柜', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1315, '无障碍设施', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1316, '智能回收机', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1317, '智能图书柜', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1318, '智能货架', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1319, '智能餐桌', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1320, '更衣柜', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1321, '服装店家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1322, '校园教学家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1325, '消防柜', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1326, '演讲台', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1327, '火锅桌', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1329, '班台/班桌', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1330, '租房公寓家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1331, '自行车停放设施', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1332, '茶水柜', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1333, '货架/展示架', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1334, '超市家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1335, '酒店后厨家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1336, '酒店大堂家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1337, '酒店套房家具', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1338, '酒店桌椅', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1339, '酒店行李柜', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1340, '阅览桌', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1342, '食堂餐桌', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1343, '餐饮沙发/卡座', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1344, '高隔断/隔墙', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1346, '龙虾桌', 10000038, 3, 1);
INSERT INTO `tk_cat` VALUES (1358, '书房套房', 10000040, 3, 1);
INSERT INTO `tk_cat` VALUES (1359, '儿童套房', 10000040, 3, 1);
INSERT INTO `tk_cat` VALUES (1360, '卧室套房', 10000040, 3, 1);
INSERT INTO `tk_cat` VALUES (1361, '客厅套房', 10000040, 3, 1);
INSERT INTO `tk_cat` VALUES (1362, '餐厅套房', 10000040, 3, 1);
INSERT INTO `tk_cat` VALUES (1364, '书房定制', 10000041, 3, 1);
INSERT INTO `tk_cat` VALUES (1365, '卧室定制', 10000041, 3, 1);
INSERT INTO `tk_cat` VALUES (1366, '客餐厅定制', 10000041, 3, 1);
INSERT INTO `tk_cat` VALUES (1367, '整装定制', 10000041, 3, 1);
INSERT INTO `tk_cat` VALUES (1368, '衣帽间定制', 10000041, 3, 1);
INSERT INTO `tk_cat` VALUES (1370, '阳台空间定制', 10000041, 3, 1);
INSERT INTO `tk_cat` VALUES (1372, '凳子', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1373, '壁炉', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1374, '屏风', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1375, '懒人沙发', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1376, '沙发', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1377, '沙发床', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1379, '玄关隔断', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1380, '电视柜', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1381, '角柜', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1382, '边桌/茶几', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1383, '鞋柜', 10000042, 3, 1);
INSERT INTO `tk_cat` VALUES (1407, '家用梯', 10000044, 3, 1);
INSERT INTO `tk_cat` VALUES (1408, '户外家具', 10000044, 3, 1);
INSERT INTO `tk_cat` VALUES (1409, '折叠床', 10000044, 3, 1);
INSERT INTO `tk_cat` VALUES (1410, '智能晾衣机', 10000044, 3, 1);
INSERT INTO `tk_cat` VALUES (1411, '晾衣架', 10000044, 3, 1);
INSERT INTO `tk_cat` VALUES (1412, '炕几/窗几', 10000044, 3, 1);
INSERT INTO `tk_cat` VALUES (1414, '花架/装饰架', 10000044, 3, 1);
INSERT INTO `tk_cat` VALUES (1416, '椅子', 10000045, 3, 1);
INSERT INTO `tk_cat` VALUES (1418, '酒柜', 10000045, 3, 1);
INSERT INTO `tk_cat` VALUES (1419, '餐桌', 10000045, 3, 1);
INSERT INTO `tk_cat` VALUES (1420, '餐边柜', 10000045, 3, 1);
INSERT INTO `tk_cat` VALUES (1424, '墙贴/装饰贴', 10000047, 3, 1);
INSERT INTO `tk_cat` VALUES (1425, '壁饰', 10000047, 3, 1);
INSERT INTO `tk_cat` VALUES (1426, '帘艺隔断', 10000047, 3, 1);
INSERT INTO `tk_cat` VALUES (1427, '手工/十字绣', 10000047, 3, 1);
INSERT INTO `tk_cat` VALUES (1429, '相框/照片墙', 10000047, 3, 1);
INSERT INTO `tk_cat` VALUES (1430, '节庆饰品', 10000047, 3, 1);
INSERT INTO `tk_cat` VALUES (1432, '印刷装饰字画', 10000047, 3, 1);
INSERT INTO `tk_cat` VALUES (1433, '装饰摆件', 10000047, 3, 1);
INSERT INTO `tk_cat` VALUES (1434, '钟饰', 10000047, 3, 1);
INSERT INTO `tk_cat` VALUES (1437, '分隔收纳', 10000048, 3, 1);
INSERT INTO `tk_cat` VALUES (1438, '收纳架/篮', 10000048, 3, 1);
INSERT INTO `tk_cat` VALUES (1439, '收纳柜', 10000048, 3, 1);
INSERT INTO `tk_cat` VALUES (1440, '收纳箱', 10000048, 3, 1);
INSERT INTO `tk_cat` VALUES (1441, '收纳袋/包', 10000048, 3, 1);
INSERT INTO `tk_cat` VALUES (1442, '防尘罩', 10000048, 3, 1);
INSERT INTO `tk_cat` VALUES (1444, '除醛用品', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (1445, '保暖防护', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (1446, '净化除味', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (1447, '洗晒/熨烫', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (1448, '浴室用品', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (1450, '缝纫机', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (1451, '缝纫/针织材料', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (1452, '雨伞雨具', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (1455, '其它清洁用品', 10000051, 3, 1);
INSERT INTO `tk_cat` VALUES (1456, '地板清洁剂', 10000051, 3, 1);
INSERT INTO `tk_cat` VALUES (1457, '家电清洁用品', 10000051, 3, 1);
INSERT INTO `tk_cat` VALUES (1458, '油污清洁剂', 10000051, 3, 1);
INSERT INTO `tk_cat` VALUES (1459, '洁厕剂', 10000051, 3, 1);
INSERT INTO `tk_cat` VALUES (1460, '洗洁精', 10000051, 3, 1);
INSERT INTO `tk_cat` VALUES (1461, '消毒液', 10000051, 3, 1);
INSERT INTO `tk_cat` VALUES (1462, '除湿干燥剂', 10000051, 3, 1);
INSERT INTO `tk_cat` VALUES (1464, '一次性清洁用品', 10000052, 3, 1);
INSERT INTO `tk_cat` VALUES (1465, '其它清洁工具', 10000052, 3, 1);
INSERT INTO `tk_cat` VALUES (1466, '垃圾袋/垃圾桶', 10000052, 3, 1);
INSERT INTO `tk_cat` VALUES (1467, '手套/鞋套/围裙', 10000052, 3, 1);
INSERT INTO `tk_cat` VALUES (1468, '抹布/百洁布', 10000052, 3, 1);
INSERT INTO `tk_cat` VALUES (1469, '拖把/扫把', 10000052, 3, 1);
INSERT INTO `tk_cat` VALUES (1470, '清洁刷具', 10000052, 3, 1);
INSERT INTO `tk_cat` VALUES (1471, '清洁用具配件', 10000052, 3, 1);
INSERT INTO `tk_cat` VALUES (1472, '脸盆/水桶', 10000052, 3, 1);
INSERT INTO `tk_cat` VALUES (1474, '其它纸品/湿巾', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (1475, '卷纸', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (1476, '厨房纸巾', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (1477, '手帕纸', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (1478, '抽纸', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (1479, '湿厕纸', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (1480, '湿巾', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (1482, '护理工具', 10000054, 3, 1);
INSERT INTO `tk_cat` VALUES (1483, '皮具护理品', 10000054, 3, 1);
INSERT INTO `tk_cat` VALUES (1485, '其它衣物清洁', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (1486, '护理剂', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (1487, '洗衣凝珠', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (1488, '洗衣液', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (1489, '洗衣皂', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (1490, '洗衣粉', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (1491, '除菌剂', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (1498, '其它个护仪器', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1499, '冲牙器', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1500, '剃/脱毛器', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1501, '电动剃须刀', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1502, '卷/直发器', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1503, '按摩器', 10000058, 3, 1);
INSERT INTO `tk_cat` VALUES (1504, '按摩椅', 10000058, 3, 1);
INSERT INTO `tk_cat` VALUES (1505, '洁面仪', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1507, '理发器', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1508, '电动牙刷', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1509, '电动牙刷头', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1510, '吹风机', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1511, '电子秤', 10000058, 3, 1);
INSERT INTO `tk_cat` VALUES (1512, '眼部按摩仪', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1513, '美容器', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (1514, '足浴盆', 10000058, 3, 1);
INSERT INTO `tk_cat` VALUES (1515, '足疗机', 10000058, 3, 1);
INSERT INTO `tk_cat` VALUES (1517, '太阳能热水器', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1518, '嵌入式微蒸烤', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1519, '油烟机', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1520, '洗碗机', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1521, '消毒柜', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1522, '燃气灶', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1523, '燃气热水器/壁挂炉', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1524, '电热水器', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1525, '空气能热水器', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1526, '蒸箱', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1527, '集成灶', 10000059, 3, 1);
INSERT INTO `tk_cat` VALUES (1530, '养生壶/煎药壶', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1531, '厨师机/和面机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1532, '厨房电器配件', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1533, '咖啡机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1534, '多用途锅', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1535, '微波炉', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1536, '打蛋器', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1537, '料理机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1538, '果蔬解毒机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1539, '榨汁机/原汁机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1540, '煮蛋器', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1542, '电压力锅', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1543, '电水壶/热水瓶', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1544, '电炖锅', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1545, '电烤箱', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1546, '电烧烤炉', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1547, '电热饭盒', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1548, '电磁炉', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1549, '电陶炉', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1550, '电饭煲', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1551, '电饼铛', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1552, '破壁机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1553, '空气炸锅', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1554, '绞肉机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1555, '豆浆机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1556, '酸奶机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1557, '面包机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1558, '面条机', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (1560, '保温售饭台', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1561, '保鲜工作台', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1562, '关东煮机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1564, '冰淇淋机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1565, '刨冰/沙冰机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1566, '制冰机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1567, '商用冰柜/冰箱', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1568, '商用净水设备', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1569, '商用压面机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1570, '商用吸尘器', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1571, '商用和面机/打蛋机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1572, '商用咖啡机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1573, '商用开水器', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1574, '商用消毒柜', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1575, '商用烤箱', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1576, '商用电器配件', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1577, '商用电磁炉', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1578, '商用电饭煲', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1579, '商用电饼铛', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1580, '商用磨浆机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1581, '商用绞肉机/切肉机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1582, '封口/封杯机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1583, '展示柜', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1585, '扒炉', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1586, '果糖机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1587, '棉花糖机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1588, '油烟净化器', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1589, '煮面桶', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1590, '爆米花机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1591, '电动餐车', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1592, '电炸炉', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1593, '章鱼丸机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1594, '肠粉机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1595, '自动售货机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1596, '蒸柜', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1597, '醒发箱', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1598, '食品烘干机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1599, '饮料机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1600, '香肠/热狗机', 10000061, 3, 1);
INSERT INTO `tk_cat` VALUES (1602, '中央空调', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1603, '冰箱', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1604, '冷柜/冰吧', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1605, '平板电视', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1606, '洗烘套装', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1607, '洗衣机', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1608, '烘干机', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1610, '移动空调', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1611, '空调', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1612, '空调外机', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1613, '酒柜', 10000062, 3, 1);
INSERT INTO `tk_cat` VALUES (1615, '个护健康配件', 10000063, 3, 1);
INSERT INTO `tk_cat` VALUES (1616, '冰箱配件', 10000063, 3, 1);
INSERT INTO `tk_cat` VALUES (1617, '厨房小电配件', 10000063, 3, 1);
INSERT INTO `tk_cat` VALUES (1618, '洗衣机配件', 10000063, 3, 1);
INSERT INTO `tk_cat` VALUES (1619, '烟机灶具配件', 10000063, 3, 1);
INSERT INTO `tk_cat` VALUES (1620, '生活电器配件', 10000063, 3, 1);
INSERT INTO `tk_cat` VALUES (1621, '电视配件', 10000063, 3, 1);
INSERT INTO `tk_cat` VALUES (1622, '空调配件', 10000063, 3, 1);
INSERT INTO `tk_cat` VALUES (1625, '冷风扇', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1626, '净水器', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1627, '加湿器', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1628, '取暖电器', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1629, '吸尘器', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1630, '干衣机', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1631, '扫地机器人', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1632, '挂烫机/熨斗', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1633, '新风系统', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1634, '毛球修剪器', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1635, '清洁机', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1637, '电暖桌', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1638, '电话机', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1639, '电风扇', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1640, '空气净化器', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1641, '除湿机', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1642, '除螨仪', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1643, '饮水机', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (1645, 'HIFI专区', 10000065, 3, 1);
INSERT INTO `tk_cat` VALUES (1646, 'KTV音响', 10000065, 3, 1);
INSERT INTO `tk_cat` VALUES (1647, '功放', 10000065, 3, 1);
INSERT INTO `tk_cat` VALUES (1648, '回音壁/Soundbar', 10000065, 3, 1);
INSERT INTO `tk_cat` VALUES (1649, '家庭影院', 10000065, 3, 1);
INSERT INTO `tk_cat` VALUES (1650, '播放器/DVD', 10000065, 3, 1);
INSERT INTO `tk_cat` VALUES (1651, '迷你音响', 10000065, 3, 1);
INSERT INTO `tk_cat` VALUES (1652, '麦克风', 10000065, 3, 1);
INSERT INTO `tk_cat` VALUES (1655, '洁面巾', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (1659, '布料', 10000067, 3, 1);
INSERT INTO `tk_cat` VALUES (1661, '挂毯/壁毯', 10000067, 3, 1);
INSERT INTO `tk_cat` VALUES (1665, '沙发垫套', 10000067, 3, 1);
INSERT INTO `tk_cat` VALUES (1678, '床垫/床褥', 10000068, 3, 1);
INSERT INTO `tk_cat` VALUES (1682, '毛毯', 10000068, 3, 1);
INSERT INTO `tk_cat` VALUES (1683, '水暖毯', 10000068, 3, 1);
INSERT INTO `tk_cat` VALUES (1685, '电热毯', 10000068, 3, 1);
INSERT INTO `tk_cat` VALUES (1695, '蚊帐', 10000068, 3, 1);
INSERT INTO `tk_cat` VALUES (1703, '仪器仪表', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1704, '劳防用品', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1705, '家用五金', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1706, '工具组套', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1707, '工具配件', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1708, '手动工具', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1709, '搬运/起重设备', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1710, '机械锁', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1711, '机电五金', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1712, '气动工具', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1713, '测量工具', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1715, '电动工具', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1716, '电子锁', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1717, '道路护栏板', 10000070, 3, 1);
INSERT INTO `tk_cat` VALUES (1719, '净水软水', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1720, '卫浴套装', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1721, '厨卫拉篮', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1722, '厨卫挂件', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1723, '厨卫配件', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1724, '吊顶', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1725, '地漏', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1726, '垃圾处理器', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1727, '干手器', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1728, '排气扇/换气设备', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1729, '智能坐便器', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1730, '智能马桶盖', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1731, '橱柜', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1732, '水槽', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1733, '沐浴桶', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1734, '浴室柜', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1735, '浴缸', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1736, '浴霸', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1737, '淋浴房', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1738, '淋浴花洒', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1740, '陶瓷件组套', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1741, '马桶', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1742, '龙头', 10000071, 3, 1);
INSERT INTO `tk_cat` VALUES (1744, '化工产品', 10000072, 3, 1);
INSERT INTO `tk_cat` VALUES (1745, '型材', 10000072, 3, 1);
INSERT INTO `tk_cat` VALUES (1746, '基建辅料', 10000072, 3, 1);
INSERT INTO `tk_cat` VALUES (1747, '木材/板材', 10000072, 3, 1);
INSERT INTO `tk_cat` VALUES (1748, '沙/石/水泥', 10000072, 3, 1);
INSERT INTO `tk_cat` VALUES (1749, '油漆/涂料', 10000072, 3, 1);
INSERT INTO `tk_cat` VALUES (1750, '涂刷化工类辅料', 10000072, 3, 1);
INSERT INTO `tk_cat` VALUES (1751, '管材管件', 10000072, 3, 1);
INSERT INTO `tk_cat` VALUES (1753, '安全爬梯', 10000073, 3, 1);
INSERT INTO `tk_cat` VALUES (1754, '施工喷淋系统', 10000073, 3, 1);
INSERT INTO `tk_cat` VALUES (1755, '施工围挡', 10000073, 3, 1);
INSERT INTO `tk_cat` VALUES (1756, '活动板房', 10000073, 3, 1);
INSERT INTO `tk_cat` VALUES (1758, '地板', 10000074, 3, 1);
INSERT INTO `tk_cat` VALUES (1759, '壁纸', 10000074, 3, 1);
INSERT INTO `tk_cat` VALUES (1760, '木材/板材', 10000074, 3, 1);
INSERT INTO `tk_cat` VALUES (1762, '瓷砖', 10000074, 3, 1);
INSERT INTO `tk_cat` VALUES (1763, '背景墙', 10000074, 3, 1);
INSERT INTO `tk_cat` VALUES (1765, 'LED灯源', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1766, '其它光源', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1767, '其它照明', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1768, '卤钨灯源', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1769, '台灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1770, '吊扇灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1771, '吊灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1772, '吸顶灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1773, '壁灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1774, '室外/庭院灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1775, '手电筒/应急灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1776, '杀菌灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1777, '氛围照明', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1778, '灯具配件', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1780, '筒灯/射灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1781, '荧光灯源', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1782, '落地灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1783, '镜前灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1784, '麻将灯', 10000075, 3, 1);
INSERT INTO `tk_cat` VALUES (1786, '光伏设备', 10000076, 3, 1);
INSERT INTO `tk_cat` VALUES (1787, '开关插座', 10000076, 3, 1);
INSERT INTO `tk_cat` VALUES (1788, '智能家居', 10000076, 3, 1);
INSERT INTO `tk_cat` VALUES (1790, '电料配件', 10000076, 3, 1);
INSERT INTO `tk_cat` VALUES (1791, '电气控制', 10000076, 3, 1);
INSERT INTO `tk_cat` VALUES (1792, '电线/电缆', 10000076, 3, 1);
INSERT INTO `tk_cat` VALUES (1793, '配电箱/断路器', 10000076, 3, 1);
INSERT INTO `tk_cat` VALUES (1794, '门铃', 10000076, 3, 1);
INSERT INTO `tk_cat` VALUES (1796, '吊顶', 10000077, 3, 1);
INSERT INTO `tk_cat` VALUES (1797, '壁炉/地暖', 10000077, 3, 1);
INSERT INTO `tk_cat` VALUES (1798, '散热器', 10000077, 3, 1);
INSERT INTO `tk_cat` VALUES (1800, '移门壁柜', 10000077, 3, 1);
INSERT INTO `tk_cat` VALUES (1801, '窗', 10000077, 3, 1);
INSERT INTO `tk_cat` VALUES (1802, '门', 10000077, 3, 1);
INSERT INTO `tk_cat` VALUES (1803, '阳光房', 10000077, 3, 1);
INSERT INTO `tk_cat` VALUES (1948, '手机', 10000101, 3, 1);
INSERT INTO `tk_cat` VALUES (1950, '充电器', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1951, '创意配件', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1953, '手机壳/保护套', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1954, '手机存储卡', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1955, '手机支架', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1956, '手机电池', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1957, '手机耳机', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1958, '手机贴膜', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1959, '手机饰品', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1960, '拍照配件', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1961, '数据线', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1962, '无线充电', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1963, '移动电源', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1964, '苹果周边', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1965, '蓝牙耳机', 10000102, 3, 1);
INSERT INTO `tk_cat` VALUES (1974, 'MP3/MP4', 10000105, 3, 1);
INSERT INTO `tk_cat` VALUES (1975, '专业音频', 10000105, 3, 1);
INSERT INTO `tk_cat` VALUES (1976, '便携/无线音箱', 10000105, 3, 1);
INSERT INTO `tk_cat` VALUES (1977, '收音机', 10000105, 3, 1);
INSERT INTO `tk_cat` VALUES (1979, '耳机/耳麦', 10000105, 3, 1);
INSERT INTO `tk_cat` VALUES (1980, '苹果配件', 10000105, 3, 1);
INSERT INTO `tk_cat` VALUES (1981, '音箱/音响', 10000105, 3, 1);
INSERT INTO `tk_cat` VALUES (1982, '麦克风', 10000105, 3, 1);
INSERT INTO `tk_cat` VALUES (1985, '单反相机', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (1986, '影棚器材', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (1987, '微单相机', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (1988, '户外器材', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (1989, '拍立得', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (1990, '摄像机', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (1991, '数码相机', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (1992, '数码相框', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (1993, '运动相机', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (1994, '镜头', 10000106, 3, 1);
INSERT INTO `tk_cat` VALUES (2000, '三脚架/云台', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6001, '存储卡', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6002, '数码支架', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6003, '机身附件', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6004, '滤镜', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6005, '电池/充电器', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6006, '相机包', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6007, '相机清洁/贴膜', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6008, '读卡器', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6009, '镜头附件', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6010, '闪光灯/手柄', 10000108, 3, 1);
INSERT INTO `tk_cat` VALUES (6012, 'VR眼镜', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6013, '体感车', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6014, '健康监测', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6016, '无人机', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6017, '智能家居', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6018, '智能手环', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6019, '智能手表', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6020, '智能机器人', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6021, '智能配饰', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6023, '运动跟踪器', 10000109, 3, 1);
INSERT INTO `tk_cat` VALUES (6025, '复读机', 10000110, 3, 1);
INSERT INTO `tk_cat` VALUES (6026, '学生平板', 10000110, 3, 1);
INSERT INTO `tk_cat` VALUES (6027, '录音笔', 10000110, 3, 1);
INSERT INTO `tk_cat` VALUES (6028, '点读机/笔/保护膜', 10000110, 3, 1);
INSERT INTO `tk_cat` VALUES (6030, '电子词典', 10000110, 3, 1);
INSERT INTO `tk_cat` VALUES (6031, '电纸书', 10000110, 3, 1);
INSERT INTO `tk_cat` VALUES (6032, '翻译机', 10000110, 3, 1);
INSERT INTO `tk_cat` VALUES (6038, '吊带/背心', 10000112, 3, 1);
INSERT INTO `tk_cat` VALUES (6043, '少女文胸', 10000112, 3, 1);
INSERT INTO `tk_cat` VALUES (6045, '打底衫', 10000112, 3, 1);
INSERT INTO `tk_cat` VALUES (6046, '打底裤', 10000112, 3, 1);
INSERT INTO `tk_cat` VALUES (6058, 'T恤', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6059, '中老年女装', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6060, '仿皮皮衣', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6061, '休闲裤', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6062, '加绒裤', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6063, '半身裙', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6064, '卫衣', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6065, '吊带/背心', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6066, '大码女装', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6067, '女装套装', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6068, '婚纱', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6069, '小西装', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6070, '打底衫', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6071, '打底裤', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6072, '旗袍/汉服', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6073, '棉服', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6074, '正装裤', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6075, '毛呢大衣', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6076, '毛衣', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6077, '牛仔裤', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6079, '皮草', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6080, '真皮皮衣', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6081, '短外套', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6082, '短裤', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6083, '礼服', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6084, '羊绒衫', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6085, '羽绒服', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6086, '衬衫', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6087, '设计师/潮牌', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6088, '连衣裙', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6089, '针织衫', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6090, '雪纺衫', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6091, '风衣', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6092, '马甲', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (6094, '假领', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6095, '光学镜架/镜片', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6096, '口罩（非医用）', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6097, '围巾/手套/帽子套装', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6098, '太阳镜', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6099, '女士丝巾/围巾/披肩', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6100, '棒球帽', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6101, '毛线/布面料', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6102, '毛线帽', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6103, '毛线手套', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6104, '游泳镜', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6106, '男士丝巾/围巾', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6107, '真皮手套', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6108, '礼帽', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6109, '老花镜', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6110, '耳罩/耳包', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6111, '袖扣', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6112, '装饰眼镜', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6113, '贝雷帽', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6114, '遮阳伞/雨伞', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6115, '遮阳帽', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6116, '钥匙扣', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6117, '防晒手套', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6118, '防辐射眼镜', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6119, '非皮质腰带', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6120, '领带/领结/领带夹', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6121, '鸭舌帽', 10000114, 3, 1);
INSERT INTO `tk_cat` VALUES (6123, 'POLO衫', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (6124, 'T恤', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (6129, '卫衣', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (6134, '工装', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (6135, '棉服', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (6144, '羽绒服', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (6145, '衬衫', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (6149, '设计师/潮牌', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (6155, '儿童餐具', 10000117, 3, 1);
INSERT INTO `tk_cat` VALUES (6156, '吸奶器', 10000117, 3, 1);
INSERT INTO `tk_cat` VALUES (6157, '围兜/防溅衣', 10000117, 3, 1);
INSERT INTO `tk_cat` VALUES (6158, '奶瓶奶嘴', 10000117, 3, 1);
INSERT INTO `tk_cat` VALUES (6159, '暖奶消毒', 10000117, 3, 1);
INSERT INTO `tk_cat` VALUES (6160, '水壶/水杯', 10000117, 3, 1);
INSERT INTO `tk_cat` VALUES (6161, '牙胶安抚', 10000117, 3, 1);
INSERT INTO `tk_cat` VALUES (6162, '辅食料理机', 10000117, 3, 1);
INSERT INTO `tk_cat` VALUES (6163, '食物存储', 10000117, 3, 1);
INSERT INTO `tk_cat` VALUES (6165, '产后塑身', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6166, '出行用品', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6167, '哺乳用品', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6168, '孕产妇家居服/哺乳装', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6169, '孕产妇洗护', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6170, '孕产妇鞋帽袜', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6171, '孕妇装', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6173, '待产护理', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6174, '文胸/内裤', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6175, '防辐射服', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (6177, '吸汗巾/垫背巾', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6178, '婴儿鞋帽袜', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6179, '婴童凉席/蚊帐', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6180, '婴童布尿裤/尿布', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6181, '婴童床单/床褥', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6182, '婴童床品套件', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6183, '婴童床围', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6184, '婴童枕芯/枕套', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6185, '婴童毛巾/口水巾', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6186, '婴童浴巾/浴衣', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6187, '婴童睡袋/抱被', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6188, '婴童被子/被套', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6189, '婴童隔尿垫/巾', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6190, '安全防护', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6191, '爬行垫', 10000119, 3, 1);
INSERT INTO `tk_cat` VALUES (6193, '增高垫', 10000120, 3, 1);
INSERT INTO `tk_cat` VALUES (6194, '安全座椅', 10000120, 3, 1);
INSERT INTO `tk_cat` VALUES (6195, '提篮式', 10000120, 3, 1);
INSERT INTO `tk_cat` VALUES (6197, '婴儿尿裤', 10000121, 3, 1);
INSERT INTO `tk_cat` VALUES (6198, '婴儿湿巾', 10000121, 3, 1);
INSERT INTO `tk_cat` VALUES (6199, '婴儿纸尿片', 10000121, 3, 1);
INSERT INTO `tk_cat` VALUES (6200, '成人尿裤', 10000121, 3, 1);
INSERT INTO `tk_cat` VALUES (6201, '拉拉裤', 10000121, 3, 1);
INSERT INTO `tk_cat` VALUES (6203, '奶瓶清洗', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6204, '婴儿口腔清洁', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6205, '婴儿理发器', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6206, '宝宝护肤', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6207, '座便器', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6208, '日常护理', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6209, '棉柔巾', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6210, '洗发沐浴', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6211, '洗澡用具', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6212, '洗衣液/皂', 10000122, 3, 1);
INSERT INTO `tk_cat` VALUES (6215, 'T恤', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6216, '亲子装', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6217, '儿童配饰', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6218, '内衣裤', 10000368, 3, 1);
INSERT INTO `tk_cat` VALUES (6219, '卫衣', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6220, '外套/大衣', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6221, '套装', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6222, '婴儿礼盒', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6223, '家居服', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6224, '运动衣/裤/套装', 10000390, 3, 1);
INSERT INTO `tk_cat` VALUES (6225, '旗袍唐装/民族服装', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6226, '校服/校服定制', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6227, '棉服', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6228, '毛衣/针织衫', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6230, '礼服/演出服', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6231, '羽绒服', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6232, '肚兜', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6233, '衬衫', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6234, '袜子', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6235, '半身裙', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6236, '裤子', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6237, '连体衣/爬服', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6238, '马甲', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (6251, '自行车', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (6253, '凉鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6254, '学步鞋/步前鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6255, '布鞋/编织鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6256, '帆布鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6257, '拖鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6258, '棉鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6259, '皮鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6260, '运动鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6261, '雨鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6262, '靴子', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (6265, 'GPS定位器', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6266, '中控锁', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6267, '保温箱', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6268, '储物箱', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6269, '充气泵', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6272, '地锁', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6273, '安全锤', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6274, '应急救援', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6275, '拖车绳', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6276, '搭火线', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6278, '摩托车后视镜', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6279, '摩托车喇叭', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6280, '摩托车头盔', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6281, '摩托车尾箱', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6282, '摩托车手套', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6283, '摩托车护具', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6284, '摩托车灯', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6285, '摩托车蓝牙装备', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6286, '摩托车锁', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6287, '摩托车雨衣', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6288, '摩托车音响', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6289, '摩托车风镜', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6290, '摩托车骑行服', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6291, '摩托车骑行裤', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6292, '摩托车骑行鞋', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6293, '方向盘锁', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6294, '灭火器', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6296, '胎压监测', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6297, '胎压计', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6298, '自驾野营', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6299, '车载床', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6300, '轮胎锁', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6301, '防滑链', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6302, '防盗警示灯', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6303, '骑士包', 10000127, 3, 1);
INSERT INTO `tk_cat` VALUES (6305, '临时停车牌', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6306, '仪表台防晒垫', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6307, '保险杠', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6309, '内饰贴', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6310, '前挡护目镜', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6311, '后备箱垫', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6312, '后视镜/圆镜', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6313, '头枕腰靠', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6314, '仪表台密封条', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6315, '导航/中控膜', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6317, '座垫', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6318, '座套', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6319, '扶手箱', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6320, '扶手箱套', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6321, '挂件', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6322, '挡泥板', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6323, '排挡/手刹套', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6324, '摆件', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6326, '方向盘套', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6327, '无线充支架', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6328, '汽车炭包', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6329, '汽车窗帘', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6330, '汽车装饰灯', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6331, '汽车钥匙扣/包', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6332, '汽车防滑垫', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6333, '汽车除雪铲', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6335, '电子香薰', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6336, '脚垫', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6337, '汽车行李架', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6338, '踏板', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6339, '车内除味剂', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6340, '车牌架/牌照托', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6341, '车用收纳袋/盒', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6342, '车用衣服架', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6343, '车衣', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6344, '车贴', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6345, '车身装饰件', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6346, '车身装饰条', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6347, '车载挂钩', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6348, '车载支架', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6349, '车载桌板', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6350, '车载烟灰缸', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6351, '车载纸巾盒', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6352, '车门拉手装饰', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6353, '遮阳挡/雪挡', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6354, '门碗贴', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6355, '防撞胶条', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6356, '防滑贴', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6357, '防踢垫', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6358, '隔音隔热棉', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6359, '雨眉', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6360, '香水', 10000128, 3, 1);
INSERT INTO `tk_cat` VALUES (6362, 'LED车灯', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6367, '刹车卡钳', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6368, '刹车油', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6369, '刹车油管', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6370, '刹车泵', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6371, '刹车片', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6372, '刹车盘/鼓', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6373, '刹车蹄', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6374, '千斤顶', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6375, '卤素灯', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6376, '变速箱油/滤', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6377, '后视镜', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6378, '大灯总成', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6379, '工具箱/工具车', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6380, '底盘装甲/护板', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6381, '摩托车机油', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6404, '胶带/双面胶', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6405, '蓄电池', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6406, '贴膜', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6407, '起动机/发电机', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6408, '车灯辅件', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6409, '轮毂', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6410, '轮胎', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6411, '钣金/喷漆工具', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6412, '钣金/喷漆用品', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6413, '防冻液', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6414, '雨刷', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6415, '高压线', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (6418, '喷漆', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6419, '底盘装甲', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6420, '打蜡机', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6421, '汽车贴膜', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6422, '洗车刷', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6423, '洗车手套', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6424, '洗车机', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6425, '洗车毛巾', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6426, '洗车水枪/枪头', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6427, '洗车水桶', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6428, '洗车水管/接头', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6429, '洗车泥', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6430, '洗车海绵', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6431, '洗车配件', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6432, '清洁剂', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6434, '玻璃水', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6435, '补漆笔', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6436, '车用掸子', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6437, '车用砂纸', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6438, '车蜡', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6439, '轮毂喷膜', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6440, '镀晶', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6441, '镀膜', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6442, '汽车防雾剂', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6443, '隐形车衣', 10000130, 3, 1);
INSERT INTO `tk_cat` VALUES (6474, '太阳能玩具', 10000133, 3, 1);
INSERT INTO `tk_cat` VALUES (6475, '水动力玩具', 10000133, 3, 1);
INSERT INTO `tk_cat` VALUES (6476, '热胀冷缩/感温玩具', 10000133, 3, 1);
INSERT INTO `tk_cat` VALUES (6477, '电路开关玩具', 10000133, 3, 1);
INSERT INTO `tk_cat` VALUES (6478, '空气动力玩具', 10000133, 3, 1);
INSERT INTO `tk_cat` VALUES (6479, '编程玩具', 10000133, 3, 1);
INSERT INTO `tk_cat` VALUES (6480, '风动船/风动转向玩具', 10000133, 3, 1);
INSERT INTO `tk_cat` VALUES (6482, '乐器箱包', 10000134, 3, 1);
INSERT INTO `tk_cat` VALUES (6483, '其它乐器配件', 10000134, 3, 1);
INSERT INTO `tk_cat` VALUES (6484, '变调夹', 10000134, 3, 1);
INSERT INTO `tk_cat` VALUES (6485, '拾音器', 10000134, 3, 1);
INSERT INTO `tk_cat` VALUES (6486, '琴弦', 10000134, 3, 1);
INSERT INTO `tk_cat` VALUES (6487, '调音器/节拍器', 10000134, 3, 1);
INSERT INTO `tk_cat` VALUES (6488, '谱架/谱台', 10000134, 3, 1);
INSERT INTO `tk_cat` VALUES (6490, '戏水玩具', 10000135, 3, 1);
INSERT INTO `tk_cat` VALUES (6491, '户外玩具', 10000135, 3, 1);
INSERT INTO `tk_cat` VALUES (6492, '炫舞毯', 10000135, 3, 1);
INSERT INTO `tk_cat` VALUES (6493, '爬行垫/毯', 10000135, 3, 1);
INSERT INTO `tk_cat` VALUES (6495, '工艺礼品乐器', 10000136, 3, 1);
INSERT INTO `tk_cat` VALUES (6498, '减压玩具', 10000137, 3, 1);
INSERT INTO `tk_cat` VALUES (6499, '创意玩具', 10000137, 3, 1);
INSERT INTO `tk_cat` VALUES (6501, '卡通娃娃', 10000138, 3, 1);
INSERT INTO `tk_cat` VALUES (6503, '智能娃娃', 10000138, 3, 1);
INSERT INTO `tk_cat` VALUES (6505, '仿真模型', 10000139, 3, 1);
INSERT INTO `tk_cat` VALUES (6506, '拼插模型', 10000139, 3, 1);
INSERT INTO `tk_cat` VALUES (6507, '收藏爱好', 10000139, 3, 1);
INSERT INTO `tk_cat` VALUES (6509, '毛绒/布艺', 10000140, 3, 1);
INSERT INTO `tk_cat` VALUES (6510, '靠垫/抱枕', 10000140, 3, 1);
INSERT INTO `tk_cat` VALUES (6512, '其它民族吹奏乐器', 10000141, 3, 1);
INSERT INTO `tk_cat` VALUES (6513, '唢呐', 10000141, 3, 1);
INSERT INTO `tk_cat` VALUES (6514, '埙', 10000141, 3, 1);
INSERT INTO `tk_cat` VALUES (6515, '巴乌', 10000141, 3, 1);
INSERT INTO `tk_cat` VALUES (6516, '笙', 10000141, 3, 1);
INSERT INTO `tk_cat` VALUES (6517, '笛子', 10000141, 3, 1);
INSERT INTO `tk_cat` VALUES (6518, '箫', 10000141, 3, 1);
INSERT INTO `tk_cat` VALUES (6519, '葫芦丝', 10000141, 3, 1);
INSERT INTO `tk_cat` VALUES (6520, '陶笛', 10000141, 3, 1);
INSERT INTO `tk_cat` VALUES (6522, '三弦', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6523, '其它民族弹拨乐器', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6524, '古琴', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6525, '古筝', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6526, '扬琴', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6527, '月琴', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6528, '柳琴', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6529, '琵琶', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6530, '秦琴', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6531, '阮', 10000142, 3, 1);
INSERT INTO `tk_cat` VALUES (6533, '其它民族打击乐器', 10000143, 3, 1);
INSERT INTO `tk_cat` VALUES (6534, '堂鼓', 10000143, 3, 1);
INSERT INTO `tk_cat` VALUES (6535, '快板', 10000143, 3, 1);
INSERT INTO `tk_cat` VALUES (6536, '排鼓', 10000143, 3, 1);
INSERT INTO `tk_cat` VALUES (6537, '腰鼓/秧歌鼓', 10000143, 3, 1);
INSERT INTO `tk_cat` VALUES (6538, '锣', 10000143, 3, 1);
INSERT INTO `tk_cat` VALUES (6539, '镲', 10000143, 3, 1);
INSERT INTO `tk_cat` VALUES (6541, '中胡', 10000144, 3, 1);
INSERT INTO `tk_cat` VALUES (6542, '二胡', 10000144, 3, 1);
INSERT INTO `tk_cat` VALUES (6543, '京胡/京二胡', 10000144, 3, 1);
INSERT INTO `tk_cat` VALUES (6544, '其它民族拉弦乐器', 10000144, 3, 1);
INSERT INTO `tk_cat` VALUES (6545, '板胡', 10000144, 3, 1);
INSERT INTO `tk_cat` VALUES (6546, '马头琴', 10000144, 3, 1);
INSERT INTO `tk_cat` VALUES (6547, '高胡', 10000144, 3, 1);
INSERT INTO `tk_cat` VALUES (6549, '手办/人偶/BJD/兵人', 10000145, 3, 1);
INSERT INTO `tk_cat` VALUES (6550, '卡通周边', 10000145, 3, 1);
INSERT INTO `tk_cat` VALUES (6551, '悠悠球/溜溜球', 10000145, 3, 1);
INSERT INTO `tk_cat` VALUES (6552, '扭蛋', 10000145, 3, 1);
INSERT INTO `tk_cat` VALUES (6554, '电影周边', 10000145, 3, 1);
INSERT INTO `tk_cat` VALUES (6555, '网游周边', 10000145, 3, 1);
INSERT INTO `tk_cat` VALUES (6556, '陀螺', 10000145, 3, 1);
INSERT INTO `tk_cat` VALUES (6557, '高达/变形模型', 10000145, 3, 1);
INSERT INTO `tk_cat` VALUES (6559, '健身架', 10000146, 3, 1);
INSERT INTO `tk_cat` VALUES (6560, '拖拉玩具', 10000146, 3, 1);
INSERT INTO `tk_cat` VALUES (6561, '摇铃/床铃', 10000146, 3, 1);
INSERT INTO `tk_cat` VALUES (6562, '早教启智', 10000146, 3, 1);
INSERT INTO `tk_cat` VALUES (6563, '魔方', 10000146, 3, 1);
INSERT INTO `tk_cat` VALUES (6565, '拼图', 10000147, 3, 1);
INSERT INTO `tk_cat` VALUES (6566, '磁力片/棒', 10000147, 3, 1);
INSERT INTO `tk_cat` VALUES (6567, '积木', 10000147, 3, 1);
INSERT INTO `tk_cat` VALUES (6568, '立体拼插', 10000147, 3, 1);
INSERT INTO `tk_cat` VALUES (6570, '情景玩具', 10000148, 3, 1);
INSERT INTO `tk_cat` VALUES (6571, '手工彩泥', 10000148, 3, 1);
INSERT INTO `tk_cat` VALUES (6572, '绘画工具', 10000148, 3, 1);
INSERT INTO `tk_cat` VALUES (6574, '中提琴', 10000149, 3, 1);
INSERT INTO `tk_cat` VALUES (6575, '低音/倍大提琴', 10000149, 3, 1);
INSERT INTO `tk_cat` VALUES (6576, '其它西洋弦乐器', 10000149, 3, 1);
INSERT INTO `tk_cat` VALUES (6577, '吉他', 10000149, 3, 1);
INSERT INTO `tk_cat` VALUES (6578, '大提琴', 10000149, 3, 1);
INSERT INTO `tk_cat` VALUES (6579, '小提琴', 10000149, 3, 1);
INSERT INTO `tk_cat` VALUES (6580, '尤克里里', 10000149, 3, 1);
INSERT INTO `tk_cat` VALUES (6581, '贝斯', 10000149, 3, 1);
INSERT INTO `tk_cat` VALUES (6583, '其它西洋打击乐器', 10000150, 3, 1);
INSERT INTO `tk_cat` VALUES (6584, '军鼓', 10000150, 3, 1);
INSERT INTO `tk_cat` VALUES (6585, '卡洪鼓/箱鼓', 10000150, 3, 1);
INSERT INTO `tk_cat` VALUES (6586, '架子鼓/爵士鼓', 10000150, 3, 1);
INSERT INTO `tk_cat` VALUES (6587, '电子鼓', 10000150, 3, 1);
INSERT INTO `tk_cat` VALUES (6588, '静音鼓', 10000150, 3, 1);
INSERT INTO `tk_cat` VALUES (6589, '非洲鼓', 10000150, 3, 1);
INSERT INTO `tk_cat` VALUES (6591, '其它西洋管乐器', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6592, '单簧管/双簧管', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6593, '口琴', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6594, '圆号', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6595, '大号', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6596, '小号', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6597, '巴松/大管', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6598, '电吹管', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6599, '短笛', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6600, '竖笛', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6601, '萨克斯', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6602, '长号', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6603, '长笛', 10000151, 3, 1);
INSERT INTO `tk_cat` VALUES (6612, '机器人', 10000153, 3, 1);
INSERT INTO `tk_cat` VALUES (6613, '轨道/助力', 10000153, 3, 1);
INSERT INTO `tk_cat` VALUES (6614, '遥控船', 10000153, 3, 1);
INSERT INTO `tk_cat` VALUES (6615, '遥控车', 10000153, 3, 1);
INSERT INTO `tk_cat` VALUES (6616, '遥控飞机', 10000153, 3, 1);
INSERT INTO `tk_cat` VALUES (6618, '其它键盘乐器', 10000154, 3, 1);
INSERT INTO `tk_cat` VALUES (6619, '口风琴', 10000154, 3, 1);
INSERT INTO `tk_cat` VALUES (6620, '手卷钢琴', 10000154, 3, 1);
INSERT INTO `tk_cat` VALUES (6621, '手风琴', 10000154, 3, 1);
INSERT INTO `tk_cat` VALUES (6622, '电子琴', 10000154, 3, 1);
INSERT INTO `tk_cat` VALUES (6623, '电钢琴', 10000154, 3, 1);
INSERT INTO `tk_cat` VALUES (6624, '钢琴', 10000154, 3, 1);
INSERT INTO `tk_cat` VALUES (6627, '低温奶', 10000156, 3, 1);
INSERT INTO `tk_cat` VALUES (6628, '冰淇淋', 10000156, 3, 1);
INSERT INTO `tk_cat` VALUES (6629, '冷藏饮料', 10000156, 3, 1);
INSERT INTO `tk_cat` VALUES (6630, '奶酪黄油', 10000156, 3, 1);
INSERT INTO `tk_cat` VALUES (6632, '奇异果/猕猴桃', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6633, '山竹', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6634, '其他水果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6635, '木瓜', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6636, '枣', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6637, '柚子', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6638, '柠檬', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6640, '柑/桔/橘', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6641, '梨', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6642, '椰青', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6644, '橙子', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6646, '火龙果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6647, '牛油果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6648, '其他瓜', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6649, '百香果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6650, '石榴', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6651, '芒果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6652, '苹果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6653, '草莓', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6654, '荔枝', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6655, '菠萝/凤梨', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6656, '葡萄/提子', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6657, '蓝莓', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6659, '香蕉', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6660, '龙眼', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (6664, '海产礼盒', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (6666, '其他海鲜制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (6672, '其他软足类', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (6675, '其它肉类', 10000159, 3, 1);
INSERT INTO `tk_cat` VALUES (6676, '内脏类', 10000159, 3, 1);
INSERT INTO `tk_cat` VALUES (6677, '牛肉', 10000159, 3, 1);
INSERT INTO `tk_cat` VALUES (6678, '猪肉', 10000159, 3, 1);
INSERT INTO `tk_cat` VALUES (6679, '羊肉', 10000159, 3, 1);
INSERT INTO `tk_cat` VALUES (6681, '其他禽类', 10000160, 3, 1);
INSERT INTO `tk_cat` VALUES (6682, '蛋类', 10000160, 3, 1);
INSERT INTO `tk_cat` VALUES (6683, '鸡肉', 10000160, 3, 1);
INSERT INTO `tk_cat` VALUES (6684, '鸭肉', 10000160, 3, 1);
INSERT INTO `tk_cat` VALUES (6687, '叶菜类', 10000161, 3, 1);
INSERT INTO `tk_cat` VALUES (6699, '其他西点', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (6700, '披萨', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (6701, '新鲜蛋糕', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (6702, '水饺/馄饨', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (6703, '汤圆/元宵', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (6704, '蛋挞', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (6705, '面点', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (6709, '墨盒', 10000165, 3, 1);
INSERT INTO `tk_cat` VALUES (6710, '墨粉', 10000165, 3, 1);
INSERT INTO `tk_cat` VALUES (6711, '硒鼓', 10000165, 3, 1);
INSERT INTO `tk_cat` VALUES (6712, '纸类', 10000165, 3, 1);
INSERT INTO `tk_cat` VALUES (6713, '色带', 10000165, 3, 1);
INSERT INTO `tk_cat` VALUES (6715, '会议音频视频', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6716, '传真设备', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6717, '保险柜/箱', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6718, '塑封机', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6719, '墨粉', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6720, '复合机', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6721, '安防监控', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6722, '打印机', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6723, '扫描仪', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6724, '投影机', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6725, '投影配件', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6726, '收银机', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6727, '条码扫描', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6728, '白板', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6729, '碎纸机', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6730, '考勤机', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6731, '装订/封装机', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6732, '验钞/点钞机', 10000166, 3, 1);
INSERT INTO `tk_cat` VALUES (6734, 'UPS电源', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6735, 'U盘', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6736, '手写板', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6737, '插座', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6738, '摄像头', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6739, '游戏设备', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6741, '电脑工具', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6742, '电脑清洁', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6743, '硬盘盒', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6744, '移动硬盘', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6745, '线缆', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6746, '网络仪表仪器', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6747, '键盘', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6748, '鼠标', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6749, '鼠标垫', 10000167, 3, 1);
INSERT INTO `tk_cat` VALUES (6751, '办公文具', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (6752, '学生文具', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (6753, '文件管理', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (6755, '本册/便签', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (6756, '激光笔', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (6757, '画具画材', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (6758, '笔类', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (6759, '计算器', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (6760, '财会用品', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (6762, '手柄/方向盘', 10000169, 3, 1);
INSERT INTO `tk_cat` VALUES (6763, '游戏周边', 10000169, 3, 1);
INSERT INTO `tk_cat` VALUES (6764, '游戏机', 10000169, 3, 1);
INSERT INTO `tk_cat` VALUES (6765, '游戏耳机', 10000169, 3, 1);
INSERT INTO `tk_cat` VALUES (6768, '一体机', 10000170, 3, 1);
INSERT INTO `tk_cat` VALUES (6769, '台式机', 10000170, 3, 1);
INSERT INTO `tk_cat` VALUES (6770, '平板电脑', 10000170, 3, 1);
INSERT INTO `tk_cat` VALUES (6771, '平板电脑配件', 10000170, 3, 1);
INSERT INTO `tk_cat` VALUES (6772, '服务器/工作站', 10000170, 3, 1);
INSERT INTO `tk_cat` VALUES (6773, '游戏本', 10000170, 3, 1);
INSERT INTO `tk_cat` VALUES (6774, '笔记本', 10000170, 3, 1);
INSERT INTO `tk_cat` VALUES (6775, '笔记本配件', 10000170, 3, 1);
INSERT INTO `tk_cat` VALUES (6777, 'CPU', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6778, 'SSD固态硬盘', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6779, '主板', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6780, '主板CPU套装', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6781, '内存', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6782, '刻录机/光驱', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6783, '声卡/扩展卡', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6784, '散热器', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6785, '显卡', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6786, '显示器', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6787, '显示器支架', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6788, '机箱', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6789, '电源', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6790, '硬盘', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6791, '组装电脑', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6792, '装机配件', 10000171, 3, 1);
INSERT INTO `tk_cat` VALUES (6794, '5G/4G上网', 10000172, 3, 1);
INSERT INTO `tk_cat` VALUES (6795, '交换机', 10000172, 3, 1);
INSERT INTO `tk_cat` VALUES (6797, '网卡', 10000172, 3, 1);
INSERT INTO `tk_cat` VALUES (6799, '网络盒子', 10000172, 3, 1);
INSERT INTO `tk_cat` VALUES (6800, '网络配件', 10000172, 3, 1);
INSERT INTO `tk_cat` VALUES (6801, '路由器', 10000172, 3, 1);
INSERT INTO `tk_cat` VALUES (6833, '书包', 10000174, 3, 1);
INSERT INTO `tk_cat` VALUES (6834, '休闲运动包', 10000174, 3, 1);
INSERT INTO `tk_cat` VALUES (6835, '拉杆包', 10000174, 3, 1);
INSERT INTO `tk_cat` VALUES (6836, '拉杆箱', 10000174, 3, 1);
INSERT INTO `tk_cat` VALUES (6837, '旅行包', 10000174, 3, 1);
INSERT INTO `tk_cat` VALUES (6838, '旅行配件', 10000174, 3, 1);
INSERT INTO `tk_cat` VALUES (6840, '电脑包', 10000174, 3, 1);
INSERT INTO `tk_cat` VALUES (6841, '登山包', 10000174, 3, 1);
INSERT INTO `tk_cat` VALUES (6842, '腰包/胸包', 10000174, 3, 1);
INSERT INTO `tk_cat` VALUES (6844, '化妆包', 10000175, 3, 1);
INSERT INTO `tk_cat` VALUES (6845, '单肩包', 10000175, 3, 1);
INSERT INTO `tk_cat` VALUES (6846, '卡包/零钱包', 10000175, 3, 1);
INSERT INTO `tk_cat` VALUES (6847, '双肩包', 10000175, 3, 1);
INSERT INTO `tk_cat` VALUES (6848, '手拿包', 10000175, 3, 1);
INSERT INTO `tk_cat` VALUES (6849, '手提包', 10000175, 3, 1);
INSERT INTO `tk_cat` VALUES (6850, '斜挎包', 10000175, 3, 1);
INSERT INTO `tk_cat` VALUES (6852, '钥匙包', 10000175, 3, 1);
INSERT INTO `tk_cat` VALUES (6853, '钱包', 10000175, 3, 1);
INSERT INTO `tk_cat` VALUES (6855, '女士皮带', 10000176, 3, 1);
INSERT INTO `tk_cat` VALUES (6856, '男士皮带', 10000176, 3, 1);
INSERT INTO `tk_cat` VALUES (6857, '皮带礼盒', 10000176, 3, 1);
INSERT INTO `tk_cat` VALUES (6858, '箱包配件', 10000176, 3, 1);
INSERT INTO `tk_cat` VALUES (6860, '单肩/斜挎包', 10000177, 3, 1);
INSERT INTO `tk_cat` VALUES (6861, '卡包名片夹', 10000177, 3, 1);
INSERT INTO `tk_cat` VALUES (6862, '双肩包', 10000177, 3, 1);
INSERT INTO `tk_cat` VALUES (6863, '商务公文包', 10000177, 3, 1);
INSERT INTO `tk_cat` VALUES (6864, '手机包', 10000177, 3, 1);
INSERT INTO `tk_cat` VALUES (6866, '男士手包', 10000177, 3, 1);
INSERT INTO `tk_cat` VALUES (6867, '男士钱包', 10000177, 3, 1);
INSERT INTO `tk_cat` VALUES (6868, '证件包', 10000177, 3, 1);
INSERT INTO `tk_cat` VALUES (6869, '钥匙包', 10000177, 3, 1);
INSERT INTO `tk_cat` VALUES (6872, '其它男士面部护肤', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6873, '剃须啫喱/剃须膏/剃须泡', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6874, '套装/礼盒', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6875, '男士T区护理', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6876, '男士乳液/面霜/乳霜', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6877, '男士卸妆', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6878, '男士洁面', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6879, '男士唇部护理', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6880, '男士爽肤水/化妆水', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6881, '男士眼霜/眼部精华', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6882, '男士防晒', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6883, '男士面膜', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6884, '男士面部精华', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (6886, '修眉刀', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (6887, '假睫毛', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (6889, '化妆刷', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (6890, '化妆棉/卸妆棉', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (6891, '双眼皮贴/胶', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (6892, '睫毛夹', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (6893, '粉扑/洗脸扑/洗脸刷', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (6894, '美妆工具套装', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (6895, '美甲工具', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (6897, 'T区护理', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6898, '乳液/面霜', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6899, '其它面部护肤', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6900, '卸妆', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6901, '唇膜/唇部精华/唇部磨砂', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6902, '套装/礼盒', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6903, '洁面', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6904, '润唇膏', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6905, '爽肤水/化妆水', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6906, '眼膜', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6907, '眼霜/眼部精华', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6908, '防晒', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6909, '面膜', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6910, '面部精华/精油', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (6912, '其它彩妆', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6913, '口红', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6914, '唇彩唇蜜/唇釉', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6915, '唇笔/唇线笔', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6916, '彩妆套装', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6917, '气垫BB/BB霜', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6918, '气垫CC/CC霜', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6919, '男士彩妆', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6920, '眉笔/眉粉/染眉膏', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6921, '眼影', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6922, '眼线笔/眼线膏', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6923, '睫毛膏/增长液', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6924, '粉底液/粉底膏/粉底霜', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6925, '粉饼', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6926, '美甲产品', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6927, '腮红/胭脂', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6928, '蜜粉/散粉', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6929, '遮瑕膏/遮瑕笔', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6930, '隔离霜/妆前乳', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6931, '香水/香膏', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (6934, '乒乓底板', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6935, '乒乓球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6936, '乒乓球发球机', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6937, '乒乓球拍', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6938, '乒乓球拍套/包', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6939, '乒乓球拍胶皮', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6940, '乒乓球挡板', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6941, '乒乓球捡球器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6942, '乒乓球服', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6943, '乒乓球桌', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6944, '乒乓球网/架', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6945, '乒乓球胶水', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6946, '乒乓球袜', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6947, '乒乓球集球网', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6948, '乒乓球鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (6960, '台尼/台球布', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6961, '台球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6962, '台球三角架', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6963, '台球修杆器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6964, '台球巧克粉', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6965, '台球手套', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6966, '台球杆', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6967, '台球杆保养工具', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6968, '台球杆盒/杆筒', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6969, '台球架杆器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6970, '台球桌', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6971, '台球皮头/杆头', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6972, '壁球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6973, '壁球拍', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6974, '守门员手套', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6975, '巧粉夹/巧粉袋', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6976, '排球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6977, '排球网/球柱', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6978, '排球鞋服', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6979, '接力棒', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6980, '推杆练习器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6981, '更多高尔夫服装', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6982, '更多高尔夫球杆', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6983, '棒球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6984, '棒球手套', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6985, '棒球棒', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6986, '棒球鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (6987, '橄榄球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6988, '橄榄球头盔', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6989, '橄榄球手套', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6990, '橄榄球鞋服', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6992, '球杆加长器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6993, '球迷用品', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6994, '穿线机', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6995, '篮球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6996, '篮球包', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6997, '篮球架', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6998, '篮球框', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (6999, '篮球袜', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7000, '网球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7001, '网球包', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7002, '网球手胶', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7003, '网球拍', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7004, '网球捡球器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7005, '网球服', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7006, '网球线', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7007, '网球网', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7008, '网球网架', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7009, '网球训练器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7010, '网球避震器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7011, '网球鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7012, '羽毛球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7013, '羽毛球包', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7014, '羽毛球手胶', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7015, '羽毛球拍', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7016, '羽毛球服', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7017, '羽毛球线', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7018, '羽毛球网', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7019, '羽毛球网架', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7020, '羽毛球蒸球机', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7021, '羽毛球袜', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7022, '羽毛球鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7023, '裁判用品', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7024, '起跑器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7025, '足球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7026, '足球战术板', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7027, '足球护腿板', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7028, '足球球门', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7029, '足球网', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7030, '足球袜', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7031, '足球训练背心', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7032, '跨栏架', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7033, '跳箱/跳马', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7034, '跳高杆', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7035, '跳高架', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7036, '运动地胶', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7037, '铁饼/标枪', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7038, '铅球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7039, '防滑粉', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7040, '高尔夫7号铁', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7041, '高尔夫T恤', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7042, '高尔夫一号木', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7043, '高尔夫卫衣/套头衫', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7044, '高尔夫夹克/风衣', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7045, '高尔夫手套', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7046, '高尔夫挖起杆', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7047, '高尔夫棉服', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7048, '高尔夫模拟器', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7049, '高尔夫毛/线衫', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7050, '高尔夫球', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7051, '高尔夫球包', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7052, '高尔夫球包车', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7053, '高尔夫球帽', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7054, '高尔夫球杆套杆', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7055, '高尔夫球钉', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7056, '高尔夫羽绒服', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7057, '高尔夫运动裤', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7058, '高尔夫铁木杆', 10000184, 3, 1);
INSERT INTO `tk_cat` VALUES (7059, '高尔夫鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7061, '仰卧板/收腹机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7062, '倒立机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7063, '健腹轮', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7064, '健身房器械定制', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7065, '健身路径', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7066, '健身车', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7068, '划船机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7069, '动感单车', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7070, '单双杠/引体向上', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7071, '哑铃', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7072, '壶铃', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7073, '律动机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7074, '拉力器/臂力器', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7075, '杠铃', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7076, '椭圆机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7079, '综合训练器', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7080, '跑步机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7081, '跳绳', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7082, '踏步机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7083, '骑马机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (7085, '其它冰上运动', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7086, '冰刀套', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7087, '冰球刀片', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7088, '冰球头盔', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7089, '冰球手套', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7090, '冰球杆', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7091, '冰球杆胶布', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7092, '冰球球饼', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7093, '冰球训练服', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7094, '冰球鞋', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7095, '花样滑冰服', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7096, '花样滑冰袜', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7097, '花样滑冰鞋', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7098, '速滑冰刀鞋', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7099, '速滑刀片', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7100, '速滑头盔', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7101, '速滑手套', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7102, '速滑服', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7103, '速滑磨刀架', 10000186, 3, 1);
INSERT INTO `tk_cat` VALUES (7105, '浮漂', 10000187, 3, 1);
INSERT INTO `tk_cat` VALUES (7106, '渔具包', 10000187, 3, 1);
INSERT INTO `tk_cat` VALUES (7110, '钓箱钓椅', 10000187, 3, 1);
INSERT INTO `tk_cat` VALUES (7112, '钓鱼灯', 10000187, 3, 1);
INSERT INTO `tk_cat` VALUES (7113, '钓鱼配件', 10000187, 3, 1);
INSERT INTO `tk_cat` VALUES (7114, '鱼线', 10000187, 3, 1);
INSERT INTO `tk_cat` VALUES (7115, '鱼线轮', 10000187, 3, 1);
INSERT INTO `tk_cat` VALUES (7116, '鱼饵', 10000187, 3, 1);
INSERT INTO `tk_cat` VALUES (7118, '军迷用品', 10000188, 3, 1);
INSERT INTO `tk_cat` VALUES (7119, '军迷装备', 10000188, 3, 1);
INSERT INTO `tk_cat` VALUES (7125, '户外配饰', 10000188, 3, 1);
INSERT INTO `tk_cat` VALUES (7127, '旅行日用品', 10000188, 3, 1);
INSERT INTO `tk_cat` VALUES (7128, '户外眼镜', 10000188, 3, 1);
INSERT INTO `tk_cat` VALUES (7129, '极限户外', 10000188, 3, 1);
INSERT INTO `tk_cat` VALUES (7134, '背包', 10000188, 3, 1);
INSERT INTO `tk_cat` VALUES (7136, '飞机游艇', 10000188, 3, 1);
INSERT INTO `tk_cat` VALUES (7138, 'T恤', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7140, '休闲鞋', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7141, '军迷服饰', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7142, '军迷鞋靴', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7144, '功能内衣', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7145, '工装鞋', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7146, '徒步鞋', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7148, '户外风衣', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7150, '沙滩/凉拖', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7151, '溯溪鞋', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7153, '登山鞋', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7155, '越野跑鞋', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7158, '雪地靴', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (7160, 'UNO牌', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (7161, '中国象棋', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (7163, '军棋/陆战棋', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (7164, '围棋', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (7165, '国际象棋', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (7173, '狼人杀', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (7180, '剑道', 10000191, 3, 1);
INSERT INTO `tk_cat` VALUES (7181, '太极', 10000191, 3, 1);
INSERT INTO `tk_cat` VALUES (7182, '拳击', 10000191, 3, 1);
INSERT INTO `tk_cat` VALUES (7183, '摔跤', 10000191, 3, 1);
INSERT INTO `tk_cat` VALUES (7184, '柔道', 10000191, 3, 1);
INSERT INTO `tk_cat` VALUES (7185, '空手道', 10000191, 3, 1);
INSERT INTO `tk_cat` VALUES (7186, '跆拳道', 10000191, 3, 1);
INSERT INTO `tk_cat` VALUES (7188, '女士泳衣', 10000192, 3, 1);
INSERT INTO `tk_cat` VALUES (7189, '比基尼', 10000192, 3, 1);
INSERT INTO `tk_cat` VALUES (7190, '泳帽', 10000192, 3, 1);
INSERT INTO `tk_cat` VALUES (7191, '泳镜', 10000192, 3, 1);
INSERT INTO `tk_cat` VALUES (7192, '游泳包防水包', 10000192, 3, 1);
INSERT INTO `tk_cat` VALUES (7193, '游泳圈', 10000192, 3, 1);
INSERT INTO `tk_cat` VALUES (7194, '游泳配件', 10000192, 3, 1);
INSERT INTO `tk_cat` VALUES (7196, '男士泳衣', 10000192, 3, 1);
INSERT INTO `tk_cat` VALUES (7198, '单板滑雪板', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7199, '双板滑雪板', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7200, '更多滑雪用具', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7201, '滑雪头盔', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7202, '滑雪服', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7203, '滑雪杖', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7204, '滑雪衣裤套装', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7205, '滑雪裤', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7206, '滑雪车', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7207, '滑雪鞋', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7208, '雪板固定器', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7209, '面罩/头套', 10000193, 3, 1);
INSERT INTO `tk_cat` VALUES (7211, '体操垫', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7212, '体操跳板', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7213, '健美操鞋', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7218, '广场舞服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7219, '广场舞鞋', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7220, '拉丁舞服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7221, '拉丁舞鞋', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7222, '普拉提器械', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7223, '现代舞服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7224, '瑜伽包', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7225, '瑜伽半圆球', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7226, '瑜伽发带', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7227, '瑜伽吊床', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7228, '瑜伽圈', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7229, '瑜伽垫', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7230, '瑜伽拉力带', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7231, '瑜伽服上衣', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7232, '瑜伽服内衣', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7233, '瑜伽服外套', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7234, '瑜伽服套装', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7235, '瑜伽服裤', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7236, '瑜伽柱', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7237, '瑜伽球', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7238, '瑜伽短裤', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7239, '瑜伽砖', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7240, '瑜伽绳', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7241, '瑜伽袜', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7242, '瑜伽铺巾', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7243, '瑜伽鞋', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7244, '肚皮舞服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7245, '肚皮舞鞋', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7246, '舞蹈扇', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7247, '舞蹈把杆', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7248, '芭蕾舞服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7249, '芭蕾舞鞋', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (7251, '其它轮滑滑板', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7252, '单排轮滑鞋', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7253, '双排轮滑鞋', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7254, '双翘板', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7255, '小鱼板', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7256, '弹跳鞋', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7257, '漂移板', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7258, '轮滑包', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7259, '轮滑护具', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7260, '长板', 10000195, 3, 1);
INSERT INTO `tk_cat` VALUES (7262, '健身手套', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7264, '助力带', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7265, '护指', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7266, '护腕', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7267, '护臂', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7268, '护齿', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7269, '紧身服/压缩衣', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7270, '运动发带', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7271, '运动护肘', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7272, '运动护肩', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7273, '运动护腰', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7274, '运动护腿', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7275, '运动护膝', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7276, '运动护臀', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7277, '运动护踝', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7278, '运动肌肉贴', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7279, '髌骨带', 10000196, 3, 1);
INSERT INTO `tk_cat` VALUES (7281, 'T恤', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (7283, '卫衣/套头衫', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (7284, '夹克/风衣', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (7285, '套装', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (7286, '棉服', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (7287, '毛衫/线衫', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (7288, '羽绒服', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (7290, '运动背心', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (7291, '运动裤', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (7295, '休闲鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7296, '帆布鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7297, '拖鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7298, '板鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7300, '篮球鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7301, '训练鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7302, '足球鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7303, '跑步鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7305, '运动鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (7309, '响鞭', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7310, '拔河绳', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7311, '毽子', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7312, '空竹', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7313, '舞狮', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7314, '门球', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7315, '马匹装备', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7316, '马房装备', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7317, '马术头盔', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7318, '马术护腿', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7319, '马术服装', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7320, '马术靴', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7321, '马术鞭', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7322, '马鞍', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7323, '龙舟服', 10000199, 3, 1);
INSERT INTO `tk_cat` VALUES (7325, '公路车', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7326, '城市自行车', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7327, '山地车', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7328, '平衡车', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7329, '折叠车', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7331, '电动滑板车', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7332, '电动车', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7333, '电动车装备', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7334, '电动车零配件', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7335, '穿戴装备', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7337, '自行车配件', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7338, '骑行服', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (7345, '伏特加', 10000204, 3, 1);
INSERT INTO `tk_cat` VALUES (7347, '力娇酒', 10000204, 3, 1);
INSERT INTO `tk_cat` VALUES (7349, '朗姆酒', 10000204, 3, 1);
INSERT INTO `tk_cat` VALUES (7351, '清酒/烧酒', 10000204, 3, 1);
INSERT INTO `tk_cat` VALUES (7353, '金酒', 10000204, 3, 1);
INSERT INTO `tk_cat` VALUES (7354, '鸡尾酒/预调酒', 10000204, 3, 1);
INSERT INTO `tk_cat` VALUES (7355, '龙舌兰', 10000204, 3, 1);
INSERT INTO `tk_cat` VALUES (7357, '白酒', 10000205, 3, 1);
INSERT INTO `tk_cat` VALUES (7359, '国产葡萄酒', 10000206, 3, 1);
INSERT INTO `tk_cat` VALUES (7361, '露酒/养生酒', 10000207, 3, 1);
INSERT INTO `tk_cat` VALUES (7362, '黄酒', 10000207, 3, 1);
INSERT INTO `tk_cat` VALUES (7365, '座钟', 10000209, 3, 1);
INSERT INTO `tk_cat` VALUES (7366, '挂钟', 10000209, 3, 1);
INSERT INTO `tk_cat` VALUES (7367, '闹钟', 10000209, 3, 1);
INSERT INTO `tk_cat` VALUES (7369, '儿童手表', 10000210, 3, 1);
INSERT INTO `tk_cat` VALUES (7370, '国表', 10000210, 3, 1);
INSERT INTO `tk_cat` VALUES (7371, '德表', 10000210, 3, 1);
INSERT INTO `tk_cat` VALUES (7372, '日韩表', 10000210, 3, 1);
INSERT INTO `tk_cat` VALUES (7374, '欧美表', 10000210, 3, 1);
INSERT INTO `tk_cat` VALUES (7375, '瑞表', 10000210, 3, 1);
INSERT INTO `tk_cat` VALUES (7377, '钟表配件', 10000211, 3, 1);
INSERT INTO `tk_cat` VALUES (7380, '休闲鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7381, '内增高', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7382, '凉鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7383, '单鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7384, '坡跟鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7385, '女靴', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7386, '妈妈鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7387, '布鞋/绣花鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7388, '帆布鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7389, '拖鞋/人字拖', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7390, '松糕鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7392, '特色鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7394, '踝靴', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7395, '防水台', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7396, '雨鞋/雨靴', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7397, '雪地靴', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7398, '鞋配件', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7399, '马丁靴', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7400, '高跟鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7401, '鱼嘴鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (7403, '休闲鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7404, '传统布鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7405, '凉鞋/沙滩鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7406, '功能鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7407, '商务休闲鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7408, '增高鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7409, '定制鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7410, '工装鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7411, '帆布鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7412, '拖鞋/人字拖', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7413, '正装鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7415, '男靴', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7417, '雨鞋/雨靴', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7418, '鞋配件', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (7421, '休闲零食', 10000216, 3, 1);
INSERT INTO `tk_cat` VALUES (7422, '坚果炒货', 10000216, 3, 1);
INSERT INTO `tk_cat` VALUES (7423, '熟食腊味', 10000216, 3, 1);
INSERT INTO `tk_cat` VALUES (7424, '糖果/巧克力', 10000216, 3, 1);
INSERT INTO `tk_cat` VALUES (7425, '肉干肉脯', 10000216, 3, 1);
INSERT INTO `tk_cat` VALUES (7426, '蜜饯', 10000216, 3, 1);
INSERT INTO `tk_cat` VALUES (7427, '饼干蛋糕', 10000216, 3, 1);
INSERT INTO `tk_cat` VALUES (7440, '南北干货', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (7441, '方便食品', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (7442, '有机食品', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (7443, '杂粮', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (7444, '烘焙原料', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (7445, '米', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (7446, '调味品', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (7447, '面', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (7448, '食用油', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (7450, '乌龙茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7451, '其它茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7452, '养生茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7453, '普洱', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7454, '白茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7455, '红茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7456, '绿茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7457, '花果茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7458, '花草茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7459, '茉莉花茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7460, '铁观音', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7461, '黑茶', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7462, '龙井', 10000219, 3, 1);
INSERT INTO `tk_cat` VALUES (7464, '休闲零食', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7465, '冲调品', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7466, '咖啡豆/咖啡粉', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7467, '方便食品', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7468, '水', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7469, '油', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7470, '牛奶乳品', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7471, '米面调味', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7472, '糖果/巧克力', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7473, '饮料', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7474, '饼干蛋糕', 10000220, 3, 1);
INSERT INTO `tk_cat` VALUES (7480, '谷物麦片', 10000222, 3, 1);
INSERT INTO `tk_cat` VALUES (7481, '咖啡豆/粉/液', 10000222, 3, 1);
INSERT INTO `tk_cat` VALUES (7482, '全家营养奶粉', 10000222, 3, 1);
INSERT INTO `tk_cat` VALUES (7483, '奶类/乳制品', 10000222, 3, 1);
INSERT INTO `tk_cat` VALUES (7484, '蜂蜜/柚子茶', 10000222, 3, 1);
INSERT INTO `tk_cat` VALUES (7485, '饮料', 10000222, 3, 1);
INSERT INTO `tk_cat` VALUES (7486, '饮用水', 10000222, 3, 1);
INSERT INTO `tk_cat` VALUES (112880, '世界军事', 10000263, 3, 1);
INSERT INTO `tk_cat` VALUES (112881, '经典传记', 10000251, 3, 1);
INSERT INTO `tk_cat` VALUES (112882, '一般工业技术', 10000238, 3, 1);
INSERT INTO `tk_cat` VALUES (112883, '休闲运动', 10000266, 3, 1);
INSERT INTO `tk_cat` VALUES (112884, '连环画', 10000234, 3, 1);
INSERT INTO `tk_cat` VALUES (112885, '教学/展示用品', 10000259, 3, 1);
INSERT INTO `tk_cat` VALUES (112886, '摄影技法', 10000233, 3, 1);
INSERT INTO `tk_cat` VALUES (112888, '文学理论', 10000245, 3, 1);
INSERT INTO `tk_cat` VALUES (112890, '国际金融', 10000262, 3, 1);
INSERT INTO `tk_cat` VALUES (117812, '历史著作', 10000247, 3, 1);
INSERT INTO `tk_cat` VALUES (117813, '科普图鉴', 10000240, 3, 1);
INSERT INTO `tk_cat` VALUES (117814, '学习方法/报考指南', 10000228, 3, 1);
INSERT INTO `tk_cat` VALUES (117815, '休闲游戏', 10000231, 3, 1);
INSERT INTO `tk_cat` VALUES (117816, '家常菜谱', 10000229, 3, 1);
INSERT INTO `tk_cat` VALUES (117817, '经典著作', 10000264, 3, 1);
INSERT INTO `tk_cat` VALUES (117818, '经典著作', 10000236, 3, 1);
INSERT INTO `tk_cat` VALUES (122151, '其他资格/职称考试', 10000254, 3, 1);
INSERT INTO `tk_cat` VALUES (122152, '中国近现代小说', 10000244, 3, 1);
INSERT INTO `tk_cat` VALUES (122153, '英汉/汉英词典', 10000267, 3, 1);
INSERT INTO `tk_cat` VALUES (128195, '外语教学/学术著作', 10000239, 3, 1);
INSERT INTO `tk_cat` VALUES (128196, '生活休闲', 10000268, 3, 1);
INSERT INTO `tk_cat` VALUES (128197, '文化研究', 10000237, 3, 1);
INSERT INTO `tk_cat` VALUES (128198, '音乐赏析', 10000255, 3, 1);
INSERT INTO `tk_cat` VALUES (128199, 'IT人文/互联网', 10000250, 3, 1);
INSERT INTO `tk_cat` VALUES (128200, '职业培训教材', 10000242, 3, 1);
INSERT INTO `tk_cat` VALUES (128201, '技法/教程', 10000260, 3, 1);
INSERT INTO `tk_cat` VALUES (128202, '医学理论与研究', 10000227, 3, 1);
INSERT INTO `tk_cat` VALUES (128203, '基础与理论', 10000241, 3, 1);
INSERT INTO `tk_cat` VALUES (128204, '城市规划、城市设计', 10000265, 3, 1);
INSERT INTO `tk_cat` VALUES (128205, '哲学经典著作', 10000248, 3, 1);
INSERT INTO `tk_cat` VALUES (128206, '其他绘画', 10000232, 3, 1);
INSERT INTO `tk_cat` VALUES (135839, '育儿百科', 10000224, 3, 1);
INSERT INTO `tk_cat` VALUES (135840, '时尚生活', 10000230, 3, 1);
INSERT INTO `tk_cat` VALUES (135841, '经典著作', 10000223, 3, 1);
INSERT INTO `tk_cat` VALUES (135842, '艺术理论与评论', 10000261, 3, 1);
INSERT INTO `tk_cat` VALUES (135843, '社会心理学', 10000249, 3, 1);
INSERT INTO `tk_cat` VALUES (135844, '经典著作', 10000226, 3, 1);
INSERT INTO `tk_cat` VALUES (376705, '家装饰品', 10000269, 3, 1);
INSERT INTO `tk_cat` VALUES (376706, '自然科学', 10000253, 3, 1);
INSERT INTO `tk_cat` VALUES (377107, '养生', 10000246, 3, 1);
INSERT INTO `tk_cat` VALUES (377108, '国学普及读物', 10000252, 3, 1);
INSERT INTO `tk_cat` VALUES (377109, '经典著作', 10000235, 3, 1);
INSERT INTO `tk_cat` VALUES (377110, '旅游指南', 10000225, 3, 1);
INSERT INTO `tk_cat` VALUES (377111, '农业基础科学', 10000258, 3, 1);
INSERT INTO `tk_cat` VALUES (378006, '公职考试培训', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (378007, '教师资格培训', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (378023, '鱼缸/水族箱', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378024, '鱼粮/饲料', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378025, '过滤器/水泵', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378026, '增氧设备', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378027, '温控器材', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378028, '水族药剂', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378029, '造景装饰', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378030, '清洁检测', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378031, '水草用品', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378032, '照明设备', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378033, '滤材/配件', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378034, '海水用品', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378035, '水族服务', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (378037, '鼠类及其它小宠用品', 10000319, 3, 1);
INSERT INTO `tk_cat` VALUES (378038, '爬宠用品', 10000319, 3, 1);
INSERT INTO `tk_cat` VALUES (378039, '鸟类用品', 10000319, 3, 1);
INSERT INTO `tk_cat` VALUES (378040, '兔子用品', 10000319, 3, 1);
INSERT INTO `tk_cat` VALUES (378043, '健骨补钙', 10000320, 3, 1);
INSERT INTO `tk_cat` VALUES (378044, '护肤美毛', 10000320, 3, 1);
INSERT INTO `tk_cat` VALUES (378045, '肠胃调理', 10000320, 3, 1);
INSERT INTO `tk_cat` VALUES (378046, '奶粉', 10000320, 3, 1);
INSERT INTO `tk_cat` VALUES (378047, '宠物驱虫', 10000320, 3, 1);
INSERT INTO `tk_cat` VALUES (378050, '强化免疫', 10000320, 3, 1);
INSERT INTO `tk_cat` VALUES (378057, '婴幼儿奶粉', 10000322, 3, 1);
INSERT INTO `tk_cat` VALUES (378058, '孕妈奶粉', 10000322, 3, 1);
INSERT INTO `tk_cat` VALUES (378060, '米粉/菜粉', 10000323, 3, 1);
INSERT INTO `tk_cat` VALUES (378061, '果泥/果汁', 10000323, 3, 1);
INSERT INTO `tk_cat` VALUES (378066, '面条/粥', 10000323, 3, 1);
INSERT INTO `tk_cat` VALUES (378067, '宝宝零食', 10000323, 3, 1);
INSERT INTO `tk_cat` VALUES (378095, '阿胶', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (378096, '灵芝/孢子粉', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (378105, '石斛', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (378138, '黄金吊坠', 10000332, 3, 1);
INSERT INTO `tk_cat` VALUES (378139, '黄金手镯', 10000332, 3, 1);
INSERT INTO `tk_cat` VALUES (378140, '黄金戒指', 10000332, 3, 1);
INSERT INTO `tk_cat` VALUES (378141, '黄金耳饰', 10000332, 3, 1);
INSERT INTO `tk_cat` VALUES (378142, '黄金转运珠', 10000332, 3, 1);
INSERT INTO `tk_cat` VALUES (378143, '黄金项链', 10000332, 3, 1);
INSERT INTO `tk_cat` VALUES (378144, '黄金手链/脚链', 10000332, 3, 1);
INSERT INTO `tk_cat` VALUES (378146, '银吊坠/项链', 10000333, 3, 1);
INSERT INTO `tk_cat` VALUES (378147, '银手链/脚链', 10000333, 3, 1);
INSERT INTO `tk_cat` VALUES (378148, '银戒指', 10000333, 3, 1);
INSERT INTO `tk_cat` VALUES (378149, '宝宝银饰', 10000333, 3, 1);
INSERT INTO `tk_cat` VALUES (378150, '银手镯', 10000333, 3, 1);
INSERT INTO `tk_cat` VALUES (378151, '银耳饰', 10000333, 3, 1);
INSERT INTO `tk_cat` VALUES (378152, '银制品', 10000333, 3, 1);
INSERT INTO `tk_cat` VALUES (378154, '裸钻', 10000334, 3, 1);
INSERT INTO `tk_cat` VALUES (378155, '钻戒', 10000334, 3, 1);
INSERT INTO `tk_cat` VALUES (378156, '钻石项链/吊坠', 10000334, 3, 1);
INSERT INTO `tk_cat` VALUES (378157, '钻石耳饰', 10000334, 3, 1);
INSERT INTO `tk_cat` VALUES (378158, '钻石手镯/手链', 10000334, 3, 1);
INSERT INTO `tk_cat` VALUES (378162, '翡翠吊坠', 10000335, 3, 1);
INSERT INTO `tk_cat` VALUES (378163, '翡翠手镯', 10000335, 3, 1);
INSERT INTO `tk_cat` VALUES (378164, '翡翠戒指', 10000335, 3, 1);
INSERT INTO `tk_cat` VALUES (378165, '翡翠耳饰', 10000335, 3, 1);
INSERT INTO `tk_cat` VALUES (378166, '挂件/摆件/把件', 10000335, 3, 1);
INSERT INTO `tk_cat` VALUES (378169, '项链/吊坠', 10000336, 3, 1);
INSERT INTO `tk_cat` VALUES (378170, '耳饰', 10000336, 3, 1);
INSERT INTO `tk_cat` VALUES (378171, '手镯/手链/脚链', 10000336, 3, 1);
INSERT INTO `tk_cat` VALUES (378172, '戒指', 10000336, 3, 1);
INSERT INTO `tk_cat` VALUES (378173, '头饰/胸针', 10000336, 3, 1);
INSERT INTO `tk_cat` VALUES (378174, '摆件/挂件', 10000336, 3, 1);
INSERT INTO `tk_cat` VALUES (378177, '琥珀/蜜蜡', 10000337, 3, 1);
INSERT INTO `tk_cat` VALUES (378178, '碧玺', 10000337, 3, 1);
INSERT INTO `tk_cat` VALUES (378179, '红宝石/蓝宝石', 10000337, 3, 1);
INSERT INTO `tk_cat` VALUES (378180, '坦桑石', 10000337, 3, 1);
INSERT INTO `tk_cat` VALUES (378182, '祖母绿', 10000337, 3, 1);
INSERT INTO `tk_cat` VALUES (378184, '葡萄石', 10000337, 3, 1);
INSERT INTO `tk_cat` VALUES (378187, '铂金项链', 10000338, 3, 1);
INSERT INTO `tk_cat` VALUES (378188, '铂金手镯/手链/脚链', 10000338, 3, 1);
INSERT INTO `tk_cat` VALUES (378189, '铂金戒指', 10000338, 3, 1);
INSERT INTO `tk_cat` VALUES (378190, '铂金耳饰', 10000338, 3, 1);
INSERT INTO `tk_cat` VALUES (378191, '铂金吊坠', 10000338, 3, 1);
INSERT INTO `tk_cat` VALUES (378193, '珍珠项链', 10000339, 3, 1);
INSERT INTO `tk_cat` VALUES (378194, '珍珠吊坠', 10000339, 3, 1);
INSERT INTO `tk_cat` VALUES (378195, '珍珠耳饰', 10000339, 3, 1);
INSERT INTO `tk_cat` VALUES (378196, '珍珠手链', 10000339, 3, 1);
INSERT INTO `tk_cat` VALUES (378197, '珍珠戒指', 10000339, 3, 1);
INSERT INTO `tk_cat` VALUES (378198, '珍珠胸针', 10000339, 3, 1);
INSERT INTO `tk_cat` VALUES (378200, '珍珠裸珠', 10000339, 3, 1);
INSERT INTO `tk_cat` VALUES (378202, 'K金吊坠', 10000340, 3, 1);
INSERT INTO `tk_cat` VALUES (378203, 'K金项链', 10000340, 3, 1);
INSERT INTO `tk_cat` VALUES (378204, 'K金手镯/手链/脚链', 10000340, 3, 1);
INSERT INTO `tk_cat` VALUES (378205, 'K金戒指', 10000340, 3, 1);
INSERT INTO `tk_cat` VALUES (378206, 'K金耳饰', 10000340, 3, 1);
INSERT INTO `tk_cat` VALUES (378208, '和田玉项链', 10000341, 3, 1);
INSERT INTO `tk_cat` VALUES (378209, '和田玉吊坠', 10000341, 3, 1);
INSERT INTO `tk_cat` VALUES (378210, '和田玉手镯', 10000341, 3, 1);
INSERT INTO `tk_cat` VALUES (378211, '和田玉手链', 10000341, 3, 1);
INSERT INTO `tk_cat` VALUES (378212, '和田玉戒指', 10000341, 3, 1);
INSERT INTO `tk_cat` VALUES (378213, '和田玉耳饰', 10000341, 3, 1);
INSERT INTO `tk_cat` VALUES (378230, '项链', 10000346, 3, 1);
INSERT INTO `tk_cat` VALUES (378231, '手链/脚链', 10000346, 3, 1);
INSERT INTO `tk_cat` VALUES (378232, '戒指', 10000346, 3, 1);
INSERT INTO `tk_cat` VALUES (378233, '耳饰', 10000346, 3, 1);
INSERT INTO `tk_cat` VALUES (378234, '胸针', 10000346, 3, 1);
INSERT INTO `tk_cat` VALUES (378235, '婚庆饰品', 10000346, 3, 1);
INSERT INTO `tk_cat` VALUES (378236, '饰品配件', 10000346, 3, 1);
INSERT INTO `tk_cat` VALUES (378237, '毛衣链', 10000346, 3, 1);
INSERT INTO `tk_cat` VALUES (378240, '发箍', 10000397, 3, 1);
INSERT INTO `tk_cat` VALUES (378241, '发带', 10000397, 3, 1);
INSERT INTO `tk_cat` VALUES (378242, '发圈/发绳', 10000397, 3, 1);
INSERT INTO `tk_cat` VALUES (378243, '发簪', 10000397, 3, 1);
INSERT INTO `tk_cat` VALUES (378244, '发饰套装', 10000397, 3, 1);
INSERT INTO `tk_cat` VALUES (378246, '发夹', 10000397, 3, 1);
INSERT INTO `tk_cat` VALUES (382005, '青少年素质培养', 10000351, 3, 1);
INSERT INTO `tk_cat` VALUES (422002, '其他滋补品', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (423005, '办公技能', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (424003, '三七', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (427003, '考研辅导', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (428005, '财经商业', 10000357, 3, 1);
INSERT INTO `tk_cat` VALUES (429002, '蜂产品', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (429003, '枸杞', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (430003, '文化休闲', 10000357, 3, 1);
INSERT INTO `tk_cat` VALUES (441003, '人文社科', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (441004, '家长教育', 10000351, 3, 1);
INSERT INTO `tk_cat` VALUES (441006, '会员充值', 10000364, 3, 1);
INSERT INTO `tk_cat` VALUES (494027, '文玩葫芦', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (494032, '草编/柳编', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (494033, '暖宝宝', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (494034, '冲浪机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (494035, '俯卧撑架', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (494036, '体测仪', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (494038, '瑜伽手套', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (494039, '月子装', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (494040, '风衣', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (494041, '休闲裤', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (494042, '休闲短裤', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (494043, '连衣裙', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (494044, '浴袍', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (494045, '羊蝎子', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (494047, '韩语', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (496022, '书法/绘画', 10000401, 3, 1);
INSERT INTO `tk_cat` VALUES (496024, '景德镇陶瓷摆件', 10000383, 3, 1);
INSERT INTO `tk_cat` VALUES (496026, '芝麻丸', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (496029, '男士须后水', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (496031, '美妆蛋/化妆海棉', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (496032, '足部护理', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (496033, '健身吊环', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (496034, '体操鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (496035, '冲锋裤', 10000390, 3, 1);
INSERT INTO `tk_cat` VALUES (496036, '速干材质衣服', 10000390, 3, 1);
INSERT INTO `tk_cat` VALUES (496037, '板鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (496038, '成人体育运动/健身健美', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (496039, '烹饪/烘焙/茶酒咖啡', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (496040, '摄影摄像', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (496041, '司法考试', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (496043, '清洁仪', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (502009, '金条', 10000332, 3, 1);
INSERT INTO `tk_cat` VALUES (502032, '鼻烟壶', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (502034, '羽绒裤', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (502036, '景德镇陶瓷杯/碟/盘/碗', 10000383, 3, 1);
INSERT INTO `tk_cat` VALUES (502040, '素颜霜', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (502041, '弹力棒/健身棒', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (502042, '健身椅', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (502047, '财务/会计培训', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (502048, '法语', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (510021, '竹雕/竹编', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (510023, '唐装/中式服装', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (510024, '灯彩', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (510025, '按摩膏/磨砂膏', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (510026, '健身锤', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (510027, '腕力器', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (510028, 'ems健身仪', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (510030, '背心/吊带', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (510032, '量脚器', 10000376, 3, 1);
INSERT INTO `tk_cat` VALUES (510034, '美容/美妆/美发', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (510036, '葡萄牙语', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (510038, '导入/导出仪', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (517004, '外套', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (517033, '铜镜', 10000378, 3, 1);
INSERT INTO `tk_cat` VALUES (517035, '男士精油', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (517036, '男士鼻贴', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (517037, '纺织', 10000391, 3, 1);
INSERT INTO `tk_cat` VALUES (517039, '呼啦圈', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (517040, '计步器', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (517041, '健身球/保健球', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (517042, '扭腰盘', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (517043, '钢管舞鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (517044, '皮鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (517048, '收纳技巧', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (517049, '自媒体运营', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (517050, '方案策划培训', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (521031, '水盂/砚滴/砚屏/砚台', 10000400, 3, 1);
INSERT INTO `tk_cat` VALUES (521033, '漆器', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (521035, '男士喷雾', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (521036, '男士眼膜', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (521037, '眉毛雨衣', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (521038, '喉鼻护理', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (521039, '手部护理', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (521040, '举重床/卧推器', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (521041, '牛仔服装', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (521043, '关东煮', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (521047, '时尚穿搭', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (524025, '印章', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (524028, '扇', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (524029, '刺绣', 10000391, 3, 1);
INSERT INTO `tk_cat` VALUES (524030, '跳跳床/蹦蹦床', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (524031, '健身踏板/韵律踏板', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (524032, '美腿机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (524033, '藏族舞鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (524034, '摩登舞鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (524035, '煲仔饭', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (524037, '成人舞蹈表演', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (524038, '职业发展/人力资源/管理营销', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (524041, '翻译类资格证书培训', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (524042, '其他语种', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (524044, '黑头仪', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (525029, '香炉', 10000378, 3, 1);
INSERT INTO `tk_cat` VALUES (525030, '摆件', 10000394, 3, 1);
INSERT INTO `tk_cat` VALUES (525032, '定妆喷雾', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (525034, '草裙舞鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (525035, '妈咪包/背婴带', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (525036, '滑雪服', 10000390, 3, 1);
INSERT INTO `tk_cat` VALUES (525037, '防晒衣', 10000390, 3, 1);
INSERT INTO `tk_cat` VALUES (525038, '软壳衣/软壳裤', 10000390, 3, 1);
INSERT INTO `tk_cat` VALUES (525039, '发育内衣/抹胸', 10000368, 3, 1);
INSERT INTO `tk_cat` VALUES (525040, '佛跳墙', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (525045, '日语', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (525047, '婚姻经营', 10000377, 3, 1);
INSERT INTO `tk_cat` VALUES (525048, '喷雾补水仪', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (526005, '高段位奶粉', 10000322, 3, 1);
INSERT INTO `tk_cat` VALUES (526031, '喷雾', 10000181, 3, 1);
INSERT INTO `tk_cat` VALUES (526033, '修容/阴影', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (526034, '街舞鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (526035, 'POLO衫', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (526036, '抓绒衣', 10000390, 3, 1);
INSERT INTO `tk_cat` VALUES (526037, '板鞋', 10000214, 3, 1);
INSERT INTO `tk_cat` VALUES (526039, '医学类资格认证', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (526040, '俄语', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (526041, '创业知识', 10000408, 3, 1);
INSERT INTO `tk_cat` VALUES (527034, '铜壶', 10000378, 3, 1);
INSERT INTO `tk_cat` VALUES (527040, '剪纸', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (527041, '假睫毛辅助工具', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (527042, '漫步机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (527043, '瑜伽披肩', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (527044, '啦啦队鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (527045, '防溢乳垫', 10000118, 3, 1);
INSERT INTO `tk_cat` VALUES (527047, '夹克/皮衣', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (527048, '汉风/民族/传统布鞋', 10000125, 3, 1);
INSERT INTO `tk_cat` VALUES (527049, '鞋垫', 10000376, 3, 1);
INSERT INTO `tk_cat` VALUES (527050, '酸菜鱼', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (527051, '其他方便菜', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (527054, '成人书法/绘画/手工艺', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (527057, '宣传文案培训', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (527058, '汉语学习', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (527060, '心理成长', 10000377, 3, 1);
INSERT INTO `tk_cat` VALUES (527062, '睫毛卷翘器', 10000387, 3, 1);
INSERT INTO `tk_cat` VALUES (529030, '摆件', 10000370, 3, 1);
INSERT INTO `tk_cat` VALUES (529033, '男士颈膜', 10000179, 3, 1);
INSERT INTO `tk_cat` VALUES (529035, '高光', 10000182, 3, 1);
INSERT INTO `tk_cat` VALUES (529036, '爽身粉', 10000006, 3, 1);
INSERT INTO `tk_cat` VALUES (529037, '器械减震垫', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (529038, '皮草/仿皮草', 10000123, 3, 1);
INSERT INTO `tk_cat` VALUES (529039, '冲锋衣', 10000390, 3, 1);
INSERT INTO `tk_cat` VALUES (529040, '洞洞鞋', 10000213, 3, 1);
INSERT INTO `tk_cat` VALUES (529041, '花椒鸡', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (529045, '设计创作/影音游戏动画', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (529047, 'IT职业/编程/计算机', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (529048, '英语', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (530034, '笔/笔筒/笔具', 10000400, 3, 1);
INSERT INTO `tk_cat` VALUES (530035, '墨/墨盒', 10000400, 3, 1);
INSERT INTO `tk_cat` VALUES (530036, '纸/纸具', 10000400, 3, 1);
INSERT INTO `tk_cat` VALUES (530041, 'POLO衫', 10000113, 3, 1);
INSERT INTO `tk_cat` VALUES (530042, '化妆包/刷包', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (530043, '檀香', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (530045, '风筝', 10000384, 3, 1);
INSERT INTO `tk_cat` VALUES (530046, '印染', 10000391, 3, 1);
INSERT INTO `tk_cat` VALUES (530047, 'DIY面膜工具', 10000180, 3, 1);
INSERT INTO `tk_cat` VALUES (530049, '登山机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (530050, '足底按摩垫', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (530051, '朝鲜舞鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (530052, '傣族舞鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (530053, '踢踏舞鞋服', 10000194, 3, 1);
INSERT INTO `tk_cat` VALUES (530054, '保暖衣/裤', 10000368, 3, 1);
INSERT INTO `tk_cat` VALUES (530055, '鞋带', 10000376, 3, 1);
INSERT INTO `tk_cat` VALUES (530057, '播音主持/演讲培训', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (530058, '成人音乐才艺', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (530059, '互联网产品与运营/电子商务', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (530061, '德语', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (530062, '西班牙语', 10000379, 3, 1);
INSERT INTO `tk_cat` VALUES (530063, '学习/读书卡', 10000380, 3, 1);
INSERT INTO `tk_cat` VALUES (544002, '礼仪气质', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (545001, '项目管理培训/经济师培训', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (545003, '金融科普', 10000408, 3, 1);
INSERT INTO `tk_cat` VALUES (545004, '沟通技巧', 10000377, 3, 1);
INSERT INTO `tk_cat` VALUES (545011, '题库/AI教辅', 10000410, 3, 1);
INSERT INTO `tk_cat` VALUES (545012, '景德镇陶瓷缸/罐/壶/炉', 10000383, 3, 1);
INSERT INTO `tk_cat` VALUES (545013, '景德镇陶瓷瓶', 10000383, 3, 1);
INSERT INTO `tk_cat` VALUES (545014, '其他陶瓷摆件', 10000383, 3, 1);
INSERT INTO `tk_cat` VALUES (545015, '其他陶瓷杯/碟/盘/碗', 10000383, 3, 1);
INSERT INTO `tk_cat` VALUES (545016, '其他陶瓷缸/罐/壶/炉', 10000383, 3, 1);
INSERT INTO `tk_cat` VALUES (545017, '其他陶瓷瓶', 10000383, 3, 1);
INSERT INTO `tk_cat` VALUES (545018, '茶盏', 10000394, 3, 1);
INSERT INTO `tk_cat` VALUES (545019, '盖碗', 10000394, 3, 1);
INSERT INTO `tk_cat` VALUES (545020, '紫砂壶', 10000370, 3, 1);
INSERT INTO `tk_cat` VALUES (545021, '紫砂杯', 10000370, 3, 1);
INSERT INTO `tk_cat` VALUES (545022, '紫砂茶盘', 10000370, 3, 1);
INSERT INTO `tk_cat` VALUES (545023, '紫砂茶宠', 10000370, 3, 1);
INSERT INTO `tk_cat` VALUES (545024, '紫砂香炉', 10000370, 3, 1);
INSERT INTO `tk_cat` VALUES (545259, '进口车厘子', 10000452, 4, 1);
INSERT INTO `tk_cat` VALUES (545260, '国产樱桃', 10000452, 4, 1);
INSERT INTO `tk_cat` VALUES (545262, '防晒衣', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (545263, '防晒面罩/防晒口罩/脸基尼', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (545264, '鲜榴莲', 10000453, 4, 1);
INSERT INTO `tk_cat` VALUES (545265, '液氮/冻榴莲', 10000453, 4, 1);
INSERT INTO `tk_cat` VALUES (545266, '常温/低温粽子', 10000218, 3, 1);
INSERT INTO `tk_cat` VALUES (545267, '洗地机', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (545283, '调味小龙虾', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (545291, '月饼', 10000216, 3, 1);
INSERT INTO `tk_cat` VALUES (545293, '空调挡风板', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (545294, '挂钩/粘钩', 10000049, 3, 1);
INSERT INTO `tk_cat` VALUES (545297, '暖菜板/暖餐桌', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (545298, '保鲜解冻器', 10000060, 3, 1);
INSERT INTO `tk_cat` VALUES (545299, '电蚊拍', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (545300, '灭蚊灯', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (545301, '国产白兰地', 10000454, 4, 1);
INSERT INTO `tk_cat` VALUES (545302, '进口白兰地/干邑', 10000454, 4, 1);
INSERT INTO `tk_cat` VALUES (545303, '国产威士忌', 10000455, 4, 1);
INSERT INTO `tk_cat` VALUES (545304, '进口威士忌', 10000455, 4, 1);
INSERT INTO `tk_cat` VALUES (545305, '进口葡萄酒', 10000206, 3, 1);
INSERT INTO `tk_cat` VALUES (545306, '米酒', 10000207, 3, 1);
INSERT INTO `tk_cat` VALUES (545307, '擦地/擦窗机器人', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (545308, '布艺清洗机', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (545309, '衣物消毒机', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (545310, '烘鞋器/干鞋器', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (545311, '香薰机', 10000064, 3, 1);
INSERT INTO `tk_cat` VALUES (545556, '处方狗粮', 10000027, 3, 1);
INSERT INTO `tk_cat` VALUES (545557, '处方猫粮', 10000027, 3, 1);
INSERT INTO `tk_cat` VALUES (545558, 'ATM防护亭', 10000039, 3, 1);
INSERT INTO `tk_cat` VALUES (545559, '候车亭', 10000039, 3, 1);
INSERT INTO `tk_cat` VALUES (545560, '分类垃圾站', 10000039, 3, 1);
INSERT INTO `tk_cat` VALUES (545561, '场馆座椅', 10000039, 3, 1);
INSERT INTO `tk_cat` VALUES (545562, '导视立牌', 10000039, 3, 1);
INSERT INTO `tk_cat` VALUES (545563, '志愿者服务亭', 10000039, 3, 1);
INSERT INTO `tk_cat` VALUES (545564, '朗读亭', 10000039, 3, 1);
INSERT INTO `tk_cat` VALUES (545565, '机场椅', 10000039, 3, 1);
INSERT INTO `tk_cat` VALUES (545566, '三轮车', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545567, '儿童摇椅', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545568, '儿童滑步车', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545569, '婴儿床', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545570, '婴儿床垫', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545571, '婴儿推车', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545572, '婴幼儿餐椅', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545573, '学步车', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545574, '扭扭车', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545575, '滑板车', 10000124, 3, 1);
INSERT INTO `tk_cat` VALUES (545576, '时政新闻', 10000357, 3, 1);
INSERT INTO `tk_cat` VALUES (545577, '孕产妇饮食/保健', 10000243, 3, 1);
INSERT INTO `tk_cat` VALUES (545578, '甩脂机', 10000185, 3, 1);
INSERT INTO `tk_cat` VALUES (545579, '老年代步车', 10000200, 3, 1);
INSERT INTO `tk_cat` VALUES (545580, '其他天然宝石', 10000337, 3, 1);
INSERT INTO `tk_cat` VALUES (545581, '青金石', 10000342, 3, 1);
INSERT INTO `tk_cat` VALUES (545582, '绿松石', 10000342, 3, 1);
INSERT INTO `tk_cat` VALUES (545583, '蓝田玉', 10000342, 3, 1);
INSERT INTO `tk_cat` VALUES (545584, '石英岩玉', 10000342, 3, 1);
INSERT INTO `tk_cat` VALUES (545585, '岫岩玉', 10000342, 3, 1);
INSERT INTO `tk_cat` VALUES (545592, '爆炸盐', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (545593, '干洗剂', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (545594, '彩漂', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (545595, '漂白剂', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (545596, '吸色片', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (545597, '留香珠', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (545598, '衣领净', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (545599, '内衣皂/内衣洗涤剂', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (545600, '即时去渍剂', 10000055, 3, 1);
INSERT INTO `tk_cat` VALUES (545601, '免插电扩香机/喷香机/散香器', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545602, '香包/香囊', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545603, '香托/香盘/香座/香插', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545604, '香薰DIY材料/工具', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545605, '香薰喷雾剂', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545606, '香薰挥发液/香薰精油', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545607, '香薰摆件', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545608, '香薰条/棒', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545609, '香薰卡片/香薰石/香薰粉/香薰膏', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545610, '香薰礼盒', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545611, '香薰灯/炉/器具', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545612, '无味蜡烛', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545613, '烛台', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545614, '蜡烛/蜡片', 10000457, 4, 1);
INSERT INTO `tk_cat` VALUES (545615, '冰丝席', 10000458, 4, 1);
INSERT INTO `tk_cat` VALUES (545616, '椅垫', 10000459, 4, 1);
INSERT INTO `tk_cat` VALUES (545617, '沙发垫', 10000459, 4, 1);
INSERT INTO `tk_cat` VALUES (545618, '蒲团', 10000459, 4, 1);
INSERT INTO `tk_cat` VALUES (545619, '飘窗垫', 10000459, 4, 1);
INSERT INTO `tk_cat` VALUES (545620, '美臀垫/保健坐垫', 10000459, 4, 1);
INSERT INTO `tk_cat` VALUES (545621, '午睡枕', 10000460, 4, 1);
INSERT INTO `tk_cat` VALUES (545622, '腰靠垫', 10000460, 4, 1);
INSERT INTO `tk_cat` VALUES (545623, '抱枕被', 10000460, 4, 1);
INSERT INTO `tk_cat` VALUES (545624, '床头靠垫', 10000460, 4, 1);
INSERT INTO `tk_cat` VALUES (545625, '桌椅脚套', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545626, '桌旗', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545627, '桌布', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545628, '椅套', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545629, '茶席', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545630, '茶几垫', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545631, '布艺餐巾', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545632, '餐垫', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545633, '桌垫', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545634, '防尘保护罩', 10000461, 4, 1);
INSERT INTO `tk_cat` VALUES (545635, '浴巾', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545636, '一次性浴巾', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545637, '浴裙/浴袍/浴衣', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545638, '浴巾毛巾方巾套装/三件套', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545639, '汗蒸服', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545640, '一次性洗脸毛巾', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545641, '手巾/手帕', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545642, '毛巾/面巾', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545643, '压缩毛巾', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545644, '干发毛巾', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545645, '敷脸巾', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545646, '擦脚布', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545647, '毛巾礼盒套装', 10000462, 4, 1);
INSERT INTO `tk_cat` VALUES (545648, '窗纱', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545649, '线帘', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545650, '门帘', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545651, '卷帘', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545652, '蜂巢帘', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545653, '珠帘/挂帘', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545654, '柜类遮挡帘', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545655, '垂直帘/梦幻帘', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545656, '窗帘面料', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545657, '百叶帘/折帘/罗马帘', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545658, '辅料配件', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545659, '窗帘轨道', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545660, '窗帘杆/罗马杆', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545661, '全屋窗帘套餐', 10000463, 4, 1);
INSERT INTO `tk_cat` VALUES (545662, '十字绣及工具配件', 10000067, 3, 1);
INSERT INTO `tk_cat` VALUES (545663, '一次性拖鞋', 10000464, 4, 1);
INSERT INTO `tk_cat` VALUES (545664, '居家棉拖', 10000464, 4, 1);
INSERT INTO `tk_cat` VALUES (545665, '居家凉拖/凉鞋', 10000464, 4, 1);
INSERT INTO `tk_cat` VALUES (545666, '地垫', 10000465, 4, 1);
INSERT INTO `tk_cat` VALUES (545667, '地毯', 10000465, 4, 1);
INSERT INTO `tk_cat` VALUES (545668, '乳胶席', 10000458, 4, 1);
INSERT INTO `tk_cat` VALUES (545669, '竹席', 10000458, 4, 1);
INSERT INTO `tk_cat` VALUES (545670, '牛皮席', 10000458, 4, 1);
INSERT INTO `tk_cat` VALUES (545671, '粗布凉席', 10000458, 4, 1);
INSERT INTO `tk_cat` VALUES (545672, '草席/藤席', 10000458, 4, 1);
INSERT INTO `tk_cat` VALUES (545673, '纤维被', 10000466, 4, 1);
INSERT INTO `tk_cat` VALUES (545674, '乳胶被', 10000466, 4, 1);
INSERT INTO `tk_cat` VALUES (545675, '棉花被', 10000466, 4, 1);
INSERT INTO `tk_cat` VALUES (545676, '蚕丝被', 10000466, 4, 1);
INSERT INTO `tk_cat` VALUES (545677, '羊毛/驼毛被', 10000466, 4, 1);
INSERT INTO `tk_cat` VALUES (545678, '羽绒/羽毛被', 10000466, 4, 1);
INSERT INTO `tk_cat` VALUES (545679, '羽绒枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545680, '纤维枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545681, '乳胶枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545682, '记忆枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545683, '花草枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545684, '颈椎枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545685, '蚕丝枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545686, '棉花枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545687, '软管枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545688, '羽毛枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545689, 'TPE枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545690, 'U型枕', 10000467, 4, 1);
INSERT INTO `tk_cat` VALUES (545691, '三件套', 10000468, 4, 1);
INSERT INTO `tk_cat` VALUES (545692, '四件套', 10000468, 4, 1);
INSERT INTO `tk_cat` VALUES (545693, '多件套', 10000468, 4, 1);
INSERT INTO `tk_cat` VALUES (545694, '婚庆床品套件', 10000468, 4, 1);
INSERT INTO `tk_cat` VALUES (545695, '被套', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545696, '枕套', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545697, '枕巾', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545698, '床罩', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545699, '床裙', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545700, '床旗', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545701, '床幔', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545702, '床盖', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545703, '床头套', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545704, '床笠', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545705, '床帘', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545706, '床单', 10000469, 4, 1);
INSERT INTO `tk_cat` VALUES (545707, '一次性床品', 10000068, 3, 1);
INSERT INTO `tk_cat` VALUES (545708, '地暖垫', 10000068, 3, 1);
INSERT INTO `tk_cat` VALUES (545709, '公路电子收费/ETC/OBU', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545710, '食补粉', 10000222, 3, 1);
INSERT INTO `tk_cat` VALUES (545711, '其他冲饮品', 10000222, 3, 1);
INSERT INTO `tk_cat` VALUES (545712, '园参/人参及制品', 10000470, 4, 1);
INSERT INTO `tk_cat` VALUES (545713, '山参/林下参', 10000470, 4, 1);
INSERT INTO `tk_cat` VALUES (545714, '红参/高丽参及制品', 10000470, 4, 1);
INSERT INTO `tk_cat` VALUES (545715, '西洋参', 10000470, 4, 1);
INSERT INTO `tk_cat` VALUES (545716, '干燕窝', 10000471, 4, 1);
INSERT INTO `tk_cat` VALUES (545717, '鲜炖/即食燕窝', 10000471, 4, 1);
INSERT INTO `tk_cat` VALUES (545718, '燕窝制品', 10000471, 4, 1);
INSERT INTO `tk_cat` VALUES (545719, '药食同源食品', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (545720, '冬虫夏草', 10000327, 3, 1);
INSERT INTO `tk_cat` VALUES (545721, '宠物伊丽莎白圈', 10000031, 3, 1);
INSERT INTO `tk_cat` VALUES (545722, '生态瓶/创意缸/桌面微景缸', 10000318, 3, 1);
INSERT INTO `tk_cat` VALUES (545723, '异宠饲料/零食', 10000319, 3, 1);
INSERT INTO `tk_cat` VALUES (545729, '短裤', 10000477, 4, 1);
INSERT INTO `tk_cat` VALUES (545730, '加绒裤', 10000477, 4, 1);
INSERT INTO `tk_cat` VALUES (545731, '牛仔裤', 10000477, 4, 1);
INSERT INTO `tk_cat` VALUES (545732, '卫裤/运动裤', 10000477, 4, 1);
INSERT INTO `tk_cat` VALUES (545733, '休闲裤', 10000477, 4, 1);
INSERT INTO `tk_cat` VALUES (545734, '羽绒裤', 10000477, 4, 1);
INSERT INTO `tk_cat` VALUES (545735, '工装裤', 10000477, 4, 1);
INSERT INTO `tk_cat` VALUES (545736, '羊毛衫', 10000478, 4, 1);
INSERT INTO `tk_cat` VALUES (545737, '羊绒衫', 10000478, 4, 1);
INSERT INTO `tk_cat` VALUES (545738, '针织衫', 10000478, 4, 1);
INSERT INTO `tk_cat` VALUES (545739, '大码上装', 10000479, 4, 1);
INSERT INTO `tk_cat` VALUES (545740, '大码下装', 10000479, 4, 1);
INSERT INTO `tk_cat` VALUES (545741, '大码套装', 10000479, 4, 1);
INSERT INTO `tk_cat` VALUES (545742, '仿皮皮衣', 10000480, 4, 1);
INSERT INTO `tk_cat` VALUES (545743, '真皮皮衣', 10000480, 4, 1);
INSERT INTO `tk_cat` VALUES (545744, '皮草', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (545745, '西服上装', 10000481, 4, 1);
INSERT INTO `tk_cat` VALUES (545746, '西服套装', 10000481, 4, 1);
INSERT INTO `tk_cat` VALUES (545747, '西装马甲', 10000481, 4, 1);
INSERT INTO `tk_cat` VALUES (545748, '西裤', 10000481, 4, 1);
INSERT INTO `tk_cat` VALUES (545749, '羽绒马甲', 10000482, 4, 1);
INSERT INTO `tk_cat` VALUES (545750, '普通马甲', 10000482, 4, 1);
INSERT INTO `tk_cat` VALUES (545751, '背心', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (545752, '学生校服', 10000483, 4, 1);
INSERT INTO `tk_cat` VALUES (545753, '休闲运动套装', 10000483, 4, 1);
INSERT INTO `tk_cat` VALUES (545754, '工作制服', 10000483, 4, 1);
INSERT INTO `tk_cat` VALUES (545755, '毛呢大衣', 10000484, 4, 1);
INSERT INTO `tk_cat` VALUES (545756, '羊毛大衣', 10000484, 4, 1);
INSERT INTO `tk_cat` VALUES (545757, '羊绒大衣', 10000484, 4, 1);
INSERT INTO `tk_cat` VALUES (545758, '中山装', 10000485, 4, 1);
INSERT INTO `tk_cat` VALUES (545759, '唐装/中式服装', 10000485, 4, 1);
INSERT INTO `tk_cat` VALUES (545760, '中老年上装', 10000486, 4, 1);
INSERT INTO `tk_cat` VALUES (545761, '中老年下装', 10000486, 4, 1);
INSERT INTO `tk_cat` VALUES (545762, '中老年套装', 10000486, 4, 1);
INSERT INTO `tk_cat` VALUES (545763, '礼服', 10000115, 3, 1);
INSERT INTO `tk_cat` VALUES (545764, '风衣', 10000487, 4, 1);
INSERT INTO `tk_cat` VALUES (545765, '夹克/飞行夹克', 10000487, 4, 1);
INSERT INTO `tk_cat` VALUES (545766, '牛仔外套', 10000487, 4, 1);
INSERT INTO `tk_cat` VALUES (545767, '棒球服', 10000487, 4, 1);
INSERT INTO `tk_cat` VALUES (545768, '派克服', 10000487, 4, 1);
INSERT INTO `tk_cat` VALUES (545769, '短袜', 10000488, 4, 1);
INSERT INTO `tk_cat` VALUES (545770, '船袜', 10000488, 4, 1);
INSERT INTO `tk_cat` VALUES (545771, '中筒袜', 10000488, 4, 1);
INSERT INTO `tk_cat` VALUES (545772, '丝袜', 10000488, 4, 1);
INSERT INTO `tk_cat` VALUES (545773, '打底袜', 10000488, 4, 1);
INSERT INTO `tk_cat` VALUES (545774, '美腿袜', 10000488, 4, 1);
INSERT INTO `tk_cat` VALUES (545775, '长筒袜', 10000488, 4, 1);
INSERT INTO `tk_cat` VALUES (545776, '一次性袜子', 10000488, 4, 1);
INSERT INTO `tk_cat` VALUES (545777, '保暖裤', 10000489, 4, 1);
INSERT INTO `tk_cat` VALUES (545778, '保暖上装', 10000489, 4, 1);
INSERT INTO `tk_cat` VALUES (545779, '保暖套装', 10000489, 4, 1);
INSERT INTO `tk_cat` VALUES (545780, '乳贴', 10000490, 4, 1);
INSERT INTO `tk_cat` VALUES (545781, '搭扣', 10000490, 4, 1);
INSERT INTO `tk_cat` VALUES (545782, '肩带', 10000490, 4, 1);
INSERT INTO `tk_cat` VALUES (545783, '插片/胸垫', 10000490, 4, 1);
INSERT INTO `tk_cat` VALUES (545784, '塑身上衣', 10000491, 4, 1);
INSERT INTO `tk_cat` VALUES (545785, '塑身腰封/腰夹', 10000491, 4, 1);
INSERT INTO `tk_cat` VALUES (545786, '塑身美体裤', 10000491, 4, 1);
INSERT INTO `tk_cat` VALUES (545787, '塑身连体衣', 10000491, 4, 1);
INSERT INTO `tk_cat` VALUES (545788, '塑身分体套装', 10000491, 4, 1);
INSERT INTO `tk_cat` VALUES (545789, '抹胸', 10000492, 4, 1);
INSERT INTO `tk_cat` VALUES (545790, '文胸', 10000492, 4, 1);
INSERT INTO `tk_cat` VALUES (545791, '女式内衣套装', 10000492, 4, 1);
INSERT INTO `tk_cat` VALUES (545792, '女式内裤', 10000493, 4, 1);
INSERT INTO `tk_cat` VALUES (545793, '一次性内裤', 10000493, 4, 1);
INSERT INTO `tk_cat` VALUES (545794, '男式内裤', 10000493, 4, 1);
INSERT INTO `tk_cat` VALUES (545795, '睡裙', 10000494, 4, 1);
INSERT INTO `tk_cat` VALUES (545796, '睡袍/浴袍款睡袍', 10000494, 4, 1);
INSERT INTO `tk_cat` VALUES (545797, '睡裤/家居裤', 10000494, 4, 1);
INSERT INTO `tk_cat` VALUES (545798, '睡衣/家居服套装', 10000494, 4, 1);
INSERT INTO `tk_cat` VALUES (545799, '睡衣上装', 10000494, 4, 1);
INSERT INTO `tk_cat` VALUES (545800, '情侣睡衣', 10000494, 4, 1);
INSERT INTO `tk_cat` VALUES (545802, '360全景影像', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545803, 'HUD抬头显示', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545804, '倒车雷达', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545805, '后视镜导航', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545806, '导航仪', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545807, '车机导航', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545808, '车用便捷式GPS导航', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545809, '安全预警仪', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545810, '执法记录仪', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545811, '电动车窗升降器', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545812, '电动折叠后视镜', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545813, '汽车应急启动电源', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545814, '行车记录仪', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545815, '车载拓展坞', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545816, '车载电器配件', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545817, '车载蓝牙', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545818, '逆变器', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545819, '驾驶辅助', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545820, '车机互联转换盒', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545821, '车用显示器/头枕屏', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545822, '车用随身wifi', 10000131, 3, 1);
INSERT INTO `tk_cat` VALUES (545823, '充电枪头防盗锁', 10000495, 4, 1);
INSERT INTO `tk_cat` VALUES (545824, '充电桩保护箱', 10000495, 4, 1);
INSERT INTO `tk_cat` VALUES (545825, '充电桩取电/放电转换器', 10000495, 4, 1);
INSERT INTO `tk_cat` VALUES (545826, '充电桩延长线', 10000495, 4, 1);
INSERT INTO `tk_cat` VALUES (545827, '新能源充放电一体机', 10000495, 4, 1);
INSERT INTO `tk_cat` VALUES (545828, '新能源接地宝', 10000495, 4, 1);
INSERT INTO `tk_cat` VALUES (545829, '新能源汽车充电控制器', 10000495, 4, 1);
INSERT INTO `tk_cat` VALUES (545830, '直流充电桩转换器', 10000495, 4, 1);
INSERT INTO `tk_cat` VALUES (545831, '车用电饭煲', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545832, '车载烧水壶', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545833, '车用电扇/暖风扇', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545834, '车载阅读灯', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545835, '汽车便携空调/驻车空调', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545836, '车用电炒锅', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545837, '车载饮水机', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545838, '车载灶台', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545839, '车载电热毯', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545840, '车载游戏手柄', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545841, '车载冰箱', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545842, '车载净化器', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545843, '车载吸尘器', 10000496, 4, 1);
INSERT INTO `tk_cat` VALUES (545844, '皮裤', 10000477, 4, 1);
INSERT INTO `tk_cat` VALUES (545846, '露营帐篷', 10000498, 4, 1);
INSERT INTO `tk_cat` VALUES (545847, '沐浴/更衣帐篷', 10000498, 4, 1);
INSERT INTO `tk_cat` VALUES (545848, '遮阳篷/雨篷', 10000498, 4, 1);
INSERT INTO `tk_cat` VALUES (545849, '天幕', 10000498, 4, 1);
INSERT INTO `tk_cat` VALUES (545850, '车顶帐篷/车边帐篷/车尾帐篷', 10000498, 4, 1);
INSERT INTO `tk_cat` VALUES (545851, '帐篷垫/防潮垫/野餐垫', 10000498, 4, 1);
INSERT INTO `tk_cat` VALUES (545852, '防火垫', 10000498, 4, 1);
INSERT INTO `tk_cat` VALUES (545858, '篷布/网纱', 10000500, 4, 1);
INSERT INTO `tk_cat` VALUES (545859, '搭建工具', 10000500, 4, 1);
INSERT INTO `tk_cat` VALUES (545860, '帐杆/支撑竿', 10000500, 4, 1);
INSERT INTO `tk_cat` VALUES (545861, '户外挂钩', 10000500, 4, 1);
INSERT INTO `tk_cat` VALUES (545862, '露营收纳包', 10000501, 4, 1);
INSERT INTO `tk_cat` VALUES (545863, '露营收纳箱', 10000501, 4, 1);
INSERT INTO `tk_cat` VALUES (545864, '户外便携便器/马桶', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545865, '睡袋', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545866, '秋千', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545867, '户外营地车', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545868, '户外灯架', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545869, '户外淋浴器', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545870, '户外床/折叠床', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545871, '充气床', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545872, '户外便携枕头', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545873, '户外便携沙发', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545874, '吊床', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545875, '户外桌子/折叠桌', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545876, '户外椅子/折叠椅', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545877, '户外桌椅/折叠桌椅套装', 10000502, 4, 1);
INSERT INTO `tk_cat` VALUES (545878, '露营灯/营地灯/帐篷灯', 10000503, 4, 1);
INSERT INTO `tk_cat` VALUES (545879, '冰包/冰桶', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545880, '户外炊具/套锅', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545881, '户外餐具', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545882, '野餐篮', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545883, '野餐烧水壶/茶壶', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545884, '野餐炉具', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545885, '卡式炉', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545886, '卡式炉气罐', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545887, '挡风板', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545888, '户外鼓风机', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545889, '便携饮水用具', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545890, '户外便携水桶', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545891, '户外便携水盆', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545892, '便携卡式喷火枪', 10000504, 4, 1);
INSERT INTO `tk_cat` VALUES (545893, '移动电源', 10000505, 4, 1);
INSERT INTO `tk_cat` VALUES (545894, '背夹电源', 10000505, 4, 1);
INSERT INTO `tk_cat` VALUES (545895, '外放电源/电枪', 10000505, 4, 1);
INSERT INTO `tk_cat` VALUES (545897, '烧烤架/炉', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545898, '锡纸/锡纸盒', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545899, '烧烤签', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545900, '烧烤炭', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545901, '木柴', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545902, '固态酒精', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545903, '烧烤炭夹', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545904, '油刷', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545905, '烧烤食品夹', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545906, '烧烤盘', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545907, '烧烤网', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545908, '烧烤针', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545909, '穿串器', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545910, '点火器', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545911, '调味盒/调料瓶', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545912, '其他烧烤配件', 10000507, 4, 1);
INSERT INTO `tk_cat` VALUES (545917, '增强免疫', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545918, '骨骼健康', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545919, '肠胃养护', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545920, '调节三高', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545921, '缓解疲劳', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545922, '养肝护肝', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545923, '改善贫血', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545924, '清咽利喉', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545925, '养颜/抗氧化', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545926, '减肥塑身', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545927, '改善睡眠', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545928, '明目益智', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545929, '补充维生素/矿物质', 10000509, 3, 1);
INSERT INTO `tk_cat` VALUES (545930, '氨基酸/运动营养', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545931, '乳清蛋白', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545932, '肽类', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545933, '褪黑素/蛇麻草/圣约翰草', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545934, '其它蛋白', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545935, '混合蛋白', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545936, '胶原蛋白', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545937, '大豆分离蛋白/混合蛋白', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545938, '蛋白棒/固体饮料', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545939, '代餐粉/代餐奶昔', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545940, '营养餐包', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545941, 'γ-氨基丁酸/GABA', 10000511, 4, 1);
INSERT INTO `tk_cat` VALUES (545942, '牛初乳', 10000512, 4, 1);
INSERT INTO `tk_cat` VALUES (545943, '袋鼠精', 10000512, 4, 1);
INSERT INTO `tk_cat` VALUES (545944, '普通动物提取物', 10000512, 4, 1);
INSERT INTO `tk_cat` VALUES (545945, '速度力量类', 10000513, 4, 1);
INSERT INTO `tk_cat` VALUES (545946, '运动后恢复类', 10000513, 4, 1);
INSERT INTO `tk_cat` VALUES (545947, '营养代餐', 10000513, 4, 1);
INSERT INTO `tk_cat` VALUES (545948, '耐力类', 10000513, 4, 1);
INSERT INTO `tk_cat` VALUES (545949, '特殊用途饮料', 10000513, 4, 1);
INSERT INTO `tk_cat` VALUES (545950, '鱼油/角鲨烯', 10000514, 4, 1);
INSERT INTO `tk_cat` VALUES (545951, '牡蛎/珍珠粉/贝类提取物', 10000514, 4, 1);
INSERT INTO `tk_cat` VALUES (545952, '螺旋藻/藻类提取物', 10000514, 4, 1);
INSERT INTO `tk_cat` VALUES (545953, '氨糖软骨素/骨胶原', 10000514, 4, 1);
INSERT INTO `tk_cat` VALUES (545954, '普通海洋生物提取物', 10000514, 4, 1);
INSERT INTO `tk_cat` VALUES (545955, '酵素', 10000515, 4, 1);
INSERT INTO `tk_cat` VALUES (545956, '益生菌', 10000515, 4, 1);
INSERT INTO `tk_cat` VALUES (545957, '猴头菇/普通菌菇提取物', 10000515, 4, 1);
INSERT INTO `tk_cat` VALUES (545958, '低聚糖/寡糖/低GI', 10000516, 4, 1);
INSERT INTO `tk_cat` VALUES (545959, '生物多糖', 10000516, 4, 1);
INSERT INTO `tk_cat` VALUES (545960, '膳食纤维/果蔬纤维', 10000516, 4, 1);
INSERT INTO `tk_cat` VALUES (545961, 'B族维生素', 10000517, 4, 1);
INSERT INTO `tk_cat` VALUES (545962, '锌/铁/硒', 10000517, 4, 1);
INSERT INTO `tk_cat` VALUES (545963, '叶酸', 10000517, 4, 1);
INSERT INTO `tk_cat` VALUES (545964, '钙铁锌/钙镁', 10000517, 4, 1);
INSERT INTO `tk_cat` VALUES (545965, '维生素/复合维生素', 10000517, 4, 1);
INSERT INTO `tk_cat` VALUES (545966, '维生素E+C', 10000517, 4, 1);
INSERT INTO `tk_cat` VALUES (545967, '左旋肉碱', 10000517, 4, 1);
INSERT INTO `tk_cat` VALUES (545968, '复合维生素/矿物质', 10000517, 4, 1);
INSERT INTO `tk_cat` VALUES (545969, '烟酰胺', 10000517, 4, 1);
INSERT INTO `tk_cat` VALUES (545970, 'DHA/EPA/DPA亚麻酸', 10000518, 4, 1);
INSERT INTO `tk_cat` VALUES (545971, '芦荟提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545972, '蔓越莓提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545973, '茶多酚/茶族提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545974, '叶黄素/蓝莓/越橘提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545975, '大豆异黄酮提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545976, '木瓜提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545977, '纳豆提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545978, '葡萄籽提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545979, '普通植物提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545980, '葛根提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545981, '灵芝/参类/石斛提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545982, '白芸豆提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545983, '青汁提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545984, '水飞蓟/奶蓟草提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545985, '柑橘多酚提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545986, '花粉提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545987, '人参皂苷提取物', 10000519, 4, 1);
INSERT INTO `tk_cat` VALUES (545988, '润喉糖', 10000520, 4, 1);
INSERT INTO `tk_cat` VALUES (545989, '膳食补充剂型饮料', 10000520, 4, 1);
INSERT INTO `tk_cat` VALUES (545990, '功能糖果', 10000520, 4, 1);
INSERT INTO `tk_cat` VALUES (545991, '功能饮品', 10000520, 4, 1);
INSERT INTO `tk_cat` VALUES (545993, '国产果酒', 10000521, 3, 1);
INSERT INTO `tk_cat` VALUES (545994, '进口果酒', 10000521, 3, 1);
INSERT INTO `tk_cat` VALUES (545995, '配制酒', 10000204, 3, 1);
INSERT INTO `tk_cat` VALUES (545996, '国产啤酒', 10000202, 3, 1);
INSERT INTO `tk_cat` VALUES (545997, '进口啤酒', 10000202, 3, 1);
INSERT INTO `tk_cat` VALUES (545998, '观音竹/富贵竹/龟背竹', 10000522, 4, 1);
INSERT INTO `tk_cat` VALUES (545999, '发财树/招财树', 10000522, 4, 1);
INSERT INTO `tk_cat` VALUES (546000, '白掌/金钻/竹芋', 10000522, 4, 1);
INSERT INTO `tk_cat` VALUES (546001, '天堂鸟/巴西木', 10000522, 4, 1);
INSERT INTO `tk_cat` VALUES (546002, '创意绿植/微景观', 10000522, 4, 1);
INSERT INTO `tk_cat` VALUES (546003, '盆景/盆栽', 10000522, 4, 1);
INSERT INTO `tk_cat` VALUES (546004, '其他绿植', 10000522, 4, 1);
INSERT INTO `tk_cat` VALUES (546005, '国兰/杂交兰/洋兰类', 10000523, 4, 1);
INSERT INTO `tk_cat` VALUES (546006, '地栽菊类', 10000523, 4, 1);
INSERT INTO `tk_cat` VALUES (546007, '绣球/木绣球', 10000523, 4, 1);
INSERT INTO `tk_cat` VALUES (546008, '月季/蔷薇/玫瑰', 10000523, 4, 1);
INSERT INTO `tk_cat` VALUES (546009, '其他草本花卉', 10000523, 4, 1);
INSERT INTO `tk_cat` VALUES (546010, '其他木本花卉', 10000523, 4, 1);
INSERT INTO `tk_cat` VALUES (546011, '鲜切花', 10000523, 4, 1);
INSERT INTO `tk_cat` VALUES (546012, '果树（苗）', 10000524, 4, 1);
INSERT INTO `tk_cat` VALUES (546013, '行道树（苗）', 10000524, 4, 1);
INSERT INTO `tk_cat` VALUES (546014, '观赏树（苗）', 10000524, 4, 1);
INSERT INTO `tk_cat` VALUES (546015, '奇异莓', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546016, '红毛丹/毛荔枝', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546017, '油柑', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546018, '榴莲蜜/菠萝蜜', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546019, '甜瓜/蜜瓜', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546020, '杏', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546021, '桃', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546022, '李子', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546023, '杨桃', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546024, '杨梅', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546025, '枇杷', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546026, '西柚', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546027, '青枣', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546028, '番石榴/芭乐', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546029, '释迦果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546030, '海棠果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546031, '柿子', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546032, '仙人掌果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546033, '燕窝果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546034, '甘蔗', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546035, '人参果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546036, '雪莲果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546037, '蛇皮沙果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546038, '龙宫果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546039, '无花果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546040, '莲雾', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546041, '新鲜山楂/甜红子', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546042, '橄榄', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546043, '嘉宝果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546044, '西梅', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546045, '蔓越莓', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546046, '树莓', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546047, '黑莓', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546048, '桑葚', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546049, '青梅', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546050, '红参果/红蜜果/红香果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546051, '蛇皮果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546052, '黄皮果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546053, '酸角', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546054, '罗汉果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546055, '姑娘果/灯笼果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546056, '鸡蛋果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546057, '黄晶果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546058, '鸡心果', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546059, '沙棘', 10000157, 3, 1);
INSERT INTO `tk_cat` VALUES (546060, '果干', 10000216, 3, 1);
INSERT INTO `tk_cat` VALUES (546103, '跑步服', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (546104, '运动打底衫', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (546105, '暴汗服', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (546106, '运动polo衫', 10000197, 3, 1);
INSERT INTO `tk_cat` VALUES (546107, '健身衣', 10000526, 4, 1);
INSERT INTO `tk_cat` VALUES (546108, '健身裤', 10000526, 4, 1);
INSERT INTO `tk_cat` VALUES (546109, '健身衣裤套装', 10000526, 4, 1);
INSERT INTO `tk_cat` VALUES (546110, '运动内裤', 10000527, 4, 1);
INSERT INTO `tk_cat` VALUES (546111, '运动文胸', 10000527, 4, 1);
INSERT INTO `tk_cat` VALUES (546112, '运动内衣套装', 10000527, 4, 1);
INSERT INTO `tk_cat` VALUES (546113, '运动袜/户外袜', 10000528, 4, 1);
INSERT INTO `tk_cat` VALUES (546114, '运动帽', 10000528, 4, 1);
INSERT INTO `tk_cat` VALUES (546115, '运动配饰/配件', 10000528, 4, 1);
INSERT INTO `tk_cat` VALUES (546116, '运动单马甲', 10000529, 4, 1);
INSERT INTO `tk_cat` VALUES (546117, '运动棉马甲', 10000529, 4, 1);
INSERT INTO `tk_cat` VALUES (546118, '运动羽绒马甲', 10000529, 4, 1);
INSERT INTO `tk_cat` VALUES (546119, '运动连衣裙', 10000530, 4, 1);
INSERT INTO `tk_cat` VALUES (546120, '运动半身裙', 10000530, 4, 1);
INSERT INTO `tk_cat` VALUES (546121, '运动短裙', 10000530, 4, 1);
INSERT INTO `tk_cat` VALUES (546122, '休闲衣', 10000531, 4, 1);
INSERT INTO `tk_cat` VALUES (546123, '休闲裤', 10000531, 4, 1);
INSERT INTO `tk_cat` VALUES (546124, '休闲衣裤套装', 10000531, 4, 1);
INSERT INTO `tk_cat` VALUES (546125, '工装裤', 10000532, 4, 1);
INSERT INTO `tk_cat` VALUES (546126, '工装裙', 10000532, 4, 1);
INSERT INTO `tk_cat` VALUES (546127, '工装外套', 10000532, 4, 1);
INSERT INTO `tk_cat` VALUES (546128, '工装衬衫', 10000532, 4, 1);
INSERT INTO `tk_cat` VALUES (546129, '冲锋衣', 10000533, 4, 1);
INSERT INTO `tk_cat` VALUES (546130, '冲锋裤', 10000533, 4, 1);
INSERT INTO `tk_cat` VALUES (546131, '冲锋衣裤套装', 10000533, 4, 1);
INSERT INTO `tk_cat` VALUES (546132, '功能内衣套装', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (546133, '抓绒衣', 10000534, 4, 1);
INSERT INTO `tk_cat` VALUES (546134, '抓绒裤', 10000534, 4, 1);
INSERT INTO `tk_cat` VALUES (546135, '抓绒衣裤套装', 10000534, 4, 1);
INSERT INTO `tk_cat` VALUES (546136, '羽绒服', 10000535, 4, 1);
INSERT INTO `tk_cat` VALUES (546137, '羽绒裤', 10000535, 4, 1);
INSERT INTO `tk_cat` VALUES (546138, '羽绒服套装', 10000535, 4, 1);
INSERT INTO `tk_cat` VALUES (546139, '棉衣', 10000536, 4, 1);
INSERT INTO `tk_cat` VALUES (546140, '棉裤', 10000536, 4, 1);
INSERT INTO `tk_cat` VALUES (546141, '棉衣裤套装', 10000536, 4, 1);
INSERT INTO `tk_cat` VALUES (546142, '软壳衣', 10000537, 4, 1);
INSERT INTO `tk_cat` VALUES (546143, '软壳裤', 10000537, 4, 1);
INSERT INTO `tk_cat` VALUES (546144, '软壳衣裤套装', 10000537, 4, 1);
INSERT INTO `tk_cat` VALUES (546145, '速干T恤', 10000538, 4, 1);
INSERT INTO `tk_cat` VALUES (546146, '速干背心', 10000538, 4, 1);
INSERT INTO `tk_cat` VALUES (546147, '速干衬衣', 10000538, 4, 1);
INSERT INTO `tk_cat` VALUES (546148, '速干裤', 10000538, 4, 1);
INSERT INTO `tk_cat` VALUES (546149, '速干衣裤套装', 10000538, 4, 1);
INSERT INTO `tk_cat` VALUES (546150, '防晒裤', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (546151, '高海拔登山靴/攀冰', 10000189, 3, 1);
INSERT INTO `tk_cat` VALUES (546152, '老爹鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (546153, '健步鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (546154, '德训鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (546155, '五指鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (546156, '田径运动鞋', 10000198, 3, 1);
INSERT INTO `tk_cat` VALUES (546157, '运动单肩/斜挎包/健身包', 10000539, 4, 1);
INSERT INTO `tk_cat` VALUES (546158, '运动登山包', 10000539, 4, 1);
INSERT INTO `tk_cat` VALUES (546159, '运动腰包/胸包', 10000539, 4, 1);
INSERT INTO `tk_cat` VALUES (546160, '运动双肩包', 10000539, 4, 1);
INSERT INTO `tk_cat` VALUES (546161, '臂包', 10000539, 4, 1);
INSERT INTO `tk_cat` VALUES (546162, '户外摄影包', 10000539, 4, 1);
INSERT INTO `tk_cat` VALUES (546165, '创意吊饰/挂饰', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546166, '创意门挡', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546167, '礼品盒/包装盒', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546168, '许愿瓶/漂流瓶/幸运星瓶', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546169, '相册/相簿', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546170, '储蓄罐/存钱罐', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546171, '创意贴纸', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546172, '时尚烟灰缸', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546173, '天气瓶/风暴瓶', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546174, '奖杯/奖牌/奖状', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546175, '冰箱贴', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546176, '音乐盒/八音盒/水晶球', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546177, '创意化妆镜', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546178, '钥匙扣', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546179, '布艺创意DIY制品', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546180, '创意帆布包/袋', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546181, '创意伞', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546182, '创意灯/纸雕灯', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546183, '其它创意家居', 10000540, 4, 1);
INSERT INTO `tk_cat` VALUES (546184, '保湿纸巾', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (546185, '马桶垫纸', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (546186, '一次性擦脚纸/巾', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (546187, '棉柔巾/洁面巾', 10000053, 3, 1);
INSERT INTO `tk_cat` VALUES (546191, '手办/模型/毛绒/Q版玩偶', 10000543, 4, 1);
INSERT INTO `tk_cat` VALUES (546192, '字牌', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546193, '将棋', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546194, '川牌', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546195, '扑克', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546196, '抽奖转盘', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546197, '摇号机', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546198, '牌九', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546199, '筹码', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546200, '筹码架/盒', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546201, '骰子/色子', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546202, '麻将', 10000190, 3, 1);
INSERT INTO `tk_cat` VALUES (546293, '鱼糕/鱼饼', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546294, '鱼丸/鱼滑', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546295, '蟹柳/蟹排/蟹味棒', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546296, '虾丸/虾滑', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546297, '猪肉丸类', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546298, '牛肉丸类', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546299, '玉米肠', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546300, '牛肚/牛百叶', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546301, '羊肚', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546302, '鸭血', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546303, '鸭肠', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546304, '小酥肉', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546305, '其他火锅丸料', 10000552, 4, 1);
INSERT INTO `tk_cat` VALUES (546306, '低温香肠/烤肠', 10000553, 4, 1);
INSERT INTO `tk_cat` VALUES (546307, '低温火腿', 10000553, 4, 1);
INSERT INTO `tk_cat` VALUES (546308, '低温培根', 10000553, 4, 1);
INSERT INTO `tk_cat` VALUES (546309, '其他肉制品', 10000553, 4, 1);
INSERT INTO `tk_cat` VALUES (546310, '鲜松茸菌', 10000554, 4, 1);
INSERT INTO `tk_cat` VALUES (546311, '鲜猴头菇', 10000554, 4, 1);
INSERT INTO `tk_cat` VALUES (546312, '鲜羊肚菌', 10000554, 4, 1);
INSERT INTO `tk_cat` VALUES (546313, '鲜鸡枞菌', 10000554, 4, 1);
INSERT INTO `tk_cat` VALUES (546314, '鲜黑松露', 10000554, 4, 1);
INSERT INTO `tk_cat` VALUES (546315, '其他鲜菌菇', 10000554, 4, 1);
INSERT INTO `tk_cat` VALUES (546316, '茄子', 10000555, 4, 1);
INSERT INTO `tk_cat` VALUES (546317, '西红柿/圣女果/番茄', 10000555, 4, 1);
INSERT INTO `tk_cat` VALUES (546318, '秋葵', 10000555, 4, 1);
INSERT INTO `tk_cat` VALUES (546319, '西葫芦', 10000555, 4, 1);
INSERT INTO `tk_cat` VALUES (546320, '冬瓜', 10000555, 4, 1);
INSERT INTO `tk_cat` VALUES (546321, '黄瓜', 10000555, 4, 1);
INSERT INTO `tk_cat` VALUES (546322, '苦瓜', 10000555, 4, 1);
INSERT INTO `tk_cat` VALUES (546323, '南瓜类', 10000555, 4, 1);
INSERT INTO `tk_cat` VALUES (546324, '其他茄瓜果类', 10000555, 4, 1);
INSERT INTO `tk_cat` VALUES (546325, '荸荠/马蹄/地梨', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546326, '红薯/地瓜类', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546327, '萝卜', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546328, '胡萝卜', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546329, '藕/莲子', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546330, '土豆', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546331, '洋葱', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546332, '玉米', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546333, '芋头/芋艿', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546334, '山药/淮山', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546335, '板栗/锥栗', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546336, '花生', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546337, '百合', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546338, '鸡头米/鲜芡实', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546339, '蒜苔', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546340, '其他根茎类', 10000556, 4, 1);
INSERT INTO `tk_cat` VALUES (546341, '葱', 10000557, 4, 1);
INSERT INTO `tk_cat` VALUES (546342, '姜', 10000557, 4, 1);
INSERT INTO `tk_cat` VALUES (546343, '蒜', 10000557, 4, 1);
INSERT INTO `tk_cat` VALUES (546344, '辣椒', 10000557, 4, 1);
INSERT INTO `tk_cat` VALUES (546345, '花椒/麻椒', 10000557, 4, 1);
INSERT INTO `tk_cat` VALUES (546346, '去皮蔬菜', 10000558, 4, 1);
INSERT INTO `tk_cat` VALUES (546347, '方便净菜/配菜', 10000558, 4, 1);
INSERT INTO `tk_cat` VALUES (546348, '笋制品', 10000161, 3, 1);
INSERT INTO `tk_cat` VALUES (546349, '鸡肉卷/牛肉卷类', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (546350, '薯条/薯饼半成品', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (546351, '油条/春卷/油炸类', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (546352, '八宝饭', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (546353, '其他冷藏/冷冻食品', 10000163, 3, 1);
INSERT INTO `tk_cat` VALUES (546354, '素菜制品', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546355, '猪肚鸡', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546356, '椰子鸡', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546357, '牛杂牛肚', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546358, '梅菜扣肉', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546359, '蜜汁叉烧', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546360, '无骨鸡爪', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546361, '东坡肉', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546362, '鱼排/烤鱼', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546363, '蒲烧鳗鱼', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546364, '其他肉禽菜肴', 10000398, 3, 1);
INSERT INTO `tk_cat` VALUES (546365, '鱼类制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546366, '鱿鱼制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546367, '蟹制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546368, '小龙虾制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546369, '虾制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546370, '牛蛙制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546371, '螺制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546372, '甲鱼制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546373, '海蜇制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546374, '海带/紫菜/藻类制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546375, '贝类制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546376, '海参/花胶制品', 10000158, 3, 1);
INSERT INTO `tk_cat` VALUES (546377, '进口海参', 10000560, 4, 1);
INSERT INTO `tk_cat` VALUES (546378, '国产海参', 10000560, 4, 1);
INSERT INTO `tk_cat` VALUES (546379, '紫菜', 10000561, 4, 1);
INSERT INTO `tk_cat` VALUES (546380, '海带', 10000561, 4, 1);
INSERT INTO `tk_cat` VALUES (546381, '其他藻类', 10000561, 4, 1);
INSERT INTO `tk_cat` VALUES (546382, '虾干', 10000562, 4, 1);
INSERT INTO `tk_cat` VALUES (546383, '干贝/瑶柱', 10000562, 4, 1);
INSERT INTO `tk_cat` VALUES (546384, '虾皮/虾米/海米', 10000562, 4, 1);
INSERT INTO `tk_cat` VALUES (546385, '鱼胶/花胶', 10000562, 4, 1);
INSERT INTO `tk_cat` VALUES (546386, '鱼干', 10000562, 4, 1);
INSERT INTO `tk_cat` VALUES (546387, '其他海产干货', 10000562, 4, 1);
INSERT INTO `tk_cat` VALUES (546388, '豆皮', 10000559, 4, 1);
INSERT INTO `tk_cat` VALUES (546389, '香干', 10000559, 4, 1);
INSERT INTO `tk_cat` VALUES (546390, '面筋', 10000559, 4, 1);
INSERT INTO `tk_cat` VALUES (546391, '豆腐', 10000559, 4, 1);
INSERT INTO `tk_cat` VALUES (546392, '其他豆制品', 10000559, 4, 1);
INSERT INTO `tk_cat` VALUES (546393, '鲜活小龙虾', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546394, '鲜活皮皮虾', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546395, '鲜活波士顿龙虾', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546396, '鲜活小青龙', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546397, '鲜活澳洲龙虾', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546398, '其他鲜活虾', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546399, '鲜活螺类', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546400, '鲜活甲鱼', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546401, '鲜活鲍鱼', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546402, '鲜活生蚝', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546403, '鲜活扇贝', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546404, '鲜活蛤蜊', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546405, '其他鲜活贝类', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546406, '鲜活淡水鱼', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546407, '鲜活海鱼', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546408, '鲜活海胆', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546411, '其他鲜活河蟹', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546413, '鲜活青蟹', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546414, '其他鲜活海蟹', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546415, '鲜活帝王蟹', 10000563, 4, 1);
INSERT INTO `tk_cat` VALUES (546416, '冷冻黑虎虾', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546417, '冷冻阿根廷红虾', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546418, '冷冻白虾', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546419, '冷冻虾仁', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546420, '其他冷冻虾', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546421, '冷冻海蜇', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546422, '冷冻帝王蟹', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546424, '冷冻青蟹', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546425, '其他冷冻蟹', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546426, '冷冻珍宝蟹', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546427, '冷冻贝类', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546428, '冷冻鱼类', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546429, '冷冻螺肉', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546430, '冷冻章鱼', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546431, '冷冻牛蛙', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546432, '冷冻海胆', 10000564, 4, 1);
INSERT INTO `tk_cat` VALUES (546433, '黄金工艺品', 10000332, 3, 1);
INSERT INTO `tk_cat` VALUES (546434, '钻石工艺品', 10000334, 3, 1);
INSERT INTO `tk_cat` VALUES (546435, '铂金工艺品', 10000338, 3, 1);
INSERT INTO `tk_cat` VALUES (546436, 'K金工艺品', 10000340, 3, 1);
INSERT INTO `tk_cat` VALUES (546437, '汽油添加剂', 10000129, 3, 1);
INSERT INTO `tk_cat` VALUES (546438, '冲浪板/浆板/帆板', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546439, '脚绳/滑水绳', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546440, '防寒衣/防磨衣', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546441, '救生衣', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546442, '滑水鞋', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546443, '滑水板', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546444, '滑水手套', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546445, '冲浪配件', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546446, '潜水镜', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546447, '浮潜面罩', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546448, '潜水服', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546449, '潜水鞋/靴', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546450, '潜水袜', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546451, '气瓶', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546452, '潜水仪表', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546453, '潜水箱包', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546454, '潜水减压表', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546455, '潜水照明装备', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546456, '潜水配件', 10000565, 4, 1);
INSERT INTO `tk_cat` VALUES (546457, '指南针/温度计/气压计/高度计', 10000566, 4, 1);
INSERT INTO `tk_cat` VALUES (546458, '风速测量仪', 10000566, 4, 1);
INSERT INTO `tk_cat` VALUES (546459, 'GPS/电子导航设备', 10000566, 4, 1);
INSERT INTO `tk_cat` VALUES (546460, '多功能工兵铲', 10000567, 4, 1);
INSERT INTO `tk_cat` VALUES (546461, '多功能伸缩棒', 10000567, 4, 1);
INSERT INTO `tk_cat` VALUES (546462, '多功能工具钳', 10000567, 4, 1);
INSERT INTO `tk_cat` VALUES (546463, '工兵斧/营地斧', 10000567, 4, 1);
INSERT INTO `tk_cat` VALUES (546464, '军刀卡/万能刀卡/瑞士军刀', 10000567, 4, 1);
INSERT INTO `tk_cat` VALUES (546465, '磨刀护刀工具', 10000567, 4, 1);
INSERT INTO `tk_cat` VALUES (546466, '伞绳', 10000567, 4, 1);
INSERT INTO `tk_cat` VALUES (546467, '户外迷你充气泵', 10000567, 4, 1);
INSERT INTO `tk_cat` VALUES (546468, '手电筒/信号灯', 10000568, 4, 1);
INSERT INTO `tk_cat` VALUES (546469, '户外照明配件', 10000568, 4, 1);
INSERT INTO `tk_cat` VALUES (546470, '救援绳/逃生绳', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546471, '便携压缩保温毯', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546472, '求生哨', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546473, '担架/折叠担架', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546474, '救生圈', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546475, '应急工具', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546476, '求生锯/绳锯/线锯', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546477, '防护面罩（非医用）', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546478, '信号镜', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546479, '救生棒/荧光棒', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546480, '防身报警器', 10000569, 4, 1);
INSERT INTO `tk_cat` VALUES (546481, '天文望远镜', 10000570, 4, 1);
INSERT INTO `tk_cat` VALUES (546482, '数码望远镜', 10000570, 4, 1);
INSERT INTO `tk_cat` VALUES (546483, '垂钓望远镜', 10000570, 4, 1);
INSERT INTO `tk_cat` VALUES (546484, '红外夜视仪', 10000570, 4, 1);
INSERT INTO `tk_cat` VALUES (546485, '激光测距望远镜', 10000570, 4, 1);
INSERT INTO `tk_cat` VALUES (546486, '下降器/保护器', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546487, '上升器', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546488, '登山杖/手杖', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546489, '登山绳/攀岩绳', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546490, '登山扣', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546491, '安全带', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546492, '攀岩鞋', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546493, '攀岩锁具', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546494, '冰爪', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546495, '冰锥', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546496, '冰镐', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546497, '登山攀岩配件装备', 10000571, 4, 1);
INSERT INTO `tk_cat` VALUES (546498, '台钓竿', 10000572, 4, 1);
INSERT INTO `tk_cat` VALUES (546499, '路亚竿', 10000572, 4, 1);
INSERT INTO `tk_cat` VALUES (546500, '溪流竿', 10000572, 4, 1);
INSERT INTO `tk_cat` VALUES (546501, '冰钓竿', 10000572, 4, 1);
INSERT INTO `tk_cat` VALUES (546502, '鱼竿套装', 10000572, 4, 1);
INSERT INTO `tk_cat` VALUES (546503, '下水连体服', 10000573, 4, 1);
INSERT INTO `tk_cat` VALUES (546504, '背带防水裤', 10000573, 4, 1);
INSERT INTO `tk_cat` VALUES (546505, '钓鱼鞋', 10000573, 4, 1);
INSERT INTO `tk_cat` VALUES (546506, '钓鱼桶', 10000574, 4, 1);
INSERT INTO `tk_cat` VALUES (546507, '抄鱼网', 10000574, 4, 1);
INSERT INTO `tk_cat` VALUES (546508, '路亚钳', 10000574, 4, 1);
INSERT INTO `tk_cat` VALUES (546509, '虾笼', 10000574, 4, 1);
INSERT INTO `tk_cat` VALUES (546510, '鱼钩', 10000187, 3, 1);
INSERT INTO `tk_cat` VALUES (546539, '文房四宝', 10000168, 3, 1);
INSERT INTO `tk_cat` VALUES (546542, '跳蛋', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546543, '震动棒', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546544, '仿真阳具', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546545, '电动飞机杯', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546546, '手动飞机杯', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546547, '充气娃娃', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546548, '实体娃娃', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546549, '阴臀倒膜', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546550, '调情香水', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546551, '情趣道具', 10000577, 3, 1);
INSERT INTO `tk_cat` VALUES (546553, '情趣内裤', 10000576, 3, 1);
INSERT INTO `tk_cat` VALUES (546554, '情趣配饰', 10000576, 3, 1);
INSERT INTO `tk_cat` VALUES (546555, '情趣睡衣', 10000576, 3, 1);
INSERT INTO `tk_cat` VALUES (546556, '情趣丝袜', 10000576, 3, 1);
INSERT INTO `tk_cat` VALUES (546557, '情趣文胸', 10000576, 3, 1);
INSERT INTO `tk_cat` VALUES (546558, '情趣内衣套装', 10000576, 3, 1);
INSERT INTO `tk_cat` VALUES (546559, '情趣制服/COS套装', 10000576, 3, 1);
INSERT INTO `tk_cat` VALUES (546560, '会员实体卡', 10000364, 3, 1);
INSERT INTO `tk_cat` VALUES (546561, '家用杀虫剂', 10000578, 4, 1);
INSERT INTO `tk_cat` VALUES (546562, '防霉防蛀片剂', 10000578, 4, 1);
INSERT INTO `tk_cat` VALUES (546563, '大米防虫剂', 10000578, 4, 1);
INSERT INTO `tk_cat` VALUES (546564, '盘香/灭蟑香/蚊香盘', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546565, '蚊香液/蚊香片', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546566, '电蚊香套装', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546567, '蚊香加热器', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546568, '驱蚊湿巾', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546569, '驱蚊扣/挂件', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546570, '防蚊贴/防蚊手环', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546571, '驱蚊草凝胶', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546572, '驱蚊剂/喷雾/走珠', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546573, '花露水', 10000579, 4, 1);
INSERT INTO `tk_cat` VALUES (546574, '除螨凝胶/除螨喷雾', 10000580, 4, 1);
INSERT INTO `tk_cat` VALUES (546575, '祛螨包/除螨垫/除螨贴', 10000580, 4, 1);
INSERT INTO `tk_cat` VALUES (546576, '捕蝇剂', 10000581, 4, 1);
INSERT INTO `tk_cat` VALUES (546577, '粘蝇纸', 10000581, 4, 1);
INSERT INTO `tk_cat` VALUES (546578, '苍蝇拍', 10000581, 4, 1);
INSERT INTO `tk_cat` VALUES (546579, '少儿球类', 10000582, 4, 1);
INSERT INTO `tk_cat` VALUES (546580, '少儿武术搏击', 10000582, 4, 1);
INSERT INTO `tk_cat` VALUES (546581, '少儿舞蹈', 10000582, 4, 1);
INSERT INTO `tk_cat` VALUES (546582, '少儿音乐', 10000582, 4, 1);
INSERT INTO `tk_cat` VALUES (546583, '少儿书法', 10000582, 4, 1);
INSERT INTO `tk_cat` VALUES (546584, '少儿绘画', 10000582, 4, 1);
INSERT INTO `tk_cat` VALUES (546585, '少儿棋类', 10000582, 4, 1);
INSERT INTO `tk_cat` VALUES (546586, '花艺培训', 10000348, 3, 1);
INSERT INTO `tk_cat` VALUES (546587, '成人棋类', 10000316, 3, 1);
INSERT INTO `tk_cat` VALUES (546588, '保鲜盒/密封罐', 10000583, 4, 1);
INSERT INTO `tk_cat` VALUES (546589, '保鲜盖', 10000583, 4, 1);
INSERT INTO `tk_cat` VALUES (546590, '保温袋', 10000583, 4, 1);
INSERT INTO `tk_cat` VALUES (546591, '手动打蛋器', 10000584, 4, 1);
INSERT INTO `tk_cat` VALUES (546592, '烘焙量勺量杯', 10000584, 4, 1);
INSERT INTO `tk_cat` VALUES (546593, '烘焙用纸', 10000584, 4, 1);
INSERT INTO `tk_cat` VALUES (546594, '蛋清分离器', 10000584, 4, 1);
INSERT INTO `tk_cat` VALUES (546595, '烘焙刮板', 10000584, 4, 1);
INSERT INTO `tk_cat` VALUES (546596, '烘焙烤盘', 10000584, 4, 1);
INSERT INTO `tk_cat` VALUES (546597, '烘焙模具', 10000584, 4, 1);
INSERT INTO `tk_cat` VALUES (546598, '其他烧烤用具', 10000585, 4, 1);
INSERT INTO `tk_cat` VALUES (546599, '烧烤笼', 10000585, 4, 1);
INSERT INTO `tk_cat` VALUES (546600, '烧烤刷', 10000585, 4, 1);
INSERT INTO `tk_cat` VALUES (546601, '糖缸', 10000021, 3, 1);
INSERT INTO `tk_cat` VALUES (546602, '奶罐', 10000021, 3, 1);
INSERT INTO `tk_cat` VALUES (546603, '玻璃杯', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546604, '保温壶', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546605, '保温杯', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546606, '焖烧杯', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546607, '陶瓷/马克杯', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546608, '塑料杯', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546609, '杯具套装', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546610, '智能水杯', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546612, '冷水壶', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546613, '户外水杯', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546614, '隔热杯', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546615, '运动水壶', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546616, '水具配件', 10000586, 4, 1);
INSERT INTO `tk_cat` VALUES (546617, '酒具配件', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546618, '酒架', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546619, '酒盒', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546620, '酒杯', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546621, '家用酒壶', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546622, '挤柠檬器', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546623, '分酒器', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546624, '调酒器', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546625, '不锈钢冰块', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546626, '冰桶', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546627, '冰夹', 10000587, 4, 1);
INSERT INTO `tk_cat` VALUES (546628, '一次性签子', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546629, '塑杯', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546630, '纸杯', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546631, '保鲜膜/袋', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546632, '一次性手套', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546633, '一次性桌布', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546634, '一次性筷子', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546635, '可降解餐具/环保餐具', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546636, '一次性碗/碟/盘', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546637, '一次性餐桌用品套装', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546638, '食物吸油纸/膜', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546639, '一次性过滤袋/调料袋', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546640, '一次性勺子', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546641, '一次性吸管', 10000588, 4, 1);
INSERT INTO `tk_cat` VALUES (546643, '闻香杯', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546644, '飘逸杯', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546645, '旅行茶具', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546646, '花草茶具', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546647, '功夫茶具', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546648, '公道杯', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546649, '盖碗', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546650, '茶叶罐', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546651, '茶具架', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546652, '茶壶', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546653, '茶道配件', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546654, '茶杯', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546655, '茶具套装', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546656, '煮茶炉', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546657, '煮茶炭', 10000589, 3, 1);
INSERT INTO `tk_cat` VALUES (546659, '汤勺', 10000590, 3, 1);
INSERT INTO `tk_cat` VALUES (546660, '漏勺', 10000590, 3, 1);
INSERT INTO `tk_cat` VALUES (546661, '锅铲', 10000590, 3, 1);
INSERT INTO `tk_cat` VALUES (546662, '饭勺', 10000590, 3, 1);
INSERT INTO `tk_cat` VALUES (546663, '烹饪工具套装', 10000590, 3, 1);
INSERT INTO `tk_cat` VALUES (546664, '手串', 10000393, 3, 1);
INSERT INTO `tk_cat` VALUES (546665, '吊坠', 10000393, 3, 1);
INSERT INTO `tk_cat` VALUES (546666, '把件', 10000393, 3, 1);
INSERT INTO `tk_cat` VALUES (546667, '手串', 10000402, 3, 1);
INSERT INTO `tk_cat` VALUES (546668, '吊坠', 10000402, 3, 1);
INSERT INTO `tk_cat` VALUES (546669, '把件', 10000402, 3, 1);
INSERT INTO `tk_cat` VALUES (546670, '手串', 10000369, 3, 1);
INSERT INTO `tk_cat` VALUES (546671, '吊坠', 10000369, 3, 1);
INSERT INTO `tk_cat` VALUES (546672, '把件', 10000369, 3, 1);
INSERT INTO `tk_cat` VALUES (546673, '手串', 10000403, 3, 1);
INSERT INTO `tk_cat` VALUES (546674, '吊坠', 10000403, 3, 1);
INSERT INTO `tk_cat` VALUES (546675, '把件', 10000403, 3, 1);
INSERT INTO `tk_cat` VALUES (546676, '手串', 10000399, 3, 1);
INSERT INTO `tk_cat` VALUES (546677, '吊坠', 10000399, 3, 1);
INSERT INTO `tk_cat` VALUES (546678, '把件', 10000399, 3, 1);
INSERT INTO `tk_cat` VALUES (546680, '文化创意胸针', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546681, '文化创意项链', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546682, '文化创意手绳/手环', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546683, '文化创意耳饰', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546684, '文化创意冰箱贴', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546685, '文化创意挂件/钥匙扣', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546686, '文化创意镜子', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546687, '文化创意装饰画', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546688, '文化创意抱枕', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546689, '文化创意毯子', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546690, '文化创意扇/伞', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546691, '文化创意毛绒玩偶', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546692, '文化创意礼盒', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546693, '文化创意香薰摆件/香料', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546694, '文化创意胶带/贴纸', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546695, '文化创意徽章', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546696, '文化创意明信片/信封', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546697, '文化创意日历', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546698, '文化创意书签', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546699, '文化创意衫', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546700, '文化创意帽子', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546701, '文化创意鞋', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546702, '文化创意包/袋', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546703, '文化创意餐具', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546704, '文化创意杯垫/餐垫', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546705, '文化创意灯', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546706, '文化创意加湿器', 10000591, 3, 1);
INSERT INTO `tk_cat` VALUES (546708, '吊坠/项链', 10000592, 3, 1);
INSERT INTO `tk_cat` VALUES (546709, '手镯/手链/脚链', 10000592, 3, 1);
INSERT INTO `tk_cat` VALUES (546710, '戒指', 10000592, 3, 1);
INSERT INTO `tk_cat` VALUES (546711, '耳饰', 10000592, 3, 1);
INSERT INTO `tk_cat` VALUES (546712, '胸针', 10000592, 3, 1);
INSERT INTO `tk_cat` VALUES (546713, '工艺品', 10000592, 3, 1);
INSERT INTO `tk_cat` VALUES (10000001, '个人护理', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000002, '口腔护理', 10000001, 2, 0);
INSERT INTO `tk_cat` VALUES (10000003, '女性护理', 10000001, 2, 0);
INSERT INTO `tk_cat` VALUES (10000004, '洗发护发', 10000001, 2, 0);
INSERT INTO `tk_cat` VALUES (10000005, '美发假发/造型', 10000001, 2, 0);
INSERT INTO `tk_cat` VALUES (10000006, '身体护理', 10000001, 2, 0);
INSERT INTO `tk_cat` VALUES (10000007, '农资园艺', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000008, '养殖器具', 10000007, 2, 0);
INSERT INTO `tk_cat` VALUES (10000010, '农膜遮网/大棚', 10000007, 2, 0);
INSERT INTO `tk_cat` VALUES (10000012, '园林/农耕', 10000007, 2, 0);
INSERT INTO `tk_cat` VALUES (10000013, '园艺用品', 10000007, 2, 0);
INSERT INTO `tk_cat` VALUES (10000014, '种子', 10000007, 2, 0);
INSERT INTO `tk_cat` VALUES (10000015, '肥料', 10000007, 2, 0);
INSERT INTO `tk_cat` VALUES (10000016, '花卉绿植', 10000007, 2, 0);
INSERT INTO `tk_cat` VALUES (10000017, '饲料', 10000007, 2, 0);
INSERT INTO `tk_cat` VALUES (10000018, '厨具', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000019, '刀剪菜板', 10000018, 2, 0);
INSERT INTO `tk_cat` VALUES (10000020, '厨房配件', 10000018, 2, 0);
INSERT INTO `tk_cat` VALUES (10000021, '咖啡具', 10000018, 2, 0);
INSERT INTO `tk_cat` VALUES (10000022, '水具酒具', 10000018, 2, 0);
INSERT INTO `tk_cat` VALUES (10000023, '烹饪锅具', 10000018, 2, 0);
INSERT INTO `tk_cat` VALUES (10000024, '酒店用品', 10000018, 2, 0);
INSERT INTO `tk_cat` VALUES (10000025, '餐具', 10000018, 2, 0);
INSERT INTO `tk_cat` VALUES (10000026, '宠物生活', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000027, '宠物主粮', 10000026, 2, 0);
INSERT INTO `tk_cat` VALUES (10000028, '宠物零食', 10000026, 2, 0);
INSERT INTO `tk_cat` VALUES (10000029, '洗护美容', 10000026, 2, 0);
INSERT INTO `tk_cat` VALUES (10000030, '宠物出行', 10000026, 2, 0);
INSERT INTO `tk_cat` VALUES (10000031, '宠物日用', 10000026, 2, 0);
INSERT INTO `tk_cat` VALUES (10000032, '宠物玩具', 10000026, 2, 0);
INSERT INTO `tk_cat` VALUES (10000033, '家具', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000034, '书房家具', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000035, '储物家具', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000036, '儿童家具', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000037, '卧室家具', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000038, '商业办公', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000039, '城市家具', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000040, '套房家具', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000041, '定制家具', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000042, '客厅家具', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000044, '阳台/户外', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000045, '餐厅家具', 10000033, 2, 0);
INSERT INTO `tk_cat` VALUES (10000046, '家居日用', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000047, '家装软饰', 10000046, 2, 0);
INSERT INTO `tk_cat` VALUES (10000048, '收纳用品', 10000046, 2, 0);
INSERT INTO `tk_cat` VALUES (10000049, '生活日用', 10000046, 2, 0);
INSERT INTO `tk_cat` VALUES (10000050, '家庭清洁/纸品', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000051, '家庭环境清洁', 10000050, 2, 0);
INSERT INTO `tk_cat` VALUES (10000052, '清洁用具', 10000050, 2, 0);
INSERT INTO `tk_cat` VALUES (10000053, '清洁纸品', 10000050, 2, 0);
INSERT INTO `tk_cat` VALUES (10000054, '皮具护理', 10000050, 2, 0);
INSERT INTO `tk_cat` VALUES (10000055, '衣物清洁', 10000050, 2, 0);
INSERT INTO `tk_cat` VALUES (10000056, '驱蚊驱虫', 10000050, 2, 0);
INSERT INTO `tk_cat` VALUES (10000057, '家用电器', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000058, '个护健康', 10000057, 2, 0);
INSERT INTO `tk_cat` VALUES (10000059, '厨卫大电', 10000057, 2, 0);
INSERT INTO `tk_cat` VALUES (10000060, '厨房小电', 10000057, 2, 0);
INSERT INTO `tk_cat` VALUES (10000061, '商用电器', 10000057, 2, 0);
INSERT INTO `tk_cat` VALUES (10000062, '大家电', 10000057, 2, 0);
INSERT INTO `tk_cat` VALUES (10000063, '家电配件', 10000057, 2, 0);
INSERT INTO `tk_cat` VALUES (10000064, '生活电器', 10000057, 2, 0);
INSERT INTO `tk_cat` VALUES (10000065, '视听影音', 10000057, 2, 0);
INSERT INTO `tk_cat` VALUES (10000066, '家纺', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000067, '居家布艺', 10000066, 2, 0);
INSERT INTO `tk_cat` VALUES (10000068, '床上用品', 10000066, 2, 0);
INSERT INTO `tk_cat` VALUES (10000069, '家装建材', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000070, '五金工具', 10000069, 2, 0);
INSERT INTO `tk_cat` VALUES (10000071, '厨房卫浴', 10000069, 2, 0);
INSERT INTO `tk_cat` VALUES (10000072, '基建材料', 10000069, 2, 0);
INSERT INTO `tk_cat` VALUES (10000073, '基建辅助设施', 10000069, 2, 0);
INSERT INTO `tk_cat` VALUES (10000074, '墙地面材料', 10000069, 2, 0);
INSERT INTO `tk_cat` VALUES (10000075, '灯饰照明', 10000069, 2, 0);
INSERT INTO `tk_cat` VALUES (10000076, '电工电料', 10000069, 2, 0);
INSERT INTO `tk_cat` VALUES (10000077, '装饰材料', 10000069, 2, 0);
INSERT INTO `tk_cat` VALUES (10000099, '手机通讯', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000101, '手机', 10000099, 2, 0);
INSERT INTO `tk_cat` VALUES (10000102, '手机配件', 10000099, 2, 0);
INSERT INTO `tk_cat` VALUES (10000104, '数码', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000105, '影音娱乐', 10000104, 2, 0);
INSERT INTO `tk_cat` VALUES (10000106, '摄影摄像', 10000104, 2, 0);
INSERT INTO `tk_cat` VALUES (10000108, '数码配件', 10000104, 2, 0);
INSERT INTO `tk_cat` VALUES (10000109, '智能设备', 10000104, 2, 0);
INSERT INTO `tk_cat` VALUES (10000110, '电子教育', 10000104, 2, 0);
INSERT INTO `tk_cat` VALUES (10000111, '服饰内衣', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000112, '内衣', 10000111, 2, 0);
INSERT INTO `tk_cat` VALUES (10000113, '女装', 10000111, 2, 0);
INSERT INTO `tk_cat` VALUES (10000114, '服饰配件', 10000111, 2, 0);
INSERT INTO `tk_cat` VALUES (10000115, '男装', 10000111, 2, 0);
INSERT INTO `tk_cat` VALUES (10000116, '母婴', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000117, '喂养用品', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000118, '妈妈专区', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000119, '婴童寝居', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000120, '安全座椅', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000121, '尿裤湿巾', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000122, '洗护用品', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000123, '童装', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000124, '童车童床', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000125, '童鞋', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000126, '汽车', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000127, '安全自驾', 10000126, 2, 0);
INSERT INTO `tk_cat` VALUES (10000128, '汽车装饰', 10000126, 2, 0);
INSERT INTO `tk_cat` VALUES (10000129, '维修保养', 10000126, 2, 0);
INSERT INTO `tk_cat` VALUES (10000130, '美容清洗', 10000126, 2, 0);
INSERT INTO `tk_cat` VALUES (10000131, '车载电器', 10000126, 2, 0);
INSERT INTO `tk_cat` VALUES (10000132, '玩具乐器', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000133, 'STEAM教玩具', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000134, '乐器配件', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000135, '健身玩具', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000136, '其它乐器', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000137, '创意减压', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000138, '娃娃玩具', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000139, '模型玩具', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000140, '毛绒布艺', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000141, '民族吹奏乐器', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000142, '民族弹拨乐器', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000143, '民族打击乐器', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000144, '民族拉弦乐器', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000145, '潮玩/动漫', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000146, '益智玩具', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000147, '积木拼插', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000148, '绘画/DIY', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000149, '西洋弦乐器', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000150, '西洋打击乐器', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000151, '西洋管乐器', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000153, '遥控/电动', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000154, '键盘乐器', 10000132, 2, 0);
INSERT INTO `tk_cat` VALUES (10000155, '生鲜', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000156, '乳品冷饮', 10000155, 2, 0);
INSERT INTO `tk_cat` VALUES (10000157, '水果', 10000155, 2, 0);
INSERT INTO `tk_cat` VALUES (10000158, '海鲜水产', 10000155, 2, 0);
INSERT INTO `tk_cat` VALUES (10000159, '猪牛羊肉', 10000155, 2, 0);
INSERT INTO `tk_cat` VALUES (10000160, '禽肉蛋品', 10000155, 2, 0);
INSERT INTO `tk_cat` VALUES (10000161, '蔬菜', 10000155, 2, 0);
INSERT INTO `tk_cat` VALUES (10000162, '速食熟食', 10000155, 2, 0);
INSERT INTO `tk_cat` VALUES (10000163, '面点烘焙', 10000155, 2, 0);
INSERT INTO `tk_cat` VALUES (10000164, '电脑、办公', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000165, '办公耗材', 10000164, 2, 0);
INSERT INTO `tk_cat` VALUES (10000166, '办公设备', 10000164, 2, 0);
INSERT INTO `tk_cat` VALUES (10000167, '外设产品', 10000164, 2, 0);
INSERT INTO `tk_cat` VALUES (10000168, '文具', 10000164, 2, 0);
INSERT INTO `tk_cat` VALUES (10000169, '游戏设备', 10000164, 2, 0);
INSERT INTO `tk_cat` VALUES (10000170, '电脑整机', 10000164, 2, 0);
INSERT INTO `tk_cat` VALUES (10000171, '电脑组件', 10000164, 2, 0);
INSERT INTO `tk_cat` VALUES (10000172, '网络产品', 10000164, 2, 0);
INSERT INTO `tk_cat` VALUES (10000173, '箱包皮具', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000174, '功能箱包', 10000173, 2, 0);
INSERT INTO `tk_cat` VALUES (10000175, '潮流女包', 10000173, 2, 0);
INSERT INTO `tk_cat` VALUES (10000176, '箱包皮具配件', 10000173, 2, 0);
INSERT INTO `tk_cat` VALUES (10000177, '精品男包', 10000173, 2, 0);
INSERT INTO `tk_cat` VALUES (10000178, '美妆护肤', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000179, '男士面部护肤', 10000178, 2, 0);
INSERT INTO `tk_cat` VALUES (10000180, '美妆工具', 10000178, 2, 0);
INSERT INTO `tk_cat` VALUES (10000181, '面部护肤', 10000178, 2, 0);
INSERT INTO `tk_cat` VALUES (10000182, '香水彩妆', 10000178, 2, 0);
INSERT INTO `tk_cat` VALUES (10000183, '运动户外', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000184, '体育用品', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000185, '健身训练', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000186, '冰上运动', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000187, '垂钓用品', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000188, '户外装备', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000189, '户外鞋服', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000190, '棋牌麻将', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000191, '武术搏击', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000192, '游泳用品', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000193, '滑雪运动', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000194, '瑜伽舞蹈', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000195, '轮滑滑板', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000196, '运动护具', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000197, '运动服饰', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000198, '运动鞋包', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000199, '马术/民俗运动', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000200, '骑行运动', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000201, '酒类', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000202, '啤酒', 10000201, 2, 0);
INSERT INTO `tk_cat` VALUES (10000204, '洋酒', 10000201, 2, 0);
INSERT INTO `tk_cat` VALUES (10000205, '白酒', 10000201, 2, 0);
INSERT INTO `tk_cat` VALUES (10000206, '葡萄酒', 10000201, 2, 0);
INSERT INTO `tk_cat` VALUES (10000207, '黄酒/米酒/露酒/养生酒', 10000201, 2, 0);
INSERT INTO `tk_cat` VALUES (10000208, '钟表', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000209, '时钟', 10000208, 2, 0);
INSERT INTO `tk_cat` VALUES (10000210, '腕表', 10000208, 2, 0);
INSERT INTO `tk_cat` VALUES (10000211, '钟表配件', 10000208, 2, 0);
INSERT INTO `tk_cat` VALUES (10000212, '鞋靴', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000213, '时尚女鞋', 10000212, 2, 0);
INSERT INTO `tk_cat` VALUES (10000214, '流行男鞋', 10000212, 2, 0);
INSERT INTO `tk_cat` VALUES (10000215, '食品饮料', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000216, '休闲食品', 10000215, 2, 0);
INSERT INTO `tk_cat` VALUES (10000218, '粮油调味', 10000215, 2, 0);
INSERT INTO `tk_cat` VALUES (10000219, '茗茶', 10000215, 2, 0);
INSERT INTO `tk_cat` VALUES (10000220, '进口食品', 10000215, 2, 0);
INSERT INTO `tk_cat` VALUES (10000222, '饮料冲调', 10000215, 2, 0);
INSERT INTO `tk_cat` VALUES (10000223, '经济', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000224, '育儿/家教', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000225, '旅游/地图', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000226, '社会科学', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000227, '医学', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000228, '中小学教辅', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000229, '烹饪/美食', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000230, '时尚/美妆', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000231, '娱乐/休闲', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000232, '绘画', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000233, '摄影', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000234, '动漫/卡通', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000235, '管理', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000236, '励志与成功', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000237, '文化', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000238, '工业技术', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000239, '外语学习', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000240, '科普读物', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000241, '电子与通信', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000242, '大中专教材教辅', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000243, '孕产/胎教', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000244, '小说', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000245, '文学', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000246, '健身与保健', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000247, '历史', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000248, '哲学/宗教', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000249, '心理学', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000250, '计算机/互联网', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000251, '传记', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000252, '国学/古籍', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000253, '科学与自然', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000254, '考试', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000255, '音乐', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000257, '图书', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000258, '农业/林业', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000259, '文化用品', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000260, '书法', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000261, '艺术', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000262, '金融与投资', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000263, '军事/政治', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000264, '法律', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000265, '建筑', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000266, '体育/运动', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000267, '字典词典/工具书', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000268, '杂志/期刊', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000269, '家居', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000316, '生活兴趣', 10000349, 2, 0);
INSERT INTO `tk_cat` VALUES (10000318, '水族', 10000026, 2, 0);
INSERT INTO `tk_cat` VALUES (10000319, '异宠用品', 10000026, 2, 0);
INSERT INTO `tk_cat` VALUES (10000320, '宠物保健', 10000026, 2, 0);
INSERT INTO `tk_cat` VALUES (10000322, '奶粉', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000323, '营养辅食', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000327, '传统滋补', 10000215, 2, 0);
INSERT INTO `tk_cat` VALUES (10000331, '珠宝首饰', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000332, '黄金', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000333, '银饰', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000334, '钻石', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000335, '翡翠', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000336, '水晶玛瑙', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000337, '彩宝', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000338, '铂金', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000339, '珍珠', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000340, 'K金饰品', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000341, '和田玉', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000342, '其它玉石', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000346, '时尚饰品', 10000331, 2, 0);
INSERT INTO `tk_cat` VALUES (10000348, '学历资格/职业技能培训', 10000349, 2, 0);
INSERT INTO `tk_cat` VALUES (10000349, '教育培训', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000351, '青少年素质教育', 10000349, 2, 0);
INSERT INTO `tk_cat` VALUES (10000357, '报纸', 10000257, 2, 0);
INSERT INTO `tk_cat` VALUES (10000358, '其他', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000364, '会员卡券', 10000358, 2, 0);
INSERT INTO `tk_cat` VALUES (10000368, '童装内衣裤', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000369, '小叶紫檀', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000370, '紫砂', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000376, '童鞋配件', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000377, '情感心理', 10000349, 2, 0);
INSERT INTO `tk_cat` VALUES (10000378, '铜器', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000379, '语言培训', 10000349, 2, 0);
INSERT INTO `tk_cat` VALUES (10000380, '学习/读书卡', 10000349, 2, 0);
INSERT INTO `tk_cat` VALUES (10000383, '陶瓷', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000384, '文玩杂项', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000387, '个护仪器', 10000001, 2, 0);
INSERT INTO `tk_cat` VALUES (10000390, '童装户外服饰', 10000116, 2, 0);
INSERT INTO `tk_cat` VALUES (10000391, '纺染织绣', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000393, '黄花梨', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000394, '建盏', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000397, '其他配饰', 10000111, 2, 0);
INSERT INTO `tk_cat` VALUES (10000398, '半成品菜/方便菜', 10000155, 2, 0);
INSERT INTO `tk_cat` VALUES (10000399, '核桃', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000400, '文房用品', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000401, '书法/绘画', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000402, '金丝楠木', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000403, '菩提', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000405, '文玩文创', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000408, '创业理财', 10000349, 2, 0);
INSERT INTO `tk_cat` VALUES (10000410, '线上教辅', 10000349, 2, 0);
INSERT INTO `tk_cat` VALUES (10000452, '车厘子/樱桃', 10000157, 3, 0);
INSERT INTO `tk_cat` VALUES (10000453, '榴莲', 10000157, 3, 0);
INSERT INTO `tk_cat` VALUES (10000454, '白兰地/干邑', 10000204, 3, 0);
INSERT INTO `tk_cat` VALUES (10000455, '威士忌', 10000204, 3, 0);
INSERT INTO `tk_cat` VALUES (10000457, '香薰蜡烛', 10000047, 3, 0);
INSERT INTO `tk_cat` VALUES (10000458, '凉席', 10000068, 3, 0);
INSERT INTO `tk_cat` VALUES (10000459, '坐垫', 10000067, 3, 0);
INSERT INTO `tk_cat` VALUES (10000460, '抱枕靠垫', 10000067, 3, 0);
INSERT INTO `tk_cat` VALUES (10000461, '桌布/罩件', 10000067, 3, 0);
INSERT INTO `tk_cat` VALUES (10000462, '毛巾/浴巾/浴袍', 10000067, 3, 0);
INSERT INTO `tk_cat` VALUES (10000463, '窗帘门帘及配件', 10000067, 3, 0);
INSERT INTO `tk_cat` VALUES (10000464, '居家鞋/凉拖/棉拖', 10000067, 3, 0);
INSERT INTO `tk_cat` VALUES (10000465, '地毯/地垫', 10000067, 3, 0);
INSERT INTO `tk_cat` VALUES (10000466, '被子', 10000068, 3, 0);
INSERT INTO `tk_cat` VALUES (10000467, '枕头', 10000068, 3, 0);
INSERT INTO `tk_cat` VALUES (10000468, '床品套件', 10000068, 3, 0);
INSERT INTO `tk_cat` VALUES (10000469, '床品配件', 10000068, 3, 0);
INSERT INTO `tk_cat` VALUES (10000470, '参类滋补品', 10000327, 3, 0);
INSERT INTO `tk_cat` VALUES (10000471, '燕窝', 10000327, 3, 0);
INSERT INTO `tk_cat` VALUES (10000477, '裤装', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000478, '毛衫', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000479, '大码男装', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000480, '皮衣', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000481, '西服', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000482, '马甲', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000483, '男装套装', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000484, '大衣', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000485, '传统服饰', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000486, '中老年男装', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000487, '外套', 10000115, 3, 0);
INSERT INTO `tk_cat` VALUES (10000488, '袜子', 10000112, 3, 0);
INSERT INTO `tk_cat` VALUES (10000489, '保暖内衣', 10000112, 3, 0);
INSERT INTO `tk_cat` VALUES (10000490, '内衣配件', 10000112, 3, 0);
INSERT INTO `tk_cat` VALUES (10000491, '塑身美体', 10000112, 3, 0);
INSERT INTO `tk_cat` VALUES (10000492, '女式内衣', 10000112, 3, 0);
INSERT INTO `tk_cat` VALUES (10000493, '内裤', 10000112, 3, 0);
INSERT INTO `tk_cat` VALUES (10000494, '睡衣/家居服', 10000112, 3, 0);
INSERT INTO `tk_cat` VALUES (10000495, '汽车充电装备', 10000131, 3, 0);
INSERT INTO `tk_cat` VALUES (10000496, '车载生活电器', 10000131, 3, 0);
INSERT INTO `tk_cat` VALUES (10000497, '露营用品', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000498, '帐篷/天幕/垫子', 10000497, 3, 0);
INSERT INTO `tk_cat` VALUES (10000500, '帐篷配件', 10000497, 3, 0);
INSERT INTO `tk_cat` VALUES (10000501, '露营收纳用品', 10000497, 3, 0);
INSERT INTO `tk_cat` VALUES (10000502, '户外休闲家具', 10000497, 3, 0);
INSERT INTO `tk_cat` VALUES (10000503, '露营灯具', 10000497, 3, 0);
INSERT INTO `tk_cat` VALUES (10000504, '户外野餐用品', 10000497, 3, 0);
INSERT INTO `tk_cat` VALUES (10000505, '户外电源', 10000497, 3, 0);
INSERT INTO `tk_cat` VALUES (10000506, '烧烤用品', 10000183, 2, 0);
INSERT INTO `tk_cat` VALUES (10000507, '烧烤用具', 10000506, 3, 0);
INSERT INTO `tk_cat` VALUES (10000508, '保健食品/膳食营养补充食品', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000509, '保健食品', 10000508, 2, 0);
INSERT INTO `tk_cat` VALUES (10000510, '普通膳食营养补充食品', 10000508, 2, 0);
INSERT INTO `tk_cat` VALUES (10000511, '蛋白粉/氨基酸/胶原蛋白', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000512, '动物精华/提取物', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000513, '运动营养食品', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000514, '海洋生物类', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000515, '菌/菇/酵素', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000516, '膳食纤维/碳水化合物', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000517, '维生素/矿物质/钙铁锌硒', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000518, '脂肪酸/脂类', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000519, '植物精华/提取物', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000520, '其他膳食营养补充食品', 10000510, 3, 0);
INSERT INTO `tk_cat` VALUES (10000521, '果酒', 10000201, 2, 0);
INSERT INTO `tk_cat` VALUES (10000522, '绿植盆栽', 10000016, 3, 0);
INSERT INTO `tk_cat` VALUES (10000523, '花卉', 10000016, 3, 0);
INSERT INTO `tk_cat` VALUES (10000524, '苗木', 10000016, 3, 0);
INSERT INTO `tk_cat` VALUES (10000526, '健身服', 10000197, 3, 0);
INSERT INTO `tk_cat` VALUES (10000527, '运动内衣', 10000197, 3, 0);
INSERT INTO `tk_cat` VALUES (10000528, '运动配饰', 10000197, 3, 0);
INSERT INTO `tk_cat` VALUES (10000529, '运动马甲', 10000197, 3, 0);
INSERT INTO `tk_cat` VALUES (10000530, '运动裙', 10000197, 3, 0);
INSERT INTO `tk_cat` VALUES (10000531, '休闲衣裤', 10000189, 3, 0);
INSERT INTO `tk_cat` VALUES (10000532, '工装服', 10000189, 3, 0);
INSERT INTO `tk_cat` VALUES (10000533, '冲锋衣裤', 10000189, 3, 0);
INSERT INTO `tk_cat` VALUES (10000534, '抓绒衣裤', 10000189, 3, 0);
INSERT INTO `tk_cat` VALUES (10000535, '羽绒衣裤', 10000189, 3, 0);
INSERT INTO `tk_cat` VALUES (10000536, '棉服', 10000189, 3, 0);
INSERT INTO `tk_cat` VALUES (10000537, '软壳衣裤', 10000189, 3, 0);
INSERT INTO `tk_cat` VALUES (10000538, '速干衣裤', 10000189, 3, 0);
INSERT INTO `tk_cat` VALUES (10000539, '运动包', 10000198, 3, 0);
INSERT INTO `tk_cat` VALUES (10000540, '创意家居', 10000047, 3, 0);
INSERT INTO `tk_cat` VALUES (10000543, '盲盒盲袋', 10000145, 3, 0);
INSERT INTO `tk_cat` VALUES (10000552, '火锅丸料', 10000162, 3, 0);
INSERT INTO `tk_cat` VALUES (10000553, '肉制品', 10000162, 3, 0);
INSERT INTO `tk_cat` VALUES (10000554, '鲜菌菇', 10000161, 3, 0);
INSERT INTO `tk_cat` VALUES (10000555, '茄果瓜类', 10000161, 3, 0);
INSERT INTO `tk_cat` VALUES (10000556, '根茎类', 10000161, 3, 0);
INSERT INTO `tk_cat` VALUES (10000557, '葱姜蒜椒', 10000161, 3, 0);
INSERT INTO `tk_cat` VALUES (10000558, '半加工蔬菜', 10000161, 3, 0);
INSERT INTO `tk_cat` VALUES (10000559, '豆制品', 10000161, 3, 0);
INSERT INTO `tk_cat` VALUES (10000560, '海参', 10000158, 3, 0);
INSERT INTO `tk_cat` VALUES (10000561, '藻类', 10000158, 3, 0);
INSERT INTO `tk_cat` VALUES (10000562, '海产干货', 10000158, 3, 0);
INSERT INTO `tk_cat` VALUES (10000563, '鲜活水产', 10000158, 3, 0);
INSERT INTO `tk_cat` VALUES (10000564, '冷冻水产', 10000158, 3, 0);
INSERT INTO `tk_cat` VALUES (10000565, '冲浪潜水', 10000188, 3, 0);
INSERT INTO `tk_cat` VALUES (10000566, '户外仪表', 10000188, 3, 0);
INSERT INTO `tk_cat` VALUES (10000567, '户外工具', 10000188, 3, 0);
INSERT INTO `tk_cat` VALUES (10000568, '户外照明', 10000188, 3, 0);
INSERT INTO `tk_cat` VALUES (10000569, '救援装备', 10000188, 3, 0);
INSERT INTO `tk_cat` VALUES (10000570, '夜视仪/望远镜', 10000188, 3, 0);
INSERT INTO `tk_cat` VALUES (10000571, '登山攀岩', 10000188, 3, 0);
INSERT INTO `tk_cat` VALUES (10000572, '钓竿', 10000187, 3, 0);
INSERT INTO `tk_cat` VALUES (10000573, '钓鱼鞋服', 10000187, 3, 0);
INSERT INTO `tk_cat` VALUES (10000574, '辅助装备', 10000187, 3, 0);
INSERT INTO `tk_cat` VALUES (10000575, '成人用品', 0, 1, 0);
INSERT INTO `tk_cat` VALUES (10000576, '情趣内衣', 10000575, 2, 0);
INSERT INTO `tk_cat` VALUES (10000577, '情趣用品', 10000575, 2, 0);
INSERT INTO `tk_cat` VALUES (10000578, '驱虫用品', 10000056, 3, 0);
INSERT INTO `tk_cat` VALUES (10000579, '驱蚊用品', 10000056, 3, 0);
INSERT INTO `tk_cat` VALUES (10000580, '除螨用品', 10000056, 3, 0);
INSERT INTO `tk_cat` VALUES (10000581, '灭蝇用品', 10000056, 3, 0);
INSERT INTO `tk_cat` VALUES (10000582, '少儿运动才艺', 10000351, 3, 0);
INSERT INTO `tk_cat` VALUES (10000583, '保鲜器皿', 10000025, 3, 0);
INSERT INTO `tk_cat` VALUES (10000584, '烘焙用具', 10000020, 3, 0);
INSERT INTO `tk_cat` VALUES (10000585, '烧烤用具', 10000020, 3, 0);
INSERT INTO `tk_cat` VALUES (10000586, '水具', 10000022, 3, 0);
INSERT INTO `tk_cat` VALUES (10000587, '酒杯/酒具', 10000022, 3, 0);
INSERT INTO `tk_cat` VALUES (10000588, '一次性用品', 10000025, 3, 0);
INSERT INTO `tk_cat` VALUES (10000589, '茶具', 10000018, 2, 0);
INSERT INTO `tk_cat` VALUES (10000590, '烹饪勺铲', 10000018, 2, 0);
INSERT INTO `tk_cat` VALUES (10000591, '文创用品', 10000405, 2, 0);
INSERT INTO `tk_cat` VALUES (10000592, '镀金饰品', 10000331, 2, 0);
COMMIT;

-- ----------------------------
-- Table structure for tk_cate
-- ----------------------------
DROP TABLE IF EXISTS `tk_cate`;
CREATE TABLE `tk_cate` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(16) NOT NULL DEFAULT '' COMMENT '分类名称',
  `cat_ids` varchar(128) DEFAULT '' COMMENT '对应微信小店类目',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COMMENT='分类';

-- ----------------------------
-- Records of tk_cate
-- ----------------------------
BEGIN;
INSERT INTO `tk_cate` VALUES (1, '食品饮料', '10000215,10000508', 1, 0);
INSERT INTO `tk_cate` VALUES (2, '生鲜酒类', '10000155,10000201', 1, 0);
INSERT INTO `tk_cate` VALUES (3, '服饰内衣', '10000111', 1, 0);
INSERT INTO `tk_cate` VALUES (4, '家纺鞋包', '10000066,10000173,10000212', 1, 0);
INSERT INTO `tk_cate` VALUES (5, '日用百货', '10000046,10000033,10000018', 1, 0);
INSERT INTO `tk_cate` VALUES (6, '美妆护肤', '10000178', 1, 0);
INSERT INTO `tk_cate` VALUES (7, '个护清洁', '10000001,10000050', 1, 0);
INSERT INTO `tk_cate` VALUES (8, '运动户外', '10000183', 1, 0);
INSERT INTO `tk_cate` VALUES (9, '数码办公', '10000104,10000164', 1, 0);
INSERT INTO `tk_cate` VALUES (10, '母婴玩具', '10000116,10000132', 1, 0);
INSERT INTO `tk_cate` VALUES (11, '图书教培', '10000257,10000349', 1, 0);
INSERT INTO `tk_cate` VALUES (12, '珠宝钟表', '10000208,10000331', 1, 0);
INSERT INTO `tk_cate` VALUES (13, '宠物绿植', '10000007,10000026', 1, 0);
INSERT INTO `tk_cate` VALUES (14, '家用电器', '10000057,10000099', 1, 0);
INSERT INTO `tk_cate` VALUES (15, '家装建材', '10000069', 1, 0);
INSERT INTO `tk_cate` VALUES (16, '汽车相关', '10000126', 1, 0);
INSERT INTO `tk_cate` VALUES (17, '文玩文创', '10000405', 1, 0);
INSERT INTO `tk_cate` VALUES (18, '其他', '10000358,10000575', 1, 0);
COMMIT;

-- ----------------------------
-- Table structure for tk_contact
-- ----------------------------
DROP TABLE IF EXISTS `tk_contact`;
CREATE TABLE `tk_contact` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `icon` varchar(16) NOT NULL DEFAULT '' COMMENT 'l图标',
  `title` varchar(16) NOT NULL DEFAULT '' COMMENT '名称',
  `content` varchar(256) NOT NULL DEFAULT '' COMMENT '内容',
  `imgs` text NOT NULL COMMENT '联系二维码，用|分隔',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Records of tk_contact
-- ----------------------------
BEGIN;
INSERT INTO `tk_contact` VALUES (1, 'shop-1', '我是商家', '我是微信小店商家，有货源想让平台帮助推广', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/682402bc000c528d235b3bef7334b00b000000a100004f50|https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/682402bc000c528d235b3bef7334b00b000000a100004f50');
INSERT INTO `tk_contact` VALUES (2, 'video-library', '我是主播/网红/达人', '想通过平台推客群体推广我的直播间和短视频内容', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/682402bc000c528d235b3bef7334b00b000000a100004f50');
INSERT INTO `tk_contact` VALUES (3, 'usergroup', '我是创业者/团队长', '平台依托微信生态，通过私域社交裂变的方式，除了可以推广微信小店海量商品以外，还可以推广明星/网红直播间、短视频等，用户分享即可赚取高额佣金，无需囤货开店，轻松实现零成本创业，平台提供全链路培训和智能工具。欢迎淘宝、微商团队、私域团长联系合作。', 'https://store.mp.video.tencent-cloud.com/161/20304/snscosdownload/SH/reserved/682402bc000c528d235b3bef7334b00b000000a100004f50');
COMMIT;

-- ----------------------------
-- Table structure for tk_coupon
-- ----------------------------
DROP TABLE IF EXISTS `tk_coupon`;
CREATE TABLE `tk_coupon` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `coupon_id` int(11) unsigned NOT NULL,
  `shop_appid` varchar(32) NOT NULL DEFAULT '' COMMENT '优惠券所属店铺id',
  `type` tinyint(4) unsigned NOT NULL COMMENT '优惠券类型',
  `status` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '优惠券状态2生效,2时可用',
  `name` varchar(64) DEFAULT '' COMMENT '名称',
  `start_time` int(10) unsigned DEFAULT '0' COMMENT '优惠券领用开始时间',
  `end_time` int(10) unsigned DEFAULT '0' COMMENT '优惠券领用结束时间',
  `discount_num` int(10) DEFAULT '0' COMMENT '优惠券折扣数 * 1000, 例如 5.1折-> 5100',
  `discount_fee` int(10) DEFAULT '0' COMMENT '优惠券金额, 单位分, 例如0.5元-> 50',
  `product_cnt` int(10) unsigned DEFAULT '0' COMMENT '优惠券使用条件, 满 x 件商品可用',
  `product_price` int(10) unsigned DEFAULT '0' COMMENT '优惠券使用条件, 价格满 x 可用，单位分',
  `product_ids` json DEFAULT NULL COMMENT '优惠券使用条件, 指定商品 id 可用',
  `limit_num_one_person` int(10) unsigned DEFAULT '1' COMMENT '单人限领张数',
  `issued_num` int(10) unsigned DEFAULT '1' COMMENT '优惠券剩余量',
  `total_num` int(10) unsigned DEFAULT '0' COMMENT '优惠券数量',
  `title` varchar(16) DEFAULT '' COMMENT '处理过的优惠券名称',
  `discount` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '折扣/减价 值',
  `discount_type` tinyint(1) unsigned DEFAULT '0' COMMENT '0 折扣券 1 减价券',
  `is_all` tinyint(1) unsigned DEFAULT '0' COMMENT '是否全店，0指定商品，1全店',
  `condition` varchar(16) DEFAULT '' COMMENT '条件',
  `show` tinyint(1) unsigned DEFAULT '0' COMMENT '是否显示',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_couponid` (`coupon_id`),
  KEY `idx_shopid` (`shop_appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='优惠券';

-- ----------------------------
-- Table structure for tk_feed
-- ----------------------------
DROP TABLE IF EXISTS `tk_feed`;
CREATE TABLE `tk_feed` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `export_id` varchar(256) NOT NULL DEFAULT '' COMMENT '短视频ID',
  `talent_appid` varchar(64) NOT NULL DEFAULT '' COMMENT '达人appid',
  `commission_amount` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '佣金',
  `product_info` json DEFAULT NULL COMMENT '带货商品JSON',
  `product_name` varchar(256) NOT NULL DEFAULT '' COMMENT '商品名称',
  `product_id` bigint(24) unsigned NOT NULL DEFAULT '0' COMMENT '商品id',
  `product_img_url` varchar(512) DEFAULT '' COMMENT '商品图',
  `product_mini_price` int(11) unsigned DEFAULT '0' COMMENT '商品最低价格',
  `sort` int(10) unsigned DEFAULT '0',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态，0不显示，1显示',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `is_shop` tinyint(1) unsigned DEFAULT '0' COMMENT '是否店播',
  `shop_appid` varchar(64) DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='达人短视频';

-- ----------------------------
-- Table structure for tk_goods
-- ----------------------------
DROP TABLE IF EXISTS `tk_goods`;
CREATE TABLE `tk_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` varchar(128) DEFAULT '' COMMENT '商品id组合shop_id+product_id+plan_type',
  `product_id` varchar(32) NOT NULL DEFAULT '' COMMENT '商品id',
  `plan_type` tinyint(2) unsigned NOT NULL DEFAULT '1' COMMENT '计划类型1,定向，2公开，3机构定向，4机构公开',
  `shop_appid` varchar(64) NOT NULL DEFAULT '' COMMENT '小店appid',
  `cat_id` int(11) unsigned DEFAULT '0' COMMENT '微信小店主类目id',
  `cate_id` int(11) unsigned DEFAULT '0' COMMENT '系统分类',
  `title` varchar(128) DEFAULT NULL COMMENT '标题',
  `sub_title` varchar(128) DEFAULT NULL COMMENT '副标题',
  `thumb` varchar(256) DEFAULT '' COMMENT '封面图',
  `price` int(10) unsigned DEFAULT '0' COMMENT '价格起始价',
  `commission` int(10) unsigned DEFAULT '0' COMMENT '佣金(分)',
  `commission_rate` decimal(10,2) unsigned DEFAULT '0.00' COMMENT '佣金率',
  `status` tinyint(2) unsigned DEFAULT '0' COMMENT '状态',
  `selling_point` tinyint(1) unsigned DEFAULT '0' COMMENT '是否有素材',
  `show` tinyint(1) unsigned DEFAULT '0' COMMENT '是否显示',
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '更新时间',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  `goods_status` tinyint(2) unsigned DEFAULT '0' COMMENT '微信商品状态，5为正常',
  `commission_status` tinyint(2) unsigned DEFAULT '0' COMMENT '微信分佣状态：1为正常',
  `end_time` int(10) unsigned DEFAULT '0',
  `start_time` int(10) unsigned DEFAULT '0',
  `sort` int(10) unsigned DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tk_goods_detail
-- ----------------------------
DROP TABLE IF EXISTS `tk_goods_detail`;
CREATE TABLE `tk_goods_detail` (
  `goods_id` int(11) unsigned NOT NULL,
  `head_imgs` json DEFAULT NULL,
  `desc_info` json DEFAULT NULL,
  `content` json DEFAULT NULL,
  PRIMARY KEY (`goods_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tk_live
-- ----------------------------
DROP TABLE IF EXISTS `tk_live`;
CREATE TABLE `tk_live` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `talent_appid` varchar(128) NOT NULL DEFAULT '',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型，0预约，1直播',
  `live_id` varchar(512) NOT NULL DEFAULT '' COMMENT '直播 id/预约id',
  `description` varchar(256) NOT NULL DEFAULT '' COMMENT '描述',
  `promoter_share_link` varchar(512) DEFAULT '',
  `start_time` int(10) unsigned DEFAULT '0' COMMENT '开播时间',
  `sort` int(10) unsigned DEFAULT '0',
  `status` tinyint(1) unsigned DEFAULT '0',
  `live_status` tinyint(1) unsigned DEFAULT '0' COMMENT '0未过期/已失效，1正常',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `shop_appid` varchar(64) DEFAULT NULL,
  `is_shop` tinyint(1) unsigned DEFAULT '0' COMMENT '是否店播',
  PRIMARY KEY (`id`),
  KEY `idx_tid` (`talent_appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tk_live_product
-- ----------------------------
DROP TABLE IF EXISTS `tk_live_product`;
CREATE TABLE `tk_live_product` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `talent_appid` varchar(128) NOT NULL DEFAULT '',
  `product_id` bigint(24) unsigned DEFAULT '0' COMMENT '商品 id',
  `product_name` varchar(128) DEFAULT '' COMMENT '商品名称',
  `product_img_url` varchar(256) DEFAULT '' COMMENT '商品的图片 url',
  `product_price` int(10) unsigned DEFAULT '0' COMMENT '商品售价【单位：分】',
  `predict_commission_amount` int(10) unsigned DEFAULT '0' COMMENT '机构预估可得佣金金额【单位：分】',
  `status` tinyint(1) unsigned DEFAULT '1' COMMENT '状态，1失效',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_tid` (`talent_appid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tk_money_log
-- ----------------------------
DROP TABLE IF EXISTS `tk_money_log`;
CREATE TABLE `tk_money_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `money` decimal(10,2) NOT NULL DEFAULT '0.00' COMMENT '变动金额，可以负数',
  `change_type` int(10) unsigned DEFAULT '0' COMMENT '变动类型',
  `third_id` varchar(32) NOT NULL DEFAULT '0' COMMENT '业务id',
  `title` varchar(32) NOT NULL DEFAULT '' COMMENT '描述/说明',
  `remark` varchar(32) NOT NULL DEFAULT '' COMMENT '管理员备注',
  `month` int(10) unsigned DEFAULT '0' COMMENT '月份',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `user_id` (`user_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='用户余额变动明细表';

-- ----------------------------
-- Table structure for tk_order
-- ----------------------------
DROP TABLE IF EXISTS `tk_order`;
CREATE TABLE `tk_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '本系统用户id',
  `order_id` varchar(64) NOT NULL DEFAULT '' COMMENT '订单id',
  `sku_id` varchar(64) NOT NULL DEFAULT '' COMMENT 'sku_id',
  `status` int(10) NOT NULL COMMENT '状态',
  `commission` int(10) unsigned DEFAULT '0' COMMENT '分给用户的佣金金额（分）',
  `commission_status` tinyint(2) DEFAULT '0' COMMENT '佣金状态',
  `create_time` int(10) unsigned DEFAULT '0' COMMENT '订单创建时间',
  `update_time` int(10) unsigned DEFAULT '0' COMMENT '更新时间',
  `product_title` varchar(128) DEFAULT '' COMMENT '订单商品名称',
  `product_img` varchar(256) DEFAULT '' COMMENT '订单商品图片',
  `product_id` varchar(64) DEFAULT '' COMMENT '商品id',
  `amount` int(10) unsigned DEFAULT '0' COMMENT '支付金额',
  `shop_app_id` varchar(64) DEFAULT '' COMMENT '微信小店app_id',
  `sharer_appid` varchar(32) DEFAULT '' COMMENT '分享人的appid',
  `nickname` varchar(32) DEFAULT '' COMMENT '分享人的nickname',
  `service_ratio` int(10) unsigned DEFAULT '0' COMMENT '佣金率百分比',
  `service_amount` int(10) unsigned DEFAULT '0' COMMENT '佣金金额(分）',
  `finished_at` int(10) unsigned DEFAULT '0' COMMENT '服务费结算时间',
  `channel_type` int(10) DEFAULT '0' COMMENT '推客推广的类型 【0：无 3:私域商品推广 4:带货内容推广 6:自营内容推广】',
  `channel_name` varchar(32) DEFAULT '' COMMENT 'channel_name',
  `buyer_open_id` varchar(64) DEFAULT '' COMMENT '购买者的openid',
  `buyer_union_id` varchar(64) DEFAULT '' COMMENT '购买者的unionid',
  `talent_appid` varchar(32) DEFAULT '' COMMENT '达人平台的 appid',
  `talent_nickname` varchar(32) DEFAULT '' COMMENT '达人平台的名称',
  `finder_id` varchar(32) DEFAULT '' COMMENT '视频号达人信息',
  `order_status` int(10) DEFAULT '0' COMMENT '订单状态',
  `is_own` tinyint(1) unsigned DEFAULT '0' COMMENT '是否自购',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tk_order_commission
-- ----------------------------
DROP TABLE IF EXISTS `tk_order_commission`;
CREATE TABLE `tk_order_commission` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '用户ID',
  `order_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '订单ID',
  `role` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '身份',
  `commission` decimal(10,2) unsigned NOT NULL DEFAULT '0.00' COMMENT '佣金',
  `rate` decimal(10,8) unsigned NOT NULL DEFAULT '0.00000000' COMMENT '佣金比例',
  `type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '佣金类型；0=市场补贴，1=服务补贴',
  `order_type` tinyint(2) unsigned NOT NULL DEFAULT '0' COMMENT '订单类型；0=我的订单，1=其它订单',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态；0=未到账，1=已到账，-1=失效',
  `created_at` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_orderId` (`order_id`),
  KEY `idx_user_id_status` (`user_id`,`status`,`created_at`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='微信小店佣金表';

-- ----------------------------
-- Table structure for tk_order_detail
-- ----------------------------
DROP TABLE IF EXISTS `tk_order_detail`;
CREATE TABLE `tk_order_detail` (
  `order_id` int(11) unsigned NOT NULL COMMENT 'order表的id字段',
  `detail` json DEFAULT NULL,
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`order_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tk_partners
-- ----------------------------
DROP TABLE IF EXISTS `tk_partners`;
CREATE TABLE `tk_partners` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `real_name` varchar(32) NOT NULL DEFAULT '' COMMENT '姓名',
  `idcard` varchar(32) DEFAULT '' COMMENT '身份证号',
  `address` varchar(128) DEFAULT '' COMMENT '地址',
  `mobile` varchar(16) DEFAULT '' COMMENT '联系手机号',
  `wechat` varchar(32) DEFAULT '' COMMENT '微信号',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '状态，1正常，0待开放',
  `level_id` tinyint(2) unsigned DEFAULT '0' COMMENT '等级id',
  `level_name` varchar(16) DEFAULT '' COMMENT '等级名称',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `logo` varchar(256) DEFAULT NULL,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COMMENT='服务商/合作伙伴';

-- ----------------------------
-- Records of tk_partners
-- ----------------------------
BEGIN;
INSERT INTO `tk_partners` VALUES (1, 1, '星火联盟', '', '', '', '', 0, 0, '', '2025-05-10 23:16:22', NULL, '星火联盟');
COMMIT;

-- ----------------------------
-- Table structure for tk_shop
-- ----------------------------
DROP TABLE IF EXISTS `tk_shop`;
CREATE TABLE `tk_shop` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(64) NOT NULL DEFAULT '' COMMENT 'appid',
  `headimg_url` varchar(512) NOT NULL DEFAULT '' COMMENT '图像',
  `nickname` varchar(32) NOT NULL DEFAULT '' COMMENT '名称',
  `product_number` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '合作商品数',
  `status` tinyint(2) NOT NULL DEFAULT '0' COMMENT '状态',
  `approved_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '合作时间',
  `brand` varchar(32) DEFAULT '' COMMENT '品牌名，多个用";"分隔',
  `memo` varchar(64) DEFAULT '' COMMENT '备注',
  `introduce` varchar(256) DEFAULT '' COMMENT '店铺介绍',
  `gmv` int(10) unsigned DEFAULT '0',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `sort` int(10) unsigned DEFAULT '0',
  `bind` tinyint(1) unsigned DEFAULT '1' COMMENT '0解绑，1绑定',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tk_store
-- ----------------------------
DROP TABLE IF EXISTS `tk_store`;
CREATE TABLE `tk_store` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `shop_appid` varchar(64) DEFAULT '',
  `bind_time` bigint(20) unsigned DEFAULT '0',
  `shop_nickname` varchar(64) DEFAULT '',
  `shop_head_img` varchar(256) DEFAULT '',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `bind` tinyint(1) unsigned DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='合作的店播小店列表';

-- ----------------------------
-- Table structure for tk_talent
-- ----------------------------
DROP TABLE IF EXISTS `tk_talent`;
CREATE TABLE `tk_talent` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `talent_appid` varchar(128) NOT NULL DEFAULT '' COMMENT 'appid',
  `talent_nickname` varchar(64) DEFAULT '' COMMENT '达人名称',
  `talent_head_img` varchar(512) DEFAULT '' COMMENT '达人头像',
  `bind_time` int(10) unsigned DEFAULT '0' COMMENT '绑定时间',
  `sort` int(10) unsigned DEFAULT '0' COMMENT '排序',
  `status` tinyint(1) unsigned DEFAULT '0' COMMENT '是否推广，0不推广，1推广',
  `memo` varchar(64) DEFAULT '' COMMENT '备注',
  `type` tinyint(1) unsigned DEFAULT '1' COMMENT '1直播，2短视频，3两个都有',
  `is_bind` tinyint(1) unsigned DEFAULT '1' COMMENT '1合作中，0解除合作',
  `cate` tinyint(1) unsigned DEFAULT '1' COMMENT '1达人，2，店播，3明星',
  `rate` int(10) unsigned DEFAULT '10' COMMENT '直播分佣比例%',
  `share_text` varchar(256) DEFAULT '' COMMENT '直播文案',
  `is_shop` tinyint(1) unsigned DEFAULT '0' COMMENT '是否店铺，1店播，0达人',
  `shop_appid` varchar(64) DEFAULT '' COMMENT '店播shop_appid',
  `promoter_type` int(10) unsigned DEFAULT '0' COMMENT '店播关联账号类型【1：视频号；4：公众号；5：服务号】',
  `related_finder_exportname_list` varchar(256) DEFAULT '' COMMENT '关联的视频号username',
  `related_mp_biz_appid_list` varchar(256) DEFAULT '' COMMENT '关联的公众号appid',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='合作达人';

-- ----------------------------
-- Table structure for tk_user
-- ----------------------------
DROP TABLE IF EXISTS `tk_user`;
CREATE TABLE `tk_user` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `openid` varchar(64) NOT NULL DEFAULT '' COMMENT 'openid',
  `sid` int(11) unsigned DEFAULT '0' COMMENT '服务商id',
  `tid` int(11) unsigned DEFAULT '0' COMMENT 'tid',
  `code` char(16) NOT NULL DEFAULT '' COMMENT '邀请码',
  `mobile` varchar(16) DEFAULT '' COMMENT '手机号',
  `nickname` varchar(32) DEFAULT '' COMMENT 'name',
  `head_img_url` varchar(256) DEFAULT '' COMMENT '头像',
  `sharer_appid` varchar(64) DEFAULT '' COMMENT 'app_id',
  `sharer_openid` varchar(64) DEFAULT '' COMMENT '机构的openid',
  `role_id` int(10) unsigned DEFAULT '0' COMMENT '身份，0未授权，1推客，2VIP',
  `commission` int(10) DEFAULT '0' COMMENT '可提现佣金',
  `commission_got` int(10) DEFAULT '0' COMMENT '已提现佣金',
  `bind_time` int(10) unsigned DEFAULT '0' COMMENT '绑定时间',
  `unionid` varchar(64) DEFAULT '',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_openid` (`openid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tk_user_feed
-- ----------------------------
DROP TABLE IF EXISTS `tk_user_feed`;
CREATE TABLE `tk_user_feed` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `feed_id` int(11) unsigned NOT NULL COMMENT 'feedid',
  `feed_token` varchar(256) DEFAULT '',
  `promoter_share_link` varchar(256) DEFAULT '',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='推客推广短视频记录表';

-- ----------------------------
-- Table structure for tk_user_goods
-- ----------------------------
DROP TABLE IF EXISTS `tk_user_goods`;
CREATE TABLE `tk_user_goods` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `goods_id` int(11) unsigned NOT NULL COMMENT '商品id',
  `product_id` varchar(32) DEFAULT '',
  `shop_appid` varchar(64) DEFAULT '',
  `short_link` varchar(256) DEFAULT '' COMMENT '短链',
  `qrcode_url` varchar(256) DEFAULT '' COMMENT '二维码',
  `product_promotion_link` varchar(256) DEFAULT '' COMMENT '内嵌商品卡片的推广参数',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='推客推广商品记录表';

-- ----------------------------
-- Table structure for tk_user_live
-- ----------------------------
DROP TABLE IF EXISTS `tk_user_live`;
CREATE TABLE `tk_user_live` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `live_id` varchar(512) NOT NULL DEFAULT '' COMMENT 'live_id',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '类型，0预约，1直播''',
  `content` varchar(256) DEFAULT '',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '时间',
  `promoter_share_link` varchar(256) DEFAULT '' COMMENT '内嵌直播卡片时需要的推广参数',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='推客推广直播记录表';

-- ----------------------------
-- Table structure for tk_user_token
-- ----------------------------
DROP TABLE IF EXISTS `tk_user_token`;
CREATE TABLE `tk_user_token` (
  `user_id` int(11) unsigned NOT NULL,
  `token` char(32) NOT NULL DEFAULT '',
  `create_time` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  PRIMARY KEY (`user_id`) USING BTREE,
  KEY `idx_token` (`token`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------
-- Table structure for tk_goods_ai
-- ----------------------------
DROP TABLE IF EXISTS `tk_goods_ai`;
CREATE TABLE `tk_goods_ai` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `goods_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '商品ID',
  `content` varchar(256) NOT NULL DEFAULT '' COMMENT '爆款文案内容',
  `create_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='商品推广文案';
SET FOREIGN_KEY_CHECKS = 1;
