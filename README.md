<p align="center">
  <img alt="logo" src="https://foruda.gitee.com/avatar/1748600250044327169/15135660_xiaotuike_1748600249.png" style="margin-bottom: 10px;">
</p>
<h3 align="center">轻量、可靠的微信推客小程序-服务端</h3>


#### 微信小店推客程序-服务端
本项目是微信小店推客小程序服务端，包含两部分功能，一个是微信小店推客程序管理后台；一个是为微信小程序提供API接口的微服务。使用了ThinkAdmin后台管理框架基于ThinkPHP6（已兼容 ThinkPHP8）构建。使用本程序需要具备一定的开发技能，包括 ThinkPHP、jQuery、LayUI 和 RequireJs。

微信小店推客程序-小程序端源码：[https://gitee.com/xiaotuike/tuike-weapp](https://gitee.com/xiaotuike/tuike-weapp)

#### 功能列表
- [x] 推客管理
- [x] 订单（佣金单）管理
- [x] 商品管理(同步)
- [x] 合作店铺管理
- [x] 优惠券
- [x] 合作达人
- [x] 直播管理（预约、直播中）
- [x] 短视频管理
- [x] 前端API接口提供

#### 技术栈
- [ThinkAdmin V6](https://thinkadmin.top/)
- ThinkPHP
- jQuery、LayUI 和 RequireJs
- PHP7.1、MySQL

#### 快速开始

#### 安装部署
该项目要求运行在 PHP7.1 或更高版本的环境中，并且已经安装好MySql5.7以上数据库。

##### 一、运行环境检查

1. 确保已安装 PHP7.1 或更高版本。执行 php -v，是否可以看到 PHP 的版本信息。
2. 确保已安装 MySQL5.7 或更高版本的数据库。

##### 二、系统下载及安装

1. 下载本仓库代码。
克隆本项目到本地：

```
git clone https://gitee.com/xiaotuike/tuike.git
```

2. 数据库配置及安装
- 创建空的数据库；
- 将数据库配置到 config/database.php 文件；
- 修改 config/database.php 文件，将数据库类型改为 mysql，并配置数据库连接参数。
```
return [
     // 数据库类型
    'default' => 'mysql',
    // 数据库连接参数
    'connections' => [
        'mysql'  => [ /* 具体参数省略 */ ], 
    ]
]
```
- 或者修改根目录下的.env.example文件改为.env文件，并修改里面的数据库配置.
修改其中的数据库和缓存配置,如果有安装redis请将缓存配置改为redis
```
# 数据配置
DB_TYPE=mysql
DB_MYSQL_HOST=127.0.0.1
DB_MYSQL_PORT=3306
DB_MYSQL_PREFIX=
DB_MYSQL_USERNAME=root
DB_MYSQL_DATABASE=tuike
DB_MYSQL_CHARSET=utf8mb4
DB_MYSQL_PASSWORD=

# 缓存配置
CACHE_TYPE=redis
CACHE_REDIS_HOST=127.0.0.1
CACHE_REDIS_PORT=6379
CACHE_REDIS_SELECT=1
CACHE_REDIS_PASSWORD=
```

3. 数据库初始化
导入database/tuike.sql数据库脚本文件到数据库

##### 三、线上生产环境部署
生产环境部署参考 ThinkPHP 官方的文档，建议使用 [宝塔面板](https://www.bt.cn/new/index.html) 管理服务器。

Nginx 服务器配置文件参考以下：
```
server {
  listen 80;
  listen 443 ssl http2;
  listen [::]:443 ssl http2;
  access_log /data/wwwlogs/tuike.log combined;
  index index.html index.htm index.php;
  server_name tuike.cn;
  root /data/wwwroot/tuike/public;
  if ($ssl_protocol = "") { return 301 https://$host$request_uri; }
  try_files $uri $uri/ /index.php?s=$uri&$args;
  location /nginx_status {
    stub_status on;
    access_log off;
    allow 127.0.0.1;
    deny all;
  }
  location ~ [^/]\.php(/|$) {
    fastcgi_pass unix:/dev/shm/php-cgi.sock;
    fastcgi_index index.php;
    include fastcgi.conf;
  }

  location ~ .*\.(gif|jpg|jpeg|png|bmp|swf|flv|mp4|ico)$ {
    expires 30d;
    access_log off;
  }
  location ~ .*\.(js|css)?$ {
    expires 7d;
    access_log off;
  }
  location ~ /(\.user\.ini|\.ht|\.git|\.svn|\.project|LICENSE|README\.md) {
    deny all;
  }
}
```

#### 四、文件夹权限设置
需要将根目录下的runtime、public/qrcode、public/upload 文件夹的可写权限
```
chown -R www:www ./runtime
chown -R www:www ./public/qrcode
chown -R www:www ./public/upload
```

#### 五、运行、推客机构及小程序相关配置
- 登录帐号admin,密码tk123456
- 登录成功后，进入 系统管理-> 微信管理 -> 推客接口配置，按提示完成推客联盟机构及小程序相关配置。

#### 六、启动计划任务
- 新版本的任务执行依赖于 symfony/process 组件。为了正常运行，您的运行环境必须启用 exec、proc_open 和 posix_kill 等函数。想着文档可以查看[ThinkAdmin系统异步任务](https://thinkadmin.top/system/core-asynchronous.html)

执行 php think xadmin:queue start # 开启异步任务守护进程（后台进程）
执行 php think xadmin:queue stop # 停止所有正在执行的异步任务进程
执行 php think xadmin:queue query # 查询当前所有正在执行的任务进程
执行 php think xadmin:queue listen # 启动异步任务监听进程（前台进程）
执行 php think xadmin:queue status # 查看当前守护进程的后台运行状态


#### 管理端部分页面展示
<img src="https://foruda.gitee.com/images/1748930295848888774/9f5a7e72_126105.png" />&nbsp;
<img src="https://foruda.gitee.com/images/1748930340702008146/b39d4416_126105.png" />&nbsp;
<img src="https://foruda.gitee.com/images/1748930374588435473/ce2768c0_126105.png" />&nbsp;


#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 官方相关文档
- 《[微信小店联盟官方接口文档](https://developers.weixin.qq.com/doc/store/leagueheadsupplier/)》
- 《[微信推客带货资料库](https://doc.weixin.qq.com/doc/w3_ATAAHwZ5AJc9IuP42XTS7yRqcATLf)》
- 《[微信小程序开发指南](https://developers.weixin.qq.com/miniprogram/dev/framework/)》
- 《[ThinkAdmin V6开发文档](https://thinkadmin.top/)》
- 《[ThinkPHP开发相关](https://www.thinkphp.cn/)》

### 如何加入
- 请发送申请邮件至13834563@qq.com
- 添加微信：wander，备注“推客”,添加后拉您入群。

![添加微信](https://foruda.gitee.com/images/1748587024440552091/b9d154a8_126105.png "微信二维码")


### 联系我
- wechat：wander
- 邮箱：13834563@qq.com



### 免责声明
任何用户在使用由开源项目前，请您仔细阅读并透彻理解本声明。您可以选择不使用此项目，若您一旦使用，您的使用行为即被视为对本声明全部内容的认可和接受。

本项目是一款开源免费的微信推客程序 ，主要用于微信推客联盟机构更快速、便捷开发微信小店推客程序。

您承诺秉着合法、合理的原则使用本开源程序，不利用本开源程序进行任何违法、侵害他人合法利益等恶意的行为，亦不将本开源项目用于任何违反我国法律法规的行为。

任何单位或个人因下载使用本开源项目代码而产生的任何意外、疏忽、合约毁坏、诽谤、版权或知识产权侵犯及其造成的损失 (包括但不限于直接、间接、附带或衍生的损失等)，本人不承担任何法律责任。

用户明确并同意本声明条款列举的全部内容，对使用本开源程序可能存在的风险和相关后果将完全由用户自行承担，本人不承担任何法律责任。

任何单位或个人在阅读本免责声明后，应在《MIT 开源许可证》所允许的范围内进行合法的发布、传播和使用本开源项目等行为，若违反本免责声明条款或违反法律法规所造成的法律责任(包括但不限于民事赔偿和刑事责任），由违约者自行承担。

如果本声明的任何部分被认为无效或不可执行，则该部分将被解释为反映本人的初衷，其余部分仍具有完全效力。不可执行的部分声明，并不构成我们放弃执行该声明的权利。

本人有权随时对本声明条款及附件内容进行单方面的变更，并以消息推送、网页公告等方式予以公布，公布后立即自动生效，无需另行单独通知；若您在本声明内容公告变更后继续使用的，表示您已充分阅读、理解并接受修改后的声明内容。