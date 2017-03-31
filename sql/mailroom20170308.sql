/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50547
Source Host           : 127.0.0.1:3306
Source Database       : mailroom

Target Server Type    : MYSQL
Target Server Version : 50547
File Encoding         : 65001

Date: 2017-03-08 13:07:55
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cmf_ad
-- ----------------------------
DROP TABLE IF EXISTS `cmf_ad`;
CREATE TABLE `cmf_ad` (
  `ad_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '广告id',
  `ad_name` varchar(255) NOT NULL COMMENT '广告名称',
  `ad_content` text COMMENT '广告内容',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  PRIMARY KEY (`ad_id`),
  KEY `ad_name` (`ad_name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_ad
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_api_log
-- ----------------------------
DROP TABLE IF EXISTS `cmf_api_log`;
CREATE TABLE `cmf_api_log` (
  `apilog_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `apioperation_uid` bigint(20) NOT NULL,
  `apioperation_time` int(10) NOT NULL,
  `apilog_content` varchar(200) NOT NULL,
  `api_name` varchar(200) NOT NULL,
  `apioperation_status` enum('0','1') NOT NULL,
  `order_id` int(50) NOT NULL,
  `apioperation_ip` text NOT NULL,
  `apioperation_node` char(50) NOT NULL,
  PRIMARY KEY (`apilog_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_api_log
-- ----------------------------
INSERT INTO `cmf_api_log` VALUES ('1', '1', '1486375592', '5', '2', '1', '1', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', 'g=Admin&m=ApiLog&a=index&user_login=admin&operatio');
INSERT INTO `cmf_api_log` VALUES ('2', '1', '1486375594', '5', '2', '1', '1', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', 'g=Admin&m=ApiLog&a=index&user_login=admin&operatio');
INSERT INTO `cmf_api_log` VALUES ('3', '1', '1486375627', '3', '2', '0', '1', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', 'g=Admin&m=ApiLog&a=index&user_login=admin&operatio');
INSERT INTO `cmf_api_log` VALUES ('4', '1', '1486375864', '3', '2', '0', '1', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', 'g=Admin&m=ApiLog&a=index');

-- ----------------------------
-- Table structure for cmf_asset
-- ----------------------------
DROP TABLE IF EXISTS `cmf_asset`;
CREATE TABLE `cmf_asset` (
  `aid` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '用户 id',
  `key` varchar(50) NOT NULL COMMENT '资源 key',
  `filename` varchar(50) DEFAULT NULL COMMENT '文件名',
  `filesize` int(11) DEFAULT NULL COMMENT '文件大小,单位Byte',
  `filepath` varchar(200) NOT NULL COMMENT '文件路径，相对于 upload 目录，可以为 url',
  `uploadtime` int(11) NOT NULL COMMENT '上传时间',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1：可用，0：删除，不可用',
  `meta` text COMMENT '其它详细信息，JSON格式',
  `suffix` varchar(50) DEFAULT NULL COMMENT '文件后缀名，不包括点',
  `download_times` int(11) NOT NULL DEFAULT '0' COMMENT '下载次数',
  PRIMARY KEY (`aid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='资源表';

-- ----------------------------
-- Records of cmf_asset
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_auth_access
-- ----------------------------
DROP TABLE IF EXISTS `cmf_auth_access`;
CREATE TABLE `cmf_auth_access` (
  `role_id` mediumint(8) unsigned NOT NULL COMMENT '角色',
  `rule_name` varchar(255) NOT NULL COMMENT '规则唯一英文标识,全小写',
  `type` varchar(30) DEFAULT NULL COMMENT '权限规则分类，请加应用前缀,如admin_',
  KEY `role_id` (`role_id`),
  KEY `rule_name` (`rule_name`) USING BTREE
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='权限授权表';

-- ----------------------------
-- Records of cmf_auth_access
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_auth_rule
-- ----------------------------
DROP TABLE IF EXISTS `cmf_auth_rule`;
CREATE TABLE `cmf_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT COMMENT '规则id,自增主键',
  `module` varchar(20) NOT NULL COMMENT '规则所属module',
  `type` varchar(30) NOT NULL DEFAULT '1' COMMENT '权限规则分类，请加应用前缀,如admin_',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '规则唯一英文标识,全小写',
  `param` varchar(255) DEFAULT NULL COMMENT '额外url参数',
  `title` varchar(20) NOT NULL DEFAULT '' COMMENT '规则中文描述',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '是否有效(0:无效,1:有效)',
  `condition` varchar(300) NOT NULL DEFAULT '' COMMENT '规则附加条件',
  PRIMARY KEY (`id`),
  KEY `module` (`module`,`status`,`type`)
) ENGINE=MyISAM AUTO_INCREMENT=208 DEFAULT CHARSET=utf8 COMMENT='权限规则表';

-- ----------------------------
-- Records of cmf_auth_rule
-- ----------------------------
INSERT INTO `cmf_auth_rule` VALUES ('1', 'Admin', 'admin_url', 'admin/content/default', null, '内容管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('2', 'Api', 'admin_url', 'api/guestbookadmin/index', null, '所有留言', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('3', 'Api', 'admin_url', 'api/guestbookadmin/delete', null, '删除网站留言', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('4', 'Comment', 'admin_url', 'comment/commentadmin/index', null, '评论管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('5', 'Comment', 'admin_url', 'comment/commentadmin/delete', null, '删除评论', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('6', 'Comment', 'admin_url', 'comment/commentadmin/check', null, '评论审核', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('7', 'Portal', 'admin_url', 'portal/adminpost/index', null, '文章管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('8', 'Portal', 'admin_url', 'portal/adminpost/listorders', null, '文章排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('9', 'Portal', 'admin_url', 'portal/adminpost/top', null, '文章置顶', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('10', 'Portal', 'admin_url', 'portal/adminpost/recommend', null, '文章推荐', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('11', 'Portal', 'admin_url', 'portal/adminpost/move', null, '批量移动', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('12', 'Portal', 'admin_url', 'portal/adminpost/check', null, '文章审核', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('13', 'Portal', 'admin_url', 'portal/adminpost/delete', null, '删除文章', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('14', 'Portal', 'admin_url', 'portal/adminpost/edit', null, '编辑文章', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('15', 'Portal', 'admin_url', 'portal/adminpost/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('16', 'Portal', 'admin_url', 'portal/adminpost/add', null, '添加文章', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('17', 'Portal', 'admin_url', 'portal/adminpost/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('18', 'Portal', 'admin_url', 'portal/adminterm/index', null, '分类管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('19', 'Portal', 'admin_url', 'portal/adminterm/listorders', null, '文章分类排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('20', 'Portal', 'admin_url', 'portal/adminterm/delete', null, '删除分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('21', 'Portal', 'admin_url', 'portal/adminterm/edit', null, '编辑分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('22', 'Portal', 'admin_url', 'portal/adminterm/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('23', 'Portal', 'admin_url', 'portal/adminterm/add', null, '添加分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('24', 'Portal', 'admin_url', 'portal/adminterm/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('25', 'Portal', 'admin_url', 'portal/adminpage/index', null, '页面管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('26', 'Portal', 'admin_url', 'portal/adminpage/listorders', null, '页面排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('27', 'Portal', 'admin_url', 'portal/adminpage/delete', null, '删除页面', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('28', 'Portal', 'admin_url', 'portal/adminpage/edit', null, '编辑页面', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('29', 'Portal', 'admin_url', 'portal/adminpage/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('30', 'Portal', 'admin_url', 'portal/adminpage/add', null, '添加页面', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('31', 'Portal', 'admin_url', 'portal/adminpage/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('32', 'Admin', 'admin_url', 'admin/recycle/default', null, '回收站', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('33', 'Portal', 'admin_url', 'portal/adminpost/recyclebin', null, '文章回收', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('34', 'Portal', 'admin_url', 'portal/adminpost/restore', null, '文章还原', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('35', 'Portal', 'admin_url', 'portal/adminpost/clean', null, '彻底删除', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('36', 'Portal', 'admin_url', 'portal/adminpage/recyclebin', null, '页面回收', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('37', 'Portal', 'admin_url', 'portal/adminpage/clean', null, '彻底删除', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('38', 'Portal', 'admin_url', 'portal/adminpage/restore', null, '页面还原', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('39', 'Admin', 'admin_url', 'admin/extension/default', null, '扩展工具', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('40', 'Admin', 'admin_url', 'admin/backup/default', null, '备份管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('41', 'Admin', 'admin_url', 'admin/backup/restore', null, '数据还原', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('42', 'Admin', 'admin_url', 'admin/backup/index', null, '数据备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('43', 'Admin', 'admin_url', 'admin/backup/index_post', null, '提交数据备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('44', 'Admin', 'admin_url', 'admin/backup/download', null, '下载备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('45', 'Admin', 'admin_url', 'admin/backup/del_backup', null, '删除备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('46', 'Admin', 'admin_url', 'admin/backup/import', null, '数据备份导入', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('47', 'Admin', 'admin_url', 'admin/plugin/index', null, '插件管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('48', 'Admin', 'admin_url', 'admin/plugin/toggle', null, '插件启用切换', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('49', 'Admin', 'admin_url', 'admin/plugin/setting', null, '插件设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('50', 'Admin', 'admin_url', 'admin/plugin/setting_post', null, '插件设置提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('51', 'Admin', 'admin_url', 'admin/plugin/install', null, '插件安装', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('52', 'Admin', 'admin_url', 'admin/plugin/uninstall', null, '插件卸载', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('53', 'Admin', 'admin_url', 'admin/slide/default', null, '幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('54', 'Admin', 'admin_url', 'admin/slide/index', null, '幻灯片管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('55', 'Admin', 'admin_url', 'admin/slide/listorders', null, '幻灯片排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('56', 'Admin', 'admin_url', 'admin/slide/toggle', null, '幻灯片显示切换', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('57', 'Admin', 'admin_url', 'admin/slide/delete', null, '删除幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('58', 'Admin', 'admin_url', 'admin/slide/edit', null, '编辑幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('59', 'Admin', 'admin_url', 'admin/slide/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('60', 'Admin', 'admin_url', 'admin/slide/add', null, '添加幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('61', 'Admin', 'admin_url', 'admin/slide/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('62', 'Admin', 'admin_url', 'admin/slidecat/index', null, '幻灯片分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('63', 'Admin', 'admin_url', 'admin/slidecat/delete', null, '删除分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('64', 'Admin', 'admin_url', 'admin/slidecat/edit', null, '编辑分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('65', 'Admin', 'admin_url', 'admin/slidecat/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('66', 'Admin', 'admin_url', 'admin/slidecat/add', null, '添加分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('67', 'Admin', 'admin_url', 'admin/slidecat/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('68', 'Admin', 'admin_url', 'admin/ad/index', null, '网站广告', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('69', 'Admin', 'admin_url', 'admin/ad/toggle', null, '广告显示切换', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('70', 'Admin', 'admin_url', 'admin/ad/delete', null, '删除广告', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('71', 'Admin', 'admin_url', 'admin/ad/edit', null, '编辑广告', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('72', 'Admin', 'admin_url', 'admin/ad/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('73', 'Admin', 'admin_url', 'admin/ad/add', null, '添加广告', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('74', 'Admin', 'admin_url', 'admin/ad/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('75', 'Admin', 'admin_url', 'admin/link/index', null, '友情链接', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('76', 'Admin', 'admin_url', 'admin/link/listorders', null, '友情链接排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('77', 'Admin', 'admin_url', 'admin/link/toggle', null, '友链显示切换', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('78', 'Admin', 'admin_url', 'admin/link/delete', null, '删除友情链接', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('79', 'Admin', 'admin_url', 'admin/link/edit', null, '编辑友情链接', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('80', 'Admin', 'admin_url', 'admin/link/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('81', 'Admin', 'admin_url', 'admin/link/add', null, '添加友情链接', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('82', 'Admin', 'admin_url', 'admin/link/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('83', 'Api', 'admin_url', 'api/oauthadmin/setting', null, '第三方登陆', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('84', 'Api', 'admin_url', 'api/oauthadmin/setting_post', null, '提交设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('85', 'Admin', 'admin_url', 'admin/menu/default', null, '菜单管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('86', 'Admin', 'admin_url', 'admin/navcat/default1', null, '前台菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('87', 'Admin', 'admin_url', 'admin/nav/index', null, '菜单管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('88', 'Admin', 'admin_url', 'admin/nav/listorders', null, '前台导航排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('89', 'Admin', 'admin_url', 'admin/nav/delete', null, '删除菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('90', 'Admin', 'admin_url', 'admin/nav/edit', null, '编辑菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('91', 'Admin', 'admin_url', 'admin/nav/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('92', 'Admin', 'admin_url', 'admin/nav/add', null, '添加菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('93', 'Admin', 'admin_url', 'admin/nav/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('94', 'Admin', 'admin_url', 'admin/navcat/index', null, '菜单分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('95', 'Admin', 'admin_url', 'admin/navcat/delete', null, '删除分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('96', 'Admin', 'admin_url', 'admin/navcat/edit', null, '编辑分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('97', 'Admin', 'admin_url', 'admin/navcat/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('98', 'Admin', 'admin_url', 'admin/navcat/add', null, '添加分类', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('99', 'Admin', 'admin_url', 'admin/navcat/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('100', 'Admin', 'admin_url', 'admin/menu/index', null, '后台菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('101', 'Admin', 'admin_url', 'admin/menu/add', null, '添加菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('102', 'Admin', 'admin_url', 'admin/menu/add_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('103', 'Admin', 'admin_url', 'admin/menu/listorders', null, '后台菜单排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('104', 'Admin', 'admin_url', 'admin/menu/export_menu', null, '菜单备份', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('105', 'Admin', 'admin_url', 'admin/menu/edit', null, '编辑菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('106', 'Admin', 'admin_url', 'admin/menu/edit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('107', 'Admin', 'admin_url', 'admin/menu/delete', null, '删除菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('108', 'Admin', 'admin_url', 'admin/menu/lists', null, '所有菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('109', 'Admin', 'admin_url', 'admin/setting/default', null, '基本设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('110', 'Admin', 'admin_url', 'admin/setting/userdefault', null, '个人信息', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('111', 'Admin', 'admin_url', 'admin/user/userinfo', null, '修改信息', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('112', 'Admin', 'admin_url', 'admin/user/userinfo_post', null, '修改信息提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('113', 'Admin', 'admin_url', 'admin/setting/password', null, '修改密码', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('114', 'Admin', 'admin_url', 'admin/setting/password_post', null, '提交修改', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('115', 'Admin', 'admin_url', 'admin/setting/site', null, '网站信息', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('116', 'Admin', 'admin_url', 'admin/setting/site_post', null, '提交修改', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('117', 'Admin', 'admin_url', 'admin/route/index', null, '路由列表', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('118', 'Admin', 'admin_url', 'admin/route/add', null, '路由添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('119', 'Admin', 'admin_url', 'admin/route/add_post', null, '路由添加提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('120', 'Admin', 'admin_url', 'admin/route/edit', null, '路由编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('121', 'Admin', 'admin_url', 'admin/route/edit_post', null, '路由编辑提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('122', 'Admin', 'admin_url', 'admin/route/delete', null, '路由删除', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('123', 'Admin', 'admin_url', 'admin/route/ban', null, '路由禁止', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('124', 'Admin', 'admin_url', 'admin/route/open', null, '路由启用', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('125', 'Admin', 'admin_url', 'admin/route/listorders', null, '路由排序', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('126', 'Admin', 'admin_url', 'admin/mailer/default', null, '邮箱配置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('127', 'Admin', 'admin_url', 'admin/mailer/index', null, 'SMTP配置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('128', 'Admin', 'admin_url', 'admin/mailer/index_post', null, '提交配置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('129', 'Admin', 'admin_url', 'admin/mailer/active', null, '注册邮件模板', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('130', 'Admin', 'admin_url', 'admin/mailer/active_post', null, '提交模板', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('131', 'Admin', 'admin_url', 'admin/setting/clearcache', null, '清除缓存', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('132', 'User', 'admin_url', 'user/indexadmin/default', null, '用户管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('133', 'User', 'admin_url', 'user/indexadmin/default1', null, '用户组', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('134', 'User', 'admin_url', 'user/indexadmin/index', null, '本站用户', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('135', 'User', 'admin_url', 'user/indexadmin/ban', null, '拉黑会员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('136', 'User', 'admin_url', 'user/indexadmin/cancelban', null, '启用会员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('137', 'User', 'admin_url', 'user/oauthadmin/index', null, '第三方用户', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('138', 'User', 'admin_url', 'user/oauthadmin/delete', null, '第三方用户解绑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('139', 'User', 'admin_url', 'user/indexadmin/default3', null, '用户管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('140', 'Admin', 'admin_url', 'admin/rbac/index', null, '角色管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('141', 'Admin', 'admin_url', 'admin/rbac/member', null, '成员管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('142', 'Admin', 'admin_url', 'admin/rbac/authorize', null, '权限设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('143', 'Admin', 'admin_url', 'admin/rbac/authorize_post', null, '提交设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('144', 'Admin', 'admin_url', 'admin/rbac/roleedit', null, '编辑角色', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('145', 'Admin', 'admin_url', 'admin/rbac/roleedit_post', null, '提交编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('146', 'Admin', 'admin_url', 'admin/rbac/roledelete', null, '删除角色', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('147', 'Admin', 'admin_url', 'admin/rbac/roleadd', null, '添加角色', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('148', 'Admin', 'admin_url', 'admin/rbac/roleadd_post', null, '提交添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('149', 'Admin', 'admin_url', 'admin/user/index', null, '管理员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('150', 'Admin', 'admin_url', 'admin/user/delete', null, '删除管理员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('151', 'Admin', 'admin_url', 'admin/user/edit', null, '管理员编辑', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('152', 'Admin', 'admin_url', 'admin/user/edit_post', null, '编辑提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('153', 'Admin', 'admin_url', 'admin/user/add', null, '管理员添加', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('154', 'Admin', 'admin_url', 'admin/user/add_post', null, '添加提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('155', 'Admin', 'admin_url', 'admin/plugin/update', null, '插件更新', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('156', 'Admin', 'admin_url', 'admin/storage/index', null, '文件存储', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('157', 'Admin', 'admin_url', 'admin/storage/setting_post', null, '文件存储设置提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('158', 'Admin', 'admin_url', 'admin/slide/ban', null, '禁用幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('159', 'Admin', 'admin_url', 'admin/slide/cancelban', null, '启用幻灯片', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('160', 'Admin', 'admin_url', 'admin/user/ban', null, '禁用管理员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('161', 'Admin', 'admin_url', 'admin/user/cancelban', null, '启用管理员', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('162', 'Demo', 'admin_url', 'demo/adminindex/index', null, '', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('163', 'Demo', 'admin_url', 'demo/adminindex/last', null, '', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('166', 'Admin', 'admin_url', 'admin/mailer/test', null, '测试邮件', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('167', 'Admin', 'admin_url', 'admin/setting/upload', null, '上传设置', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('168', 'Admin', 'admin_url', 'admin/setting/upload_post', null, '上传设置提交', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('169', 'Portal', 'admin_url', 'portal/adminpost/copy', null, '文章批量复制', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('170', 'Admin', 'admin_url', 'admin/menu/backup_menu', null, '备份菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('171', 'Admin', 'admin_url', 'admin/menu/export_menu_lang', null, '导出后台菜单多语言包', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('172', 'Admin', 'admin_url', 'admin/menu/restore_menu', null, '还原菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('173', 'Admin', 'admin_url', 'admin/menu/getactions', null, '导入新菜单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('174', 'Admin', 'admin_url', 'admin/master/default', null, '基础档案', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('175', 'Admin', 'admin_url', 'admin/user/default', null, '员工信息', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('176', 'Admin', 'admin_url', 'admin/departments/index', null, '部门信息', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('177', 'Admin', 'admin_url', 'admin/company/default', null, '企业信息', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('178', 'Admin', 'admin_url', 'admin/cost/default', null, '成本中心', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('179', 'Admin', 'admin_url', 'admin/distribution/index', null, '配送路径', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('180', 'Admin', 'admin_url', 'admin/mailroom/default', null, 'MailRoom', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('181', 'Admin', 'admin_url', 'admin/expresscompany/index', null, '快递公司', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('182', 'Admin', 'admin_url', 'admin/expressprice/default', null, '快递价目', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('183', 'Admin', 'admin_url', 'admin/address/default', null, '收件地址', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('184', 'Express', 'admin_url', 'express/receiving/index', null, '收件管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('185', 'Admin', 'admin_url', 'admin/sender/default', null, '发件管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('186', 'Admin', 'admin_url', 'admin/reports/default', null, '系统报表', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('187', 'Admin', 'admin_url', 'admin/delivery/default', null, '快件查询', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('188', 'Admin', 'admin_url', 'admin/deliveryreports/default', null, '快件报表', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('189', 'Admin', 'admin_url', 'admin/billimport/default', null, '账单导入', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('190', 'Admin', 'admin_url', 'admin/balance/default', null, '快递对账', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('191', 'Admin', 'admin_url', 'admin/regions/index', null, '地区管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('192', 'Express', 'admin_url', 'express/receiving/create', null, '收件任务', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('193', 'Express', 'admin_url', 'express/receiving/location', null, '定位收件', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('194', 'Express', 'admin_url', 'express/receiving/printlabel', null, '标签打印', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('195', 'Admin', 'admin_url', 'admin/receiving/querylabel', null, '标签查询', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('196', 'Express', 'admin_url', 'express/delivery/printing', null, '派送单打印', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('197', 'Admin', 'admin_url', 'admin/recivering/querysender', null, '派送单查询', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('198', 'Express', 'admin_url', 'express/archiving/archive', null, '派送归档', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('199', 'Admin', 'admin_url', 'admin/recivering/letter', null, '平信管理', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('200', 'Express', 'admin_url', 'express/archiving/late_file', null, '滞纳件', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('201', 'Admin', 'admin_url', 'admin/sender/create', null, '发件任务', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('202', 'Admin', 'admin_url', 'admin/sender/print', null, '快递单打印', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('203', 'Admin', 'admin_url', 'admin/sender/list', null, '出件清单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('204', 'Admin', 'admin_url', 'admin/sender/archive ', null, '出件归档', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('205', 'Admin', 'admin_url', 'admin/sender/get', null, '取件清单', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('206', 'Admin', 'admin_url', 'admin/way/index', null, '派送路径', '1', '');
INSERT INTO `cmf_auth_rule` VALUES ('207', 'Admin', 'admin_url', 'admin/queue/index', null, '导入导出队列', '1', '');

-- ----------------------------
-- Table structure for cmf_comments
-- ----------------------------
DROP TABLE IF EXISTS `cmf_comments`;
CREATE TABLE `cmf_comments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_table` varchar(100) NOT NULL COMMENT '评论内容所在表，不带表前缀',
  `post_id` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '评论内容 id',
  `url` varchar(255) DEFAULT NULL COMMENT '原文地址',
  `uid` int(11) NOT NULL DEFAULT '0' COMMENT '发表评论的用户id',
  `to_uid` int(11) NOT NULL DEFAULT '0' COMMENT '被评论的用户id',
  `full_name` varchar(50) DEFAULT NULL COMMENT '评论者昵称',
  `email` varchar(255) DEFAULT NULL COMMENT '评论者邮箱',
  `createtime` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '评论时间',
  `content` text NOT NULL COMMENT '评论内容',
  `type` smallint(1) NOT NULL DEFAULT '1' COMMENT '评论类型；1实名评论',
  `parentid` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '被回复的评论id',
  `path` varchar(500) DEFAULT NULL,
  `status` smallint(1) NOT NULL DEFAULT '1' COMMENT '状态，1已审核，0未审核',
  PRIMARY KEY (`id`),
  KEY `comment_post_ID` (`post_id`),
  KEY `comment_approved_date_gmt` (`status`),
  KEY `comment_parent` (`parentid`),
  KEY `table_id_status` (`post_table`,`post_id`,`status`),
  KEY `createtime` (`createtime`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of cmf_comments
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_common_action_log
-- ----------------------------
DROP TABLE IF EXISTS `cmf_common_action_log`;
CREATE TABLE `cmf_common_action_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` bigint(20) DEFAULT '0' COMMENT '用户id',
  `object` varchar(100) DEFAULT NULL COMMENT '访问对象的id,格式：不带前缀的表名+id;如posts1表示xx_posts表里id为1的记录',
  `action` varchar(50) DEFAULT NULL COMMENT '操作名称；格式规定为：应用名+控制器+操作名；也可自己定义格式只要不发生冲突且惟一；',
  `count` int(11) DEFAULT '0' COMMENT '访问次数',
  `last_time` int(11) DEFAULT '0' COMMENT '最后访问的时间戳',
  `ip` varchar(15) DEFAULT NULL COMMENT '访问者最后访问ip',
  PRIMARY KEY (`id`),
  KEY `user_object_action` (`user`,`object`,`action`),
  KEY `user_object_action_ip` (`user`,`object`,`action`,`ip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='访问记录表';

-- ----------------------------
-- Records of cmf_common_action_log
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_costcenters
-- ----------------------------
DROP TABLE IF EXISTS `cmf_costcenters`;
CREATE TABLE `cmf_costcenters` (
  `center_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `center_name` varchar(100) NOT NULL,
  `office` varchar(100) DEFAULT NULL,
  `city` varchar(100) DEFAULT NULL,
  `delivery_no` varchar(100) DEFAULT NULL,
  `contacts` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) DEFAULT NULL,
  `update_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`center_id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_costcenters
-- ----------------------------
INSERT INTO `cmf_costcenters` VALUES ('1', 'sfsdf', null, null, null, 'sdfsdf', 'sfsd', 'sfsd', '1', null, '1484555919');
INSERT INTO `cmf_costcenters` VALUES ('2', 'erterte', null, null, null, 'etre', 'ertre', 'ertret', '1', null, '1484554895');
INSERT INTO `cmf_costcenters` VALUES ('3', '11111', 'tt', 'tt', 'xx', '22222', '33333', '55555', '0', null, '1486346215');
INSERT INTO `cmf_costcenters` VALUES ('4', '12222', 'xxx', 'xxxd', 'tttt', '23232', '23232', '23232tttt', '0', '1484554510', '1486347055');
INSERT INTO `cmf_costcenters` VALUES ('5', '1111', null, null, null, '2222', '3333', '4444555', '0', '1484555905', '1484555905');

-- ----------------------------
-- Table structure for cmf_delivery
-- ----------------------------
DROP TABLE IF EXISTS `cmf_delivery`;
CREATE TABLE `cmf_delivery` (
  `delivery_id` int(11) NOT NULL AUTO_INCREMENT,
  `delivery_no` varchar(50) NOT NULL COMMENT '派送单批次号',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0,：删除，1：可用状态',
  `way_id` int(11) NOT NULL COMMENT '路径ID',
  `way_name` varchar(255) DEFAULT NULL COMMENT '路径名称',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '派送人',
  `user_name` varchar(255) DEFAULT NULL COMMENT '派送人姓名',
  `operator_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作人',
  `create_time` int(10) DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`delivery_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_delivery
-- ----------------------------
INSERT INTO `cmf_delivery` VALUES ('1', '201703070001', '0', '8', 'A01-01', '4', 'admin', '1', '1488876914', '1488876914');
INSERT INTO `cmf_delivery` VALUES ('2', '201703070001', '0', '8', 'A01-01', '4', 'admin', '1', '1488881235', '1488881235');
INSERT INTO `cmf_delivery` VALUES ('3', '201703070001', '0', '9', 'A01-02', '4', 'admin', '1', '1488881235', '1488881235');

-- ----------------------------
-- Table structure for cmf_delivery_address
-- ----------------------------
DROP TABLE IF EXISTS `cmf_delivery_address`;
CREATE TABLE `cmf_delivery_address` (
  `delivery_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `delivery_name` varchar(50) NOT NULL,
  `delivery_mobile` varchar(20) NOT NULL,
  `delivery_address` varchar(200) NOT NULL,
  `staff_id` int(11) NOT NULL,
  `delivery_street` varchar(100) DEFAULT NULL,
  `delivery_postcode` int(6) DEFAULT NULL,
  `delivery_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`delivery_id`)
) ENGINE=MyISAM AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_delivery_address
-- ----------------------------
INSERT INTO `cmf_delivery_address` VALUES ('1', '订单', '3333333', '47', '6', '打豆豆', '333', '0');
INSERT INTO `cmf_delivery_address` VALUES ('2', '点点滴滴', '3333322', '47', '6', '事实上', '33333', '0');
INSERT INTO `cmf_delivery_address` VALUES ('3', '反反复复', '33222211', '146', '6', '增长值', '2222', '1');
INSERT INTO `cmf_delivery_address` VALUES ('4', '地对地导弹', '555555', '75', '6', '烦烦烦', '1111', '0');
INSERT INTO `cmf_delivery_address` VALUES ('5', '古古怪怪', '4444444', '46', '6', '点点滴滴', '4444444', '0');
INSERT INTO `cmf_delivery_address` VALUES ('6', 'VVVVVV', '44444', '51', '6', '哈哈哈哈h', '33333', '0');
INSERT INTO `cmf_delivery_address` VALUES ('7', '娜娜娜娜娜娜', '444444', '22', '6', '', '444', '0');
INSERT INTO `cmf_delivery_address` VALUES ('10', '吗吗吗吗吗吗吗', '55555555', '138', '6', '', '55555', '0');
INSERT INTO `cmf_delivery_address` VALUES ('11', '发说说说说', '333333', '367', '6', '', '3333', '0');

-- ----------------------------
-- Table structure for cmf_delivery_receiving
-- ----------------------------
DROP TABLE IF EXISTS `cmf_delivery_receiving`;
CREATE TABLE `cmf_delivery_receiving` (
  `delivery_id` int(11) NOT NULL DEFAULT '0' COMMENT '派送单ID',
  `receive_id` int(11) NOT NULL,
  `way_id` int(11) NOT NULL DEFAULT '0' COMMENT '座位号ID,确定数据一致性',
  `create_time` int(10) DEFAULT NULL COMMENT '添加时间',
  `update_time` int(10) DEFAULT NULL COMMENT '更新时间',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除，0：可用，1：不可用',
  PRIMARY KEY (`delivery_id`,`receive_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_delivery_receiving
-- ----------------------------
INSERT INTO `cmf_delivery_receiving` VALUES ('1', '80', '8', '1488876914', '1488876914', '0');
INSERT INTO `cmf_delivery_receiving` VALUES ('1', '81', '8', '1488876914', '1488876914', '0');
INSERT INTO `cmf_delivery_receiving` VALUES ('2', '76', '8', '1488881235', '1488881235', '0');
INSERT INTO `cmf_delivery_receiving` VALUES ('2', '77', '8', '1488881235', '1488881235', '0');
INSERT INTO `cmf_delivery_receiving` VALUES ('3', '67', '9', '1488881235', '1488881235', '0');
INSERT INTO `cmf_delivery_receiving` VALUES ('3', '68', '9', '1488881235', '1488881235', '0');
INSERT INTO `cmf_delivery_receiving` VALUES ('3', '69', '9', '1488881235', '1488881235', '0');
INSERT INTO `cmf_delivery_receiving` VALUES ('3', '72', '9', '1488881235', '1488881235', '0');
INSERT INTO `cmf_delivery_receiving` VALUES ('3', '73', '9', '1488881235', '1488881235', '0');

-- ----------------------------
-- Table structure for cmf_departments
-- ----------------------------
DROP TABLE IF EXISTS `cmf_departments`;
CREATE TABLE `cmf_departments` (
  `department_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `department_name` varchar(100) NOT NULL,
  `contacts` varchar(100) DEFAULT NULL,
  `mobile` varchar(20) DEFAULT NULL,
  `tel` varchar(20) DEFAULT NULL,
  `account` varchar(100) DEFAULT NULL,
  `company` varchar(100) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) DEFAULT NULL,
  `update_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`department_id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_departments
-- ----------------------------
INSERT INTO `cmf_departments` VALUES ('1', '研发部', 'SB', '13776588736', '0510-85388092', null, null, '1', '1484028768', '1484028789');
INSERT INTO `cmf_departments` VALUES ('3', '行政部', 'erer', '15978776535', '0551-67778574', 'werew', 'werew', '1', null, '1486360099');
INSERT INTO `cmf_departments` VALUES ('4', '行政部', 'erertt', '15978776535', '0551-67778574', null, null, '1', null, null);
INSERT INTO `cmf_departments` VALUES ('5', '行政部', 'ererttsss', '15978776535', '0551-67778574', null, null, '1', null, null);
INSERT INTO `cmf_departments` VALUES ('6', '行政部', 'ererttsssxxx', '15978776535', '0551-67778574', null, null, '1', null, null);
INSERT INTO `cmf_departments` VALUES ('7', '行政部', 'aaaa', '15978776535', '0551-67778574', null, null, '1', null, null);
INSERT INTO `cmf_departments` VALUES ('11', '2342342', '23432', '2342', '23424', null, null, '1', null, null);
INSERT INTO `cmf_departments` VALUES ('10', 'tttteeee', 'eete', 'etee', 'etet', null, null, '1', null, null);
INSERT INTO `cmf_departments` VALUES ('12', '研发部', '', '', '', '', '', '0', '1488680488', '1488680488');
INSERT INTO `cmf_departments` VALUES ('13', '测试部', '', '', '', '', '', '0', '1488680495', '1488680495');
INSERT INTO `cmf_departments` VALUES ('14', '人事部', '', '', '', '', '', '0', '1488680502', '1488680502');

-- ----------------------------
-- Table structure for cmf_express_company
-- ----------------------------
DROP TABLE IF EXISTS `cmf_express_company`;
CREATE TABLE `cmf_express_company` (
  `express_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '快递公司ID',
  `express_name` varchar(100) NOT NULL COMMENT '快递公司名称',
  `express_code` varchar(100) NOT NULL COMMENT '快递公司代码',
  `express_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '快递公司类型，1：国外件，0：国内件',
  `express_attr` tinyint(1) NOT NULL DEFAULT '0' COMMENT '快件属性：0：文件、1：包裹',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除：1（TRUE）不可用， 0（FALSE）可用',
  `create_time` int(10) NOT NULL COMMENT '添加时间',
  `update_time` int(10) NOT NULL COMMENT '更新时间',
  PRIMARY KEY (`express_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_express_company
-- ----------------------------
INSERT INTO `cmf_express_company` VALUES ('1', 'test', 'test2', '0', '0', '0', '1484112741', '1484749238');
INSERT INTO `cmf_express_company` VALUES ('2', '顺丰', 'SF', '1', '0', '0', '1484116521', '1484120771');
INSERT INTO `cmf_express_company` VALUES ('3', '圆通', 'YT', '0', '0', '0', '1487061204', '1487061204');
INSERT INTO `cmf_express_company` VALUES ('4', 'testsss', 'aaaa', '0', '1', '1', '1487747857', '1487749040');

-- ----------------------------
-- Table structure for cmf_express_fw_prices
-- ----------------------------
DROP TABLE IF EXISTS `cmf_express_fw_prices`;
CREATE TABLE `cmf_express_fw_prices` (
  `fw_price_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '首重价格ID ',
  `express_id` int(11) NOT NULL COMMENT '快递公司ID',
  `region_ids` text NOT NULL COMMENT '地区ID集合',
  `weight` double(10,3) NOT NULL DEFAULT '0.000' COMMENT '首重',
  `price` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT '首重价格',
  `discount` double(10,3) NOT NULL DEFAULT '1.000' COMMENT '首重折扣',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除：1（TRUE）， 0（FALSE）',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`fw_price_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='国内件首重表';

-- ----------------------------
-- Records of cmf_express_fw_prices
-- ----------------------------
INSERT INTO `cmf_express_fw_prices` VALUES ('6', '1', '|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100|101|102|103|', '10.000', '12.000', '1.000', '0', '1487645012', '1487646628');
INSERT INTO `cmf_express_fw_prices` VALUES ('7', '3', '|3268|1|2|3|4|5|6|7|8|9|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36|37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60|61|62|63|64|65|66|67|68|69|70|71|72|73|74|75|76|77|78|79|80|81|82|83|84|85|86|87|88|89|90|91|92|93|94|95|96|97|98|99|100|101|102|103|104|105|106|107|108|109|110|111|112|113|114|115|116|117|118|119|120|121|122|123|124|125|126|127|128|129|130|131|132|133|134|135|136|137|138|139|140|141|142|143|144|145|146|147|148|149|150|151|152|153|154|155|156|157|158|159|160|161|162|163|164|165|166|167|168|169|170|171|172|173|174|175|176|177|178|179|180|181|182|183|184|185|186|187|188|189|190|191|192|193|194|195|196|197|198|199|200|201|202|203|204|205|206|207|208|209|210|211|212|213|214|215|216|217|218|219|220|221|222|223|224|225|226|227|228|229|230|231|232|233|234|235|236|237|238|239|240|241|242|243|244|245|246|247|248|249|250|251|252|253|254|255|256|257|258|259|260|261|262|263|264|265|266|267|268|269|270|271|272|273|274|275|276|277|278|279|280|281|282|283|284|285|286|287|288|289|290|291|292|293|294|295|296|297|298|299|300|301|302|303|304|305|306|307|308|309|310|311|312|313|314|315|316|317|318|319|320|321|322|323|324|325|326|327|328|329|330|331|332|333|334|335|336|337|338|339|340|341|342|343|344|345|346|347|348|349|350|351|352|353|354|355|356|357|358|359|360|361|362|363|364|365|366|367|368|369|370|371|372|373|374|375|376|377|378|379|380|381|382|383|384|385|386|387|388|389|390|391|392|393|394|395|396|397|398|399|400|401|402|403|404|405|406|407|408|409|410|411|412|413|414|415|416|417|418|419|420|421|422|423|424|425|426|427|428|429|430|431|432|433|434|435|436|437|438|439|440|441|442|443|444|445|446|447|448|449|450|451|452|453|454|455|456|457|458|459|460|461|462|463|464|465|466|467|468|469|470|471|472|473|474|475|476|477|478|479|480|481|482|483|484|485|486|487|488|489|490|491|492|493|494|495|496|497|498|499|500|501|502|503|504|505|506|507|508|509|510|511|512|513|514|515|516|517|518|519|520|521|522|523|524|525|526|527|528|529|530|531|532|533|534|535|536|537|538|539|540|541|542|543|544|545|546|547|548|549|550|551|552|553|554|555|556|557|558|559|560|561|562|563|564|565|566|567|568|569|570|571|572|573|574|575|576|577|578|579|580|581|582|583|584|585|586|587|588|589|590|591|592|593|594|595|596|597|598|599|600|601|602|603|604|605|606|607|608|609|610|611|612|613|614|615|616|617|618|619|620|621|622|623|624|625|626|627|628|629|630|631|632|633|634|635|636|637|638|639|640|641|642|643|644|645|646|647|648|649|650|651|652|653|654|655|656|657|658|659|660|661|662|663|664|665|666|667|668|669|670|671|672|673|674|675|676|677|678|679|680|681|682|683|684|685|686|687|688|689|690|691|692|693|694|695|696|697|698|699|700|701|702|703|704|705|706|707|708|709|710|711|712|713|714|715|716|717|718|719|720|721|722|723|724|725|726|727|728|729|730|731|732|733|734|735|736|737|738|739|740|741|742|743|744|745|746|747|748|749|750|751|752|753|754|755|756|757|758|759|760|761|762|763|764|765|766|767|768|769|770|771|772|773|774|775|776|777|778|779|780|781|782|783|784|785|786|787|788|789|790|791|792|793|794|795|796|797|798|799|800|801|802|803|804|805|806|807|808|809|810|811|812|813|814|815|816|817|818|819|820|821|822|823|824|825|826|827|828|829|830|831|832|833|834|835|836|837|838|839|840|841|842|843|844|845|846|847|848|849|850|851|852|853|854|855|856|857|858|859|860|861|862|863|864|865|866|867|868|869|870|871|872|873|874|875|876|877|878|879|880|881|882|883|884|885|886|887|888|889|890|891|892|893|894|895|896|897|898|899|900|901|902|903|904|905|906|907|908|909|910|911|912|913|914|915|916|917|918|919|920|921|922|923|924|925|926|927|928|929|930|931|932|933|934|935|936|937|938|939|940|941|942|943|944|945|946|947|948|949|950|951|952|953|954|955|956|957|958|959|960|961|962|963|964|965|966|967|968|969|970|971|972|973|974|975|976|977|978|979|980|981|982|983|984|985|986|987|988|989|990|991|992|993|994|995|996|997|998|999|1000|1001|1002|1003|1004|1005|1006|1007|1008|1009|1010|1011|1012|1013|1014|1015|1016|1017|1018|1019|1020|1021|1022|1023|1024|1025|1026|1027|1028|1029|1030|1031|1032|1033|1034|1035|1036|1037|1038|1039|1040|1041|1042|1043|1044|1045|1046|1047|1048|1049|1050|1051|1052|1053|1054|1055|1056|1057|1058|1059|1060|1061|1062|1063|1064|1065|1066|1067|1068|1069|1070|1071|1072|1073|1074|1075|1076|1077|1078|1079|1080|1081|1082|1083|1084|1085|1086|1087|1088|1089|1090|1091|1092|1093|1094|1095|1096|1097|1098|1099|1100|1101|1102|1103|1104|1105|1106|1107|1108|1109|1110|1111|1112|1113|1114|1115|1116|1117|1118|1119|1120|1121|1122|1123|1124|1125|1126|1127|1128|1129|1130|1131|1132|1133|1134|1135|1136|1137|1138|1139|1140|1141|1142|1143|1144|1145|1146|1147|1148|1149|1150|1151|1152|1153|1154|1155|1156|1157|1158|1159|1160|1161|1162|1163|1164|1165|1166|1167|1168|1169|1170|1171|1172|1173|1174|1175|1176|1177|1178|1179|1180|1181|1182|1183|1184|1185|1186|1187|1188|1189|1190|1191|1192|1193|1194|1195|1196|1197|1198|1199|1200|1201|1202|1203|1204|1205|1206|1207|1208|1209|1210|1211|1212|1213|1214|1215|1216|1217|1218|1219|1220|1221|1222|1223|1224|1225|1226|1227|1228|1229|1230|1231|1232|1233|1234|1235|1236|1237|1238|1239|1240|1241|1242|1243|1244|1245|1246|1247|1248|1249|1250|1251|1252|1253|1254|1255|1256|1257|1258|1259|1260|1261|1262|1263|1264|1265|1266|1267|1268|1269|1270|1271|1272|1273|1274|1275|1276|1277|1278|1279|1280|1281|1282|1283|1284|1285|1286|1287|1288|1289|1290|1291|1292|1293|1294|1295|1296|1297|1298|1299|1300|1301|1302|1303|1304|1305|1306|1307|1308|1309|1310|1311|1312|1313|1314|1315|1316|1317|1318|1319|1320|1321|1322|1323|1324|1325|1326|1327|1328|1329|1330|1331|1332|1333|1334|1335|1336|1337|1338|1339|1340|1341|1342|1343|1344|1345|1346|1347|1348|1349|1350|1351|1352|1353|1354|1355|1356|1357|1358|1359|1360|1361|1362|1363|1364|1365|1366|1367|1368|1369|1370|1371|1372|1373|1374|1375|1376|1377|1378|1379|1380|1381|1382|1383|1384|1385|1386|1387|1388|1389|1390|1391|1392|1393|1394|1395|1396|1397|1398|1399|1400|1401|1402|1403|1404|1405|1406|1407|1408|1409|1410|1411|1412|1413|1414|1415|1416|1417|1418|1419|1420|1421|1422|1423|1424|1425|1426|1427|1428|1429|1430|1431|1432|1433|1434|1435|1436|1437|1438|1439|1440|1441|1442|1443|1444|1445|1446|1447|1448|1449|1450|1451|1452|1453|1454|1455|1456|1457|1458|1459|1460|1461|1462|1463|1464|1465|1466|1467|1468|1469|1470|1471|1472|1473|1474|1475|1476|1477|1478|1479|1480|1481|1482|1483|1484|1485|1486|1487|1488|1489|1490|1491|1492|1493|1494|1495|1496|1497|1498|1499|1500|1501|1502|1503|1504|1505|1506|1507|1508|1509|1510|1511|1512|1513|1514|1515|1516|1517|1518|1519|1520|1521|1522|1523|1524|1525|1526|1527|1528|1529|1530|1531|1532|1533|1534|1535|1536|1537|1538|1539|1540|1541|1542|1543|1544|1545|1546|1547|1548|1549|1550|1551|1552|1553|1554|1555|1556|1557|1558|1559|1560|1561|1562|1563|1564|1565|1566|1567|1568|1569|1570|1571|1572|1573|1574|1575|1576|1577|1578|1579|1580|1581|1582|1583|1584|1585|1586|1587|1588|1589|1590|1591|1592|1593|1594|1595|1596|1597|1598|1599|1600|1601|1602|1603|1604|1605|1606|1607|1608|1609|1610|1611|1612|1613|1614|1615|1616|1617|1618|1619|1620|1621|1622|1623|1624|1625|1626|1627|1628|1629|1630|1631|1632|1633|1634|1635|1636|1637|1638|1639|1640|1641|1642|1643|1644|1645|1646|1647|1648|1649|1650|1651|1652|1653|1654|1655|1656|1657|1658|1659|1660|1661|1662|1663|1664|1665|1666|1667|1668|1669|1670|1671|1672|1673|1674|1675|1676|1677|1678|1679|1680|1681|1682|1683|1684|1685|1686|1687|1688|1689|1690|1691|1692|1693|1694|1695|1696|1697|1698|1699|1700|1701|1702|1703|1704|1705|1706|1707|1708|1709|1710|1711|1712|1713|1714|1715|1716|1717|1718|1719|1720|1721|1722|1723|1724|1725|1726|1727|1728|1729|1730|1731|1732|1733|1734|1735|1736|1737|1738|1739|1740|1741|1742|1743|1744|1745|1746|1747|1748|1749|1750|1751|1752|1753|1754|1755|1756|1757|1758|1759|1760|1761|1762|1763|1764|1765|1766|1767|1768|1769|1770|1771|1772|1773|1774|1775|1776|1777|1778|1779|1780|1781|1782|1783|1784|1785|1786|1787|1788|1789|1790|1791|1792|1793|1794|1795|1796|1797|1798|1799|1800|1801|1802|1803|1804|1805|1806|1807|1808|1809|1810|1811|1812|1813|1814|1815|1816|1817|1818|1819|1820|1821|1822|1823|1824|1825|1826|1827|1828|1829|1830|1831|1832|1833|1834|1835|1836|1837|1838|1839|1840|1841|1842|1843|1844|1845|1846|1847|1848|1849|1850|1851|1852|1853|1854|1855|1856|1857|1858|1859|1860|1861|1862|1863|1864|1865|1866|1867|1868|1869|1870|1871|1872|1873|1874|1875|1876|1877|1878|1879|1880|1881|1882|1883|1884|1885|1886|1887|1888|1889|1890|1891|1892|1893|1894|1895|1896|1897|1898|1899|1900|1901|1902|1903|1904|1905|1906|1907|1908|1909|1910|1911|1912|1913|1914|1915|1916|1917|1918|1919|1920|1921|1922|1923|1924|1925|1926|1927|1928|1929|1930|1931|1932|1933|1934|1935|1936|1937|1938|1939|1940|1941|1942|1943|1944|1945|1946|1947|1948|1949|1950|1951|1952|1953|1954|1955|1956|1957|1958|1959|1960|1961|1962|1963|1964|1965|1966|1967|1968|1969|1970|1971|1972|1973|1974|1975|1976|1977|1978|1979|1980|1981|1982|1983|1984|1985|1986|1987|1988|1989|1990|1991|1992|1993|1994|1995|1996|1997|1998|1999|2000|2001|2002|2003|2004|2005|2006|2007|2008|2009|2010|2011|2012|2013|2014|2015|2016|2017|2018|2019|2020|2021|2022|2023|2024|2025|2026|2027|2028|2029|2030|2031|2032|2033|2034|2035|2036|2037|2038|2039|2040|2041|2042|2043|2044|2045|2046|2047|2048|2049|2050|2051|2052|2053|2054|2055|2056|2057|2058|2059|2060|2061|2062|2063|2064|2065|2066|2067|2068|2069|2070|2071|2072|2073|2074|2075|2076|2077|2078|2079|2080|2081|2082|2083|2084|2085|2086|2087|2088|2089|2090|2091|2092|2093|2094|2095|2096|2097|2098|2099|2100|2101|2102|2103|2104|2105|2106|2107|2108|2109|2110|2111|2112|2113|2114|2115|2116|2117|2118|2119|2120|2121|2122|2123|2124|2125|2126|2127|2128|2129|2130|2131|2132|2133|2134|2135|2136|2137|2138|2139|2140|2141|2142|2143|2144|2145|2146|2147|2148|2149|2150|2151|2152|2153|2154|2155|2156|2157|2158|2159|2160|2161|2162|2163|2164|2165|2166|2167|2168|2169|2170|2171|2172|2173|2174|2175|2176|2177|2178|2179|2180|2181|2182|2183|2184|2185|2186|2187|2188|2189|2190|2191|2192|2193|2194|2195|2196|2197|2198|2199|2200|2201|2202|2203|2204|2205|2206|2207|2208|2209|2210|2211|2212|2213|2214|2215|2216|2217|2218|2219|2220|2221|2222|2223|2224|2225|2226|2227|2228|2229|2230|2231|2232|2233|2234|2235|2236|2237|2238|2239|2240|2241|2242|2243|2244|2245|2246|2247|2248|2249|2250|2251|2252|2253|2254|2255|2256|2257|2258|2259|2260|2261|2262|2263|2264|2265|2266|2267|2268|2269|2270|2271|2272|2273|2274|2275|2276|2277|2278|2279|2280|2281|2282|2283|2284|2285|2286|2287|2288|2289|2290|2291|2292|2293|2294|2295|2296|2297|2298|2299|2300|2301|2302|2303|2304|2305|2306|2307|2308|2309|2310|2311|2312|2313|2314|2315|2316|2317|2318|2319|2320|2321|2322|2323|2324|2325|2326|2327|2328|2329|2330|2331|2332|2333|2334|2335|2336|2337|2338|2339|2340|2341|2342|2343|2344|2345|2346|2347|2348|2349|2350|2351|2352|2353|2354|2355|2356|2357|2358|2359|2360|2361|2362|2363|2364|2365|2366|2367|2368|2369|2370|2371|2372|2373|2374|2375|2376|2377|2378|2379|2380|2381|2382|2383|2384|2385|2386|2387|2388|2389|2390|2391|2392|2393|2394|2395|2396|2397|2398|2399|2400|2401|2402|2403|2404|2405|2406|2407|2408|2409|2410|2411|2412|2413|2414|2415|2416|2417|2418|2419|2420|2421|2422|2423|2424|2425|2426|2427|2428|2429|2430|2431|2432|2433|2434|2435|2436|2437|2438|2439|2440|2441|2442|2443|2444|2445|2446|2447|2448|2449|2450|2451|2452|2453|2454|2455|2456|2457|2458|2459|2460|2461|2462|2463|2464|2465|2466|2467|2468|2469|2470|2471|2472|2473|2474|2475|2476|2477|2478|2479|2480|2481|2482|2483|2484|2485|2486|2487|2488|2489|2490|2491|2492|2493|2494|2495|2496|2497|2498|2499|2500|2501|2502|2503|2504|2505|2506|2507|2508|2509|2510|2511|2512|2513|2514|2515|2516|2517|2518|2519|2520|2521|2522|2523|2524|2525|2526|2527|2528|2529|2530|2531|2532|2533|2534|2535|2536|2537|2538|2539|2540|2541|2542|2543|2544|2545|2546|2547|2548|2549|2550|2551|2552|2553|2554|2555|2556|2557|2558|2559|2560|2561|2562|2563|2564|2565|2566|2567|2568|2569|2570|2571|2572|2573|2574|2575|2576|2577|2578|2579|2580|2581|2582|2583|2584|2585|2586|2587|2588|2589|2590|2591|2592|2593|2594|2595|2596|2597|2598|2599|2600|2601|2602|2603|2604|2605|2606|2607|2608|2609|2610|2611|2612|2613|2614|2615|2616|2617|2618|2619|2620|2621|2622|2623|2624|2625|2626|2627|2628|2629|2630|2631|2632|2633|2634|2635|2636|2637|2638|2639|2640|2641|2642|2643|2644|2645|2646|2647|2648|2649|2650|2651|2652|2653|2654|2655|2656|2657|2658|2659|2660|2661|2662|2663|2664|2665|2666|2667|2668|2669|2670|2671|2672|2673|2674|2675|2676|2677|2678|2679|2680|2681|2682|2683|2684|2685|2686|2687|2688|2689|2690|2691|2692|2693|2694|2695|2696|2697|2698|2699|2700|2701|2702|2703|2704|2705|2706|2707|2708|2709|2710|2711|2712|2713|2714|2715|2716|2717|2718|2719|2720|2721|2722|2723|2724|2725|2726|2727|2728|2729|2730|2731|2732|2733|2734|2735|2736|2737|2738|2739|2740|2741|2742|2743|2744|2745|2746|2747|2748|2749|2750|2751|2752|2753|2754|2755|2756|2757|2758|2759|2760|2761|2762|2763|2764|2765|2766|2767|2768|2769|2770|2771|2772|2773|2774|2775|2776|2777|2778|2779|2780|2781|2782|2783|2784|2785|2786|2787|2788|2789|2790|2791|2792|2793|2794|2795|2796|2797|2798|2799|2800|2801|2802|2803|2804|2805|2806|2807|2808|2809|2810|2811|2812|2813|2814|2815|2816|2817|2818|2819|2820|2821|2822|2823|2824|2825|2826|2827|2828|2829|2830|2831|2832|2833|2834|2835|2836|2837|2838|2839|2840|2841|2842|2843|2844|2845|2846|2847|2848|2849|2850|2851|2852|2853|2854|2855|2856|2857|2858|2859|2860|2861|2862|2863|2864|2865|2866|2867|2868|2869|2870|2871|2872|2873|2874|2875|2876|2877|2878|2879|2880|2881|2882|2883|2884|2885|2886|2887|2888|2889|2890|2891|2892|2893|2894|2895|2896|2897|2898|2899|2900|2901|2902|2903|2904|2905|2906|2907|2908|2909|2910|2911|2912|2913|2914|2915|2916|2917|2918|2919|2920|2921|2922|2923|2924|2925|2926|2927|2928|2929|2930|2931|2932|2933|2934|2935|2936|2937|2938|2939|2940|2941|2942|2943|2944|2945|2946|2947|2948|2949|2950|2951|2952|2953|2954|2955|2956|2957|2958|2959|2960|2961|2962|2963|2964|2965|2966|2967|2968|2969|2970|2971|2972|2973|2974|2975|2976|2977|2978|2979|2980|2981|2982|2983|2984|2985|2986|2987|2988|2989|2990|2991|2992|2993|2994|2995|2996|2997|2998|2999|3000|3001|3002|3003|3004|3005|3006|3007|3008|3009|3010|3011|3012|3013|3014|3015|3016|3017|3018|3019|3020|3021|3022|3023|3024|3025|3026|3027|3028|3029|3030|3031|3032|3033|3034|3035|3036|3037|3038|3039|3040|3041|3042|3043|3044|3045|3046|3047|3048|3049|3050|3051|3052|3053|3054|3055|3056|3057|3058|3059|3060|3061|3062|3063|3064|3065|3066|3067|3068|3069|3070|3071|3072|3073|3074|3075|3076|3077|3078|3079|3080|3081|3082|3083|3084|3085|3086|3087|3088|3089|3090|3091|3092|3093|3094|3095|3096|3097|3098|3099|3100|3101|3102|3103|3104|3105|3106|3107|3108|3109|3110|3111|3112|3113|3114|3115|3116|3117|3118|3119|3120|3121|3122|3123|3124|3125|3126|3127|3128|3129|3130|3131|3132|3133|3134|3135|3136|3137|3138|3139|3140|3141|3142|3143|3144|3145|3146|3147|3148|3149|3150|3151|3152|3153|3154|3155|3156|3157|3158|3159|3160|3161|3162|3163|3164|3165|3166|3167|3168|3169|3170|3171|3172|3173|3174|3175|3176|3177|3178|3179|3180|3181|3182|3183|3184|3185|3186|3187|3188|3189|3190|3191|3192|3193|3194|3195|3196|3197|3198|3199|3200|3201|3202|3203|3204|3205|3206|3207|3208|3209|3210|3211|3212|3213|3214|3215|3216|3217|3218|3219|3220|3221|3222|3223|3224|3225|3226|3227|3228|3229|3230|3231|3232|3233|3234|3235|3236|3237|3238|3239|3240|3241|3242|3243|3244|3245|3246|3247|3248|3249|3250|3251|3252|3253|3254|3255|3256|3257|3258|3259|3260|3261|3262|3263|3264|3265|3266|', '1.000', '10.000', '0.120', '0', '1487757887', '1487757887');

-- ----------------------------
-- Table structure for cmf_express_ladder_prices
-- ----------------------------
DROP TABLE IF EXISTS `cmf_express_ladder_prices`;
CREATE TABLE `cmf_express_ladder_prices` (
  `ladder_price_id` int(11) NOT NULL AUTO_INCREMENT,
  `fw_price_id` int(11) NOT NULL COMMENT '首重ID',
  `weight_start` double(10,3) NOT NULL DEFAULT '0.000' COMMENT '重量起始值',
  `weight_end` double(10,3) NOT NULL DEFAULT '0.000' COMMENT '重量结束值',
  `ladder_discount` double(10,3) NOT NULL DEFAULT '1.000' COMMENT '折扣',
  `ladder_price` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT '阶梯价格',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除：1（TRUE）， 0（FALSE）',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`ladder_price_id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 COMMENT='国内件价目阶梯表';

-- ----------------------------
-- Records of cmf_express_ladder_prices
-- ----------------------------
INSERT INTO `cmf_express_ladder_prices` VALUES ('27', '7', '2.000', '10.000', '0.340', '15.000', '0', '1487757887', '1487757887');

-- ----------------------------
-- Table structure for cmf_express_template
-- ----------------------------
DROP TABLE IF EXISTS `cmf_express_template`;
CREATE TABLE `cmf_express_template` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `express_company_id` int(11) DEFAULT NULL,
  `express_tpl_name` varchar(25) NOT NULL,
  `express_tpl_encode` varchar(10) NOT NULL,
  `express_tpl_img` varchar(55) NOT NULL,
  `img_position` text NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_express_template
-- ----------------------------
INSERT INTO `cmf_express_template` VALUES ('18', null, '天天快递', 'TK00001', 'ExpressTemplate/2017-01-10/587485b004d16.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"81\";s:4:\"left\";s:3:\"102\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:3:\"238\";s:4:\"left\";s:2:\"20\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:2:\"83\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:1:\"1\";s:4:\"left\";s:3:\"642\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:2:\"43\";s:4:\"left\";s:3:\"642\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:2:\"82\";s:4:\"left\";s:3:\"642\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"224\";s:4:\"left\";s:2:\"72\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"169\";s:4:\"left\";s:2:\"90\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"166\";s:4:\"left\";s:3:\"236\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"194\";s:4:\"left\";s:2:\"41\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"195\";s:4:\"left\";s:2:\"74\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"193\";s:4:\"left\";s:3:\"147\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"194\";s:4:\"left\";s:3:\"248\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"252\";s:4:\"left\";s:2:\"80\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:2:\"78\";s:4:\"left\";s:3:\"698\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"296\";s:4:\"left\";s:2:\"80\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"296\";s:4:\"left\";s:3:\"113\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"295\";s:4:\"left\";s:3:\"140\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"162\";s:4:\"left\";s:3:\"708\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:2:\"80\";s:4:\"left\";s:3:\"327\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:2:\"80\";s:4:\"left\";s:3:\"447\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"103\";s:4:\"left\";s:3:\"337\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:1:\"1\";s:4:\"left\";s:3:\"600\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:2:\"41\";s:4:\"left\";s:3:\"599\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:2:\"83\";s:4:\"left\";s:3:\"599\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"126\";s:4:\"left\";s:3:\"327\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"169\";s:4:\"left\";s:3:\"335\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"168\";s:4:\"left\";s:3:\"446\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"610\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"219\";s:4:\"left\";s:3:\"602\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"238\";s:4:\"left\";s:3:\"604\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"238\";s:4:\"left\";s:2:\"20\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"193\";s:4:\"left\";s:3:\"606\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"195\";s:4:\"left\";s:3:\"331\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"191\";s:4:\"left\";s:3:\"363\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"214\";s:4:\"left\";s:3:\"343\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"214\";s:4:\"left\";s:3:\"380\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"214\";s:4:\"left\";s:3:\"409\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"216\";s:4:\"left\";s:3:\"443\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"213\";s:4:\"left\";s:3:\"483\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"304\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"384\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"466\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"286\";s:4:\"left\";s:3:\"424\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"307\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"251\";s:4:\"left\";s:3:\"715\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"134\";s:4:\"left\";s:3:\"713\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"711\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"292\";s:4:\"left\";s:3:\"309\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"292\";s:4:\"left\";s:3:\"339\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"292\";s:4:\"left\";s:3:\"365\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"288\";s:4:\"left\";s:3:\"174\";}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('13', null, 'd\'s\'f\'s', 'd\'s\'f\'f\'s\'', 'express/2017-01-08/5871de7868b33.jpg', 'a:2:{s:9:\"from_name\";a:2:{s:3:\"top\";s:3:\"184\";s:4:\"left\";s:3:\"150\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"476\";}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('14', null, 'a\'s\'ca\'s', 'a\'s\'ca', 'express/2017-01-08/5871deb002b4c.jpg', 'a:2:{s:9:\"from_name\";a:2:{s:3:\"top\";s:3:\"104\";s:4:\"left\";s:3:\"109\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:3:\"148\";s:4:\"left\";s:3:\"172\";}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('15', null, 'aaaa', 'adsads', 'express/2017-01-08/5871e625968f8.jpg', 'a:2:{s:9:\"from_name\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:12:\"from_address\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('16', null, 'asdaasdadasdasda', 'asda', 'express/2017-01-08/5871e99d56f10.jpg', 'a:2:{s:9:\"from_name\";a:2:{s:3:\"top\";s:3:\"105\";s:4:\"left\";s:3:\"441\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"88\";s:4:\"left\";s:3:\"110\";}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('17', null, '111111aasa', 'sdcaaasca', 'express/2017-01-10/587459784262d.jpg', 'a:32:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:3:\"112\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:3:\"244\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"127\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"136\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"207\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"283\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:2:\"71\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"143\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:2:\"97\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"276\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"114\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"227\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:2:\"69\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"105\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"137\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"309\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"441\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"572\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"445\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"489\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"558\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"637\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"390\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"466\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"429\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"570\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"429\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"571\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"607\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"639\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"672\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"225\";}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('19', null, 'a\'c\'s', 'a\'sa\'d\'sa', 'ExpressTemplate/2017-01-10/587485ce991c7.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:12:\"from_address\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"province_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"city_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"area_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:12:\"address_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"tel_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"phone_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"sign_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:6:\"y_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:6:\"m_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:6:\"d_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"to_name\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"to_address\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:12:\"province_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"city_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"area_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:11:\"address_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"tel_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"phone_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"weight_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"chang_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"height_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"v_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"wan_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"qian_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"bai_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"shi_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:11:\"charges_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"note_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"sign_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"card_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"card_dai\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"y_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"m_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"d_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:3:\"num\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('20', null, 'qsaa', 'asdada', 'ExpressTemplate/2017-01-10/587487116e172.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:1:\"5\";s:4:\"left\";s:1:\"3\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:1:\"2\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"city_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"area_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:12:\"address_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"tel_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"phone_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"sign_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:6:\"y_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:6:\"m_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:6:\"d_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"to_name\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"to_address\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:12:\"province_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"city_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"area_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:11:\"address_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"tel_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"phone_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"weight_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"chang_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"height_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"v_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"wan_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"qian_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"bai_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"shi_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"633\";s:4:\"left\";s:3:\"371\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"note_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"sign_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"card_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"card_dai\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"y_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"m_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"d_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"633\";s:4:\"left\";s:3:\"267\";}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('21', null, 'ooooooo', '5465662', 'ExpressTemplate/2017-01-10/58748eb1b830f.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"79\";s:4:\"left\";s:2:\"93\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"79\";s:4:\"left\";s:3:\"204\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"101\";s:4:\"left\";s:3:\"101\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"city_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"area_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:12:\"address_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"tel_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"phone_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"sign_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"319\";s:4:\"left\";s:3:\"220\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:6:\"m_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:6:\"d_send\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"to_name\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"to_address\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:12:\"province_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"city_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"area_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:11:\"address_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"tel_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"phone_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"weight_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:9:\"chang_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:10:\"height_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"v_get\";a:2:{s:3:\"top\";s:2:\"78\";s:4:\"left\";s:3:\"324\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"wan_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"qian_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"bai_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:7:\"shi_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"124\";s:4:\"left\";s:3:\"323\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"323\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"note_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"sign_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"card_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:8:\"card_dai\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"y_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"m_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:5:\"d_get\";a:2:{s:3:\"top\";s:0:\"\";s:4:\"left\";N;}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"288\";s:4:\"left\";s:3:\"243\";}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('22', null, '', '', 'ExpressTemplate/2017-01-10/58749bab71c70.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:3:\"112\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:3:\"244\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"127\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"136\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"207\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"283\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:2:\"71\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"143\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"258\";s:4:\"left\";s:3:\"898\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:2:\"40\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"135\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:2:\"97\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"276\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"114\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"227\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:2:\"69\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"105\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"137\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"309\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"441\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"572\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"445\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"489\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"558\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"637\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"390\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"466\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"619\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"508\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"527\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"568\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"608\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"399\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"508\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"607\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"480\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"515\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"549\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"581\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"612\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"416\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"519\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"648\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"411\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"429\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"570\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"429\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"571\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"607\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"639\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"672\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"225\";}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('23', null, '', '', 'ExpressTemplate/2017-01-10/58749be4a662d.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:3:\"112\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:3:\"244\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"127\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"136\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"207\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"283\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:2:\"71\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"143\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"250\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:2:\"40\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"135\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:2:\"97\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"276\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"114\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"227\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:2:\"69\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"105\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"137\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"309\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"441\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"572\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"445\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"489\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"558\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"637\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"390\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"466\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"619\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"508\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"527\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"568\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"608\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"399\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"508\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"607\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"480\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"515\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"549\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"581\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"612\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"416\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"519\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"648\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"411\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"429\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"570\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"429\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"571\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"607\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"639\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"672\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"225\";}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('24', null, '', '', 'ExpressTemplate/2017-01-10/58749e6555b52.jpg', 'a:1:{s:0:\"\";a:2:{s:3:\"top\";N;s:4:\"left\";N;}}', '1', '1484199526', '1484199526');
INSERT INTO `cmf_express_template` VALUES ('26', null, '11saaa', 'ascacacas', '', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484548840', '1484548840');
INSERT INTO `cmf_express_template` VALUES ('25', null, 'ascasca', 'acsacssa', '', '', '1', '0', '0');
INSERT INTO `cmf_express_template` VALUES ('27', null, 'ssc', 'scac', '', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484549005', '1484549005');
INSERT INTO `cmf_express_template` VALUES ('28', null, 'sc', '啊啊啊啊', '', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484549242', '1484549242');
INSERT INTO `cmf_express_template` VALUES ('29', null, '新模板', '1155484', 'upload/2017-01-16/587c76fb5dac5.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484551931', '1484551931');
INSERT INTO `cmf_express_template` VALUES ('30', null, 'ascaascacac', 'ascacas', 'upload/2017-01-16/587c77fc6ea69.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484552188', '1484552188');
INSERT INTO `cmf_express_template` VALUES ('31', null, 'sa\'c', 'a\'s\'ca', 'upload/2017-01-16/587c787a4bb55.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484552314', '1484552314');
INSERT INTO `cmf_express_template` VALUES ('32', null, 'ascaascacac', 'ascacas', 'upload/2017-01-16/587c79455fa5f.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484552517', '1484552517');
INSERT INTO `cmf_express_template` VALUES ('33', null, 'a\'s\'ca', '啊陈飒擦', 'upload/2017-01-16/587c797362c9a.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484552563', '1484552563');
INSERT INTO `cmf_express_template` VALUES ('34', null, 'ascac', 'acsacssa', 'upload/2017-01-16/587c7a0d35ad3.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484552717', '1484552717');
INSERT INTO `cmf_express_template` VALUES ('35', null, 'RHTR', 'HTRH', 'upload/2017-01-16/587c7df69fc12.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"41\";s:4:\"left\";s:2:\"41\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"418\";s:4:\"left\";s:3:\"418\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"373\";s:4:\"left\";s:3:\"373\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484553718', '1484553718');
INSERT INTO `cmf_express_template` VALUES ('36', null, 'sbffsb', 'sbfsbf', 'upload/2017-01-16/587c8090114df.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"87\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"116\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"102\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"155\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"208\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"280\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"354\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"353\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"388\";}}', '1', '1484554384', '1484554384');
INSERT INTO `cmf_express_template` VALUES ('37', null, '模板演示', 'test0001', 'upload/2017-01-16/587c812a9ef7d.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:9:\"from_name\";s:4:\"left\";s:2:\"77\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:12:\"from_address\";s:4:\"left\";s:2:\"87\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:14:\"unit_name_send\";s:4:\"left\";s:3:\"116\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:13:\"province_send\";s:4:\"left\";s:3:\"149\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:9:\"city_send\";s:4:\"left\";s:3:\"149\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:9:\"area_send\";s:4:\"left\";s:3:\"149\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:12:\"address_send\";s:4:\"left\";s:3:\"181\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:8:\"tel_send\";s:4:\"left\";s:3:\"202\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:10:\"phone_send\";s:4:\"left\";s:3:\"202\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:16:\"select_file_send\";s:4:\"left\";s:3:\"232\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:16:\"select_good_send\";s:4:\"left\";s:3:\"232\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:14:\"good_name_send\";s:4:\"left\";s:3:\"264\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:13:\"good_num_send\";s:4:\"left\";s:3:\"264\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:9:\"sign_send\";s:4:\"left\";s:3:\"337\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:8:\"sign_lan\";s:4:\"left\";s:3:\"334\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:6:\"y_send\";s:4:\"left\";s:3:\"368\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:6:\"m_send\";s:4:\"left\";s:3:\"368\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:6:\"d_send\";s:4:\"left\";s:3:\"369\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:8:\"seal_lan\";s:4:\"left\";s:3:\"336\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:7:\"to_name\";s:4:\"left\";s:3:\"102\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:10:\"to_address\";s:4:\"left\";s:3:\"103\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:13:\"unit_name_get\";s:4:\"left\";s:3:\"127\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:12:\"province_get\";s:4:\"left\";s:3:\"154\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:8:\"city_get\";s:4:\"left\";s:3:\"155\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:8:\"area_get\";s:4:\"left\";s:3:\"159\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:11:\"address_get\";s:4:\"left\";s:3:\"186\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:7:\"tel_get\";s:4:\"left\";s:3:\"208\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:9:\"phone_get\";s:4:\"left\";s:3:\"229\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:10:\"weight_get\";s:4:\"left\";s:3:\"231\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:9:\"chang_get\";s:4:\"left\";s:3:\"254\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:8:\"kuan_get\";s:4:\"left\";s:3:\"254\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:10:\"height_get\";s:4:\"left\";s:3:\"251\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:5:\"v_get\";s:4:\"left\";s:3:\"254\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:15:\"select_cash_get\";s:4:\"left\";s:3:\"280\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:14:\"select_own_get\";s:4:\"left\";s:3:\"288\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:7:\"wan_get\";s:4:\"left\";s:3:\"298\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:8:\"qian_get\";s:4:\"left\";s:3:\"298\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:7:\"bai_get\";s:4:\"left\";s:3:\"298\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:7:\"shi_get\";s:4:\"left\";s:3:\"298\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:8:\"yuan_get\";s:4:\"left\";s:3:\"298\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:11:\"charges_get\";s:4:\"left\";s:3:\"298\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:16:\"valuationfee_get\";s:4:\"left\";s:3:\"318\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:13:\"value_all_get\";s:4:\"left\";s:3:\"366\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:8:\"note_get\";s:4:\"left\";s:3:\"389\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:8:\"sign_get\";s:4:\"left\";s:3:\"318\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:8:\"card_get\";s:4:\"left\";s:3:\"315\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:8:\"sign_dai\";s:4:\"left\";s:3:\"344\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:8:\"card_dai\";s:4:\"left\";s:3:\"346\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:5:\"y_get\";s:4:\"left\";s:3:\"372\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:5:\"m_get\";s:4:\"left\";s:3:\"372\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:5:\"d_get\";s:4:\"left\";s:3:\"352\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"num\";s:4:\"left\";s:3:\"388\";}}', '1', '1484554538', '1484554538');
INSERT INTO `cmf_express_template` VALUES ('38', null, '模板示例1', 'test001', 'upload/2017-01-16/587c819dcad78.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"79\";s:4:\"left\";s:2:\"80\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:3:\"238\";s:4:\"left\";s:2:\"20\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"112\";s:4:\"left\";s:3:\"133\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"136\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"207\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"149\";s:4:\"left\";s:3:\"283\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"181\";s:4:\"left\";s:2:\"71\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"143\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"250\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:2:\"40\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"232\";s:4:\"left\";s:3:\"135\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:2:\"97\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"276\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"337\";s:4:\"left\";s:3:\"114\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"227\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:2:\"69\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"368\";s:4:\"left\";s:3:\"105\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"369\";s:4:\"left\";s:3:\"137\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"336\";s:4:\"left\";s:3:\"309\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"441\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"572\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"127\";s:4:\"left\";s:3:\"445\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"154\";s:4:\"left\";s:3:\"489\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"558\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"155\";s:4:\"left\";s:3:\"637\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"186\";s:4:\"left\";s:3:\"390\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"466\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"208\";s:4:\"left\";s:3:\"619\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"231\";s:4:\"left\";s:3:\"508\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"527\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"568\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"608\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"254\";s:4:\"left\";s:3:\"399\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"508\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"280\";s:4:\"left\";s:3:\"607\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"480\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"515\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"549\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"581\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"612\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"298\";s:4:\"left\";s:3:\"416\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"519\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"648\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"389\";s:4:\"left\";s:3:\"411\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:3:\"429\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"315\";s:4:\"left\";s:3:\"570\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"429\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"346\";s:4:\"left\";s:3:\"571\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"607\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"354\";s:4:\"left\";s:3:\"639\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"353\";s:4:\"left\";s:3:\"672\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"388\";s:4:\"left\";s:3:\"225\";}}', '0', '1484554653', '1488512659');
INSERT INTO `cmf_express_template` VALUES ('39', null, '123', '123', 'upload/2017-03-03/58b9019beb348.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"85\";s:4:\"left\";s:3:\"112\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"85\";s:4:\"left\";s:3:\"244\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"114\";s:4:\"left\";s:3:\"127\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"147\";s:4:\"left\";s:3:\"136\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"147\";s:4:\"left\";s:3:\"207\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"147\";s:4:\"left\";s:3:\"283\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"179\";s:4:\"left\";s:2:\"71\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"200\";s:4:\"left\";s:3:\"143\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"200\";s:4:\"left\";s:3:\"250\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"230\";s:4:\"left\";s:2:\"40\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"230\";s:4:\"left\";s:3:\"135\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"262\";s:4:\"left\";s:2:\"97\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"262\";s:4:\"left\";s:3:\"276\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"335\";s:4:\"left\";s:3:\"114\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"332\";s:4:\"left\";s:3:\"227\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"366\";s:4:\"left\";s:2:\"69\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"366\";s:4:\"left\";s:3:\"105\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"367\";s:4:\"left\";s:3:\"137\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"334\";s:4:\"left\";s:3:\"309\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:2:\"72\";s:4:\"left\";s:3:\"535\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:2:\"80\";s:4:\"left\";s:3:\"705\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"125\";s:4:\"left\";s:3:\"445\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"152\";s:4:\"left\";s:3:\"489\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"153\";s:4:\"left\";s:3:\"558\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"153\";s:4:\"left\";s:3:\"637\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"184\";s:4:\"left\";s:3:\"390\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"206\";s:4:\"left\";s:3:\"466\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"206\";s:4:\"left\";s:3:\"619\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"229\";s:4:\"left\";s:3:\"508\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"252\";s:4:\"left\";s:3:\"527\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"252\";s:4:\"left\";s:3:\"568\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"252\";s:4:\"left\";s:3:\"608\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"252\";s:4:\"left\";s:3:\"399\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"278\";s:4:\"left\";s:3:\"508\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"278\";s:4:\"left\";s:3:\"607\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"296\";s:4:\"left\";s:3:\"480\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"296\";s:4:\"left\";s:3:\"515\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"296\";s:4:\"left\";s:3:\"549\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"296\";s:4:\"left\";s:3:\"581\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"296\";s:4:\"left\";s:3:\"612\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"296\";s:4:\"left\";s:3:\"416\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"316\";s:4:\"left\";s:3:\"519\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"316\";s:4:\"left\";s:3:\"648\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"387\";s:4:\"left\";s:3:\"411\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"316\";s:4:\"left\";s:3:\"429\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"313\";s:4:\"left\";s:3:\"570\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"342\";s:4:\"left\";s:3:\"429\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"344\";s:4:\"left\";s:3:\"571\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"352\";s:4:\"left\";s:3:\"607\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"352\";s:4:\"left\";s:3:\"639\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"351\";s:4:\"left\";s:3:\"672\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"386\";s:4:\"left\";s:3:\"225\";}}', '0', '1488519579', '1488519588');
INSERT INTO `cmf_express_template` VALUES ('40', '2', '312', '123', 'upload/2017-03-03/58b903224feac.jpg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:3:\"140\";s:4:\"left\";s:3:\"164\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:3:\"130\";s:4:\"left\";s:3:\"338\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"166\";s:4:\"left\";s:3:\"149\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"198\";s:4:\"left\";s:3:\"124\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"196\";s:4:\"left\";s:3:\"210\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"194\";s:4:\"left\";s:3:\"276\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"237\";s:4:\"left\";s:3:\"121\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"276\";s:4:\"left\";s:3:\"291\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"276\";s:4:\"left\";s:3:\"133\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"318\";s:4:\"left\";s:2:\"82\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"319\";s:4:\"left\";s:3:\"163\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"380\";s:4:\"left\";s:3:\"263\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"309\";s:4:\"left\";s:3:\"432\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"453\";s:4:\"left\";s:3:\"118\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"403\";s:4:\"left\";s:3:\"412\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"474\";s:4:\"left\";s:3:\"289\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"473\";s:4:\"left\";s:3:\"327\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"473\";s:4:\"left\";s:3:\"363\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"359\";s:4:\"left\";s:3:\"388\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:2:\"50\";s:4:\"left\";s:3:\"441\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:2:\"50\";s:4:\"left\";s:3:\"572\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:2:\"75\";s:4:\"left\";s:3:\"445\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"489\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"103\";s:4:\"left\";s:3:\"558\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"103\";s:4:\"left\";s:3:\"637\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"374\";s:4:\"left\";s:3:\"578\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"156\";s:4:\"left\";s:3:\"466\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"156\";s:4:\"left\";s:3:\"619\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"179\";s:4:\"left\";s:3:\"508\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"527\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"568\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"202\";s:4:\"left\";s:3:\"608\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"347\";s:4:\"left\";s:3:\"160\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"228\";s:4:\"left\";s:3:\"508\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"228\";s:4:\"left\";s:3:\"607\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"246\";s:4:\"left\";s:3:\"480\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"246\";s:4:\"left\";s:3:\"515\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"246\";s:4:\"left\";s:3:\"549\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"246\";s:4:\"left\";s:3:\"581\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"246\";s:4:\"left\";s:3:\"612\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"246\";s:4:\"left\";s:3:\"416\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"266\";s:4:\"left\";s:3:\"519\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"266\";s:4:\"left\";s:3:\"648\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"380\";s:4:\"left\";s:3:\"152\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"426\";s:4:\"left\";s:3:\"673\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"263\";s:4:\"left\";s:3:\"570\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"460\";s:4:\"left\";s:3:\"564\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"294\";s:4:\"left\";s:3:\"571\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"302\";s:4:\"left\";s:3:\"607\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"302\";s:4:\"left\";s:3:\"639\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"301\";s:4:\"left\";s:3:\"672\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"535\";s:4:\"left\";s:3:\"369\";}}', '0', '1488519970', '1488524148');
INSERT INTO `cmf_express_template` VALUES ('41', '3', '测试模板', '3123123', 'upload/2017-03-03/58b914281941b.jpeg', 'a:52:{s:9:\"from_name\";a:2:{s:3:\"top\";s:2:\"97\";s:4:\"left\";s:3:\"132\";}s:12:\"from_address\";a:2:{s:3:\"top\";s:2:\"97\";s:4:\"left\";s:3:\"292\";}s:14:\"unit_name_send\";a:2:{s:3:\"top\";s:3:\"135\";s:4:\"left\";s:3:\"133\";}s:13:\"province_send\";a:2:{s:3:\"top\";s:3:\"167\";s:4:\"left\";s:3:\"128\";}s:9:\"city_send\";a:2:{s:3:\"top\";s:3:\"170\";s:4:\"left\";s:3:\"214\";}s:9:\"area_send\";a:2:{s:3:\"top\";s:3:\"169\";s:4:\"left\";s:3:\"300\";}s:12:\"address_send\";a:2:{s:3:\"top\";s:3:\"206\";s:4:\"left\";s:2:\"66\";}s:8:\"tel_send\";a:2:{s:3:\"top\";s:3:\"236\";s:4:\"left\";s:3:\"143\";}s:10:\"phone_send\";a:2:{s:3:\"top\";s:3:\"236\";s:4:\"left\";s:3:\"255\";}s:16:\"select_file_send\";a:2:{s:3:\"top\";s:3:\"316\";s:4:\"left\";s:2:\"59\";}s:16:\"select_good_send\";a:2:{s:3:\"top\";s:3:\"293\";s:4:\"left\";s:2:\"58\";}s:14:\"good_name_send\";a:2:{s:3:\"top\";s:3:\"265\";s:4:\"left\";s:3:\"144\";}s:13:\"good_num_send\";a:2:{s:3:\"top\";s:3:\"268\";s:4:\"left\";s:3:\"330\";}s:9:\"sign_send\";a:2:{s:3:\"top\";s:3:\"345\";s:4:\"left\";s:3:\"135\";}s:8:\"sign_lan\";a:2:{s:3:\"top\";s:3:\"282\";s:4:\"left\";s:3:\"227\";}s:6:\"y_send\";a:2:{s:3:\"top\";s:3:\"393\";s:4:\"left\";s:3:\"157\";}s:6:\"m_send\";a:2:{s:3:\"top\";s:3:\"393\";s:4:\"left\";s:3:\"196\";}s:6:\"d_send\";a:2:{s:3:\"top\";s:3:\"393\";s:4:\"left\";s:3:\"235\";}s:8:\"seal_lan\";a:2:{s:3:\"top\";s:3:\"140\";s:4:\"left\";s:3:\"726\";}s:7:\"to_name\";a:2:{s:3:\"top\";s:3:\"102\";s:4:\"left\";s:3:\"503\";}s:10:\"to_address\";a:2:{s:3:\"top\";s:3:\"101\";s:4:\"left\";s:3:\"666\";}s:13:\"unit_name_get\";a:2:{s:3:\"top\";s:3:\"138\";s:4:\"left\";s:3:\"510\";}s:12:\"province_get\";a:2:{s:3:\"top\";s:3:\"167\";s:4:\"left\";s:3:\"496\";}s:8:\"city_get\";a:2:{s:3:\"top\";s:3:\"161\";s:4:\"left\";s:3:\"592\";}s:8:\"area_get\";a:2:{s:3:\"top\";s:3:\"166\";s:4:\"left\";s:3:\"689\";}s:11:\"address_get\";a:2:{s:3:\"top\";s:3:\"205\";s:4:\"left\";s:3:\"424\";}s:7:\"tel_get\";a:2:{s:3:\"top\";s:3:\"237\";s:4:\"left\";s:3:\"535\";}s:9:\"phone_get\";a:2:{s:3:\"top\";s:3:\"236\";s:4:\"left\";s:3:\"675\";}s:10:\"weight_get\";a:2:{s:3:\"top\";s:3:\"265\";s:4:\"left\";s:3:\"461\";}s:9:\"chang_get\";a:2:{s:3:\"top\";s:3:\"264\";s:4:\"left\";s:3:\"592\";}s:8:\"kuan_get\";a:2:{s:3:\"top\";s:3:\"261\";s:4:\"left\";s:3:\"639\";}s:10:\"height_get\";a:2:{s:3:\"top\";s:3:\"263\";s:4:\"left\";s:3:\"696\";}s:5:\"v_get\";a:2:{s:3:\"top\";s:3:\"295\";s:4:\"left\";s:3:\"696\";}s:15:\"select_cash_get\";a:2:{s:3:\"top\";s:3:\"468\";s:4:\"left\";s:3:\"223\";}s:14:\"select_own_get\";a:2:{s:3:\"top\";s:3:\"453\";s:4:\"left\";s:3:\"315\";}s:7:\"wan_get\";a:2:{s:3:\"top\";s:3:\"462\";s:4:\"left\";s:3:\"576\";}s:8:\"qian_get\";a:2:{s:3:\"top\";s:3:\"461\";s:4:\"left\";s:3:\"627\";}s:7:\"bai_get\";a:2:{s:3:\"top\";s:3:\"461\";s:4:\"left\";s:3:\"682\";}s:7:\"shi_get\";a:2:{s:3:\"top\";s:3:\"458\";s:4:\"left\";s:3:\"737\";}s:8:\"yuan_get\";a:2:{s:3:\"top\";s:3:\"460\";s:4:\"left\";s:3:\"776\";}s:11:\"charges_get\";a:2:{s:3:\"top\";s:3:\"314\";s:4:\"left\";s:3:\"457\";}s:16:\"valuationfee_get\";a:2:{s:3:\"top\";s:3:\"332\";s:4:\"left\";s:3:\"659\";}s:13:\"value_all_get\";a:2:{s:3:\"top\";s:3:\"341\";s:4:\"left\";s:3:\"779\";}s:8:\"note_get\";a:2:{s:3:\"top\";s:3:\"410\";s:4:\"left\";s:3:\"726\";}s:8:\"sign_get\";a:2:{s:3:\"top\";s:3:\"373\";s:4:\"left\";s:3:\"652\";}s:8:\"card_get\";a:2:{s:3:\"top\";s:3:\"442\";s:4:\"left\";s:3:\"500\";}s:8:\"sign_dai\";a:2:{s:3:\"top\";s:3:\"393\";s:4:\"left\";s:3:\"441\";}s:8:\"card_dai\";a:2:{s:3:\"top\";s:3:\"443\";s:4:\"left\";s:3:\"424\";}s:5:\"y_get\";a:2:{s:3:\"top\";s:3:\"409\";s:4:\"left\";s:3:\"578\";}s:5:\"m_get\";a:2:{s:3:\"top\";s:3:\"406\";s:4:\"left\";s:3:\"625\";}s:5:\"d_get\";a:2:{s:3:\"top\";s:3:\"404\";s:4:\"left\";s:3:\"689\";}s:3:\"num\";a:2:{s:3:\"top\";s:3:\"420\";s:4:\"left\";s:3:\"438\";}}', '0', '1488524328', '1488526652');

-- ----------------------------
-- Table structure for cmf_guestbook
-- ----------------------------
DROP TABLE IF EXISTS `cmf_guestbook`;
CREATE TABLE `cmf_guestbook` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `full_name` varchar(50) NOT NULL COMMENT '留言者姓名',
  `email` varchar(100) NOT NULL COMMENT '留言者邮箱',
  `title` varchar(255) DEFAULT NULL COMMENT '留言标题',
  `msg` text NOT NULL COMMENT '留言内容',
  `createtime` datetime NOT NULL COMMENT '留言时间',
  `status` smallint(2) NOT NULL DEFAULT '1' COMMENT '留言状态，1：正常，0：删除',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='留言表';

-- ----------------------------
-- Records of cmf_guestbook
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_inter_express_prices
-- ----------------------------
DROP TABLE IF EXISTS `cmf_inter_express_prices`;
CREATE TABLE `cmf_inter_express_prices` (
  `inter_price_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '价目ID',
  `express_id` int(11) NOT NULL COMMENT '快递公司ID',
  `region_id` int(11) NOT NULL COMMENT '地区ID',
  `weight_start` double(10,3) NOT NULL DEFAULT '0.000' COMMENT '重量范围开始值，单位kg',
  `weight_end` double(10,3) NOT NULL DEFAULT '0.000' COMMENT '重量范围结束值，单位kg',
  `weight` double(10,3) NOT NULL DEFAULT '0.000' COMMENT '重量范围结束值，单位kg',
  `price` decimal(10,3) NOT NULL DEFAULT '0.000' COMMENT '价格',
  `discount` float(5,3) NOT NULL DEFAULT '1.000' COMMENT '折扣',
  `tariff` float(5,3) NOT NULL DEFAULT '0.000' COMMENT '费率，燃油费率',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除：1（TRUE）， 0（FALSE）',
  `create_time` int(10) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(10) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`inter_price_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_inter_express_prices
-- ----------------------------
INSERT INTO `cmf_inter_express_prices` VALUES ('3', '2', '3268', '0.500', '1.000', '0.000', '12.000', '1.000', '1.000', '0', '1487742743', '1487742743');
INSERT INTO `cmf_inter_express_prices` VALUES ('2', '2', '3268', '10.000', '20.000', '2.000', '12.000', '1.000', '1.000', '0', '1487644963', '1487758698');

-- ----------------------------
-- Table structure for cmf_links
-- ----------------------------
DROP TABLE IF EXISTS `cmf_links`;
CREATE TABLE `cmf_links` (
  `link_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `link_url` varchar(255) NOT NULL COMMENT '友情链接地址',
  `link_name` varchar(255) NOT NULL COMMENT '友情链接名称',
  `link_image` varchar(255) DEFAULT NULL COMMENT '友情链接图标',
  `link_target` varchar(25) NOT NULL DEFAULT '_blank' COMMENT '友情链接打开方式',
  `link_description` text NOT NULL COMMENT '友情链接描述',
  `link_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  `link_rating` int(11) NOT NULL DEFAULT '0' COMMENT '友情链接评级',
  `link_rel` varchar(255) DEFAULT NULL COMMENT '链接与网站的关系',
  `listorder` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`link_id`),
  KEY `link_visible` (`link_status`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='友情链接表';

-- ----------------------------
-- Records of cmf_links
-- ----------------------------
INSERT INTO `cmf_links` VALUES ('1', 'http://www.thinkcmf.com', 'ThinkCMF', '', '_blank', '', '1', '0', '', '0');

-- ----------------------------
-- Table structure for cmf_mailroom
-- ----------------------------
DROP TABLE IF EXISTS `cmf_mailroom`;
CREATE TABLE `cmf_mailroom` (
  `mailroom_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT 'mailroom ID， 自增，主键',
  `mailroom_name` varchar(100) NOT NULL COMMENT 'mailroom 名称',
  `contacts` varchar(100) DEFAULT NULL COMMENT '联系人',
  `mobile` varchar(20) DEFAULT NULL COMMENT '联系人手机',
  `tel` varchar(20) DEFAULT NULL COMMENT '联系人电话',
  `city` varchar(100) DEFAULT NULL,
  `customer` varchar(100) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除：1（TRUE）， 0（FALSE）',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  PRIMARY KEY (`mailroom_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COMMENT='mailroom';

-- ----------------------------
-- Records of cmf_mailroom
-- ----------------------------
INSERT INTO `cmf_mailroom` VALUES ('1', 'mailroom1', '张三', '18895647854', '3689547', '111', '222', '333', '0', '1484199526', '1486364701');
INSERT INTO `cmf_mailroom` VALUES ('2', '威锋网', '李四的', '18659745874', '1111111', null, null, null, '0', '1484295019', '1484533130');
INSERT INTO `cmf_mailroom` VALUES ('3', 'asca', '王五', '186954786545', '35697458', null, null, null, '1', '1484295341', '1484295341');
INSERT INTO `cmf_mailroom` VALUES ('4', 'macsas', '李帅', '18565475984', '3569847', null, null, null, '1', '1484530153', '1484530153');
INSERT INTO `cmf_mailroom` VALUES ('6', '阿斯蒂芬', '是否', '1863269845', '', null, null, null, '1', '1484535326', '1484535326');
INSERT INTO `cmf_mailroom` VALUES ('7', '11111', '2222', '33333', '44444', '55555', '66666', '7777', '0', '1486366881', '1486366881');

-- ----------------------------
-- Table structure for cmf_menu
-- ----------------------------
DROP TABLE IF EXISTS `cmf_menu`;
CREATE TABLE `cmf_menu` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `parentid` smallint(6) unsigned NOT NULL DEFAULT '0',
  `app` varchar(30) NOT NULL DEFAULT '' COMMENT '应用名称app',
  `model` varchar(30) NOT NULL DEFAULT '' COMMENT '控制器',
  `action` varchar(50) NOT NULL DEFAULT '' COMMENT '操作名称',
  `data` varchar(50) NOT NULL DEFAULT '' COMMENT '额外参数',
  `type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '菜单类型  1：权限认证+菜单；0：只作为菜单',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT '状态，1显示，0不显示',
  `name` varchar(50) NOT NULL COMMENT '菜单名称',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `remark` varchar(255) NOT NULL DEFAULT '' COMMENT '备注',
  `listorder` smallint(6) unsigned NOT NULL DEFAULT '0' COMMENT '排序ID',
  PRIMARY KEY (`id`),
  KEY `status` (`status`),
  KEY `parentid` (`parentid`),
  KEY `model` (`model`)
) ENGINE=MyISAM AUTO_INCREMENT=223 DEFAULT CHARSET=utf8 COMMENT='后台菜单表';

-- ----------------------------
-- Records of cmf_menu
-- ----------------------------
INSERT INTO `cmf_menu` VALUES ('1', '0', 'Admin', 'Content', 'default', '', '0', '1', '内容管理', 'th', '', '30');
INSERT INTO `cmf_menu` VALUES ('2', '1', 'Api', 'Guestbookadmin', 'index', '', '1', '1', '所有留言', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('3', '2', 'Api', 'Guestbookadmin', 'delete', '', '1', '0', '删除网站留言', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('4', '1', 'Comment', 'Commentadmin', 'index', '', '1', '1', '评论管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('5', '4', 'Comment', 'Commentadmin', 'delete', '', '1', '0', '删除评论', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('6', '4', 'Comment', 'Commentadmin', 'check', '', '1', '0', '评论审核', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('7', '1', 'Portal', 'AdminPost', 'index', '', '1', '1', '文章管理', '', '', '1');
INSERT INTO `cmf_menu` VALUES ('8', '7', 'Portal', 'AdminPost', 'listorders', '', '1', '0', '文章排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('9', '7', 'Portal', 'AdminPost', 'top', '', '1', '0', '文章置顶', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('10', '7', 'Portal', 'AdminPost', 'recommend', '', '1', '0', '文章推荐', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('11', '7', 'Portal', 'AdminPost', 'move', '', '1', '0', '批量移动', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('12', '7', 'Portal', 'AdminPost', 'check', '', '1', '0', '文章审核', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('13', '7', 'Portal', 'AdminPost', 'delete', '', '1', '0', '删除文章', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('14', '7', 'Portal', 'AdminPost', 'edit', '', '1', '0', '编辑文章', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('15', '14', 'Portal', 'AdminPost', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('16', '7', 'Portal', 'AdminPost', 'add', '', '1', '0', '添加文章', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('17', '16', 'Portal', 'AdminPost', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('18', '1', 'Portal', 'AdminTerm', 'index', '', '0', '1', '分类管理', '', '', '2');
INSERT INTO `cmf_menu` VALUES ('19', '18', 'Portal', 'AdminTerm', 'listorders', '', '1', '0', '文章分类排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('20', '18', 'Portal', 'AdminTerm', 'delete', '', '1', '0', '删除分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('21', '18', 'Portal', 'AdminTerm', 'edit', '', '1', '0', '编辑分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('22', '21', 'Portal', 'AdminTerm', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('23', '18', 'Portal', 'AdminTerm', 'add', '', '1', '0', '添加分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('24', '23', 'Portal', 'AdminTerm', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('25', '1', 'Portal', 'AdminPage', 'index', '', '1', '1', '页面管理', '', '', '3');
INSERT INTO `cmf_menu` VALUES ('26', '25', 'Portal', 'AdminPage', 'listorders', '', '1', '0', '页面排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('27', '25', 'Portal', 'AdminPage', 'delete', '', '1', '0', '删除页面', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('28', '25', 'Portal', 'AdminPage', 'edit', '', '1', '0', '编辑页面', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('29', '28', 'Portal', 'AdminPage', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('30', '25', 'Portal', 'AdminPage', 'add', '', '1', '0', '添加页面', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('31', '30', 'Portal', 'AdminPage', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('32', '1', 'Admin', 'Recycle', 'default', '', '1', '1', '回收站', '', '', '4');
INSERT INTO `cmf_menu` VALUES ('33', '32', 'Portal', 'AdminPost', 'recyclebin', '', '1', '1', '文章回收', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('34', '33', 'Portal', 'AdminPost', 'restore', '', '1', '0', '文章还原', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('35', '33', 'Portal', 'AdminPost', 'clean', '', '1', '0', '彻底删除', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('36', '32', 'Portal', 'AdminPage', 'recyclebin', '', '1', '1', '页面回收', '', '', '1');
INSERT INTO `cmf_menu` VALUES ('37', '36', 'Portal', 'AdminPage', 'clean', '', '1', '0', '彻底删除', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('38', '36', 'Portal', 'AdminPage', 'restore', '', '1', '0', '页面还原', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('39', '0', 'Admin', 'Extension', 'default', '', '0', '0', '扩展工具', 'cloud', '', '40');
INSERT INTO `cmf_menu` VALUES ('40', '39', 'Admin', 'Backup', 'default', '', '1', '0', '备份管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('41', '40', 'Admin', 'Backup', 'restore', '', '1', '1', '数据还原', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('42', '40', 'Admin', 'Backup', 'index', '', '1', '1', '数据备份', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('43', '42', 'Admin', 'Backup', 'index_post', '', '1', '0', '提交数据备份', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('44', '40', 'Admin', 'Backup', 'download', '', '1', '0', '下载备份', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('45', '40', 'Admin', 'Backup', 'del_backup', '', '1', '0', '删除备份', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('46', '40', 'Admin', 'Backup', 'import', '', '1', '0', '数据备份导入', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('47', '39', 'Admin', 'Plugin', 'index', '', '1', '1', '插件管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('48', '47', 'Admin', 'Plugin', 'toggle', '', '1', '0', '插件启用切换', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('49', '47', 'Admin', 'Plugin', 'setting', '', '1', '0', '插件设置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('50', '49', 'Admin', 'Plugin', 'setting_post', '', '1', '0', '插件设置提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('51', '47', 'Admin', 'Plugin', 'install', '', '1', '0', '插件安装', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('52', '47', 'Admin', 'Plugin', 'uninstall', '', '1', '0', '插件卸载', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('53', '39', 'Admin', 'Slide', 'default', '', '1', '1', '幻灯片', '', '', '1');
INSERT INTO `cmf_menu` VALUES ('54', '53', 'Admin', 'Slide', 'index', '', '1', '1', '幻灯片管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('55', '54', 'Admin', 'Slide', 'listorders', '', '1', '0', '幻灯片排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('56', '54', 'Admin', 'Slide', 'toggle', '', '1', '0', '幻灯片显示切换', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('57', '54', 'Admin', 'Slide', 'delete', '', '1', '0', '删除幻灯片', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('58', '54', 'Admin', 'Slide', 'edit', '', '1', '0', '编辑幻灯片', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('59', '58', 'Admin', 'Slide', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('60', '54', 'Admin', 'Slide', 'add', '', '1', '0', '添加幻灯片', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('61', '60', 'Admin', 'Slide', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('62', '53', 'Admin', 'Slidecat', 'index', '', '1', '1', '幻灯片分类', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('63', '62', 'Admin', 'Slidecat', 'delete', '', '1', '0', '删除分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('64', '62', 'Admin', 'Slidecat', 'edit', '', '1', '0', '编辑分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('65', '64', 'Admin', 'Slidecat', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('66', '62', 'Admin', 'Slidecat', 'add', '', '1', '0', '添加分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('67', '66', 'Admin', 'Slidecat', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('68', '39', 'Admin', 'Ad', 'index', '', '1', '1', '网站广告', '', '', '2');
INSERT INTO `cmf_menu` VALUES ('69', '68', 'Admin', 'Ad', 'toggle', '', '1', '0', '广告显示切换', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('70', '68', 'Admin', 'Ad', 'delete', '', '1', '0', '删除广告', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('71', '68', 'Admin', 'Ad', 'edit', '', '1', '0', '编辑广告', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('72', '71', 'Admin', 'Ad', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('73', '68', 'Admin', 'Ad', 'add', '', '1', '0', '添加广告', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('74', '73', 'Admin', 'Ad', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('75', '39', 'Admin', 'Link', 'index', '', '0', '1', '友情链接', '', '', '3');
INSERT INTO `cmf_menu` VALUES ('76', '75', 'Admin', 'Link', 'listorders', '', '1', '0', '友情链接排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('77', '75', 'Admin', 'Link', 'toggle', '', '1', '0', '友链显示切换', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('78', '75', 'Admin', 'Link', 'delete', '', '1', '0', '删除友情链接', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('79', '75', 'Admin', 'Link', 'edit', '', '1', '0', '编辑友情链接', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('80', '79', 'Admin', 'Link', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('81', '75', 'Admin', 'Link', 'add', '', '1', '0', '添加友情链接', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('82', '81', 'Admin', 'Link', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('83', '39', 'Api', 'Oauthadmin', 'setting', '', '1', '1', '第三方登陆', 'leaf', '', '4');
INSERT INTO `cmf_menu` VALUES ('84', '83', 'Api', 'Oauthadmin', 'setting_post', '', '1', '0', '提交设置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('85', '109', 'Admin', 'Menu', 'default', '', '1', '1', '菜单管理', 'list', '', '20');
INSERT INTO `cmf_menu` VALUES ('86', '85', 'Admin', 'Navcat', 'default1', '', '1', '1', '前台菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('87', '86', 'Admin', 'Nav', 'index', '', '1', '1', '菜单管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('88', '87', 'Admin', 'Nav', 'listorders', '', '1', '0', '前台导航排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('89', '87', 'Admin', 'Nav', 'delete', '', '1', '0', '删除菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('90', '87', 'Admin', 'Nav', 'edit', '', '1', '0', '编辑菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('91', '90', 'Admin', 'Nav', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('92', '87', 'Admin', 'Nav', 'add', '', '1', '0', '添加菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('93', '92', 'Admin', 'Nav', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('94', '86', 'Admin', 'Navcat', 'index', '', '1', '1', '菜单分类', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('95', '94', 'Admin', 'Navcat', 'delete', '', '1', '0', '删除分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('96', '94', 'Admin', 'Navcat', 'edit', '', '1', '0', '编辑分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('97', '96', 'Admin', 'Navcat', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('98', '94', 'Admin', 'Navcat', 'add', '', '1', '0', '添加分类', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('99', '98', 'Admin', 'Navcat', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('100', '85', 'Admin', 'Menu', 'index', '', '1', '1', '后台菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('101', '100', 'Admin', 'Menu', 'add', '', '1', '0', '添加菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('102', '101', 'Admin', 'Menu', 'add_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('103', '100', 'Admin', 'Menu', 'listorders', '', '1', '0', '后台菜单排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('104', '100', 'Admin', 'Menu', 'export_menu', '', '1', '0', '菜单备份', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('105', '100', 'Admin', 'Menu', 'edit', '', '1', '0', '编辑菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('106', '105', 'Admin', 'Menu', 'edit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('107', '100', 'Admin', 'Menu', 'delete', '', '1', '0', '删除菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('108', '100', 'Admin', 'Menu', 'lists', '', '1', '0', '所有菜单', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('109', '0', 'Admin', 'Setting', 'default', '', '0', '1', '基本设置', 'cogs', '', '0');
INSERT INTO `cmf_menu` VALUES ('110', '109', 'Admin', 'Setting', 'userdefault', '', '0', '1', '个人信息', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('111', '110', 'Admin', 'User', 'userinfo', '', '1', '1', '修改信息', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('112', '111', 'Admin', 'User', 'userinfo_post', '', '1', '0', '修改信息提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('113', '110', 'Admin', 'Setting', 'password', '', '1', '1', '修改密码', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('114', '113', 'Admin', 'Setting', 'password_post', '', '1', '0', '提交修改', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('115', '109', 'Admin', 'Setting', 'site', '', '1', '1', '网站信息', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('116', '115', 'Admin', 'Setting', 'site_post', '', '1', '0', '提交修改', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('117', '115', 'Admin', 'Route', 'index', '', '1', '0', '路由列表', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('118', '115', 'Admin', 'Route', 'add', '', '1', '0', '路由添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('119', '118', 'Admin', 'Route', 'add_post', '', '1', '0', '路由添加提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('120', '115', 'Admin', 'Route', 'edit', '', '1', '0', '路由编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('121', '120', 'Admin', 'Route', 'edit_post', '', '1', '0', '路由编辑提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('122', '115', 'Admin', 'Route', 'delete', '', '1', '0', '路由删除', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('123', '115', 'Admin', 'Route', 'ban', '', '1', '0', '路由禁止', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('124', '115', 'Admin', 'Route', 'open', '', '1', '0', '路由启用', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('125', '115', 'Admin', 'Route', 'listorders', '', '1', '0', '路由排序', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('126', '109', 'Admin', 'Mailer', 'default', '', '1', '1', '邮箱配置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('127', '126', 'Admin', 'Mailer', 'index', '', '1', '1', 'SMTP配置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('128', '127', 'Admin', 'Mailer', 'index_post', '', '1', '0', '提交配置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('129', '126', 'Admin', 'Mailer', 'active', '', '1', '1', '注册邮件模板', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('130', '129', 'Admin', 'Mailer', 'active_post', '', '1', '0', '提交模板', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('131', '109', 'Admin', 'Setting', 'clearcache', '', '1', '1', '清除缓存', '', '', '1');
INSERT INTO `cmf_menu` VALUES ('132', '0', 'User', 'Indexadmin', 'default', '', '1', '0', '用户管理', 'group', '', '10');
INSERT INTO `cmf_menu` VALUES ('133', '132', 'User', 'Indexadmin', 'default1', '', '1', '1', '用户组', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('134', '133', 'User', 'Indexadmin', 'index', '', '1', '1', '本站用户', 'leaf', '', '0');
INSERT INTO `cmf_menu` VALUES ('135', '134', 'User', 'Indexadmin', 'ban', '', '1', '0', '拉黑会员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('136', '134', 'User', 'Indexadmin', 'cancelban', '', '1', '0', '启用会员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('137', '133', 'User', 'Oauthadmin', 'index', '', '1', '1', '第三方用户', 'leaf', '', '0');
INSERT INTO `cmf_menu` VALUES ('138', '137', 'User', 'Oauthadmin', 'delete', '', '1', '0', '第三方用户解绑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('139', '109', 'User', 'Indexadmin', 'default3', '', '1', '1', '用户管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('140', '139', 'Admin', 'Rbac', 'index', '', '1', '1', '角色管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('141', '140', 'Admin', 'Rbac', 'member', '', '1', '0', '成员管理', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('142', '140', 'Admin', 'Rbac', 'authorize', '', '1', '0', '权限设置', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('143', '142', 'Admin', 'Rbac', 'authorize_post', '', '1', '0', '提交设置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('144', '140', 'Admin', 'Rbac', 'roleedit', '', '1', '0', '编辑角色', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('145', '144', 'Admin', 'Rbac', 'roleedit_post', '', '1', '0', '提交编辑', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('146', '140', 'Admin', 'Rbac', 'roledelete', '', '1', '1', '删除角色', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('147', '140', 'Admin', 'Rbac', 'roleadd', '', '1', '1', '添加角色', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('148', '147', 'Admin', 'Rbac', 'roleadd_post', '', '1', '0', '提交添加', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('149', '139', 'Admin', 'User', 'index', '', '1', '1', '管理员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('150', '149', 'Admin', 'User', 'delete', '', '1', '0', '删除管理员', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('151', '149', 'Admin', 'User', 'edit', '', '1', '0', '管理员编辑', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('152', '151', 'Admin', 'User', 'edit_post', '', '1', '0', '编辑提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('153', '149', 'Admin', 'User', 'add', '', '1', '0', '管理员添加', '', '', '1000');
INSERT INTO `cmf_menu` VALUES ('154', '153', 'Admin', 'User', 'add_post', '', '1', '0', '添加提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('155', '47', 'Admin', 'Plugin', 'update', '', '1', '0', '插件更新', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('156', '109', 'Admin', 'Storage', 'index', '', '1', '1', '文件存储', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('157', '156', 'Admin', 'Storage', 'setting_post', '', '1', '0', '文件存储设置提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('158', '54', 'Admin', 'Slide', 'ban', '', '1', '0', '禁用幻灯片', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('159', '54', 'Admin', 'Slide', 'cancelban', '', '1', '0', '启用幻灯片', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('160', '149', 'Admin', 'User', 'ban', '', '1', '0', '禁用管理员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('161', '149', 'Admin', 'User', 'cancelban', '', '1', '0', '启用管理员', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('166', '127', 'Admin', 'Mailer', 'test', '', '1', '0', '测试邮件', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('167', '109', 'Admin', 'Setting', 'upload', '', '1', '1', '上传设置', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('168', '167', 'Admin', 'Setting', 'upload_post', '', '1', '0', '上传设置提交', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('169', '7', 'Portal', 'AdminPost', 'copy', '', '1', '0', '文章批量复制', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('174', '100', 'Admin', 'Menu', 'backup_menu', '', '1', '0', '备份菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('175', '100', 'Admin', 'Menu', 'export_menu_lang', '', '1', '0', '导出后台菜单多语言包', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('176', '100', 'Admin', 'Menu', 'restore_menu', '', '1', '0', '还原菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('177', '100', 'Admin', 'Menu', 'getactions', '', '1', '0', '导入新菜单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('187', '0', 'Admin', 'Master', 'default', '', '1', '1', '基础档案', 'eyedropper', '', '0');
INSERT INTO `cmf_menu` VALUES ('188', '187', 'Admin', 'Staff', 'index', '', '1', '1', '员工信息', 'life-ring', '', '0');
INSERT INTO `cmf_menu` VALUES ('189', '187', 'Admin', 'Departments', 'index', '', '1', '1', '部门信息', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('190', '187', 'Admin', 'Company', 'default', '', '1', '0', '企业信息', 'magnet', '', '0');
INSERT INTO `cmf_menu` VALUES ('191', '187', 'Admin', 'Costcenters', 'index', '', '1', '1', '成本中心', 'meh-o', '', '0');
INSERT INTO `cmf_menu` VALUES ('220', '187', 'Admin', 'Seat', 'index', '', '1', '1', '座位号', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('193', '187', 'Admin', 'Mailroom', 'index', '', '1', '1', 'MailRoom', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('194', '187', 'Admin', 'ExpressCompany', 'index', '', '1', '1', '快递公司', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('221', '187', 'Admin', 'Send', 'index', '', '1', '1', '派送计划', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('196', '187', 'Admin', 'PackageAddress', 'index', '', '1', '1', '收件地址', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('197', '0', 'Express', 'Receiving', 'index', '', '1', '1', '收件管理', 'twitch', '', '0');
INSERT INTO `cmf_menu` VALUES ('198', '0', 'Express', 'Sending', 'default', '', '1', '1', '发件管理', 'slideshare', '', '0');
INSERT INTO `cmf_menu` VALUES ('199', '0', 'Admin', 'Reports', 'default', '', '1', '1', '系统报表', 'line-chart', '', '0');
INSERT INTO `cmf_menu` VALUES ('200', '199', 'Admin', 'Delivery', 'default', '', '1', '1', '快件查询', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('201', '199', 'Admin', 'DeliveryReports', 'default', '', '1', '1', '快件报表', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('202', '199', 'Admin', 'BillImport', 'default', '', '1', '1', '账单导入', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('203', '199', 'Admin', 'Balance', 'default', '', '1', '1', '快递对账', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('204', '109', 'Admin', 'Regions', 'index', '', '1', '1', '地区管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('205', '197', 'Express', 'Receiving', 'create', '', '1', '1', '收件任务', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('206', '197', 'Express', 'Receiving', 'location', '', '1', '1', '定位收件', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('207', '197', 'Express', 'Receiving', 'printlabel', '', '1', '1', '标签打印', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('209', '197', 'Express', 'Delivery', 'printing', '', '1', '1', '派送单打印', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('222', '109', 'Admin', 'Queue', 'index', '', '1', '1', '导入导出队列', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('211', '197', 'Express', 'Archiving', 'archive', '', '1', '1', '派送归档', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('212', '197', 'Admin', 'Recivering', 'letter', '', '1', '1', '平信管理', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('213', '197', 'Express', 'Archiving', 'late_file', '', '1', '1', '滞纳件', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('214', '198', 'Express', 'Sending', 'index', '', '1', '1', '发件任务', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('215', '198', 'Admin', 'Sender', 'print', '', '1', '1', '快递单打印', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('216', '198', 'Admin', 'Sender', 'list', '', '1', '1', '出件清单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('217', '198', 'Admin', 'Sender', 'archive ', '', '1', '1', '出件归档', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('218', '198', 'Admin', 'Sender', 'get', '', '1', '1', '取件清单', '', '', '0');
INSERT INTO `cmf_menu` VALUES ('219', '187', 'Admin', 'Way', 'index', '', '1', '1', '派送路径', '', '', '0');

-- ----------------------------
-- Table structure for cmf_nav
-- ----------------------------
DROP TABLE IF EXISTS `cmf_nav`;
CREATE TABLE `cmf_nav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cid` int(11) NOT NULL COMMENT '导航分类 id',
  `parentid` int(11) NOT NULL COMMENT '导航父 id',
  `label` varchar(255) NOT NULL COMMENT '导航标题',
  `target` varchar(50) DEFAULT NULL COMMENT '打开方式',
  `href` varchar(255) NOT NULL COMMENT '导航链接',
  `icon` varchar(255) NOT NULL COMMENT '导航图标',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  `listorder` int(6) DEFAULT '0' COMMENT '排序',
  `path` varchar(255) NOT NULL DEFAULT '0' COMMENT '层级关系',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='前台导航表';

-- ----------------------------
-- Records of cmf_nav
-- ----------------------------
INSERT INTO `cmf_nav` VALUES ('1', '1', '0', '首页', '', 'home', '', '1', '0', '0-1');
INSERT INTO `cmf_nav` VALUES ('2', '1', '0', '列表演示', '', 'a:2:{s:6:\"action\";s:17:\"Portal/List/index\";s:5:\"param\";a:1:{s:2:\"id\";s:1:\"1\";}}', '', '1', '0', '0-2');
INSERT INTO `cmf_nav` VALUES ('3', '1', '0', '瀑布流', '', 'a:2:{s:6:\"action\";s:17:\"Portal/List/index\";s:5:\"param\";a:1:{s:2:\"id\";s:1:\"2\";}}', '', '1', '0', '0-3');

-- ----------------------------
-- Table structure for cmf_nav_cat
-- ----------------------------
DROP TABLE IF EXISTS `cmf_nav_cat`;
CREATE TABLE `cmf_nav_cat` (
  `navcid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '导航分类名',
  `active` int(1) NOT NULL DEFAULT '1' COMMENT '是否为主菜单，1是，0不是',
  `remark` text COMMENT '备注',
  PRIMARY KEY (`navcid`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='前台导航分类表';

-- ----------------------------
-- Records of cmf_nav_cat
-- ----------------------------
INSERT INTO `cmf_nav_cat` VALUES ('1', '主导航', '1', '主导航');

-- ----------------------------
-- Table structure for cmf_oauth_user
-- ----------------------------
DROP TABLE IF EXISTS `cmf_oauth_user`;
CREATE TABLE `cmf_oauth_user` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `from` varchar(20) NOT NULL COMMENT '用户来源key',
  `name` varchar(30) NOT NULL COMMENT '第三方昵称',
  `head_img` varchar(200) NOT NULL COMMENT '头像',
  `uid` int(20) NOT NULL COMMENT '关联的本站用户id',
  `create_time` datetime NOT NULL COMMENT '绑定时间',
  `last_login_time` datetime NOT NULL COMMENT '最后登录时间',
  `last_login_ip` varchar(16) NOT NULL COMMENT '最后登录ip',
  `login_times` int(6) NOT NULL COMMENT '登录次数',
  `status` tinyint(2) NOT NULL,
  `access_token` varchar(512) NOT NULL,
  `expires_date` int(11) NOT NULL COMMENT 'access_token过期时间',
  `openid` varchar(40) NOT NULL COMMENT '第三方用户id',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='第三方用户表';

-- ----------------------------
-- Records of cmf_oauth_user
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `cmf_operation_log`;
CREATE TABLE `cmf_operation_log` (
  `operation_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '操作记录主键',
  `operation_uid` bigint(20) NOT NULL DEFAULT '0' COMMENT '操作人/如果是接口返回-1暂不记录接口请求人',
  `operation_node` char(50) NOT NULL DEFAULT '' COMMENT '操作节点',
  `operation_content` varchar(255) NOT NULL DEFAULT '' COMMENT '操作内容',
  `operation_ip` text NOT NULL COMMENT '记录操作IP,省市,等信息',
  `operation_time` int(10) NOT NULL DEFAULT '0' COMMENT '操作时间',
  PRIMARY KEY (`operation_id`),
  KEY `index_uid_node` (`operation_uid`,`operation_node`,`operation_id`)
) ENGINE=InnoDB AUTO_INCREMENT=165 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_operation_log
-- ----------------------------
INSERT INTO `cmf_operation_log` VALUES ('4', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:哈哈哈', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486350039');
INSERT INTO `cmf_operation_log` VALUES ('5', '1', 'g=Admin&m=Staff&a=delete&staff_id=12', '删除员工:哈哈哈', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486350147');
INSERT INTO `cmf_operation_log` VALUES ('6', '1', 'g=Admin&m=Staff&a=delete&staff_id=11', '删除员工:你地哦十年前', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486351533');
INSERT INTO `cmf_operation_log` VALUES ('7', '1', 'g=Admin&m=Regions&a=deleteArea&id=3315', '删除地区:各个', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486352827');
INSERT INTO `cmf_operation_log` VALUES ('8', '1', 'g=Admin&m=Regions&a=updateArea', '更新地区:从未承认威尔士', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486352909');
INSERT INTO `cmf_operation_log` VALUES ('9', '1', 'g=Admin&m=Regions&a=updateArea', '添加地区:从未承认威尔士', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486352909');
INSERT INTO `cmf_operation_log` VALUES ('10', '1', 'g=Admin&m=Regions&a=updateArea', '更新地区:从未承认', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486352960');
INSERT INTO `cmf_operation_log` VALUES ('11', '1', 'g=Admin&m=PackageAddress&a=delete', '批量删除打包地址:我家,呵呵,纱包线,哈哈哈,rcvewers,fcv3wvc4,cadscs,uyvyb,s brtev,s brte', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486430353');
INSERT INTO `cmf_operation_log` VALUES ('12', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:重复涩女', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486430407');
INSERT INTO `cmf_operation_log` VALUES ('13', '1', 'g=Admin&m=Staff&a=delete', '批量删除员工:重复涩女', 'a:5:{s:2:\"ip\";s:7:\"0.0.0.0\";s:7:\"beginip\";s:7:\"0.0.0.0\";s:5:\"endip\";s:13:\"0.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:12:\"保留地址\";}', '1486430421');
INSERT INTO `cmf_operation_log` VALUES ('14', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL120170217000009-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1487924480');
INSERT INTO `cmf_operation_log` VALUES ('15', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL120170217000008-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1487925594');
INSERT INTO `cmf_operation_log` VALUES ('16', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL120170217000009-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1487931043');
INSERT INTO `cmf_operation_log` VALUES ('17', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170225000001-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1487953353');
INSERT INTO `cmf_operation_log` VALUES ('18', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL120170217000008-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488087970');
INSERT INTO `cmf_operation_log` VALUES ('19', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL120170217000008-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488089386');
INSERT INTO `cmf_operation_log` VALUES ('20', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL120170217000007-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488090592');
INSERT INTO `cmf_operation_log` VALUES ('21', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170302000001-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488418284');
INSERT INTO `cmf_operation_log` VALUES ('22', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170302000002-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488440413');
INSERT INTO `cmf_operation_log` VALUES ('23', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170302000003-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488440486');
INSERT INTO `cmf_operation_log` VALUES ('24', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:我的名字', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488507193');
INSERT INTO `cmf_operation_log` VALUES ('25', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:你的名字', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488507208');
INSERT INTO `cmf_operation_log` VALUES ('26', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:我的名字', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488507284');
INSERT INTO `cmf_operation_log` VALUES ('27', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:他的名字', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488507300');
INSERT INTO `cmf_operation_log` VALUES ('28', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:你的名字', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488507311');
INSERT INTO `cmf_operation_log` VALUES ('29', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:他的名字', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488507323');
INSERT INTO `cmf_operation_log` VALUES ('30', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:我的名字', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488507334');
INSERT INTO `cmf_operation_log` VALUES ('31', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:我的名字', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488508556');
INSERT INTO `cmf_operation_log` VALUES ('32', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170302000003-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488509610');
INSERT INTO `cmf_operation_log` VALUES ('33', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170302000002-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488509630');
INSERT INTO `cmf_operation_log` VALUES ('34', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170302000001-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488509646');
INSERT INTO `cmf_operation_log` VALUES ('35', '1', 'g=Express&m=Receiving&a=delete', '删除收件信息:DHL1170223000006-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488679236');
INSERT INTO `cmf_operation_log` VALUES ('36', '1', 'g=Express&m=Receiving&a=delete', '删除收件信息:DHL1170218000009-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488679241');
INSERT INTO `cmf_operation_log` VALUES ('37', '1', 'g=Express&m=Receiving&a=delete', '删除收件信息:DHL1170217000008-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488679245');
INSERT INTO `cmf_operation_log` VALUES ('38', '1', 'g=Express&m=Receiving&a=delete', '删除收件信息:9780199532179', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488679247');
INSERT INTO `cmf_operation_log` VALUES ('39', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000001-2-1,DHL1170305000001-2-2', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680261');
INSERT INTO `cmf_operation_log` VALUES ('40', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000003-2-1,DHL1170305000003-2-2', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680273');
INSERT INTO `cmf_operation_log` VALUES ('41', '1', 'g=Express&m=Receiving&a=delete', '删除收件信息:DHL1170305000003-2-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680298');
INSERT INTO `cmf_operation_log` VALUES ('42', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000003-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680354');
INSERT INTO `cmf_operation_log` VALUES ('43', '1', 'g=Express&m=Receiving&a=del&receive_id=49', '删除收件任务:DHL1170305000003-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680358');
INSERT INTO `cmf_operation_log` VALUES ('44', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000003-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680369');
INSERT INTO `cmf_operation_log` VALUES ('45', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000004-2-1,DHL1170305000004-2-2', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680381');
INSERT INTO `cmf_operation_log` VALUES ('46', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000006-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680392');
INSERT INTO `cmf_operation_log` VALUES ('47', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000007-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680415');
INSERT INTO `cmf_operation_log` VALUES ('48', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000008-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680421');
INSERT INTO `cmf_operation_log` VALUES ('49', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000009-2-1,DHL1170305000009-2-2', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680429');
INSERT INTO `cmf_operation_log` VALUES ('50', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000011-2-1,DHL1170305000011-2-2', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680435');
INSERT INTO `cmf_operation_log` VALUES ('51', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000013-2-1,DHL1170305000013-2-2', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680440');
INSERT INTO `cmf_operation_log` VALUES ('52', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170305000015-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680450');
INSERT INTO `cmf_operation_log` VALUES ('53', '1', 'g=Admin&m=Staff&a=delete', '批量删除员工:我的名字,他的名字,你的名字', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680470');
INSERT INTO `cmf_operation_log` VALUES ('54', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:悦悦', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680554');
INSERT INTO `cmf_operation_log` VALUES ('55', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:乐乐', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680585');
INSERT INTO `cmf_operation_log` VALUES ('56', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:糊糊', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680627');
INSERT INTO `cmf_operation_log` VALUES ('57', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:圆圆', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680656');
INSERT INTO `cmf_operation_log` VALUES ('58', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:咕咕', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680709');
INSERT INTO `cmf_operation_log` VALUES ('59', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:酷酷', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680737');
INSERT INTO `cmf_operation_log` VALUES ('60', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:拂拂', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680765');
INSERT INTO `cmf_operation_log` VALUES ('61', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:发发', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680794');
INSERT INTO `cmf_operation_log` VALUES ('62', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:嘟嘟', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680822');
INSERT INTO `cmf_operation_log` VALUES ('63', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:馥馥', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680852');
INSERT INTO `cmf_operation_log` VALUES ('64', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:杜杜', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680880');
INSERT INTO `cmf_operation_log` VALUES ('65', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:素素', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680908');
INSERT INTO `cmf_operation_log` VALUES ('66', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:瑟瑟', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680946');
INSERT INTO `cmf_operation_log` VALUES ('67', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:粗粗', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488680974');
INSERT INTO `cmf_operation_log` VALUES ('68', '1', 'g=Admin&m=Staff&a=add_post', '添加员工:我我', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488681006');
INSERT INTO `cmf_operation_log` VALUES ('69', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:悦悦', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683426');
INSERT INTO `cmf_operation_log` VALUES ('70', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:乐乐', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683438');
INSERT INTO `cmf_operation_log` VALUES ('71', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:糊糊', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683448');
INSERT INTO `cmf_operation_log` VALUES ('72', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:圆圆', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683457');
INSERT INTO `cmf_operation_log` VALUES ('73', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:咕咕', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683467');
INSERT INTO `cmf_operation_log` VALUES ('74', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:酷酷', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683478');
INSERT INTO `cmf_operation_log` VALUES ('75', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:拂拂', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683488');
INSERT INTO `cmf_operation_log` VALUES ('76', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:发发', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683498');
INSERT INTO `cmf_operation_log` VALUES ('77', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:嘟嘟', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683508');
INSERT INTO `cmf_operation_log` VALUES ('78', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:馥馥', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683519');
INSERT INTO `cmf_operation_log` VALUES ('79', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:杜杜', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683529');
INSERT INTO `cmf_operation_log` VALUES ('80', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:素素', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683546');
INSERT INTO `cmf_operation_log` VALUES ('81', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:瑟瑟', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683560');
INSERT INTO `cmf_operation_log` VALUES ('82', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:粗粗', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683576');
INSERT INTO `cmf_operation_log` VALUES ('83', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:粗粗', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683589');
INSERT INTO `cmf_operation_log` VALUES ('84', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:我我', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683641');
INSERT INTO `cmf_operation_log` VALUES ('85', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000015-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488683750');
INSERT INTO `cmf_operation_log` VALUES ('86', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000013-2-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488684060');
INSERT INTO `cmf_operation_log` VALUES ('87', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000009-2-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488684716');
INSERT INTO `cmf_operation_log` VALUES ('88', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000008-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488684751');
INSERT INTO `cmf_operation_log` VALUES ('89', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000007-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488684780');
INSERT INTO `cmf_operation_log` VALUES ('90', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000006-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488684824');
INSERT INTO `cmf_operation_log` VALUES ('91', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000004-2-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488684852');
INSERT INTO `cmf_operation_log` VALUES ('92', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000003-1-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488684877');
INSERT INTO `cmf_operation_log` VALUES ('93', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000001-2-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488685156');
INSERT INTO `cmf_operation_log` VALUES ('94', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170305000011-2-1', 'a:5:{s:2:\"ip\";s:11:\"192.168.2.6\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488685272');
INSERT INTO `cmf_operation_log` VALUES ('95', '1', 'g=Admin&m=Staff&a=resetpass', '编辑员工:', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488694781');
INSERT INTO `cmf_operation_log` VALUES ('96', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170306000001-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488764516');
INSERT INTO `cmf_operation_log` VALUES ('97', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170306000002-1-1', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488765423');
INSERT INTO `cmf_operation_log` VALUES ('98', '1', 'g=Express&m=Receiving&a=delete', '删除收件信息:DHL1170305000008-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866546');
INSERT INTO `cmf_operation_log` VALUES ('99', '1', 'g=Express&m=Receiving&a=delete', '删除收件信息:DHL1170305000001-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866554');
INSERT INTO `cmf_operation_log` VALUES ('100', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000001-2-1,DHL1170307000001-2-2', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866589');
INSERT INTO `cmf_operation_log` VALUES ('101', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000003-2-1,DHL1170307000003-2-2', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866605');
INSERT INTO `cmf_operation_log` VALUES ('102', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000005-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866676');
INSERT INTO `cmf_operation_log` VALUES ('103', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000006-2-1,DHL1170307000006-2-2', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866689');
INSERT INTO `cmf_operation_log` VALUES ('104', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000008-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866698');
INSERT INTO `cmf_operation_log` VALUES ('105', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000009-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866703');
INSERT INTO `cmf_operation_log` VALUES ('106', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000010-2-1,DHL1170307000010-2-2', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866714');
INSERT INTO `cmf_operation_log` VALUES ('107', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000012-2-1,DHL1170307000012-2-2', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866723');
INSERT INTO `cmf_operation_log` VALUES ('108', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000014-2-1,DHL1170307000014-2-2', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866729');
INSERT INTO `cmf_operation_log` VALUES ('109', '1', 'g=Express&m=Receiving&a=add_post', '添加收件信息:DHL1170307000016-2-1,DHL1170307000016-2-2', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866738');
INSERT INTO `cmf_operation_log` VALUES ('110', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:悦悦', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866815');
INSERT INTO `cmf_operation_log` VALUES ('111', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:乐乐', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866828');
INSERT INTO `cmf_operation_log` VALUES ('112', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:糊糊', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866840');
INSERT INTO `cmf_operation_log` VALUES ('113', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:圆圆', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866854');
INSERT INTO `cmf_operation_log` VALUES ('114', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:咕咕', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866875');
INSERT INTO `cmf_operation_log` VALUES ('115', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:酷酷', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866887');
INSERT INTO `cmf_operation_log` VALUES ('116', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:拂拂', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866901');
INSERT INTO `cmf_operation_log` VALUES ('117', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:发发', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866913');
INSERT INTO `cmf_operation_log` VALUES ('118', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:馥馥', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866937');
INSERT INTO `cmf_operation_log` VALUES ('119', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:嘟嘟', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866949');
INSERT INTO `cmf_operation_log` VALUES ('120', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:杜杜', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866969');
INSERT INTO `cmf_operation_log` VALUES ('121', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:素素', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488866997');
INSERT INTO `cmf_operation_log` VALUES ('122', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:素素', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867016');
INSERT INTO `cmf_operation_log` VALUES ('123', '1', 'g=Admin&m=Staff&a=edit_post', '编辑员工:瑟瑟', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867034');
INSERT INTO `cmf_operation_log` VALUES ('124', '1', 'g=Admin&m=Staff&a=delete', '批量删除员工:粗粗,我我', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867055');
INSERT INTO `cmf_operation_log` VALUES ('125', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000016-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867099');
INSERT INTO `cmf_operation_log` VALUES ('126', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000014-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867142');
INSERT INTO `cmf_operation_log` VALUES ('127', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000012-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867162');
INSERT INTO `cmf_operation_log` VALUES ('128', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000010-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867343');
INSERT INTO `cmf_operation_log` VALUES ('129', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000009-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867381');
INSERT INTO `cmf_operation_log` VALUES ('130', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000008-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867437');
INSERT INTO `cmf_operation_log` VALUES ('131', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000006-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867471');
INSERT INTO `cmf_operation_log` VALUES ('132', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000005-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867505');
INSERT INTO `cmf_operation_log` VALUES ('133', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000003-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867531');
INSERT INTO `cmf_operation_log` VALUES ('134', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000001-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867583');
INSERT INTO `cmf_operation_log` VALUES ('135', '1', 'g=Express&m=Receiving&a=print_label_post', '定位人保存:DHL1170307000001-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488867628');
INSERT INTO `cmf_operation_log` VALUES ('136', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000016-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488876619');
INSERT INTO `cmf_operation_log` VALUES ('137', '1', 'g=Express&m=Receiving&a=print_label_post', '定位人保存:DHL1170307000016-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488876636');
INSERT INTO `cmf_operation_log` VALUES ('138', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000016-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488876850');
INSERT INTO `cmf_operation_log` VALUES ('139', '1', 'g=Express&m=Receiving&a=print_label_post', '定位人保存:DHL1170307000016-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488876859');
INSERT INTO `cmf_operation_log` VALUES ('140', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000014-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488876953');
INSERT INTO `cmf_operation_log` VALUES ('141', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000012-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488876980');
INSERT INTO `cmf_operation_log` VALUES ('142', '1', 'g=Express&m=Receiving&a=print_label_post', '定位人保存:DHL1170307000014-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488876993');
INSERT INTO `cmf_operation_log` VALUES ('143', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000010-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879110');
INSERT INTO `cmf_operation_log` VALUES ('144', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000006-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879131');
INSERT INTO `cmf_operation_log` VALUES ('145', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000005-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879149');
INSERT INTO `cmf_operation_log` VALUES ('146', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000005-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879171');
INSERT INTO `cmf_operation_log` VALUES ('147', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000003-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879196');
INSERT INTO `cmf_operation_log` VALUES ('148', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000001-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879213');
INSERT INTO `cmf_operation_log` VALUES ('149', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000009-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879245');
INSERT INTO `cmf_operation_log` VALUES ('150', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000008-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879260');
INSERT INTO `cmf_operation_log` VALUES ('151', '1', 'g=Express&m=Receiving&a=print_label_post', '定位人保存:DHL1170307000014-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879306');
INSERT INTO `cmf_operation_log` VALUES ('152', '1', 'g=Express&m=Receiving&a=print_label_post', '定位人保存:DHL1170307000001-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488879343');
INSERT INTO `cmf_operation_log` VALUES ('153', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000014-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488880477');
INSERT INTO `cmf_operation_log` VALUES ('154', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000010-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488880500');
INSERT INTO `cmf_operation_log` VALUES ('155', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000006-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488880527');
INSERT INTO `cmf_operation_log` VALUES ('156', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000005-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488880541');
INSERT INTO `cmf_operation_log` VALUES ('157', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000005-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488880576');
INSERT INTO `cmf_operation_log` VALUES ('158', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000003-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488880592');
INSERT INTO `cmf_operation_log` VALUES ('159', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000009-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488880644');
INSERT INTO `cmf_operation_log` VALUES ('160', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000008-1-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488880660');
INSERT INTO `cmf_operation_log` VALUES ('161', '1', 'g=Express&m=Receiving&a=print_label_post', '定位人保存:DHL1170307000001-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488880725');
INSERT INTO `cmf_operation_log` VALUES ('162', '1', 'g=Express&m=Receiving&a=location_post', '定位人保存:DHL1170307000014-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488881105');
INSERT INTO `cmf_operation_log` VALUES ('163', '1', 'g=Express&m=Receiving&a=print_label_post', '定位人保存:DHL1170307000014-2-1', 'a:5:{s:2:\"ip\";s:12:\"192.168.2.20\";s:7:\"beginip\";s:11:\"192.168.0.0\";s:5:\"endip\";s:15:\"192.168.255.255\";s:7:\"country\";s:9:\"局域网\";s:4:\"area\";s:30:\"对方和您在同一内部网\";}', '1488881120');
INSERT INTO `cmf_operation_log` VALUES ('164', '1', 'g=Admin&m=Staff&a=resetpass', '编辑员工:', 'a:5:{s:2:\"ip\";s:9:\"127.0.0.1\";s:7:\"beginip\";s:9:\"127.0.0.0\";s:5:\"endip\";s:15:\"127.255.255.255\";s:7:\"country\";s:4:\"IANA\";s:4:\"area\";s:30:\"保留地址用于本地回送\";}', '1488942990');

-- ----------------------------
-- Table structure for cmf_options
-- ----------------------------
DROP TABLE IF EXISTS `cmf_options`;
CREATE TABLE `cmf_options` (
  `option_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `option_name` varchar(64) NOT NULL COMMENT '配置名',
  `option_value` longtext NOT NULL COMMENT '配置值',
  `autoload` int(2) NOT NULL DEFAULT '1' COMMENT '是否自动加载',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='全站配置表';

-- ----------------------------
-- Records of cmf_options
-- ----------------------------
INSERT INTO `cmf_options` VALUES ('1', 'member_email_active_location', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1');
INSERT INTO `cmf_options` VALUES ('6', 'site_options', '            {\r\n            		\"site_name\":\"ThinkCMF内容管理框架\",\r\n            		\"site_host\":\"http://localhost/\",\r\n            		\"site_root\":\"\",\r\n            		\"site_icp\":\"\",\r\n            		\"site_admin_email\":\"937731092@qq.com\",\r\n            		\"site_tongji\":\"\",\r\n            		\"site_copyright\":\"\",\r\n            		\"site_seo_title\":\"ThinkCMF内容管理框架\",\r\n            		\"site_seo_keywords\":\"ThinkCMF,php,内容管理框架,cmf,cms,简约风, simplewind,framework\",\r\n            		\"site_seo_description\":\"ThinkCMF是简约风网络科技发布的一款用于快速开发的内容管理框架\"\r\n        }', '1');
INSERT INTO `cmf_options` VALUES ('7', 'member_email_active_stamp', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u54c8\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1');
INSERT INTO `cmf_options` VALUES ('8', 'member_email_active_sendfalse', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1');
INSERT INTO `cmf_options` VALUES ('9', 'member_email_active_sendtrue', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1');
INSERT INTO `cmf_options` VALUES ('10', 'member_email_active_order', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1');
INSERT INTO `cmf_options` VALUES ('11', 'member_email_active_affirm', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp; &nbsp;<strong>\\u5e10\\u53f7\\u6fc0\\u6d3b\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp; &nbsp; (\\u5982\\u679c\\u4e0a\\u9762\\u4e0d\\u662f\\u94fe\\u63a5\\u5f62\\u5f0f\\uff0c\\u8bf7\\u5c06\\u8be5\\u5730\\u5740\\u624b\\u5de5\\u7c98\\u8d34\\u5230\\u6d4f\\u89c8\\u5668\\u5730\\u5740\\u680f\\u518d\\u8bbf\\u95ee)<br\\/>&nbsp; &nbsp; \\u611f\\u8c22\\u60a8\\u7684\\u8bbf\\u95ee\\uff0c\\u795d\\u60a8\\u4f7f\\u7528\\u6109\\u5feb\\uff01<br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1');
INSERT INTO `cmf_options` VALUES ('13', 'member_email_active_moment', '{\"title\":\"ThinkCMF\\u90ae\\u4ef6\\u6fc0\\u6d3b\\u901a\\u77e5.\",\"template\":\"<p>\\u672c\\u90ae\\u4ef6\\u6765\\u81ea<a href=\\\"http:\\/\\/www.thinkcmf.com\\\">ThinkCMF<\\/a><br\\/><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/>&nbsp;&nbsp; <strong>\\u53d1\\u9001\\u90ae\\u4ef6\\u8bf4\\u660e<\\/strong><br\\/>&nbsp; &nbsp;<strong>---------------<strong style=\\\"white-space: normal;\\\">---<\\/strong><\\/strong><br\\/><br\\/>&nbsp; &nbsp; \\u5c0a\\u656c\\u7684<span style=\\\"FONT-SIZE: 16px; FONT-FAMILY: Arial; COLOR: rgb(51,51,51); LINE-HEIGHT: 18px; BACKGROUND-COLOR: rgb(255,255,255)\\\">#username#\\uff0c\\u60a8\\u597d\\u3002<\\/span>\\u5982\\u679c\\u60a8\\u662fThinkCMF\\u7684\\u65b0\\u7528\\u6237\\uff0c\\u6216\\u5728\\u4fee\\u6539\\u60a8\\u7684\\u6ce8\\u518cEmail\\u65f6\\u4f7f\\u7528\\u4e86\\u672c\\u5730\\u5740\\uff0c\\u6211\\u4eec\\u9700\\u8981\\u5bf9\\u60a8\\u7684\\u5730\\u5740\\u6709\\u6548\\u6027\\u8fdb\\u884c\\u9a8c\\u8bc1\\u4ee5\\u907f\\u514d\\u5783\\u573e\\u90ae\\u4ef6\\u6216\\u5730\\u5740\\u88ab\\u6ee5\\u7528\\u3002<br\\/>&nbsp; &nbsp; \\u60a8\\u53ea\\u9700\\u70b9\\u51fb\\u4e0b\\u9762\\u7684\\u94fe\\u63a5\\u5373\\u53ef\\u6fc0\\u6d3b\\u60a8\\u7684\\u5e10\\u53f7\\uff1a<br\\/>&nbsp; &nbsp; <a title=\\\"\\\" href=\\\"http:\\/\\/#link#\\\" target=\\\"_self\\\">http:\\/\\/#link#<\\/a><br\\/>&nbsp;&nbsp; <br\\/><br\\/>&nbsp; &nbsp; \\u6b64\\u81f4<br\\/>&nbsp; &nbsp; ThinkCMF \\u7ba1\\u7406\\u56e2\\u961f.<\\/p>\"}', '1');

-- ----------------------------
-- Table structure for cmf_package_address
-- ----------------------------
DROP TABLE IF EXISTS `cmf_package_address`;
CREATE TABLE `cmf_package_address` (
  `address_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `address_name` varchar(100) NOT NULL,
  `country_id` int(10) DEFAULT NULL COMMENT '国家ID',
  `province_id` int(10) DEFAULT NULL COMMENT '省ID',
  `city_id` int(10) DEFAULT NULL COMMENT '市ID',
  `county_id` int(10) DEFAULT NULL COMMENT '县ID',
  `address_detail` text,
  `is_abroad` tinyint(1) NOT NULL DEFAULT '0' COMMENT '0：国内，1：国外',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除：1（TRUE）， 0（FALSE）',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  PRIMARY KEY (`address_id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_package_address
-- ----------------------------
INSERT INTO `cmf_package_address` VALUES ('1', 'dsvservse', '3268', '0', '0', '0', '', '0', '0', '1486433457', '1486433457');
INSERT INTO `cmf_package_address` VALUES ('2', '哈哈哈哈', '3268', '21', '0', '0', '', '0', '0', '1486979620', '1486979620');
INSERT INTO `cmf_package_address` VALUES ('3', '完成任务福', '3268', '62', '0', '0', '如厕人', '0', '0', '1486979717', '1486979717');
INSERT INTO `cmf_package_address` VALUES ('4', '不位不凑而出', '0', '0', '0', '0', '', '0', '0', '1486981319', '1486981319');
INSERT INTO `cmf_package_address` VALUES ('5', '你从爱而是你从', '3268', '0', '0', '0', '侧安慰', '0', '0', '1486981522', '1486981522');
INSERT INTO `cmf_package_address` VALUES ('6', 'rvaerfcer', '3271', '3273', '0', '0', 'fwerfwerfwer', '0', '0', '1487039522', '1487039522');
INSERT INTO `cmf_package_address` VALUES ('7', 'vsfvsfvs', '3271', '0', '0', '0', 'crsfdvf', '0', '0', '1487055959', '1487055959');

-- ----------------------------
-- Table structure for cmf_paths
-- ----------------------------
DROP TABLE IF EXISTS `cmf_paths`;
CREATE TABLE `cmf_paths` (
  `path_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '路径ID， 自增，主键',
  `path_name` varchar(100) NOT NULL COMMENT '路径名称',
  `building_start` varchar(100) NOT NULL DEFAULT '0' COMMENT '楼开始',
  `building_end` varchar(100) NOT NULL DEFAULT '0' COMMENT '楼结束',
  `floor_start` varchar(100) NOT NULL DEFAULT '0' COMMENT '层开始',
  `floor_end` varchar(100) NOT NULL DEFAULT '0' COMMENT '层结束',
  `area_start` varchar(100) NOT NULL DEFAULT '0' COMMENT '区域开始',
  `area_end` varchar(100) NOT NULL DEFAULT '0' COMMENT '区域结束',
  `seat_start` varchar(100) NOT NULL DEFAULT '0' COMMENT '邮箱',
  `seat_end` varchar(100) NOT NULL DEFAULT '0' COMMENT '收件需求：0派送，1自取；',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除：1（TRUE）， 0（FALSE）',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  `search_start` varchar(100) NOT NULL,
  `search_end` varchar(100) NOT NULL,
  PRIMARY KEY (`path_id`)
) ENGINE=MyISAM AUTO_INCREMENT=14 DEFAULT CHARSET=utf8 COMMENT='路径表';

-- ----------------------------
-- Records of cmf_paths
-- ----------------------------
INSERT INTO `cmf_paths` VALUES ('11', 'TEST4', '2', '3', '4', '2', '1', '2', '4', '1', '0', '1484212515', '1484641361', '0000000002000000000400000000010000000004', '0000000003000000000200000000020000000001');
INSERT INTO `cmf_paths` VALUES ('10', 'TEST3', '2', '2', '1', '4', '1', '1', '4', '3', '0', '1484212429', '1484641354', '0000000002000000000100000000010000000004', '0000000002000000000400000000010000000003');
INSERT INTO `cmf_paths` VALUES ('9', 'test2', '1', '2', '1', '1', '1', '1', '4', '3', '0', '1484204938', '1484641335', '0000000001000000000100000000010000000004', '0000000002000000000100000000010000000003');
INSERT INTO `cmf_paths` VALUES ('8', 'test1', '1', '1', '1', '1', '1', '1', '1', '3', '0', '1484199526', '1484641328', '0000000001000000000100000000010000000001', '0000000001000000000100000000010000000003');
INSERT INTO `cmf_paths` VALUES ('12', 'test5', '3', '5', '2', '1', '2', '1', '2', '1', '0', '1484212571', '1484641368', '0000000003000000000200000000020000000002', '0000000005000000000100000000010000000001');
INSERT INTO `cmf_paths` VALUES ('13', 'test6', '11', '111', '12', '222', '13', '333', '14', '444', '0', '1484640924', '1484640924', '0000000011000000001200000000130000000014', '0000000111000000022200000003330000000444');

-- ----------------------------
-- Table structure for cmf_plugins
-- ----------------------------
DROP TABLE IF EXISTS `cmf_plugins`;
CREATE TABLE `cmf_plugins` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '自增id',
  `name` varchar(50) NOT NULL COMMENT '插件名，英文',
  `title` varchar(50) NOT NULL DEFAULT '' COMMENT '插件名称',
  `description` text COMMENT '插件描述',
  `type` tinyint(2) DEFAULT '0' COMMENT '插件类型, 1:网站；8;微信',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '状态；1开启；',
  `config` text COMMENT '插件配置',
  `hooks` varchar(255) DEFAULT NULL COMMENT '实现的钩子;以“，”分隔',
  `has_admin` tinyint(2) DEFAULT '0' COMMENT '插件是否有后台管理界面',
  `author` varchar(50) DEFAULT '' COMMENT '插件作者',
  `version` varchar(20) DEFAULT '' COMMENT '插件版本号',
  `createtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '插件安装时间',
  `listorder` smallint(6) NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='插件表';

-- ----------------------------
-- Records of cmf_plugins
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_posts
-- ----------------------------
DROP TABLE IF EXISTS `cmf_posts`;
CREATE TABLE `cmf_posts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `post_author` bigint(20) unsigned DEFAULT '0' COMMENT '发表者id',
  `post_keywords` varchar(150) NOT NULL COMMENT 'seo keywords',
  `post_source` varchar(150) DEFAULT NULL COMMENT '转载文章的来源',
  `post_date` datetime DEFAULT '2000-01-01 00:00:00' COMMENT 'post发布日期',
  `post_content` longtext COMMENT 'post内容',
  `post_title` text COMMENT 'post标题',
  `post_excerpt` text COMMENT 'post摘要',
  `post_status` int(2) DEFAULT '1' COMMENT 'post状态，1已审核，0未审核,3删除',
  `comment_status` int(2) DEFAULT '1' COMMENT '评论状态，1允许，0不允许',
  `post_modified` datetime DEFAULT '2000-01-01 00:00:00' COMMENT 'post更新时间，可在前台修改，显示给用户',
  `post_content_filtered` longtext,
  `post_parent` bigint(20) unsigned DEFAULT '0' COMMENT 'post的父级post id,表示post层级关系',
  `post_type` int(2) DEFAULT '1' COMMENT 'post类型，1文章,2页面',
  `post_mime_type` varchar(100) DEFAULT '',
  `comment_count` bigint(20) DEFAULT '0',
  `smeta` text COMMENT 'post的扩展字段，保存相关扩展属性，如缩略图；格式为json',
  `post_hits` int(11) DEFAULT '0' COMMENT 'post点击数，查看数',
  `post_like` int(11) DEFAULT '0' COMMENT 'post赞数',
  `istop` tinyint(1) NOT NULL DEFAULT '0' COMMENT '置顶 1置顶； 0不置顶',
  `recommended` tinyint(1) NOT NULL DEFAULT '0' COMMENT '推荐 1推荐 0不推荐',
  PRIMARY KEY (`id`),
  KEY `type_status_date` (`post_type`,`post_status`,`post_date`,`id`),
  KEY `post_parent` (`post_parent`),
  KEY `post_author` (`post_author`),
  KEY `post_date` (`post_date`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Portal文章表';

-- ----------------------------
-- Records of cmf_posts
-- ----------------------------
INSERT INTO `cmf_posts` VALUES ('1', '1', 'tttt', 'tt', '2017-01-11 10:03:24', '<p>sadfdsafdasfdsafsadfdsf</p>', 'aaaaa', '12321321', '1', '1', '2017-01-11 10:03:48', null, '0', '1', '', '0', '{\"thumb\":\"\",\"template\":\"\"}', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for cmf_queue
-- ----------------------------
DROP TABLE IF EXISTS `cmf_queue`;
CREATE TABLE `cmf_queue` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL COMMENT '任务名称',
  `params` text NOT NULL COMMENT '参数',
  `status` tinyint(1) NOT NULL DEFAULT '2' COMMENT '执行状态0:失败，1：成功，2：待执行,3:运行中',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  `file_url` varchar(255) DEFAULT NULL COMMENT '文件路径',
  `queue_type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '1：导出，2：导入，3，发邮件',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=182 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_queue
-- ----------------------------
INSERT INTO `cmf_queue` VALUES ('1', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export666.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:27136;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"182ff4aa0c102f602586d0f5d100c2c4\";s:4:\"sha1\";s:40:\"a9fdff8aab3f40844090dae66180e0a55892f47b\";s:8:\"savename\";s:17:\"58b8de70d49b9.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488510576', '1488510583', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('2', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export666.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:27136;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"2fdb088b686de7034af485deeafb0f83\";s:4:\"sha1\";s:40:\"42a537953862d8da94f9ab58c5b56b8da881c73c\";s:8:\"savename\";s:17:\"58b8decab83df.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488510666', '1488510671', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('3', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export666.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:27136;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"d48bf0ff68155f0c85cf1f5ed253b756\";s:4:\"sha1\";s:40:\"026a37cb0203629e7e07a0f4b3752e78a3454bd8\";s:8:\"savename\";s:17:\"58b8df0c8c9f0.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '0', '1488510732', '1488510737', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('4', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export666.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:27136;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"82342e84c3cdf24fed7a2f7cd194afde\";s:4:\"sha1\";s:40:\"7864fa92ae6609580ef1fc2a358b10e0dbe138a2\";s:8:\"savename\";s:17:\"58b8dfa4203f0.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488510884', '1488510892', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('5', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488510919', '1488510924', './data/excel/export/Staff5_20170303111524.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('6', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:6:\"ha.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"6b4bb465e6b445d68ba6cbb11614c8eb\";s:4:\"sha1\";s:40:\"a286b2a7b122bc074e1f9d7815bbb2f04b8aa7ba\";s:8:\"savename\";s:17:\"58b8e0521432e.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488511058', '1488511063', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('7', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export666.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:27136;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"82342e84c3cdf24fed7a2f7cd194afde\";s:4:\"sha1\";s:40:\"7864fa92ae6609580ef1fc2a358b10e0dbe138a2\";s:8:\"savename\";s:17:\"58b8e2620124f.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488511586', '1488511590', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('8', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:6:\"ha.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:27136;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"1828ec4c2648cf6bec9f394147eac9c9\";s:4:\"sha1\";s:40:\"25d102087496a12349f16f023f899e9b6178fbb9\";s:8:\"savename\";s:17:\"58b8e33144d21.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488511793', '1488511800', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('9', 'PackageAddress export', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '3', '1488525281', '1488525287', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('10', 'PackageAddress export', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488525343', '1488525351', './data/excel/export/PackageAddress10_20170303151551.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('11', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"2d13c396f5da732584048decbe5241ca\";s:4:\"sha1\";s:40:\"2eb6c2ebbf90e934cb02453795146e9908e1c73f\";s:8:\"savename\";s:17:\"58b9193d99a18.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488525629', '1488525635', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('12', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"2d13c396f5da732584048decbe5241ca\";s:4:\"sha1\";s:40:\"2eb6c2ebbf90e934cb02453795146e9908e1c73f\";s:8:\"savename\";s:17:\"58b9199e82712.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488525726', '1488525732', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('13', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a24d42fd53229ccec0587275339531ba\";s:4:\"sha1\";s:40:\"e98c51648d4844366c7491f75409a5f8b0208d89\";s:8:\"savename\";s:17:\"58b91a437ecfb.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488525891', '1488525897', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('14', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a24d42fd53229ccec0587275339531ba\";s:4:\"sha1\";s:40:\"e98c51648d4844366c7491f75409a5f8b0208d89\";s:8:\"savename\";s:17:\"58b91bed2a8bf.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488526317', '1488527210', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('15', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a24d42fd53229ccec0587275339531ba\";s:4:\"sha1\";s:40:\"e98c51648d4844366c7491f75409a5f8b0208d89\";s:8:\"savename\";s:17:\"58b91cd0a55f2.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488526544', '1488527211', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('16', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a24d42fd53229ccec0587275339531ba\";s:4:\"sha1\";s:40:\"e98c51648d4844366c7491f75409a5f8b0208d89\";s:8:\"savename\";s:17:\"58b91f6571872.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488527205', '1488527211', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('17', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a24d42fd53229ccec0587275339531ba\";s:4:\"sha1\";s:40:\"e98c51648d4844366c7491f75409a5f8b0208d89\";s:8:\"savename\";s:17:\"58b91f90067a1.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488527248', '1488527282', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('18', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a24d42fd53229ccec0587275339531ba\";s:4:\"sha1\";s:40:\"e98c51648d4844366c7491f75409a5f8b0208d89\";s:8:\"savename\";s:17:\"58b9203395c68.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488527411', '1488527417', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('19', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a24d42fd53229ccec0587275339531ba\";s:4:\"sha1\";s:40:\"e98c51648d4844366c7491f75409a5f8b0208d89\";s:8:\"savename\";s:17:\"58b92360b7a52.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488528224', '1488528230', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('20', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a24d42fd53229ccec0587275339531ba\";s:4:\"sha1\";s:40:\"e98c51648d4844366c7491f75409a5f8b0208d89\";s:8:\"savename\";s:17:\"58b924507beca.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488528464', '1488528470', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('21', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"e9cb6df5ff6fe7280fb136488806815e\";s:4:\"sha1\";s:40:\"59315700382002db674e90f9aa90cc5a8b935c1f\";s:8:\"savename\";s:17:\"58b924cc6dfa8.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488528588', '1488528592', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('22', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"4d5ffcd878d7f6e6abf40aa8f69cab31\";s:4:\"sha1\";s:40:\"fbd39d029f4d9bbd3db4e5e82a609e266111ae1f\";s:8:\"savename\";s:17:\"58b925220da85.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488528674', '1488528681', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('23', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"058dabcb1134a020936f1df1533b5ad5\";s:4:\"sha1\";s:40:\"503ae4efdd05bf4e2f0bea8391939d7677845485\";s:8:\"savename\";s:17:\"58b9256c9a3dd.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488528748', '1488528758', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('24', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"058dabcb1134a020936f1df1533b5ad5\";s:4:\"sha1\";s:40:\"503ae4efdd05bf4e2f0bea8391939d7677845485\";s:8:\"savename\";s:17:\"58b925c70841b.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488528839', '1488528844', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('25', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"058dabcb1134a020936f1df1533b5ad5\";s:4:\"sha1\";s:40:\"503ae4efdd05bf4e2f0bea8391939d7677845485\";s:8:\"savename\";s:17:\"58b926220f3cc.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488528930', '1488528934', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('26', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"058dabcb1134a020936f1df1533b5ad5\";s:4:\"sha1\";s:40:\"503ae4efdd05bf4e2f0bea8391939d7677845485\";s:8:\"savename\";s:17:\"58b9264d4a94d.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488528973', '1488528978', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('27', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"058dabcb1134a020936f1df1533b5ad5\";s:4:\"sha1\";s:40:\"503ae4efdd05bf4e2f0bea8391939d7677845485\";s:8:\"savename\";s:17:\"58b92744c3fa5.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488529220', '1488529225', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('28', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"058dabcb1134a020936f1df1533b5ad5\";s:4:\"sha1\";s:40:\"503ae4efdd05bf4e2f0bea8391939d7677845485\";s:8:\"savename\";s:17:\"58b927ef5d969.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488529391', '1488529397', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('29', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"058dabcb1134a020936f1df1533b5ad5\";s:4:\"sha1\";s:40:\"503ae4efdd05bf4e2f0bea8391939d7677845485\";s:8:\"savename\";s:17:\"58b92a3b1453d.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488529979', '1488529984', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('30', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"058dabcb1134a020936f1df1533b5ad5\";s:4:\"sha1\";s:40:\"503ae4efdd05bf4e2f0bea8391939d7677845485\";s:8:\"savename\";s:17:\"58b92aa9f3bfd.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488530090', '1488530096', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('31', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"cec3bf3ec5804e916e90ddde846436b1\";s:4:\"sha1\";s:40:\"7eecb9b758a0a1502bb359700e3a28b810af8bbe\";s:8:\"savename\";s:17:\"58b92b1bf1479.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488530204', '1488530211', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('32', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"cec3bf3ec5804e916e90ddde846436b1\";s:4:\"sha1\";s:40:\"7eecb9b758a0a1502bb359700e3a28b810af8bbe\";s:8:\"savename\";s:17:\"58b92b6507449.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488530277', '1488530282', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('33', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"b2a4b9a00ae74065dcaafa25ecb3df96\";s:4:\"sha1\";s:40:\"b6a6f505eb95a4e04f20c5083ae6ae0070ed93e7\";s:8:\"savename\";s:17:\"58b92bd35655a.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488530387', '1488530393', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('34', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"b2a4b9a00ae74065dcaafa25ecb3df96\";s:4:\"sha1\";s:40:\"b6a6f505eb95a4e04f20c5083ae6ae0070ed93e7\";s:8:\"savename\";s:17:\"58b92ea6bb4b2.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488531110', '1488531123', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('35', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"b2a4b9a00ae74065dcaafa25ecb3df96\";s:4:\"sha1\";s:40:\"b6a6f505eb95a4e04f20c5083ae6ae0070ed93e7\";s:8:\"savename\";s:17:\"58b92eca62d4a.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488531146', '1488531153', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('36', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"b2a4b9a00ae74065dcaafa25ecb3df96\";s:4:\"sha1\";s:40:\"b6a6f505eb95a4e04f20c5083ae6ae0070ed93e7\";s:8:\"savename\";s:17:\"58b92fb107b0e.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '3', '1488531377', '1488531387', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('37', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f06d9a787dbdf84bfc4d01153fc8bc88\";s:4:\"sha1\";s:40:\"7dfb7be30a24e2b1e8ce1ab7a4bd3074ad7d91b3\";s:8:\"savename\";s:17:\"58b930147941c.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-03/\";}}}}', '1', '1488531476', '1488531484', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('38', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488687436', '1488687451', './data/excel/export/Staff38_20170305121732.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('39', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"c29996b3a25f5395429c12d46d6b964a\";s:4:\"sha1\";s:40:\"615c9309a18ae84b3639feb1251e7571a11b1689\";s:8:\"savename\";s:17:\"58bb91f5d32ab.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488687605', '1488687613', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('40', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"c29996b3a25f5395429c12d46d6b964a\";s:4:\"sha1\";s:40:\"615c9309a18ae84b3639feb1251e7571a11b1689\";s:8:\"savename\";s:17:\"58bb928a9a5d2.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488687754', '1488687760', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('41', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"c29996b3a25f5395429c12d46d6b964a\";s:4:\"sha1\";s:40:\"615c9309a18ae84b3639feb1251e7571a11b1689\";s:8:\"savename\";s:17:\"58bb92c152233.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488687809', '1488687822', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('42', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"8492d383c1fe78be91e4e76ccee7d18e\";s:4:\"sha1\";s:40:\"e5e0925e81e46f31858229ba16cccf8821b3b4e9\";s:8:\"savename\";s:17:\"58bb92f41c6d8.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488687860', '1488687866', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('43', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"8492d383c1fe78be91e4e76ccee7d18e\";s:4:\"sha1\";s:40:\"e5e0925e81e46f31858229ba16cccf8821b3b4e9\";s:8:\"savename\";s:17:\"58bb9332886be.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488687922', '1488687932', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('44', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"8492d383c1fe78be91e4e76ccee7d18e\";s:4:\"sha1\";s:40:\"e5e0925e81e46f31858229ba16cccf8821b3b4e9\";s:8:\"savename\";s:17:\"58bba18f68894.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488691599', '1488691605', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('45', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"b03cd78017baff7b1f86870e39b535e5\";s:4:\"sha1\";s:40:\"8de969098de01852650f3a3aae67019aa32e37e9\";s:8:\"savename\";s:17:\"58bba1b13e9b7.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488691633', '1488691638', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('46', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"e2c695a4292cf6027aaebdb975666c0e\";s:4:\"sha1\";s:40:\"5ba0d2f57f2f4d9d5ba74b18e17b8489cddad2ca\";s:8:\"savename\";s:17:\"58bba1d910d40.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488691673', '1488691681', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('47', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"e2c695a4292cf6027aaebdb975666c0e\";s:4:\"sha1\";s:40:\"5ba0d2f57f2f4d9d5ba74b18e17b8489cddad2ca\";s:8:\"savename\";s:17:\"58bba25f4066c.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488691807', '1488691811', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('48', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"9d3b909e9a4aa558ecd43d0b0969b7a4\";s:4:\"sha1\";s:40:\"b1c7028f1b2828a743c55aa0d97b92ace8563f48\";s:8:\"savename\";s:17:\"58bba2ef78ca0.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488691951', '1488691958', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('49', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"689333c081af0b83c6f8a40fdd544152\";s:4:\"sha1\";s:40:\"601aeeba35ab539e37c285d636a9cdc090285d3a\";s:8:\"savename\";s:17:\"58bba376e6a3d.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488692086', '1488692092', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('50', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"689333c081af0b83c6f8a40fdd544152\";s:4:\"sha1\";s:40:\"601aeeba35ab539e37c285d636a9cdc090285d3a\";s:8:\"savename\";s:17:\"58bba3d504aa9.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488692181', '1488692186', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('51', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"689333c081af0b83c6f8a40fdd544152\";s:4:\"sha1\";s:40:\"601aeeba35ab539e37c285d636a9cdc090285d3a\";s:8:\"savename\";s:17:\"58bba40b9ce28.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488692235', '1488692239', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('52', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"689333c081af0b83c6f8a40fdd544152\";s:4:\"sha1\";s:40:\"601aeeba35ab539e37c285d636a9cdc090285d3a\";s:8:\"savename\";s:17:\"58bba472ac33d.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488692338', '1488692344', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('53', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"689333c081af0b83c6f8a40fdd544152\";s:4:\"sha1\";s:40:\"601aeeba35ab539e37c285d636a9cdc090285d3a\";s:8:\"savename\";s:17:\"58bba4c760749.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488692423', '1488692429', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('54', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"689333c081af0b83c6f8a40fdd544152\";s:4:\"sha1\";s:40:\"601aeeba35ab539e37c285d636a9cdc090285d3a\";s:8:\"savename\";s:17:\"58bba57d4c5f6.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488692605', '1488692610', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('55', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28160;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"689333c081af0b83c6f8a40fdd544152\";s:4:\"sha1\";s:40:\"601aeeba35ab539e37c285d636a9cdc090285d3a\";s:8:\"savename\";s:17:\"58bba5c0a382a.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488692672', '1488692679', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('56', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28672;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"55526d06cecb7cedee49d56a890e728b\";s:4:\"sha1\";s:40:\"e5700a2bdfab9f8c6fdf0b970dacb94a71fc8883\";s:8:\"savename\";s:17:\"58bba6059744c.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488692741', '1488692749', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('57', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28672;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"55526d06cecb7cedee49d56a890e728b\";s:4:\"sha1\";s:40:\"e5700a2bdfab9f8c6fdf0b970dacb94a71fc8883\";s:8:\"savename\";s:17:\"58bba7069c5a9.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488692998', '1488693005', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('58', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28672;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"140a5a6b9b2c40097e9802f52792fe34\";s:4:\"sha1\";s:40:\"e4067d646db668272a96205214f9b3e165aaef63\";s:8:\"savename\";s:17:\"58bba73ce1443.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488693052', '1488693059', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('59', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28672;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"140a5a6b9b2c40097e9802f52792fe34\";s:4:\"sha1\";s:40:\"e4067d646db668272a96205214f9b3e165aaef63\";s:8:\"savename\";s:17:\"58bba79d781f0.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488693149', '1488693155', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('60', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28672;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"140a5a6b9b2c40097e9802f52792fe34\";s:4:\"sha1\";s:40:\"e4067d646db668272a96205214f9b3e165aaef63\";s:8:\"savename\";s:17:\"58bba82dd487f.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488693293', '1488693298', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('61', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:17:\"Staff export1.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:28672;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"140a5a6b9b2c40097e9802f52792fe34\";s:4:\"sha1\";s:40:\"e4067d646db668272a96205214f9b3e165aaef63\";s:8:\"savename\";s:17:\"58bba89394086.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488693395', '1488693406', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('62', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488696289', '1488696298', './data/excel/export/Staff62_20170305144458.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('63', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export333.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:34552;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"21aa57053825e199e6230706d092fba4\";s:4:\"sha1\";s:40:\"5f79322a3af740f75e0da5b7c2798804966d28b2\";s:8:\"savename\";s:17:\"58bbb5770e339.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488696695', '1488696707', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('64', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export333.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:34552;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"21aa57053825e199e6230706d092fba4\";s:4:\"sha1\";s:40:\"5f79322a3af740f75e0da5b7c2798804966d28b2\";s:8:\"savename\";s:17:\"58bbb5f8963bb.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '3', '1488696824', '1488696832', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('65', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export333.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:34552;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"21aa57053825e199e6230706d092fba4\";s:4:\"sha1\";s:40:\"5f79322a3af740f75e0da5b7c2798804966d28b2\";s:8:\"savename\";s:17:\"58bbb90d7da3e.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488697613', '1488697631', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('66', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export333.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:32768;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"6082940db34234405002d361e9403f63\";s:4:\"sha1\";s:40:\"c5808c01fbfee39f03f66f5a80d10c814ce12073\";s:8:\"savename\";s:17:\"58bbb98006791.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488697728', '1488697738', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('67', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export333.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:32768;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"80d40650bdcbbe9f2c3f32fc84d58d65\";s:4:\"sha1\";s:40:\"6e2e554250e02ff85205ffd86bb6bbddde244b04\";s:8:\"savename\";s:17:\"58bbb9d0d70ac.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '0', '1488697808', '1488697861', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('68', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export333.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:32768;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"80d40650bdcbbe9f2c3f32fc84d58d65\";s:4:\"sha1\";s:40:\"6e2e554250e02ff85205ffd86bb6bbddde244b04\";s:8:\"savename\";s:17:\"58bbb9fcdee46.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '0', '1488697852', '1488697862', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('69', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Staff export333.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:32768;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"80d40650bdcbbe9f2c3f32fc84d58d65\";s:4:\"sha1\";s:40:\"6e2e554250e02ff85205ffd86bb6bbddde244b04\";s:8:\"savename\";s:17:\"58bbbd9d30f34.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488698781', '1488698789', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('70', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488698922', '1488698929', './data/excel/export/Staff70_20170305152849.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('71', 'PackageAddress export', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488700479', '1488700485', './data/excel/export/PackageAddress71_20170305155445.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('72', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:29:\"PackageAddress export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:30720;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"307df87547638daff3a8a22786eefa68\";s:4:\"sha1\";s:40:\"47685629b1bc5c1eef84017d1fdb54755867c3b6\";s:8:\"savename\";s:17:\"58bbc49ed1436.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488700574', '1488700580', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('73', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:29:\"PackageAddress export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:30720;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a5ca8bf37bbeb5c05cd1b4ab4fc7cd7f\";s:4:\"sha1\";s:40:\"1f03e980f0627cb0ddb52c0ae64dd6aeeaee65e1\";s:8:\"savename\";s:17:\"58bbc4fdf37e0.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488700670', '1488700692', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('74', 'Departments export', 'a:4:{s:10:\"controller\";s:11:\"Departments\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488701467', '1488701472', './data/excel/export/Departments74_20170305161112.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('75', 'Departments export', 'a:4:{s:10:\"controller\";s:11:\"Departments\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488701523', '1488701566', './data/excel/export/Departments75_20170305161246.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('76', 'Departments import', 'a:4:{s:10:\"controller\";s:11:\"Departments\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:22:\"Departments export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"6072f8fb11665db3d0b5631d9c212728\";s:4:\"sha1\";s:40:\"9b30f7545b39fa35b98b68d73d292800795bb671\";s:8:\"savename\";s:17:\"58bbc8793d26b.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488701561', '1488701566', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('77', 'Departments import', 'a:4:{s:10:\"controller\";s:11:\"Departments\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:22:\"Departments export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"2bdcdf27dd369048086a3c4734fc0eae\";s:4:\"sha1\";s:40:\"af91019284e36499d818560cdcbf2f15c8b76594\";s:8:\"savename\";s:17:\"58bbc8b954659.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488701625', '1488701630', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('78', 'Costcenters export', 'a:4:{s:10:\"controller\";s:11:\"Costcenters\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488702791', '1488702796', './data/excel/export/Costcenters78_20170305163316.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('79', 'Costcenters import', 'a:4:{s:10:\"controller\";s:11:\"Costcenters\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:22:\"Costcenters export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"e2c89a6ccb051c517fa91f2d6e15ecdf\";s:4:\"sha1\";s:40:\"022651821887db7d7e4d59c4534cf037ba559017\";s:8:\"savename\";s:17:\"58bbcd76a8240.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488702838', '1488702843', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('80', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488703203', '1488703209', './data/excel/export/Staff80_20170305164009.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('81', 'Costcenters export', 'a:4:{s:10:\"controller\";s:11:\"Costcenters\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488703234', '1488703239', './data/excel/export/Costcenters81_20170305164039.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('82', 'Seat export', 'a:4:{s:10:\"controller\";s:4:\"Seat\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488703680', '1488703684', './data/excel/export/Seat82_20170305164805.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('83', 'Seat import', 'a:4:{s:10:\"controller\";s:4:\"Seat\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:15:\"Seat export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"03da6318f697b65cc3bfb5fa1e8fbfad\";s:4:\"sha1\";s:40:\"56ecfcbde82f1c9e51cb3e9536f2f0539b6de571\";s:8:\"savename\";s:17:\"58bbd10137927.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488703745', '1488703750', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('84', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488704304', '1488704418', './data/excel/export/Staff84_20170305170018.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('85', 'Mailroom export', 'a:4:{s:10:\"controller\";s:8:\"Mailroom\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488704413', '1488704418', './data/excel/export/Mailroom85_20170305170018.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('86', 'Mailroom import', 'a:4:{s:10:\"controller\";s:8:\"Mailroom\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Mailroom export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"258f4dcf7059ee3b2377ee74c86c9e4a\";s:4:\"sha1\";s:40:\"82659af637726fca89f08e8ff577990e9006cb14\";s:8:\"savename\";s:17:\"58bbd3f2ebe60.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488704499', '1488704503', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('87', 'ExpressCompany export', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488705990', '1488705995', './data/excel/export/ExpressCompany87_20170305172635.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('88', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"b36aa108476742c5f931e23ebef4969a\";s:4:\"sha1\";s:40:\"3f57efe6a83dc6745c84d102eac47885c062f239\";s:8:\"savename\";s:17:\"58bbda103e1cc.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488706064', '1488706072', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('89', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"d153eab7b3233bc2ad604f00c221fa37\";s:4:\"sha1\";s:40:\"fa27ae9ece914fe3e4125a8acf3ca4ea41458cf9\";s:8:\"savename\";s:17:\"58bbdc1214b86.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488706578', '1488706587', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('90', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"d153eab7b3233bc2ad604f00c221fa37\";s:4:\"sha1\";s:40:\"fa27ae9ece914fe3e4125a8acf3ca4ea41458cf9\";s:8:\"savename\";s:17:\"58bbdc3bb404e.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488706619', '1488706623', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('91', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"d153eab7b3233bc2ad604f00c221fa37\";s:4:\"sha1\";s:40:\"fa27ae9ece914fe3e4125a8acf3ca4ea41458cf9\";s:8:\"savename\";s:17:\"58bbdc75aefa3.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488706677', '1488706682', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('92', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"07bb27c0186df6c3c38931676ea02a52\";s:4:\"sha1\";s:40:\"d345f2c7c79ad58b7652eb571715bdb0d44a8051\";s:8:\"savename\";s:17:\"58bbdcdf6cec9.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488706783', '1488706789', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('93', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f4c2345cba0dcacfbcd3a43ea2b76af8\";s:4:\"sha1\";s:40:\"8ab4cda4383f6f704548cf29e98be04dac5f7ea6\";s:8:\"savename\";s:17:\"58bbdd4344c76.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488706883', '1488706888', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('94', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"4a02dfc6a79f7901b61fe47d19cb6efb\";s:4:\"sha1\";s:40:\"5954a11cff0e233a44af3b51d002f22eb1f48a4f\";s:8:\"savename\";s:17:\"58bbdd9ab640e.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488706970', '1488706975', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('95', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"4a02dfc6a79f7901b61fe47d19cb6efb\";s:4:\"sha1\";s:40:\"5954a11cff0e233a44af3b51d002f22eb1f48a4f\";s:8:\"savename\";s:17:\"58bbde24cbcc1.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488707108', '1488707114', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('96', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"4a02dfc6a79f7901b61fe47d19cb6efb\";s:4:\"sha1\";s:40:\"5954a11cff0e233a44af3b51d002f22eb1f48a4f\";s:8:\"savename\";s:17:\"58bbe09165cf8.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488707729', '1488707733', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('97', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"c768d41f41e6dbe0142f47f0eed9c555\";s:4:\"sha1\";s:40:\"94d760a76871c3e760a55c6a20bc4f05a1b46823\";s:8:\"savename\";s:17:\"58bbe0ea04b13.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488707818', '1488707825', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('98', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"c768d41f41e6dbe0142f47f0eed9c555\";s:4:\"sha1\";s:40:\"94d760a76871c3e760a55c6a20bc4f05a1b46823\";s:8:\"savename\";s:17:\"58bbe13e8b0b4.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488707902', '1488707907', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('99', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"c768d41f41e6dbe0142f47f0eed9c555\";s:4:\"sha1\";s:40:\"94d760a76871c3e760a55c6a20bc4f05a1b46823\";s:8:\"savename\";s:17:\"58bbe2801ecff.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488708224', '1488708229', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('100', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"c768d41f41e6dbe0142f47f0eed9c555\";s:4:\"sha1\";s:40:\"94d760a76871c3e760a55c6a20bc4f05a1b46823\";s:8:\"savename\";s:17:\"58bbe2c084f29.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488708288', '1488708294', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('101', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"c768d41f41e6dbe0142f47f0eed9c555\";s:4:\"sha1\";s:40:\"94d760a76871c3e760a55c6a20bc4f05a1b46823\";s:8:\"savename\";s:17:\"58bbe2ebe3c5d.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488708331', '1488708337', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('102', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"ac9115881c974e6b45d65b984a89c7fb\";s:4:\"sha1\";s:40:\"6855495f0e42b1980abff451fa56c4432a23370c\";s:8:\"savename\";s:17:\"58bbe3371dd30.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488708407', '1488708412', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('103', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"680a7c6bfe4fe6b675837ff32200ccd9\";s:4:\"sha1\";s:40:\"8c3bb9f4ddee6b8dddc910e6f92b7adaa4bc9b57\";s:8:\"savename\";s:17:\"58bbe460d177b.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488708704', '1488708732', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('104', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"680a7c6bfe4fe6b675837ff32200ccd9\";s:4:\"sha1\";s:40:\"8c3bb9f4ddee6b8dddc910e6f92b7adaa4bc9b57\";s:8:\"savename\";s:17:\"58bbe475c6242.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488708725', '1488708732', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('105', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"34514a3b8c3a9217e6e23a8cc37bfc78\";s:4:\"sha1\";s:40:\"0da2537ceb19b49c4b0f546344de56ba227e582e\";s:8:\"savename\";s:17:\"58bbe50819b3c.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488708872', '1488708878', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('106', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"30a14796b1e64c39d18d010f8c26942f\";s:4:\"sha1\";s:40:\"5c1593cb318edc14531ee263a8da30463fcd32c0\";s:8:\"savename\";s:17:\"58bbe5416d935.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488708929', '1488708934', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('107', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"30a14796b1e64c39d18d010f8c26942f\";s:4:\"sha1\";s:40:\"5c1593cb318edc14531ee263a8da30463fcd32c0\";s:8:\"savename\";s:17:\"58bbe56aa4bb8.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488708970', '1488708975', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('108', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488709207', '1488709281', './data/excel/export/Staff108_20170305182121.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('109', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:16:\"Staff export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"4c2f820f0281a38442d08cf977e3732b\";s:4:\"sha1\";s:40:\"3203cff8f87ae5a1f4eb35552281068ee689978f\";s:8:\"savename\";s:17:\"58bbe6ebafb3b.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488709355', '1488709402', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('110', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f5baded9b803bb915ffbf3ee1f360016\";s:4:\"sha1\";s:40:\"18bfb0fdc1f52d604f8c9e4397c7575b53f48453\";s:8:\"savename\";s:17:\"58bbe89600ee7.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488709782', '1488709791', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('111', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f06d9a787dbdf84bfc4d01153fc8bc88\";s:4:\"sha1\";s:40:\"7dfb7be30a24e2b1e8ce1ab7a4bd3074ad7d91b3\";s:8:\"savename\";s:17:\"58bbe8d39ffa3.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488709843', '1488709849', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('112', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f5baded9b803bb915ffbf3ee1f360016\";s:4:\"sha1\";s:40:\"18bfb0fdc1f52d604f8c9e4397c7575b53f48453\";s:8:\"savename\";s:17:\"58bbe915b0bfc.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488709909', '1488709914', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('113', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f5baded9b803bb915ffbf3ee1f360016\";s:4:\"sha1\";s:40:\"18bfb0fdc1f52d604f8c9e4397c7575b53f48453\";s:8:\"savename\";s:17:\"58bbe945e32b5.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488709957', '1488709962', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('114', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f5baded9b803bb915ffbf3ee1f360016\";s:4:\"sha1\";s:40:\"18bfb0fdc1f52d604f8c9e4397c7575b53f48453\";s:8:\"savename\";s:17:\"58bbe993aa1fc.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710035', '1488710040', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('115', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f5baded9b803bb915ffbf3ee1f360016\";s:4:\"sha1\";s:40:\"18bfb0fdc1f52d604f8c9e4397c7575b53f48453\";s:8:\"savename\";s:17:\"58bbe9bb7df14.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710075', '1488710080', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('116', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f5baded9b803bb915ffbf3ee1f360016\";s:4:\"sha1\";s:40:\"18bfb0fdc1f52d604f8c9e4397c7575b53f48453\";s:8:\"savename\";s:17:\"58bbea00a4839.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710144', '1488710160', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('117', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f5baded9b803bb915ffbf3ee1f360016\";s:4:\"sha1\";s:40:\"18bfb0fdc1f52d604f8c9e4397c7575b53f48453\";s:8:\"savename\";s:17:\"58bbea7388528.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710259', '1488710264', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('118', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"f5baded9b803bb915ffbf3ee1f360016\";s:4:\"sha1\";s:40:\"18bfb0fdc1f52d604f8c9e4397c7575b53f48453\";s:8:\"savename\";s:17:\"58bbeaad35024.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710317', '1488710379', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('119', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:16:\"Staff export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"0c86864b7a3341388017333f55c92e64\";s:4:\"sha1\";s:40:\"d3e25e996ca4b5ddf7581924826f2eac28476629\";s:8:\"savename\";s:17:\"58bbeae5d0c5c.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710373', '1488710379', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('120', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"bc81301eca23886aa7098ad0a21336be\";s:4:\"sha1\";s:40:\"f11dc07e853de0dcc6d4569980308f4eca2206a2\";s:8:\"savename\";s:17:\"58bbebc9d73cb.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710601', '1488710612', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('121', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"bc81301eca23886aa7098ad0a21336be\";s:4:\"sha1\";s:40:\"f11dc07e853de0dcc6d4569980308f4eca2206a2\";s:8:\"savename\";s:17:\"58bbec301a9ec.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710704', '1488710708', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('122', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"7993fa33173c60d1dd3b395134231eae\";s:4:\"sha1\";s:40:\"58c037487c7b1809a9f110edf25c0da0ea5116c3\";s:8:\"savename\";s:17:\"58bbec954ad06.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710805', '1488710811', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('123', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"d8cf5a8dde9ecc060e6fee002c693780\";s:4:\"sha1\";s:40:\"19580eee81d9c3e81fe3e693e7f5128fc65ad660\";s:8:\"savename\";s:17:\"58bbecd25ebe6.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-05/\";}}}}', '1', '1488710866', '1488710875', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('124', 'Mailroom export', 'a:4:{s:10:\"controller\";s:8:\"Mailroom\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '3', '1488763584', '1488800609', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('125', 'Seat export', 'a:4:{s:10:\"controller\";s:4:\"Seat\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '0', '1488763593', '1488800631', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('126', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";a:2:{s:7:\"task_id\";s:3:\"126\";s:11:\"error_reson\";s:24:\"生成表格文件失败\";}}', '0', '1488800539', '1488800632', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('127', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";a:2:{s:7:\"task_id\";s:3:\"127\";s:11:\"error_reson\";s:24:\"生成表格文件失败\";}}', '0', '1488800563', '1488800632', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('128', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";a:2:{s:7:\"task_id\";s:3:\"128\";s:11:\"error_reson\";s:24:\"生成表格文件失败\";}}', '0', '1488800742', '1488800747', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('129', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";a:2:{s:7:\"task_id\";s:3:\"129\";s:11:\"error_reson\";s:24:\"生成表格文件失败\";}}', '0', '1488801336', '1488801342', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('130', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488801505', '1488801511', './data/excel/export/Staff130_20170306195831.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('131', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488801507', '1488801511', './data/excel/export/Staff131_20170306195831.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('132', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:20:\"Staff export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"fd573e6d5a662d8662d4d6a8104a466d\";s:4:\"sha1\";s:40:\"9b22324300df8ad557f6ad5589a5dd45ea798633\";s:8:\"savename\";s:17:\"58bd4f5545f20.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '1', '1488801621', '1488801630', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('133', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:20:\"Staff export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a7aaa2470e76858d1dbda6b7f91d5652\";s:4:\"sha1\";s:40:\"b16397496d07c0c654d78abac24512f220d3b0bd\";s:8:\"savename\";s:17:\"58bd5058dce04.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '1', '1488801880', '1488801886', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('134', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:20:\"Staff export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"a7aaa2470e76858d1dbda6b7f91d5652\";s:4:\"sha1\";s:40:\"b16397496d07c0c654d78abac24512f220d3b0bd\";s:8:\"savename\";s:17:\"58bd508b8eee9.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '1', '1488801931', '1488801937', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('135', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:20:\"Staff export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"770fa1216ece3027d69e977017e0b0c9\";s:4:\"sha1\";s:40:\"b46c3ce4f2ea03c691540871abe619161ea8d3f2\";s:8:\"savename\";s:17:\"58bd516160025.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '1', '1488802145', '1488802153', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('136', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488802338', '1488802343', './data/excel/export/Staff136_20170306201223.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('137', 'PackageAddress export', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488802750', '1488802756', './data/excel/export/PackageAddress137_20170306201916.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('138', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:29:\"PackageAddress export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"274747b06d1a04fee99431808c847504\";s:4:\"sha1\";s:40:\"f48765e67e36b91a8be15a91633190311888a798\";s:8:\"savename\";s:17:\"58bd540d383fa.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '3', '1488802829', '1488802835', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('139', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:29:\"PackageAddress export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"274747b06d1a04fee99431808c847504\";s:4:\"sha1\";s:40:\"f48765e67e36b91a8be15a91633190311888a798\";s:8:\"savename\";s:17:\"58bd548dde658.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '1', '1488802957', '1488802971', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('140', 'Costcenters export', 'a:4:{s:10:\"controller\";s:11:\"Costcenters\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488804540', '1488804558', './data/excel/export/Costcenters140_20170306204918.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('141', 'Costcenters import', 'a:4:{s:10:\"controller\";s:11:\"Costcenters\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:22:\"Costcenters export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"1c79d58b9d5b3b1647722afadd631e16\";s:4:\"sha1\";s:40:\"ede180ef3df9263d58ab8be491809b97c3ebd57b\";s:8:\"savename\";s:17:\"58bd5b246572d.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '3', '1488804644', '1488804655', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('142', 'Costcenters import', 'a:4:{s:10:\"controller\";s:11:\"Costcenters\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:22:\"Costcenters export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"1c79d58b9d5b3b1647722afadd631e16\";s:4:\"sha1\";s:40:\"ede180ef3df9263d58ab8be491809b97c3ebd57b\";s:8:\"savename\";s:17:\"58bd5ba2273e1.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '1', '1488804770', '1488804776', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('143', 'Departments export', 'a:4:{s:10:\"controller\";s:11:\"Departments\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488805058', '1488805063', './data/excel/export/Departments143_20170306205743.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('144', 'Departments import', 'a:4:{s:10:\"controller\";s:11:\"Departments\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:22:\"Departments export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25088;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"35946c04aec949643c71c9342c0ad7af\";s:4:\"sha1\";s:40:\"3909ee99973ad7c261928df7fd932caad141a993\";s:8:\"savename\";s:17:\"58bd5d5f6e2ff.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '1', '1488805215', '1488805226', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('145', 'ExpressCompany export', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488805653', '1488805658', './data/excel/export/ExpressCompany145_20170306210738.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('146', 'ExpressCompany import', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"ExpressCompany export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:27136;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"ccc9991ce226ade4291e81545450666c\";s:4:\"sha1\";s:40:\"40aceb9ee9530ecb05eb3bb5e64aef11d85799c2\";s:8:\"savename\";s:17:\"58bd5f4adbf37.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-06/\";}}}}', '1', '1488805706', '1488805723', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('147', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488848887', '1488848926', './data/excel/export/Staff147_20170307090846.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('148', 'Departments export', 'a:4:{s:10:\"controller\";s:11:\"Departments\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488848896', '1488848926', './data/excel/export/Departments148_20170307090846.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('149', 'Costcenters export', 'a:4:{s:10:\"controller\";s:11:\"Costcenters\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488848903', '1488848926', './data/excel/export/Costcenters149_20170307090846.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('150', 'PackageAddress export', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488848921', '1488848926', './data/excel/export/PackageAddress150_20170307090846.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('151', 'Staff import', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:16:\"Staff export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"323a85e20dbf7ea901eb559edebbd527\";s:4:\"sha1\";s:40:\"82f34c5fe9cc19cbc0191699f3556e77149ab540\";s:8:\"savename\";s:17:\"58be09d3da7e1.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488849363', '1488849368', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('152', 'Departments import', 'a:4:{s:10:\"controller\";s:11:\"Departments\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:22:\"Departments export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26624;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"2fc7f319de8fdee2da96c87980788734\";s:4:\"sha1\";s:40:\"0d503342d0689feb765600befce1f4b8ffe0d8de\";s:8:\"savename\";s:17:\"58be0a107f63f.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488849424', '1488849430', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('153', 'Costcenters import', 'a:4:{s:10:\"controller\";s:11:\"Costcenters\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:22:\"Costcenters export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"0c227789df84567d146d381319f43f30\";s:4:\"sha1\";s:40:\"83f222ce0cabea6b0f522612f78cf8dbb9a3ce30\";s:8:\"savename\";s:17:\"58be0ab60717e.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488849590', '1488849595', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('154', 'PackageAddress import', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:25:\"PackageAddress export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"d9b2ef33af254e84e119098cb93c5d87\";s:4:\"sha1\";s:40:\"65618a608bcbeaca4573d0a9a577277613dcd0aa\";s:8:\"savename\";s:17:\"58be0b10140d7.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488849680', '1488849684', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('155', 'Seat export', 'a:4:{s:10:\"controller\";s:4:\"Seat\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488850169', '1488850448', './data/excel/export/Seat155_20170307093408.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('156', 'Seat export', 'a:4:{s:10:\"controller\";s:4:\"Seat\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488850444', '1488850448', './data/excel/export/Seat156_20170307093408.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('157', 'Seat import', 'a:4:{s:10:\"controller\";s:4:\"Seat\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:15:\"Seat export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:24576;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"da92f990ff66cca443b87f03590a16a6\";s:4:\"sha1\";s:40:\"7dd385c50dcd304b06aee7b94082068bc76d4a8b\";s:8:\"savename\";s:17:\"58be0e6dae89a.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488850541', '1488850546', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('158', 'Mailroom export', 'a:4:{s:10:\"controller\";s:8:\"Mailroom\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488850567', '1488851215', './data/excel/export/Mailroom158_20170307094655.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('159', 'Mailroom export', 'a:4:{s:10:\"controller\";s:8:\"Mailroom\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488851210', '1488851216', './data/excel/export/Mailroom159_20170307094656.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('160', 'Mailroom import', 'a:4:{s:10:\"controller\";s:8:\"Mailroom\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Mailroom export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"5a145740a259dfaceb959608b1486a1f\";s:4:\"sha1\";s:40:\"84724ee023fc2d1452365e68e76dcdc942efa941\";s:8:\"savename\";s:17:\"58be121334ac1.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '3', '1488851475', '1488851505', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('161', 'Mailroom export', 'a:4:{s:10:\"controller\";s:8:\"Mailroom\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488851717', '1488851725', './data/excel/export/Mailroom161_20170307095525.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('162', 'Mailroom import', 'a:4:{s:10:\"controller\";s:8:\"Mailroom\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:23:\"Mailroom export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"5eee8861b1873ecc8645932d24862382\";s:4:\"sha1\";s:40:\"7b02377daa446b9290be7e1e570bed760c22980b\";s:8:\"savename\";s:17:\"58be139a1ef75.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488851866', '1488851871', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('163', 'Send export', 'a:4:{s:10:\"controller\";s:4:\"Send\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488865218', '1488865227', './data/excel/export/Send163_20170307134027.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('164', 'Send import', 'a:4:{s:10:\"controller\";s:4:\"Send\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:15:\"Send export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"436c3919cb7cdee11e1c6df8593d5f25\";s:4:\"sha1\";s:40:\"5094df99ec29bc48a4f46bf09938ffd4a711b8c5\";s:8:\"savename\";s:17:\"58be49029b2ca.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488865538', '1488865544', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('165', 'Send import', 'a:4:{s:10:\"controller\";s:4:\"Send\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:15:\"Send export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"2f11fe125c5e1f5c454f42b8fd949188\";s:4:\"sha1\";s:40:\"fe6a2d43b4d722356ee9b55c37100a8596b9ee51\";s:8:\"savename\";s:17:\"58be4b0a9f71f.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488866058', '1488866064', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('166', 'Send import', 'a:4:{s:10:\"controller\";s:4:\"Send\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:15:\"Send export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26112;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"71ddac4a1a6586f3f8e5ef6a8810173d\";s:4:\"sha1\";s:40:\"e350d7e10d138eadebe28ec5b0f8f2b0dbd7815b\";s:8:\"savename\";s:17:\"58be4bd093994.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488866256', '1488866261', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('167', 'Send export', 'a:4:{s:10:\"controller\";s:4:\"Send\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488867121', '1488867126', './data/excel/export/Send167_20170307141206.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('168', 'Send import', 'a:4:{s:10:\"controller\";s:4:\"Send\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:19:\"Send export (1).xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:26874;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"b4df506cd0b4d1c50fad0c6d05676f76\";s:4:\"sha1\";s:40:\"fa9d0c09755e23e0ed8182e8170b288d6d75e9ea\";s:8:\"savename\";s:17:\"58be4fc0904cc.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488867264', '1488867269', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('169', 'Way export', 'a:4:{s:10:\"controller\";s:3:\"Way\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '1', '1488869043', '1488869048', './data/excel/export/Way169_20170307144408.xls', '1', '0');
INSERT INTO `cmf_queue` VALUES ('170', 'Way import', 'a:4:{s:10:\"controller\";s:3:\"Way\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"import\";s:6:\"params\";a:1:{s:4:\"info\";a:1:{s:4:\"file\";a:9:{s:4:\"name\";s:14:\"Way export.xls\";s:4:\"type\";s:18:\"application/msword\";s:4:\"size\";i:25600;s:3:\"key\";s:4:\"file\";s:3:\"ext\";s:3:\"xls\";s:3:\"md5\";s:32:\"b1afac625f6babd7289e28b0c302e1e8\";s:4:\"sha1\";s:40:\"d4889032557b08604fa4839756ea4c69a331a06a\";s:8:\"savename\";s:17:\"58be57086d417.xls\";s:8:\"savepath\";s:24:\"excel/import/2017-03-07/\";}}}}', '1', '1488869128', '1488869158', null, '2', '0');
INSERT INTO `cmf_queue` VALUES ('171', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880297', '1488880297', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('172', 'Departments export', 'a:4:{s:10:\"controller\";s:11:\"Departments\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880303', '1488880303', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('173', 'Costcenters export', 'a:4:{s:10:\"controller\";s:11:\"Costcenters\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880308', '1488880308', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('174', 'Seat export', 'a:4:{s:10:\"controller\";s:4:\"Seat\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880314', '1488880314', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('175', 'Mailroom export', 'a:4:{s:10:\"controller\";s:8:\"Mailroom\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880320', '1488880320', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('176', 'ExpressCompany export', 'a:4:{s:10:\"controller\";s:14:\"ExpressCompany\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880346', '1488880346', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('177', 'Send export', 'a:4:{s:10:\"controller\";s:4:\"Send\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880352', '1488880352', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('178', 'Send export', 'a:4:{s:10:\"controller\";s:4:\"Send\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880357', '1488880357', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('179', 'PackageAddress export', 'a:4:{s:10:\"controller\";s:14:\"PackageAddress\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880362', '1488880362', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('180', 'Way export', 'a:4:{s:10:\"controller\";s:3:\"Way\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488880370', '1488880370', null, '1', '0');
INSERT INTO `cmf_queue` VALUES ('181', 'Staff export', 'a:4:{s:10:\"controller\";s:5:\"Staff\";s:5:\"model\";s:5:\"Admin\";s:6:\"action\";s:6:\"export\";s:6:\"params\";N;}', '2', '1488935734', '1488935734', null, '1', '0');

-- ----------------------------
-- Table structure for cmf_receiving
-- ----------------------------
DROP TABLE IF EXISTS `cmf_receiving`;
CREATE TABLE `cmf_receiving` (
  `receive_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '快件ID',
  `airway_bill_no` varchar(50) NOT NULL DEFAULT '0' COMMENT '运单号',
  `serial_number` int(11) NOT NULL DEFAULT '1' COMMENT '流水号',
  `job_no` varchar(50) NOT NULL DEFAULT '0' COMMENT '内部编号',
  `express_attr` tinyint(1) NOT NULL DEFAULT '0' COMMENT '快件属性：0：文件、1：包裹',
  `express_type` tinyint(1) NOT NULL DEFAULT '0' COMMENT '快件类型：0：国内件、1：国外件',
  `express_company_id` int(255) NOT NULL DEFAULT '0' COMMENT '快递公司 ID',
  `package_num` tinyint(3) NOT NULL DEFAULT '1' COMMENT '包裹数量',
  `operator_id` int(11) NOT NULL DEFAULT '0' COMMENT '操作人ID',
  `inside_and_outside` enum('outside','inside') NOT NULL DEFAULT 'outside' COMMENT '内外部件标识',
  `staff_name` varchar(255) DEFAULT NULL COMMENT '员工姓名',
  `staff_department_id` int(11) NOT NULL DEFAULT '0' COMMENT '部门ID',
  `staff_department` varchar(255) DEFAULT NULL COMMENT '员工部门',
  `staff_id` int(11) NOT NULL DEFAULT '0' COMMENT '收件人ID',
  `staff_mobile` varchar(50) DEFAULT '' COMMENT '收件人电话',
  `staff_tel` varchar(50) DEFAULT NULL COMMENT '收件人固话',
  `seat_id` int(11) NOT NULL DEFAULT '0' COMMENT '座位号ID',
  `seat_number` varchar(200) DEFAULT NULL COMMENT '座位号快照',
  `remark` text COMMENT '备注',
  `send_name` varchar(50) DEFAULT NULL COMMENT '发件人姓名',
  `send_mobile` varchar(50) DEFAULT NULL COMMENT '发件人手机',
  `send_tel` varchar(50) DEFAULT NULL COMMENT '发件人固话',
  `send_region_id` int(11) DEFAULT NULL COMMENT '发件人地区ID',
  `send_detail_addr` varchar(255) DEFAULT NULL COMMENT '发件人详细地址',
  `send_company` varchar(255) DEFAULT NULL COMMENT '发件人公司',
  `status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '录入状态：0：mailroom 未签收，1 已签收（归档），2滞纳件，3，派送失败',
  `fail_reason` varchar(255) DEFAULT NULL COMMENT '滞纳原因，失败原因',
  `sing_time` int(11) NOT NULL DEFAULT '0' COMMENT '签收时间',
  `print_count` smallint(6) NOT NULL DEFAULT '0' COMMENT '打印次数',
  `print_status` tinyint(1) NOT NULL DEFAULT '0' COMMENT '打印状态，0未打印，1已打印过',
  `print_time` int(10) NOT NULL DEFAULT '0' COMMENT '打印时间',
  `to_pay_part` tinyint(1) NOT NULL DEFAULT '0' COMMENT '1：到付，0：已付',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除：1（TRUE）， 0（FALSE）',
  `create_time` int(11) NOT NULL DEFAULT '0' COMMENT '添加时间',
  `update_time` int(11) NOT NULL DEFAULT '0' COMMENT '更新时间',
  PRIMARY KEY (`receive_id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_receiving
-- ----------------------------
INSERT INTO `cmf_receiving` VALUES ('65', '99990001', '1', 'DHL1170307000001-2-1', '0', '0', '2', '1', '1', 'outside', '素素', '0', '人事部', '22', '18912370012', '', '31', 'A01-03-02', '', '馥馥妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866589', '1488866589');
INSERT INTO `cmf_receiving` VALUES ('66', '99990001', '1', 'DHL1170307000001-2-2', '0', '0', '2', '1', '1', 'outside', '素素', '0', '人事部', '22', '18912370012', '', '31', 'A01-03-02', '', '馥馥妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866589', '1488866589');
INSERT INTO `cmf_receiving` VALUES ('67', '99990002', '3', 'DHL1170307000003-2-1', '1', '0', '3', '1', '1', 'outside', '嘟嘟', '0', '测试部', '19', '18912370009', '', '28', 'A01-02-04', '', '瑟瑟妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866605', '1488866605');
INSERT INTO `cmf_receiving` VALUES ('68', '99990002', '3', 'DHL1170307000003-2-2', '1', '0', '3', '1', '1', 'outside', '嘟嘟', '0', '测试部', '19', '18912370009', '', '28', 'A01-02-04', '', '瑟瑟妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866605', '1488866605');
INSERT INTO `cmf_receiving` VALUES ('69', '99990003', '5', 'DHL1170307000005-1-1', '1', '0', '3', '1', '1', 'outside', '嘟嘟', '0', '测试部', '19', '18912370009', '', '28', 'A01-02-04', '', '素素妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866676', '1488866676');
INSERT INTO `cmf_receiving` VALUES ('70', '99990004', '6', 'DHL1170307000006-2-1', '1', '0', '2', '1', '1', 'outside', '杜杜', '0', '人事部', '21', '18912370011', '', '30', 'A01-03-01', '', '杜杜妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866689', '1488866689');
INSERT INTO `cmf_receiving` VALUES ('71', '99990004', '6', 'DHL1170307000006-2-2', '1', '0', '2', '1', '1', 'outside', '杜杜', '0', '人事部', '21', '18912370011', '', '30', 'A01-03-01', '', '杜杜妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866689', '1488866689');
INSERT INTO `cmf_receiving` VALUES ('72', '99990005', '8', 'DHL1170307000008-1-1', '1', '0', '2', '1', '1', 'outside', '酷酷', '0', '研发部', '16', '18912370006', '', '25', 'A01-02-01', '', '佛佛妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866698', '1488866698');
INSERT INTO `cmf_receiving` VALUES ('73', '99990005', '9', 'DHL1170307000009-1-1', '1', '0', '2', '1', '1', 'outside', '拂拂', '0', '测试部', '17', '18912370007', '', '26', 'A01-02-02', '', '酷酷妈', '', '', '0', '', '', '3', '派送不成功', '0', '3', '1', '1488880725', '0', '0', '1488866703', '1488866703');
INSERT INTO `cmf_receiving` VALUES ('74', '99990006', '10', 'DHL1170307000010-2-1', '1', '0', '3', '1', '1', 'outside', '素素', '0', '人事部', '22', '18912370012', '', '31', 'A01-03-02', '', '咕咕妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866714', '1488866714');
INSERT INTO `cmf_receiving` VALUES ('75', '99990006', '10', 'DHL1170307000010-2-2', '1', '0', '3', '1', '1', 'outside', '素素', '0', '人事部', '22', '18912370012', '', '31', 'A01-03-02', '', '咕咕妈', '', '', '0', '', '', '0', null, '0', '3', '1', '1488880725', '0', '0', '1488866714', '1488866714');
INSERT INTO `cmf_receiving` VALUES ('76', '99990007', '12', 'DHL1170307000012-2-1', '1', '0', '3', '1', '1', 'outside', '悦悦', '0', '研发部', '11', '18912370001', '', '21', 'A01-01-02', '', '糊糊妈', '', '', '0', '', '', '1', null, '1488895475', '3', '1', '1488880725', '0', '0', '1488866722', '1488866722');
INSERT INTO `cmf_receiving` VALUES ('77', '99990007', '12', 'DHL1170307000012-2-2', '1', '0', '3', '1', '1', 'outside', '悦悦', '0', '研发部', '11', '18912370001', '', '21', 'A01-01-02', '', '糊糊妈', '', '', '0', '', '', '1', null, '1488895475', '3', '1', '1488880725', '0', '0', '1488866722', '1488866722');
INSERT INTO `cmf_receiving` VALUES ('78', '99990008', '14', 'DHL1170307000014-2-1', '1', '0', '3', '1', '1', 'outside', '瑟瑟', '0', '人事部', '23', '18912370013', '', '32', 'A01-03-03', '', '乐乐妈', '', '', '0', '', '', '0', null, '0', '6', '1', '1488881120', '0', '0', '1488866729', '1488866729');
INSERT INTO `cmf_receiving` VALUES ('79', '99990008', '14', 'DHL1170307000014-2-2', '1', '0', '3', '1', '1', 'outside', '瑟瑟', '0', '人事部', '23', '18912370013', '', '32', 'A01-03-03', '', '乐乐妈', '', '', '0', '', '', '0', null, '0', '6', '1', '1488881120', '0', '0', '1488866729', '1488866729');
INSERT INTO `cmf_receiving` VALUES ('80', '99990009', '16', 'DHL1170307000016-2-1', '1', '0', '3', '1', '1', 'inside', '乐乐', '0', '测试部', '12', '18912370002', '', '20', 'A01-01-01', '', '悦悦妈', '', '', '0', '', '', '1', null, '1488895475', '6', '1', '1488880725', '0', '0', '1488866738', '1488866738');
INSERT INTO `cmf_receiving` VALUES ('81', '99990009', '16', 'DHL1170307000016-2-2', '1', '0', '3', '1', '1', 'inside', '乐乐', '0', '测试部', '12', '18912370002', '', '20', 'A01-01-01', '', '悦悦妈', '', '', '0', '', '', '1', null, '1488895475', '6', '1', '1488880725', '0', '0', '1488866738', '1488866738');

-- ----------------------------
-- Table structure for cmf_regions
-- ----------------------------
DROP TABLE IF EXISTS `cmf_regions`;
CREATE TABLE `cmf_regions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentid` int(11) NOT NULL DEFAULT '0',
  `name` varchar(100) DEFAULT NULL,
  `grade` smallint(5) DEFAULT '1',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  `path` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3269 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_regions
-- ----------------------------
INSERT INTO `cmf_regions` VALUES ('3268', '0', '中国', '1', '0', '0', '0', ',3268,');
INSERT INTO `cmf_regions` VALUES ('1', '3268', '北京', '2', '0', '0', '0', ',3268,1,');
INSERT INTO `cmf_regions` VALUES ('2', '1', '北京市', '3', '0', '0', '0', ',3268,1,2,');
INSERT INTO `cmf_regions` VALUES ('3', '2', '东城区', '4', '0', '0', '0', ',3268,1,2,3,');
INSERT INTO `cmf_regions` VALUES ('4', '2', '西城区', '4', '0', '0', '0', ',3268,1,2,4,');
INSERT INTO `cmf_regions` VALUES ('5', '2', '崇文区', '4', '0', '0', '0', ',3268,1,2,5,');
INSERT INTO `cmf_regions` VALUES ('6', '2', '宣武区', '4', '0', '0', '0', ',3268,1,2,6,');
INSERT INTO `cmf_regions` VALUES ('7', '2', '朝阳区', '4', '0', '0', '0', ',3268,1,2,7,');
INSERT INTO `cmf_regions` VALUES ('8', '2', '丰台区', '4', '0', '0', '0', ',3268,1,2,8,');
INSERT INTO `cmf_regions` VALUES ('9', '2', '石景山区', '4', '0', '0', '0', ',3268,1,2,9,');
INSERT INTO `cmf_regions` VALUES ('10', '2', '海淀区', '4', '0', '0', '0', ',3268,1,2,10,');
INSERT INTO `cmf_regions` VALUES ('11', '2', '门头沟区', '4', '0', '0', '0', ',3268,1,2,11,');
INSERT INTO `cmf_regions` VALUES ('12', '2', '房山区', '4', '0', '0', '0', ',3268,1,2,12,');
INSERT INTO `cmf_regions` VALUES ('13', '2', '通州区', '4', '0', '0', '0', ',3268,1,2,13,');
INSERT INTO `cmf_regions` VALUES ('14', '2', '顺义区', '4', '0', '0', '0', ',3268,1,2,14,');
INSERT INTO `cmf_regions` VALUES ('15', '2', '昌平区', '4', '0', '0', '0', ',3268,1,2,15,');
INSERT INTO `cmf_regions` VALUES ('16', '2', '大兴区', '4', '0', '0', '0', ',3268,1,2,16,');
INSERT INTO `cmf_regions` VALUES ('17', '2', '怀柔区', '4', '0', '0', '0', ',3268,1,2,17,');
INSERT INTO `cmf_regions` VALUES ('18', '2', '平谷区', '4', '0', '0', '0', ',3268,1,2,18,');
INSERT INTO `cmf_regions` VALUES ('19', '2', '密云县', '4', '0', '0', '0', ',3268,1,2,19,');
INSERT INTO `cmf_regions` VALUES ('20', '2', '延庆县', '4', '0', '0', '0', ',3268,1,2,20,');
INSERT INTO `cmf_regions` VALUES ('21', '3268', '上海', '2', '0', '0', '0', ',3268,21,');
INSERT INTO `cmf_regions` VALUES ('22', '21', '上海市', '3', '0', '0', '0', ',3268,21,22,');
INSERT INTO `cmf_regions` VALUES ('23', '22', '黄浦区', '4', '0', '0', '0', ',3268,21,22,23,');
INSERT INTO `cmf_regions` VALUES ('24', '22', '卢湾区', '4', '0', '0', '0', ',3268,21,22,24,');
INSERT INTO `cmf_regions` VALUES ('25', '22', '徐汇区', '4', '0', '0', '0', ',3268,21,22,25,');
INSERT INTO `cmf_regions` VALUES ('26', '22', '长宁区', '4', '0', '0', '0', ',3268,21,22,26,');
INSERT INTO `cmf_regions` VALUES ('27', '22', '静安区', '4', '0', '0', '0', ',3268,21,22,27,');
INSERT INTO `cmf_regions` VALUES ('28', '22', '普陀区', '4', '0', '0', '0', ',3268,21,22,28,');
INSERT INTO `cmf_regions` VALUES ('29', '22', '闸北区', '4', '0', '0', '0', ',3268,21,22,29,');
INSERT INTO `cmf_regions` VALUES ('30', '22', '虹口区', '4', '0', '0', '0', ',3268,21,22,30,');
INSERT INTO `cmf_regions` VALUES ('31', '22', '杨浦区', '4', '0', '0', '0', ',3268,21,22,31,');
INSERT INTO `cmf_regions` VALUES ('32', '22', '闵行区', '4', '0', '0', '0', ',3268,21,22,32,');
INSERT INTO `cmf_regions` VALUES ('33', '22', '宝山区', '4', '0', '0', '0', ',3268,21,22,33,');
INSERT INTO `cmf_regions` VALUES ('34', '22', '嘉定区', '4', '0', '0', '0', ',3268,21,22,34,');
INSERT INTO `cmf_regions` VALUES ('35', '22', '浦东新区', '4', '0', '0', '0', ',3268,21,22,35,');
INSERT INTO `cmf_regions` VALUES ('36', '22', '金山区', '4', '0', '0', '0', ',3268,21,22,36,');
INSERT INTO `cmf_regions` VALUES ('37', '22', '松江区', '4', '0', '0', '0', ',3268,21,22,37,');
INSERT INTO `cmf_regions` VALUES ('38', '22', '青浦区', '4', '0', '0', '0', ',3268,21,22,38,');
INSERT INTO `cmf_regions` VALUES ('39', '22', '南汇区', '4', '0', '0', '0', ',3268,21,22,39,');
INSERT INTO `cmf_regions` VALUES ('40', '22', '奉贤区', '4', '0', '0', '0', ',3268,21,22,40,');
INSERT INTO `cmf_regions` VALUES ('41', '22', '崇明县', '4', '0', '0', '0', ',3268,21,22,41,');
INSERT INTO `cmf_regions` VALUES ('42', '3268', '天津', '2', '0', '0', '0', ',3268,42,');
INSERT INTO `cmf_regions` VALUES ('43', '42', '天津市', '3', '0', '0', '0', ',3268,42,43,');
INSERT INTO `cmf_regions` VALUES ('44', '43', '和平区', '4', '0', '0', '0', ',3268,42,43,44,');
INSERT INTO `cmf_regions` VALUES ('45', '43', '河东区', '4', '0', '0', '0', ',3268,42,43,45,');
INSERT INTO `cmf_regions` VALUES ('46', '43', '河西区', '4', '0', '0', '0', ',3268,42,43,46,');
INSERT INTO `cmf_regions` VALUES ('47', '43', '南开区', '4', '0', '0', '0', ',3268,42,43,47,');
INSERT INTO `cmf_regions` VALUES ('48', '43', '河北区', '4', '0', '0', '0', ',3268,42,43,48,');
INSERT INTO `cmf_regions` VALUES ('49', '43', '红桥区', '4', '0', '0', '0', ',3268,42,43,49,');
INSERT INTO `cmf_regions` VALUES ('50', '43', '塘沽区', '4', '0', '0', '0', ',3268,42,43,50,');
INSERT INTO `cmf_regions` VALUES ('51', '43', '汉沽区', '4', '0', '0', '0', ',3268,42,43,51,');
INSERT INTO `cmf_regions` VALUES ('52', '43', '大港区', '4', '0', '0', '0', ',3268,42,43,52,');
INSERT INTO `cmf_regions` VALUES ('53', '43', '东丽区', '4', '0', '0', '0', ',3268,42,43,53,');
INSERT INTO `cmf_regions` VALUES ('54', '43', '西青区', '4', '0', '0', '0', ',3268,42,43,54,');
INSERT INTO `cmf_regions` VALUES ('55', '43', '津南区', '4', '0', '0', '0', ',3268,42,43,55,');
INSERT INTO `cmf_regions` VALUES ('56', '43', '北辰区', '4', '0', '0', '0', ',3268,42,43,56,');
INSERT INTO `cmf_regions` VALUES ('57', '43', '武清区', '4', '0', '0', '0', ',3268,42,43,57,');
INSERT INTO `cmf_regions` VALUES ('58', '43', '宝坻区', '4', '0', '0', '0', ',3268,42,43,58,');
INSERT INTO `cmf_regions` VALUES ('59', '43', '宁河县', '4', '0', '0', '0', ',3268,42,43,59,');
INSERT INTO `cmf_regions` VALUES ('60', '43', '静海县', '4', '0', '0', '0', ',3268,42,43,60,');
INSERT INTO `cmf_regions` VALUES ('61', '43', '蓟县', '4', '0', '0', '0', ',3268,42,43,61,');
INSERT INTO `cmf_regions` VALUES ('62', '3268', '重庆', '2', '0', '0', '0', ',3268,62,');
INSERT INTO `cmf_regions` VALUES ('63', '62', '重庆市', '3', '0', '0', '0', ',3268,62,63,');
INSERT INTO `cmf_regions` VALUES ('64', '63', '万州区', '4', '0', '0', '0', ',3268,62,63,64,');
INSERT INTO `cmf_regions` VALUES ('65', '63', '涪陵区', '4', '0', '0', '0', ',3268,62,63,65,');
INSERT INTO `cmf_regions` VALUES ('66', '63', '渝中区', '4', '0', '0', '0', ',3268,62,63,66,');
INSERT INTO `cmf_regions` VALUES ('67', '63', '大渡口区', '4', '0', '0', '0', ',3268,62,63,67,');
INSERT INTO `cmf_regions` VALUES ('68', '63', '江北区', '4', '0', '0', '0', ',3268,62,63,68,');
INSERT INTO `cmf_regions` VALUES ('69', '63', '沙坪坝区', '4', '0', '0', '0', ',3268,62,63,69,');
INSERT INTO `cmf_regions` VALUES ('70', '63', '九龙坡区', '4', '0', '0', '0', ',3268,62,63,70,');
INSERT INTO `cmf_regions` VALUES ('71', '63', '南岸区', '4', '0', '0', '0', ',3268,62,63,71,');
INSERT INTO `cmf_regions` VALUES ('72', '63', '北碚区', '4', '0', '0', '0', ',3268,62,63,72,');
INSERT INTO `cmf_regions` VALUES ('73', '63', '万盛区', '4', '0', '0', '0', ',3268,62,63,73,');
INSERT INTO `cmf_regions` VALUES ('74', '63', '双桥区', '4', '0', '0', '0', ',3268,62,63,74,');
INSERT INTO `cmf_regions` VALUES ('75', '63', '渝北区', '4', '0', '0', '0', ',3268,62,63,75,');
INSERT INTO `cmf_regions` VALUES ('76', '63', '巴南区', '4', '0', '0', '0', ',3268,62,63,76,');
INSERT INTO `cmf_regions` VALUES ('77', '63', '黔江区', '4', '0', '0', '0', ',3268,62,63,77,');
INSERT INTO `cmf_regions` VALUES ('78', '63', '长寿区', '4', '0', '0', '0', ',3268,62,63,78,');
INSERT INTO `cmf_regions` VALUES ('79', '63', '綦江县', '4', '0', '0', '0', ',3268,62,63,79,');
INSERT INTO `cmf_regions` VALUES ('80', '63', '潼南县', '4', '0', '0', '0', ',3268,62,63,80,');
INSERT INTO `cmf_regions` VALUES ('81', '63', '铜梁县', '4', '0', '0', '0', ',3268,62,63,81,');
INSERT INTO `cmf_regions` VALUES ('82', '63', '大足县', '4', '0', '0', '0', ',3268,62,63,82,');
INSERT INTO `cmf_regions` VALUES ('83', '63', '荣昌县', '4', '0', '0', '0', ',3268,62,63,83,');
INSERT INTO `cmf_regions` VALUES ('84', '63', '璧山县', '4', '0', '0', '0', ',3268,62,63,84,');
INSERT INTO `cmf_regions` VALUES ('85', '63', '梁平县', '4', '0', '0', '0', ',3268,62,63,85,');
INSERT INTO `cmf_regions` VALUES ('86', '63', '城口县', '4', '0', '0', '0', ',3268,62,63,86,');
INSERT INTO `cmf_regions` VALUES ('87', '63', '丰都县', '4', '0', '0', '0', ',3268,62,63,87,');
INSERT INTO `cmf_regions` VALUES ('88', '63', '垫江县', '4', '0', '0', '0', ',3268,62,63,88,');
INSERT INTO `cmf_regions` VALUES ('89', '63', '武隆县', '4', '0', '0', '0', ',3268,62,63,89,');
INSERT INTO `cmf_regions` VALUES ('90', '63', '忠县', '4', '0', '0', '0', ',3268,62,63,90,');
INSERT INTO `cmf_regions` VALUES ('91', '63', '开县', '4', '0', '0', '0', ',3268,62,63,91,');
INSERT INTO `cmf_regions` VALUES ('92', '63', '云阳县', '4', '0', '0', '0', ',3268,62,63,92,');
INSERT INTO `cmf_regions` VALUES ('93', '63', '奉节县', '4', '0', '0', '0', ',3268,62,63,93,');
INSERT INTO `cmf_regions` VALUES ('94', '63', '巫山县', '4', '0', '0', '0', ',3268,62,63,94,');
INSERT INTO `cmf_regions` VALUES ('95', '63', '巫溪县', '4', '0', '0', '0', ',3268,62,63,95,');
INSERT INTO `cmf_regions` VALUES ('96', '63', '石柱土家族自治县', '4', '0', '0', '0', ',3268,62,63,96,');
INSERT INTO `cmf_regions` VALUES ('97', '63', '秀山土家族苗族自治县', '4', '0', '0', '0', ',3268,62,63,97,');
INSERT INTO `cmf_regions` VALUES ('98', '63', '酉阳土家族苗族自治县', '4', '0', '0', '0', ',3268,62,63,98,');
INSERT INTO `cmf_regions` VALUES ('99', '63', '彭水苗族土家族自治县', '4', '0', '0', '0', ',3268,62,63,99,');
INSERT INTO `cmf_regions` VALUES ('100', '63', '江津市', '4', '0', '0', '0', ',3268,62,63,100,');
INSERT INTO `cmf_regions` VALUES ('101', '63', '合川市', '4', '0', '0', '0', ',3268,62,63,101,');
INSERT INTO `cmf_regions` VALUES ('102', '63', '永川市', '4', '0', '0', '0', ',3268,62,63,102,');
INSERT INTO `cmf_regions` VALUES ('103', '63', '南川市', '4', '0', '0', '0', ',3268,62,63,103,');
INSERT INTO `cmf_regions` VALUES ('104', '3268', '安徽', '2', '0', '0', '0', ',3268,104,');
INSERT INTO `cmf_regions` VALUES ('105', '104', '合肥市', '3', '0', '0', '0', ',3268,104,105,');
INSERT INTO `cmf_regions` VALUES ('106', '105', '瑶海区', '4', '0', '0', '0', ',3268,104,105,106,');
INSERT INTO `cmf_regions` VALUES ('107', '105', '庐阳区', '4', '0', '0', '0', ',3268,104,105,107,');
INSERT INTO `cmf_regions` VALUES ('108', '105', '蜀山区', '4', '0', '0', '0', ',3268,104,105,108,');
INSERT INTO `cmf_regions` VALUES ('109', '105', '包河区', '4', '0', '0', '0', ',3268,104,105,109,');
INSERT INTO `cmf_regions` VALUES ('110', '105', '长丰县', '4', '0', '0', '0', ',3268,104,105,110,');
INSERT INTO `cmf_regions` VALUES ('111', '105', '肥东县', '4', '0', '0', '0', ',3268,104,105,111,');
INSERT INTO `cmf_regions` VALUES ('112', '105', '肥西县', '4', '0', '0', '0', ',3268,104,105,112,');
INSERT INTO `cmf_regions` VALUES ('113', '104', '安庆市', '3', '0', '0', '0', ',3268,104,113,');
INSERT INTO `cmf_regions` VALUES ('114', '113', '迎江区', '4', '0', '0', '0', ',3268,104,113,114,');
INSERT INTO `cmf_regions` VALUES ('115', '113', '大观区', '4', '0', '0', '0', ',3268,104,113,115,');
INSERT INTO `cmf_regions` VALUES ('116', '113', '郊区', '4', '0', '0', '0', ',3268,104,113,116,');
INSERT INTO `cmf_regions` VALUES ('117', '113', '怀宁县', '4', '0', '0', '0', ',3268,104,113,117,');
INSERT INTO `cmf_regions` VALUES ('118', '113', '枞阳县', '4', '0', '0', '0', ',3268,104,113,118,');
INSERT INTO `cmf_regions` VALUES ('119', '113', '潜山县', '4', '0', '0', '0', ',3268,104,113,119,');
INSERT INTO `cmf_regions` VALUES ('120', '113', '太湖县', '4', '0', '0', '0', ',3268,104,113,120,');
INSERT INTO `cmf_regions` VALUES ('121', '113', '宿松县', '4', '0', '0', '0', ',3268,104,113,121,');
INSERT INTO `cmf_regions` VALUES ('122', '113', '望江县', '4', '0', '0', '0', ',3268,104,113,122,');
INSERT INTO `cmf_regions` VALUES ('123', '113', '岳西县', '4', '0', '0', '0', ',3268,104,113,123,');
INSERT INTO `cmf_regions` VALUES ('124', '113', '桐城市', '4', '0', '0', '0', ',3268,104,113,124,');
INSERT INTO `cmf_regions` VALUES ('125', '104', '蚌埠市', '3', '0', '0', '0', ',3268,104,125,');
INSERT INTO `cmf_regions` VALUES ('126', '125', '龙子湖区', '4', '0', '0', '0', ',3268,104,125,126,');
INSERT INTO `cmf_regions` VALUES ('127', '125', '蚌山区', '4', '0', '0', '0', ',3268,104,125,127,');
INSERT INTO `cmf_regions` VALUES ('128', '125', '禹会区', '4', '0', '0', '0', ',3268,104,125,128,');
INSERT INTO `cmf_regions` VALUES ('129', '125', '淮上区', '4', '0', '0', '0', ',3268,104,125,129,');
INSERT INTO `cmf_regions` VALUES ('130', '125', '怀远县', '4', '0', '0', '0', ',3268,104,125,130,');
INSERT INTO `cmf_regions` VALUES ('131', '125', '五河县', '4', '0', '0', '0', ',3268,104,125,131,');
INSERT INTO `cmf_regions` VALUES ('132', '125', '固镇县', '4', '0', '0', '0', ',3268,104,125,132,');
INSERT INTO `cmf_regions` VALUES ('133', '104', '亳州市', '3', '0', '0', '0', ',3268,104,133,');
INSERT INTO `cmf_regions` VALUES ('134', '133', '谯城区', '4', '0', '0', '0', ',3268,104,133,134,');
INSERT INTO `cmf_regions` VALUES ('135', '133', '涡阳县', '4', '0', '0', '0', ',3268,104,133,135,');
INSERT INTO `cmf_regions` VALUES ('136', '133', '蒙城县', '4', '0', '0', '0', ',3268,104,133,136,');
INSERT INTO `cmf_regions` VALUES ('137', '133', '利辛县', '4', '0', '0', '0', ',3268,104,133,137,');
INSERT INTO `cmf_regions` VALUES ('138', '104', '巢湖市', '3', '0', '0', '0', ',3268,104,138,');
INSERT INTO `cmf_regions` VALUES ('139', '138', '居巢区', '4', '0', '0', '0', ',3268,104,138,139,');
INSERT INTO `cmf_regions` VALUES ('140', '138', '庐江县', '4', '0', '0', '0', ',3268,104,138,140,');
INSERT INTO `cmf_regions` VALUES ('141', '138', '无为县', '4', '0', '0', '0', ',3268,104,138,141,');
INSERT INTO `cmf_regions` VALUES ('142', '138', '含山县', '4', '0', '0', '0', ',3268,104,138,142,');
INSERT INTO `cmf_regions` VALUES ('143', '138', '和县', '4', '0', '0', '0', ',3268,104,138,143,');
INSERT INTO `cmf_regions` VALUES ('144', '104', '池州市', '3', '0', '0', '0', ',3268,104,144,');
INSERT INTO `cmf_regions` VALUES ('145', '144', '贵池区', '4', '0', '0', '0', ',3268,104,144,145,');
INSERT INTO `cmf_regions` VALUES ('146', '144', '东至县', '4', '0', '0', '0', ',3268,104,144,146,');
INSERT INTO `cmf_regions` VALUES ('147', '144', '石台县', '4', '0', '0', '0', ',3268,104,144,147,');
INSERT INTO `cmf_regions` VALUES ('148', '144', '青阳县', '4', '0', '0', '0', ',3268,104,144,148,');
INSERT INTO `cmf_regions` VALUES ('149', '104', '滁州市', '3', '0', '0', '0', ',3268,104,149,');
INSERT INTO `cmf_regions` VALUES ('150', '149', '琅琊区', '4', '0', '0', '0', ',3268,104,149,150,');
INSERT INTO `cmf_regions` VALUES ('151', '149', '南谯区', '4', '0', '0', '0', ',3268,104,149,151,');
INSERT INTO `cmf_regions` VALUES ('152', '149', '来安县', '4', '0', '0', '0', ',3268,104,149,152,');
INSERT INTO `cmf_regions` VALUES ('153', '149', '全椒县', '4', '0', '0', '0', ',3268,104,149,153,');
INSERT INTO `cmf_regions` VALUES ('154', '149', '定远县', '4', '0', '0', '0', ',3268,104,149,154,');
INSERT INTO `cmf_regions` VALUES ('155', '149', '凤阳县', '4', '0', '0', '0', ',3268,104,149,155,');
INSERT INTO `cmf_regions` VALUES ('156', '149', '天长市', '4', '0', '0', '0', ',3268,104,149,156,');
INSERT INTO `cmf_regions` VALUES ('157', '149', '明光市', '4', '0', '0', '0', ',3268,104,149,157,');
INSERT INTO `cmf_regions` VALUES ('158', '104', '阜阳市', '3', '0', '0', '0', ',3268,104,158,');
INSERT INTO `cmf_regions` VALUES ('159', '158', '颍州区', '4', '0', '0', '0', ',3268,104,158,159,');
INSERT INTO `cmf_regions` VALUES ('160', '158', '颍东区', '4', '0', '0', '0', ',3268,104,158,160,');
INSERT INTO `cmf_regions` VALUES ('161', '158', '颍泉区', '4', '0', '0', '0', ',3268,104,158,161,');
INSERT INTO `cmf_regions` VALUES ('162', '158', '临泉县', '4', '0', '0', '0', ',3268,104,158,162,');
INSERT INTO `cmf_regions` VALUES ('163', '158', '太和县', '4', '0', '0', '0', ',3268,104,158,163,');
INSERT INTO `cmf_regions` VALUES ('164', '158', '阜南县', '4', '0', '0', '0', ',3268,104,158,164,');
INSERT INTO `cmf_regions` VALUES ('165', '158', '颍上县', '4', '0', '0', '0', ',3268,104,158,165,');
INSERT INTO `cmf_regions` VALUES ('166', '158', '界首市', '4', '0', '0', '0', ',3268,104,158,166,');
INSERT INTO `cmf_regions` VALUES ('167', '104', '淮北市', '3', '0', '0', '0', ',3268,104,167,');
INSERT INTO `cmf_regions` VALUES ('168', '167', '杜集区', '4', '0', '0', '0', ',3268,104,167,168,');
INSERT INTO `cmf_regions` VALUES ('169', '167', '相山区', '4', '0', '0', '0', ',3268,104,167,169,');
INSERT INTO `cmf_regions` VALUES ('170', '167', '烈山区', '4', '0', '0', '0', ',3268,104,167,170,');
INSERT INTO `cmf_regions` VALUES ('171', '167', '濉溪县', '4', '0', '0', '0', ',3268,104,167,171,');
INSERT INTO `cmf_regions` VALUES ('172', '104', '淮南市', '3', '0', '0', '0', ',3268,104,172,');
INSERT INTO `cmf_regions` VALUES ('173', '172', '大通区', '4', '0', '0', '0', ',3268,104,172,173,');
INSERT INTO `cmf_regions` VALUES ('174', '172', '田家庵区', '4', '0', '0', '0', ',3268,104,172,174,');
INSERT INTO `cmf_regions` VALUES ('175', '172', '谢家集区', '4', '0', '0', '0', ',3268,104,172,175,');
INSERT INTO `cmf_regions` VALUES ('176', '172', '八公山区', '4', '0', '0', '0', ',3268,104,172,176,');
INSERT INTO `cmf_regions` VALUES ('177', '172', '潘集区', '4', '0', '0', '0', ',3268,104,172,177,');
INSERT INTO `cmf_regions` VALUES ('178', '172', '凤台县', '4', '0', '0', '0', ',3268,104,172,178,');
INSERT INTO `cmf_regions` VALUES ('179', '104', '黄山市', '3', '0', '0', '0', ',3268,104,179,');
INSERT INTO `cmf_regions` VALUES ('180', '179', '屯溪区', '4', '0', '0', '0', ',3268,104,179,180,');
INSERT INTO `cmf_regions` VALUES ('181', '179', '黄山区', '4', '0', '0', '0', ',3268,104,179,181,');
INSERT INTO `cmf_regions` VALUES ('182', '179', '徽州区', '4', '0', '0', '0', ',3268,104,179,182,');
INSERT INTO `cmf_regions` VALUES ('183', '179', '歙县', '4', '0', '0', '0', ',3268,104,179,183,');
INSERT INTO `cmf_regions` VALUES ('184', '179', '休宁县', '4', '0', '0', '0', ',3268,104,179,184,');
INSERT INTO `cmf_regions` VALUES ('185', '179', '黟县', '4', '0', '0', '0', ',3268,104,179,185,');
INSERT INTO `cmf_regions` VALUES ('186', '179', '祁门县', '4', '0', '0', '0', ',3268,104,179,186,');
INSERT INTO `cmf_regions` VALUES ('187', '104', '六安市', '3', '0', '0', '0', ',3268,104,187,');
INSERT INTO `cmf_regions` VALUES ('188', '187', '金安区', '4', '0', '0', '0', ',3268,104,187,188,');
INSERT INTO `cmf_regions` VALUES ('189', '187', '裕安区', '4', '0', '0', '0', ',3268,104,187,189,');
INSERT INTO `cmf_regions` VALUES ('190', '187', '寿县', '4', '0', '0', '0', ',3268,104,187,190,');
INSERT INTO `cmf_regions` VALUES ('191', '187', '霍邱县', '4', '0', '0', '0', ',3268,104,187,191,');
INSERT INTO `cmf_regions` VALUES ('192', '187', '舒城县', '4', '0', '0', '0', ',3268,104,187,192,');
INSERT INTO `cmf_regions` VALUES ('193', '187', '金寨县', '4', '0', '0', '0', ',3268,104,187,193,');
INSERT INTO `cmf_regions` VALUES ('194', '187', '霍山县', '4', '0', '0', '0', ',3268,104,187,194,');
INSERT INTO `cmf_regions` VALUES ('195', '104', '马鞍山市', '3', '0', '0', '0', ',3268,104,195,');
INSERT INTO `cmf_regions` VALUES ('196', '195', '金家庄区', '4', '0', '0', '0', ',3268,104,195,196,');
INSERT INTO `cmf_regions` VALUES ('197', '195', '花山区', '4', '0', '0', '0', ',3268,104,195,197,');
INSERT INTO `cmf_regions` VALUES ('198', '195', '雨山区', '4', '0', '0', '0', ',3268,104,195,198,');
INSERT INTO `cmf_regions` VALUES ('199', '195', '当涂县', '4', '0', '0', '0', ',3268,104,195,199,');
INSERT INTO `cmf_regions` VALUES ('200', '104', '宿州市', '3', '0', '0', '0', ',3268,104,200,');
INSERT INTO `cmf_regions` VALUES ('201', '200', '墉桥区', '4', '0', '0', '0', ',3268,104,200,201,');
INSERT INTO `cmf_regions` VALUES ('202', '200', '砀山县', '4', '0', '0', '0', ',3268,104,200,202,');
INSERT INTO `cmf_regions` VALUES ('203', '200', '萧县', '4', '0', '0', '0', ',3268,104,200,203,');
INSERT INTO `cmf_regions` VALUES ('204', '200', '灵璧县', '4', '0', '0', '0', ',3268,104,200,204,');
INSERT INTO `cmf_regions` VALUES ('205', '200', '泗县', '4', '0', '0', '0', ',3268,104,200,205,');
INSERT INTO `cmf_regions` VALUES ('206', '104', '铜陵市', '3', '0', '0', '0', ',3268,104,206,');
INSERT INTO `cmf_regions` VALUES ('207', '206', '铜官山区', '4', '0', '0', '0', ',3268,104,206,207,');
INSERT INTO `cmf_regions` VALUES ('208', '206', '狮子山区', '4', '0', '0', '0', ',3268,104,206,208,');
INSERT INTO `cmf_regions` VALUES ('209', '206', '郊区', '4', '0', '0', '0', ',3268,104,206,209,');
INSERT INTO `cmf_regions` VALUES ('210', '206', '铜陵县', '4', '0', '0', '0', ',3268,104,206,210,');
INSERT INTO `cmf_regions` VALUES ('211', '104', '芜湖市', '3', '0', '0', '0', ',3268,104,211,');
INSERT INTO `cmf_regions` VALUES ('212', '211', '镜湖区', '4', '0', '0', '0', ',3268,104,211,212,');
INSERT INTO `cmf_regions` VALUES ('213', '211', '马塘区', '4', '0', '0', '0', ',3268,104,211,213,');
INSERT INTO `cmf_regions` VALUES ('214', '211', '新芜区', '4', '0', '0', '0', ',3268,104,211,214,');
INSERT INTO `cmf_regions` VALUES ('215', '211', '鸠江区', '4', '0', '0', '0', ',3268,104,211,215,');
INSERT INTO `cmf_regions` VALUES ('216', '211', '芜湖县', '4', '0', '0', '0', ',3268,104,211,216,');
INSERT INTO `cmf_regions` VALUES ('217', '211', '繁昌县', '4', '0', '0', '0', ',3268,104,211,217,');
INSERT INTO `cmf_regions` VALUES ('218', '211', '南陵县', '4', '0', '0', '0', ',3268,104,211,218,');
INSERT INTO `cmf_regions` VALUES ('219', '104', '宣城市', '3', '0', '0', '0', ',3268,104,219,');
INSERT INTO `cmf_regions` VALUES ('220', '219', '宣州区', '4', '0', '0', '0', ',3268,104,219,220,');
INSERT INTO `cmf_regions` VALUES ('221', '219', '郎溪县', '4', '0', '0', '0', ',3268,104,219,221,');
INSERT INTO `cmf_regions` VALUES ('222', '219', '广德县', '4', '0', '0', '0', ',3268,104,219,222,');
INSERT INTO `cmf_regions` VALUES ('223', '219', '泾县', '4', '0', '0', '0', ',3268,104,219,223,');
INSERT INTO `cmf_regions` VALUES ('224', '219', '绩溪县', '4', '0', '0', '0', ',3268,104,219,224,');
INSERT INTO `cmf_regions` VALUES ('225', '219', '旌德县', '4', '0', '0', '0', ',3268,104,219,225,');
INSERT INTO `cmf_regions` VALUES ('226', '219', '宁国市', '4', '0', '0', '0', ',3268,104,219,226,');
INSERT INTO `cmf_regions` VALUES ('227', '3268', '福建', '2', '0', '0', '0', ',3268,227,');
INSERT INTO `cmf_regions` VALUES ('228', '227', '福州市', '3', '0', '0', '0', ',3268,227,228,');
INSERT INTO `cmf_regions` VALUES ('229', '228', '鼓楼区', '4', '0', '0', '0', ',3268,227,228,229,');
INSERT INTO `cmf_regions` VALUES ('230', '228', '台江区', '4', '0', '0', '0', ',3268,227,228,230,');
INSERT INTO `cmf_regions` VALUES ('231', '228', '仓山区', '4', '0', '0', '0', ',3268,227,228,231,');
INSERT INTO `cmf_regions` VALUES ('232', '228', '马尾区', '4', '0', '0', '0', ',3268,227,228,232,');
INSERT INTO `cmf_regions` VALUES ('233', '228', '晋安区', '4', '0', '0', '0', ',3268,227,228,233,');
INSERT INTO `cmf_regions` VALUES ('234', '228', '闽侯县', '4', '0', '0', '0', ',3268,227,228,234,');
INSERT INTO `cmf_regions` VALUES ('235', '228', '连江县', '4', '0', '0', '0', ',3268,227,228,235,');
INSERT INTO `cmf_regions` VALUES ('236', '228', '罗源县', '4', '0', '0', '0', ',3268,227,228,236,');
INSERT INTO `cmf_regions` VALUES ('237', '228', '闽清县', '4', '0', '0', '0', ',3268,227,228,237,');
INSERT INTO `cmf_regions` VALUES ('238', '228', '永泰县', '4', '0', '0', '0', ',3268,227,228,238,');
INSERT INTO `cmf_regions` VALUES ('239', '228', '平潭县', '4', '0', '0', '0', ',3268,227,228,239,');
INSERT INTO `cmf_regions` VALUES ('240', '228', '福清市', '4', '0', '0', '0', ',3268,227,228,240,');
INSERT INTO `cmf_regions` VALUES ('241', '228', '长乐市', '4', '0', '0', '0', ',3268,227,228,241,');
INSERT INTO `cmf_regions` VALUES ('242', '227', '龙岩市', '3', '0', '0', '0', ',3268,227,242,');
INSERT INTO `cmf_regions` VALUES ('243', '242', '新罗区', '4', '0', '0', '0', ',3268,227,242,243,');
INSERT INTO `cmf_regions` VALUES ('244', '242', '长汀县', '4', '0', '0', '0', ',3268,227,242,244,');
INSERT INTO `cmf_regions` VALUES ('245', '242', '永定县', '4', '0', '0', '0', ',3268,227,242,245,');
INSERT INTO `cmf_regions` VALUES ('246', '242', '上杭县', '4', '0', '0', '0', ',3268,227,242,246,');
INSERT INTO `cmf_regions` VALUES ('247', '242', '武平县', '4', '0', '0', '0', ',3268,227,242,247,');
INSERT INTO `cmf_regions` VALUES ('248', '242', '连城县', '4', '0', '0', '0', ',3268,227,242,248,');
INSERT INTO `cmf_regions` VALUES ('249', '242', '漳平市', '4', '0', '0', '0', ',3268,227,242,249,');
INSERT INTO `cmf_regions` VALUES ('250', '227', '南平市', '3', '0', '0', '0', ',3268,227,250,');
INSERT INTO `cmf_regions` VALUES ('251', '250', '延平区', '4', '0', '0', '0', ',3268,227,250,251,');
INSERT INTO `cmf_regions` VALUES ('252', '250', '顺昌县', '4', '0', '0', '0', ',3268,227,250,252,');
INSERT INTO `cmf_regions` VALUES ('253', '250', '浦城县', '4', '0', '0', '0', ',3268,227,250,253,');
INSERT INTO `cmf_regions` VALUES ('254', '250', '光泽县', '4', '0', '0', '0', ',3268,227,250,254,');
INSERT INTO `cmf_regions` VALUES ('255', '250', '松溪县', '4', '0', '0', '0', ',3268,227,250,255,');
INSERT INTO `cmf_regions` VALUES ('256', '250', '政和县', '4', '0', '0', '0', ',3268,227,250,256,');
INSERT INTO `cmf_regions` VALUES ('257', '250', '邵武市', '4', '0', '0', '0', ',3268,227,250,257,');
INSERT INTO `cmf_regions` VALUES ('258', '250', '武夷山市', '4', '0', '0', '0', ',3268,227,250,258,');
INSERT INTO `cmf_regions` VALUES ('259', '250', '建瓯市', '4', '0', '0', '0', ',3268,227,250,259,');
INSERT INTO `cmf_regions` VALUES ('260', '250', '建阳市', '4', '0', '0', '0', ',3268,227,250,260,');
INSERT INTO `cmf_regions` VALUES ('261', '227', '宁德市', '3', '0', '0', '0', ',3268,227,261,');
INSERT INTO `cmf_regions` VALUES ('262', '261', '蕉城区', '4', '0', '0', '0', ',3268,227,261,262,');
INSERT INTO `cmf_regions` VALUES ('263', '261', '霞浦县', '4', '0', '0', '0', ',3268,227,261,263,');
INSERT INTO `cmf_regions` VALUES ('264', '261', '古田县', '4', '0', '0', '0', ',3268,227,261,264,');
INSERT INTO `cmf_regions` VALUES ('265', '261', '屏南县', '4', '0', '0', '0', ',3268,227,261,265,');
INSERT INTO `cmf_regions` VALUES ('266', '261', '寿宁县', '4', '0', '0', '0', ',3268,227,261,266,');
INSERT INTO `cmf_regions` VALUES ('267', '261', '周宁县', '4', '0', '0', '0', ',3268,227,261,267,');
INSERT INTO `cmf_regions` VALUES ('268', '261', '柘荣县', '4', '0', '0', '0', ',3268,227,261,268,');
INSERT INTO `cmf_regions` VALUES ('269', '261', '福安市', '4', '0', '0', '0', ',3268,227,261,269,');
INSERT INTO `cmf_regions` VALUES ('270', '261', '福鼎市', '4', '0', '0', '0', ',3268,227,261,270,');
INSERT INTO `cmf_regions` VALUES ('271', '227', '莆田市', '3', '0', '0', '0', ',3268,227,271,');
INSERT INTO `cmf_regions` VALUES ('272', '271', '城厢区', '4', '0', '0', '0', ',3268,227,271,272,');
INSERT INTO `cmf_regions` VALUES ('273', '271', '涵江区', '4', '0', '0', '0', ',3268,227,271,273,');
INSERT INTO `cmf_regions` VALUES ('274', '271', '荔城区', '4', '0', '0', '0', ',3268,227,271,274,');
INSERT INTO `cmf_regions` VALUES ('275', '271', '秀屿区', '4', '0', '0', '0', ',3268,227,271,275,');
INSERT INTO `cmf_regions` VALUES ('276', '271', '仙游县', '4', '0', '0', '0', ',3268,227,271,276,');
INSERT INTO `cmf_regions` VALUES ('277', '227', '泉州市', '3', '0', '0', '0', ',3268,227,277,');
INSERT INTO `cmf_regions` VALUES ('278', '277', '鲤城区', '4', '0', '0', '0', ',3268,227,277,278,');
INSERT INTO `cmf_regions` VALUES ('279', '277', '丰泽区', '4', '0', '0', '0', ',3268,227,277,279,');
INSERT INTO `cmf_regions` VALUES ('280', '277', '洛江区', '4', '0', '0', '0', ',3268,227,277,280,');
INSERT INTO `cmf_regions` VALUES ('281', '277', '泉港区', '4', '0', '0', '0', ',3268,227,277,281,');
INSERT INTO `cmf_regions` VALUES ('282', '277', '惠安县', '4', '0', '0', '0', ',3268,227,277,282,');
INSERT INTO `cmf_regions` VALUES ('283', '277', '安溪县', '4', '0', '0', '0', ',3268,227,277,283,');
INSERT INTO `cmf_regions` VALUES ('284', '277', '永春县', '4', '0', '0', '0', ',3268,227,277,284,');
INSERT INTO `cmf_regions` VALUES ('285', '277', '德化县', '4', '0', '0', '0', ',3268,227,277,285,');
INSERT INTO `cmf_regions` VALUES ('286', '277', '金门县', '4', '0', '0', '0', ',3268,227,277,286,');
INSERT INTO `cmf_regions` VALUES ('287', '277', '石狮市', '4', '0', '0', '0', ',3268,227,277,287,');
INSERT INTO `cmf_regions` VALUES ('288', '277', '晋江市', '4', '0', '0', '0', ',3268,227,277,288,');
INSERT INTO `cmf_regions` VALUES ('289', '277', '南安市', '4', '0', '0', '0', ',3268,227,277,289,');
INSERT INTO `cmf_regions` VALUES ('290', '227', '三明市', '3', '0', '0', '0', ',3268,227,290,');
INSERT INTO `cmf_regions` VALUES ('291', '290', '梅列区', '4', '0', '0', '0', ',3268,227,290,291,');
INSERT INTO `cmf_regions` VALUES ('292', '290', '三元区', '4', '0', '0', '0', ',3268,227,290,292,');
INSERT INTO `cmf_regions` VALUES ('293', '290', '明溪县', '4', '0', '0', '0', ',3268,227,290,293,');
INSERT INTO `cmf_regions` VALUES ('294', '290', '清流县', '4', '0', '0', '0', ',3268,227,290,294,');
INSERT INTO `cmf_regions` VALUES ('295', '290', '宁化县', '4', '0', '0', '0', ',3268,227,290,295,');
INSERT INTO `cmf_regions` VALUES ('296', '290', '大田县', '4', '0', '0', '0', ',3268,227,290,296,');
INSERT INTO `cmf_regions` VALUES ('297', '290', '尤溪县', '4', '0', '0', '0', ',3268,227,290,297,');
INSERT INTO `cmf_regions` VALUES ('298', '290', '沙县', '4', '0', '0', '0', ',3268,227,290,298,');
INSERT INTO `cmf_regions` VALUES ('299', '290', '将乐县', '4', '0', '0', '0', ',3268,227,290,299,');
INSERT INTO `cmf_regions` VALUES ('300', '290', '泰宁县', '4', '0', '0', '0', ',3268,227,290,300,');
INSERT INTO `cmf_regions` VALUES ('301', '290', '建宁县', '4', '0', '0', '0', ',3268,227,290,301,');
INSERT INTO `cmf_regions` VALUES ('302', '290', '永安市', '4', '0', '0', '0', ',3268,227,290,302,');
INSERT INTO `cmf_regions` VALUES ('303', '227', '厦门市', '3', '0', '0', '0', ',3268,227,303,');
INSERT INTO `cmf_regions` VALUES ('304', '303', '思明区', '4', '0', '0', '0', ',3268,227,303,304,');
INSERT INTO `cmf_regions` VALUES ('305', '303', '海沧区', '4', '0', '0', '0', ',3268,227,303,305,');
INSERT INTO `cmf_regions` VALUES ('306', '303', '湖里区', '4', '0', '0', '0', ',3268,227,303,306,');
INSERT INTO `cmf_regions` VALUES ('307', '303', '集美区', '4', '0', '0', '0', ',3268,227,303,307,');
INSERT INTO `cmf_regions` VALUES ('308', '303', '同安区', '4', '0', '0', '0', ',3268,227,303,308,');
INSERT INTO `cmf_regions` VALUES ('309', '303', '翔安区', '4', '0', '0', '0', ',3268,227,303,309,');
INSERT INTO `cmf_regions` VALUES ('310', '227', '漳州市', '3', '0', '0', '0', ',3268,227,310,');
INSERT INTO `cmf_regions` VALUES ('311', '310', '芗城区', '4', '0', '0', '0', ',3268,227,310,311,');
INSERT INTO `cmf_regions` VALUES ('312', '310', '龙文区', '4', '0', '0', '0', ',3268,227,310,312,');
INSERT INTO `cmf_regions` VALUES ('313', '310', '云霄县', '4', '0', '0', '0', ',3268,227,310,313,');
INSERT INTO `cmf_regions` VALUES ('314', '310', '漳浦县', '4', '0', '0', '0', ',3268,227,310,314,');
INSERT INTO `cmf_regions` VALUES ('315', '310', '诏安县', '4', '0', '0', '0', ',3268,227,310,315,');
INSERT INTO `cmf_regions` VALUES ('316', '310', '长泰县', '4', '0', '0', '0', ',3268,227,310,316,');
INSERT INTO `cmf_regions` VALUES ('317', '310', '东山县', '4', '0', '0', '0', ',3268,227,310,317,');
INSERT INTO `cmf_regions` VALUES ('318', '310', '南靖县', '4', '0', '0', '0', ',3268,227,310,318,');
INSERT INTO `cmf_regions` VALUES ('319', '310', '平和县', '4', '0', '0', '0', ',3268,227,310,319,');
INSERT INTO `cmf_regions` VALUES ('320', '310', '华安县', '4', '0', '0', '0', ',3268,227,310,320,');
INSERT INTO `cmf_regions` VALUES ('321', '310', '龙海市', '4', '0', '0', '0', ',3268,227,310,321,');
INSERT INTO `cmf_regions` VALUES ('322', '3268', '甘肃', '2', '0', '0', '0', ',3268,322,');
INSERT INTO `cmf_regions` VALUES ('323', '322', '兰州市', '3', '0', '0', '0', ',3268,322,323,');
INSERT INTO `cmf_regions` VALUES ('324', '323', '城关区', '4', '0', '0', '0', ',3268,322,323,324,');
INSERT INTO `cmf_regions` VALUES ('325', '323', '七里河区', '4', '0', '0', '0', ',3268,322,323,325,');
INSERT INTO `cmf_regions` VALUES ('326', '323', '西固区', '4', '0', '0', '0', ',3268,322,323,326,');
INSERT INTO `cmf_regions` VALUES ('327', '323', '安宁区', '4', '0', '0', '0', ',3268,322,323,327,');
INSERT INTO `cmf_regions` VALUES ('328', '323', '红古区', '4', '0', '0', '0', ',3268,322,323,328,');
INSERT INTO `cmf_regions` VALUES ('329', '323', '永登县', '4', '0', '0', '0', ',3268,322,323,329,');
INSERT INTO `cmf_regions` VALUES ('330', '323', '皋兰县', '4', '0', '0', '0', ',3268,322,323,330,');
INSERT INTO `cmf_regions` VALUES ('331', '323', '榆中县', '4', '0', '0', '0', ',3268,322,323,331,');
INSERT INTO `cmf_regions` VALUES ('332', '322', '白银市', '3', '0', '0', '0', ',3268,322,332,');
INSERT INTO `cmf_regions` VALUES ('333', '332', '白银区', '4', '0', '0', '0', ',3268,322,332,333,');
INSERT INTO `cmf_regions` VALUES ('334', '332', '平川区', '4', '0', '0', '0', ',3268,322,332,334,');
INSERT INTO `cmf_regions` VALUES ('335', '332', '靖远县', '4', '0', '0', '0', ',3268,322,332,335,');
INSERT INTO `cmf_regions` VALUES ('336', '332', '会宁县', '4', '0', '0', '0', ',3268,322,332,336,');
INSERT INTO `cmf_regions` VALUES ('337', '332', '景泰县', '4', '0', '0', '0', ',3268,322,332,337,');
INSERT INTO `cmf_regions` VALUES ('338', '322', '定西市', '3', '0', '0', '0', ',3268,322,338,');
INSERT INTO `cmf_regions` VALUES ('339', '338', '安定区', '4', '0', '0', '0', ',3268,322,338,339,');
INSERT INTO `cmf_regions` VALUES ('340', '338', '通渭县', '4', '0', '0', '0', ',3268,322,338,340,');
INSERT INTO `cmf_regions` VALUES ('341', '338', '陇西县', '4', '0', '0', '0', ',3268,322,338,341,');
INSERT INTO `cmf_regions` VALUES ('342', '338', '渭源县', '4', '0', '0', '0', ',3268,322,338,342,');
INSERT INTO `cmf_regions` VALUES ('343', '338', '临洮县', '4', '0', '0', '0', ',3268,322,338,343,');
INSERT INTO `cmf_regions` VALUES ('344', '338', '漳县', '4', '0', '0', '0', ',3268,322,338,344,');
INSERT INTO `cmf_regions` VALUES ('345', '338', '岷县', '4', '0', '0', '0', ',3268,322,338,345,');
INSERT INTO `cmf_regions` VALUES ('346', '322', '甘南藏族自治州', '3', '0', '0', '0', ',3268,322,346,');
INSERT INTO `cmf_regions` VALUES ('347', '346', '合作市', '4', '0', '0', '0', ',3268,322,346,347,');
INSERT INTO `cmf_regions` VALUES ('348', '346', '临潭县', '4', '0', '0', '0', ',3268,322,346,348,');
INSERT INTO `cmf_regions` VALUES ('349', '346', '卓尼县', '4', '0', '0', '0', ',3268,322,346,349,');
INSERT INTO `cmf_regions` VALUES ('350', '346', '舟曲县', '4', '0', '0', '0', ',3268,322,346,350,');
INSERT INTO `cmf_regions` VALUES ('351', '346', '迭部县', '4', '0', '0', '0', ',3268,322,346,351,');
INSERT INTO `cmf_regions` VALUES ('352', '346', '玛曲县', '4', '0', '0', '0', ',3268,322,346,352,');
INSERT INTO `cmf_regions` VALUES ('353', '346', '碌曲县', '4', '0', '0', '0', ',3268,322,346,353,');
INSERT INTO `cmf_regions` VALUES ('354', '346', '夏河县', '4', '0', '0', '0', ',3268,322,346,354,');
INSERT INTO `cmf_regions` VALUES ('355', '322', '嘉峪关市', '3', '0', '0', '0', ',3268,322,355,');
INSERT INTO `cmf_regions` VALUES ('356', '322', '金昌市', '3', '0', '0', '0', ',3268,322,356,');
INSERT INTO `cmf_regions` VALUES ('357', '356', '金川区', '4', '0', '0', '0', ',3268,322,356,357,');
INSERT INTO `cmf_regions` VALUES ('358', '356', '永昌县', '4', '0', '0', '0', ',3268,322,356,358,');
INSERT INTO `cmf_regions` VALUES ('359', '322', '酒泉市', '3', '0', '0', '0', ',3268,322,359,');
INSERT INTO `cmf_regions` VALUES ('360', '359', '肃州区', '4', '0', '0', '0', ',3268,322,359,360,');
INSERT INTO `cmf_regions` VALUES ('361', '359', '金塔县', '4', '0', '0', '0', ',3268,322,359,361,');
INSERT INTO `cmf_regions` VALUES ('362', '359', '安西县', '4', '0', '0', '0', ',3268,322,359,362,');
INSERT INTO `cmf_regions` VALUES ('363', '359', '肃北蒙古族自治县', '4', '0', '0', '0', ',3268,322,359,363,');
INSERT INTO `cmf_regions` VALUES ('364', '359', '阿克塞哈萨克族自治县', '4', '0', '0', '0', ',3268,322,359,364,');
INSERT INTO `cmf_regions` VALUES ('365', '359', '玉门市', '4', '0', '0', '0', ',3268,322,359,365,');
INSERT INTO `cmf_regions` VALUES ('366', '359', '敦煌市', '4', '0', '0', '0', ',3268,322,359,366,');
INSERT INTO `cmf_regions` VALUES ('367', '322', '临夏回族自治州', '3', '0', '0', '0', ',3268,322,367,');
INSERT INTO `cmf_regions` VALUES ('368', '367', '临夏市', '4', '0', '0', '0', ',3268,322,367,368,');
INSERT INTO `cmf_regions` VALUES ('369', '367', '临夏县', '4', '0', '0', '0', ',3268,322,367,369,');
INSERT INTO `cmf_regions` VALUES ('370', '367', '康乐县', '4', '0', '0', '0', ',3268,322,367,370,');
INSERT INTO `cmf_regions` VALUES ('371', '367', '永靖县', '4', '0', '0', '0', ',3268,322,367,371,');
INSERT INTO `cmf_regions` VALUES ('372', '367', '广河县', '4', '0', '0', '0', ',3268,322,367,372,');
INSERT INTO `cmf_regions` VALUES ('373', '367', '和政县', '4', '0', '0', '0', ',3268,322,367,373,');
INSERT INTO `cmf_regions` VALUES ('374', '367', '东乡族自治县', '4', '0', '0', '0', ',3268,322,367,374,');
INSERT INTO `cmf_regions` VALUES ('375', '367', '积石山保安族东乡族撒拉族自治县', '4', '0', '0', '0', ',3268,322,367,375,');
INSERT INTO `cmf_regions` VALUES ('376', '322', '陇南市', '3', '0', '0', '0', ',3268,322,376,');
INSERT INTO `cmf_regions` VALUES ('377', '376', '武都区', '4', '0', '0', '0', ',3268,322,376,377,');
INSERT INTO `cmf_regions` VALUES ('378', '376', '成县', '4', '0', '0', '0', ',3268,322,376,378,');
INSERT INTO `cmf_regions` VALUES ('379', '376', '文县', '4', '0', '0', '0', ',3268,322,376,379,');
INSERT INTO `cmf_regions` VALUES ('380', '376', '宕昌县', '4', '0', '0', '0', ',3268,322,376,380,');
INSERT INTO `cmf_regions` VALUES ('381', '376', '康县', '4', '0', '0', '0', ',3268,322,376,381,');
INSERT INTO `cmf_regions` VALUES ('382', '376', '西和县', '4', '0', '0', '0', ',3268,322,376,382,');
INSERT INTO `cmf_regions` VALUES ('383', '376', '礼县', '4', '0', '0', '0', ',3268,322,376,383,');
INSERT INTO `cmf_regions` VALUES ('384', '376', '徽县', '4', '0', '0', '0', ',3268,322,376,384,');
INSERT INTO `cmf_regions` VALUES ('385', '376', '两当县', '4', '0', '0', '0', ',3268,322,376,385,');
INSERT INTO `cmf_regions` VALUES ('386', '322', '平凉市', '3', '0', '0', '0', ',3268,322,386,');
INSERT INTO `cmf_regions` VALUES ('387', '386', '崆峒区', '4', '0', '0', '0', ',3268,322,386,387,');
INSERT INTO `cmf_regions` VALUES ('388', '386', '泾川县', '4', '0', '0', '0', ',3268,322,386,388,');
INSERT INTO `cmf_regions` VALUES ('389', '386', '灵台县', '4', '0', '0', '0', ',3268,322,386,389,');
INSERT INTO `cmf_regions` VALUES ('390', '386', '崇信县', '4', '0', '0', '0', ',3268,322,386,390,');
INSERT INTO `cmf_regions` VALUES ('391', '386', '华亭县', '4', '0', '0', '0', ',3268,322,386,391,');
INSERT INTO `cmf_regions` VALUES ('392', '386', '庄浪县', '4', '0', '0', '0', ',3268,322,386,392,');
INSERT INTO `cmf_regions` VALUES ('393', '386', '静宁县', '4', '0', '0', '0', ',3268,322,386,393,');
INSERT INTO `cmf_regions` VALUES ('394', '322', '庆阳市', '3', '0', '0', '0', ',3268,322,394,');
INSERT INTO `cmf_regions` VALUES ('395', '394', '西峰区', '4', '0', '0', '0', ',3268,322,394,395,');
INSERT INTO `cmf_regions` VALUES ('396', '394', '庆城县', '4', '0', '0', '0', ',3268,322,394,396,');
INSERT INTO `cmf_regions` VALUES ('397', '394', '环县', '4', '0', '0', '0', ',3268,322,394,397,');
INSERT INTO `cmf_regions` VALUES ('398', '394', '华池县', '4', '0', '0', '0', ',3268,322,394,398,');
INSERT INTO `cmf_regions` VALUES ('399', '394', '合水县', '4', '0', '0', '0', ',3268,322,394,399,');
INSERT INTO `cmf_regions` VALUES ('400', '394', '正宁县', '4', '0', '0', '0', ',3268,322,394,400,');
INSERT INTO `cmf_regions` VALUES ('401', '394', '宁县', '4', '0', '0', '0', ',3268,322,394,401,');
INSERT INTO `cmf_regions` VALUES ('402', '394', '镇原县', '4', '0', '0', '0', ',3268,322,394,402,');
INSERT INTO `cmf_regions` VALUES ('403', '322', '天水市', '3', '0', '0', '0', ',3268,322,403,');
INSERT INTO `cmf_regions` VALUES ('404', '403', '秦城区', '4', '0', '0', '0', ',3268,322,403,404,');
INSERT INTO `cmf_regions` VALUES ('405', '403', '北道区', '4', '0', '0', '0', ',3268,322,403,405,');
INSERT INTO `cmf_regions` VALUES ('406', '403', '清水县', '4', '0', '0', '0', ',3268,322,403,406,');
INSERT INTO `cmf_regions` VALUES ('407', '403', '秦安县', '4', '0', '0', '0', ',3268,322,403,407,');
INSERT INTO `cmf_regions` VALUES ('408', '403', '甘谷县', '4', '0', '0', '0', ',3268,322,403,408,');
INSERT INTO `cmf_regions` VALUES ('409', '403', '武山县', '4', '0', '0', '0', ',3268,322,403,409,');
INSERT INTO `cmf_regions` VALUES ('410', '403', '张家川回族自治县', '4', '0', '0', '0', ',3268,322,403,410,');
INSERT INTO `cmf_regions` VALUES ('411', '322', '武威市', '3', '0', '0', '0', ',3268,322,411,');
INSERT INTO `cmf_regions` VALUES ('412', '411', '凉州区', '4', '0', '0', '0', ',3268,322,411,412,');
INSERT INTO `cmf_regions` VALUES ('413', '411', '民勤县', '4', '0', '0', '0', ',3268,322,411,413,');
INSERT INTO `cmf_regions` VALUES ('414', '411', '古浪县', '4', '0', '0', '0', ',3268,322,411,414,');
INSERT INTO `cmf_regions` VALUES ('415', '411', '天祝藏族自治县', '4', '0', '0', '0', ',3268,322,411,415,');
INSERT INTO `cmf_regions` VALUES ('416', '322', '张掖市', '3', '0', '0', '0', ',3268,322,416,');
INSERT INTO `cmf_regions` VALUES ('417', '416', '甘州区', '4', '0', '0', '0', ',3268,322,416,417,');
INSERT INTO `cmf_regions` VALUES ('418', '416', '肃南裕固族自治县', '4', '0', '0', '0', ',3268,322,416,418,');
INSERT INTO `cmf_regions` VALUES ('419', '416', '民乐县', '4', '0', '0', '0', ',3268,322,416,419,');
INSERT INTO `cmf_regions` VALUES ('420', '416', '临泽县', '4', '0', '0', '0', ',3268,322,416,420,');
INSERT INTO `cmf_regions` VALUES ('421', '416', '高台县', '4', '0', '0', '0', ',3268,322,416,421,');
INSERT INTO `cmf_regions` VALUES ('422', '416', '山丹县', '4', '0', '0', '0', ',3268,322,416,422,');
INSERT INTO `cmf_regions` VALUES ('423', '3268', '广东', '2', '0', '0', '0', ',3268,423,');
INSERT INTO `cmf_regions` VALUES ('424', '423', '广州市', '3', '0', '0', '0', ',3268,423,424,');
INSERT INTO `cmf_regions` VALUES ('425', '424', '东山区', '4', '0', '0', '0', ',3268,423,424,425,');
INSERT INTO `cmf_regions` VALUES ('426', '424', '荔湾区', '4', '0', '0', '0', ',3268,423,424,426,');
INSERT INTO `cmf_regions` VALUES ('427', '424', '越秀区', '4', '0', '0', '0', ',3268,423,424,427,');
INSERT INTO `cmf_regions` VALUES ('428', '424', '海珠区', '4', '0', '0', '0', ',3268,423,424,428,');
INSERT INTO `cmf_regions` VALUES ('429', '424', '天河区', '4', '0', '0', '0', ',3268,423,424,429,');
INSERT INTO `cmf_regions` VALUES ('430', '424', '芳村区', '4', '0', '0', '0', ',3268,423,424,430,');
INSERT INTO `cmf_regions` VALUES ('431', '424', '白云区', '4', '0', '0', '0', ',3268,423,424,431,');
INSERT INTO `cmf_regions` VALUES ('432', '424', '黄埔区', '4', '0', '0', '0', ',3268,423,424,432,');
INSERT INTO `cmf_regions` VALUES ('433', '424', '番禺区', '4', '0', '0', '0', ',3268,423,424,433,');
INSERT INTO `cmf_regions` VALUES ('434', '424', '花都区', '4', '0', '0', '0', ',3268,423,424,434,');
INSERT INTO `cmf_regions` VALUES ('435', '424', '增城市', '4', '0', '0', '0', ',3268,423,424,435,');
INSERT INTO `cmf_regions` VALUES ('436', '424', '从化市', '4', '0', '0', '0', ',3268,423,424,436,');
INSERT INTO `cmf_regions` VALUES ('437', '423', '潮州市', '3', '0', '0', '0', ',3268,423,437,');
INSERT INTO `cmf_regions` VALUES ('438', '437', '湘桥区', '4', '0', '0', '0', ',3268,423,437,438,');
INSERT INTO `cmf_regions` VALUES ('439', '437', '潮安县', '4', '0', '0', '0', ',3268,423,437,439,');
INSERT INTO `cmf_regions` VALUES ('440', '437', '饶平县', '4', '0', '0', '0', ',3268,423,437,440,');
INSERT INTO `cmf_regions` VALUES ('441', '423', '东莞市', '3', '0', '0', '0', ',3268,423,441,');
INSERT INTO `cmf_regions` VALUES ('442', '423', '佛山市', '3', '0', '0', '0', ',3268,423,442,');
INSERT INTO `cmf_regions` VALUES ('443', '442', '禅城区', '4', '0', '0', '0', ',3268,423,442,443,');
INSERT INTO `cmf_regions` VALUES ('444', '442', '南海区', '4', '0', '0', '0', ',3268,423,442,444,');
INSERT INTO `cmf_regions` VALUES ('445', '442', '顺德区', '4', '0', '0', '0', ',3268,423,442,445,');
INSERT INTO `cmf_regions` VALUES ('446', '442', '三水区', '4', '0', '0', '0', ',3268,423,442,446,');
INSERT INTO `cmf_regions` VALUES ('447', '442', '高明区', '4', '0', '0', '0', ',3268,423,442,447,');
INSERT INTO `cmf_regions` VALUES ('448', '423', '河源市', '3', '0', '0', '0', ',3268,423,448,');
INSERT INTO `cmf_regions` VALUES ('449', '448', '源城区', '4', '0', '0', '0', ',3268,423,448,449,');
INSERT INTO `cmf_regions` VALUES ('450', '448', '紫金县', '4', '0', '0', '0', ',3268,423,448,450,');
INSERT INTO `cmf_regions` VALUES ('451', '448', '龙川县', '4', '0', '0', '0', ',3268,423,448,451,');
INSERT INTO `cmf_regions` VALUES ('452', '448', '连平县', '4', '0', '0', '0', ',3268,423,448,452,');
INSERT INTO `cmf_regions` VALUES ('453', '448', '和平县', '4', '0', '0', '0', ',3268,423,448,453,');
INSERT INTO `cmf_regions` VALUES ('454', '448', '东源县', '4', '0', '0', '0', ',3268,423,448,454,');
INSERT INTO `cmf_regions` VALUES ('455', '423', '惠州市', '3', '0', '0', '0', ',3268,423,455,');
INSERT INTO `cmf_regions` VALUES ('456', '455', '惠城区', '4', '0', '0', '0', ',3268,423,455,456,');
INSERT INTO `cmf_regions` VALUES ('457', '455', '惠阳区', '4', '0', '0', '0', ',3268,423,455,457,');
INSERT INTO `cmf_regions` VALUES ('458', '455', '博罗县', '4', '0', '0', '0', ',3268,423,455,458,');
INSERT INTO `cmf_regions` VALUES ('459', '455', '惠东县', '4', '0', '0', '0', ',3268,423,455,459,');
INSERT INTO `cmf_regions` VALUES ('460', '455', '龙门县', '4', '0', '0', '0', ',3268,423,455,460,');
INSERT INTO `cmf_regions` VALUES ('461', '423', '江门市', '3', '0', '0', '0', ',3268,423,461,');
INSERT INTO `cmf_regions` VALUES ('462', '461', '蓬江区', '4', '0', '0', '0', ',3268,423,461,462,');
INSERT INTO `cmf_regions` VALUES ('463', '461', '江海区', '4', '0', '0', '0', ',3268,423,461,463,');
INSERT INTO `cmf_regions` VALUES ('464', '461', '新会区', '4', '0', '0', '0', ',3268,423,461,464,');
INSERT INTO `cmf_regions` VALUES ('465', '461', '台山市', '4', '0', '0', '0', ',3268,423,461,465,');
INSERT INTO `cmf_regions` VALUES ('466', '461', '开平市', '4', '0', '0', '0', ',3268,423,461,466,');
INSERT INTO `cmf_regions` VALUES ('467', '461', '鹤山市', '4', '0', '0', '0', ',3268,423,461,467,');
INSERT INTO `cmf_regions` VALUES ('468', '461', '恩平市', '4', '0', '0', '0', ',3268,423,461,468,');
INSERT INTO `cmf_regions` VALUES ('469', '423', '揭阳市', '3', '0', '0', '0', ',3268,423,469,');
INSERT INTO `cmf_regions` VALUES ('470', '469', '榕城区', '4', '0', '0', '0', ',3268,423,469,470,');
INSERT INTO `cmf_regions` VALUES ('471', '469', '揭东县', '4', '0', '0', '0', ',3268,423,469,471,');
INSERT INTO `cmf_regions` VALUES ('472', '469', '揭西县', '4', '0', '0', '0', ',3268,423,469,472,');
INSERT INTO `cmf_regions` VALUES ('473', '469', '惠来县', '4', '0', '0', '0', ',3268,423,469,473,');
INSERT INTO `cmf_regions` VALUES ('474', '469', '普宁市', '4', '0', '0', '0', ',3268,423,469,474,');
INSERT INTO `cmf_regions` VALUES ('475', '423', '茂名市', '3', '0', '0', '0', ',3268,423,475,');
INSERT INTO `cmf_regions` VALUES ('476', '475', '茂南区', '4', '0', '0', '0', ',3268,423,475,476,');
INSERT INTO `cmf_regions` VALUES ('477', '475', '茂港区', '4', '0', '0', '0', ',3268,423,475,477,');
INSERT INTO `cmf_regions` VALUES ('478', '475', '电白县', '4', '0', '0', '0', ',3268,423,475,478,');
INSERT INTO `cmf_regions` VALUES ('479', '475', '高州市', '4', '0', '0', '0', ',3268,423,475,479,');
INSERT INTO `cmf_regions` VALUES ('480', '475', '化州市', '4', '0', '0', '0', ',3268,423,475,480,');
INSERT INTO `cmf_regions` VALUES ('481', '475', '信宜市', '4', '0', '0', '0', ',3268,423,475,481,');
INSERT INTO `cmf_regions` VALUES ('482', '423', '梅江区', '3', '0', '0', '0', ',3268,423,482,');
INSERT INTO `cmf_regions` VALUES ('483', '423', '梅州市', '3', '0', '0', '0', ',3268,423,483,');
INSERT INTO `cmf_regions` VALUES ('484', '483', '梅县', '4', '0', '0', '0', ',3268,423,483,484,');
INSERT INTO `cmf_regions` VALUES ('485', '483', '大埔县', '4', '0', '0', '0', ',3268,423,483,485,');
INSERT INTO `cmf_regions` VALUES ('486', '483', '丰顺县', '4', '0', '0', '0', ',3268,423,483,486,');
INSERT INTO `cmf_regions` VALUES ('487', '483', '五华县', '4', '0', '0', '0', ',3268,423,483,487,');
INSERT INTO `cmf_regions` VALUES ('488', '483', '平远县', '4', '0', '0', '0', ',3268,423,483,488,');
INSERT INTO `cmf_regions` VALUES ('489', '483', '蕉岭县', '4', '0', '0', '0', ',3268,423,483,489,');
INSERT INTO `cmf_regions` VALUES ('490', '483', '兴宁市', '4', '0', '0', '0', ',3268,423,483,490,');
INSERT INTO `cmf_regions` VALUES ('491', '423', '清远市', '3', '0', '0', '0', ',3268,423,491,');
INSERT INTO `cmf_regions` VALUES ('492', '491', '清城区', '4', '0', '0', '0', ',3268,423,491,492,');
INSERT INTO `cmf_regions` VALUES ('493', '491', '佛冈县', '4', '0', '0', '0', ',3268,423,491,493,');
INSERT INTO `cmf_regions` VALUES ('494', '491', '阳山县', '4', '0', '0', '0', ',3268,423,491,494,');
INSERT INTO `cmf_regions` VALUES ('495', '491', '连山壮族瑶族自治县', '4', '0', '0', '0', ',3268,423,491,495,');
INSERT INTO `cmf_regions` VALUES ('496', '491', '连南瑶族自治县', '4', '0', '0', '0', ',3268,423,491,496,');
INSERT INTO `cmf_regions` VALUES ('497', '491', '清新县', '4', '0', '0', '0', ',3268,423,491,497,');
INSERT INTO `cmf_regions` VALUES ('498', '491', '英德市', '4', '0', '0', '0', ',3268,423,491,498,');
INSERT INTO `cmf_regions` VALUES ('499', '491', '连州市', '4', '0', '0', '0', ',3268,423,491,499,');
INSERT INTO `cmf_regions` VALUES ('500', '423', '汕头市', '3', '0', '0', '0', ',3268,423,500,');
INSERT INTO `cmf_regions` VALUES ('501', '500', '龙湖区', '4', '0', '0', '0', ',3268,423,500,501,');
INSERT INTO `cmf_regions` VALUES ('502', '500', '金平区', '4', '0', '0', '0', ',3268,423,500,502,');
INSERT INTO `cmf_regions` VALUES ('503', '500', '濠江区', '4', '0', '0', '0', ',3268,423,500,503,');
INSERT INTO `cmf_regions` VALUES ('504', '500', '潮阳区', '4', '0', '0', '0', ',3268,423,500,504,');
INSERT INTO `cmf_regions` VALUES ('505', '500', '潮南区', '4', '0', '0', '0', ',3268,423,500,505,');
INSERT INTO `cmf_regions` VALUES ('506', '500', '澄海区', '4', '0', '0', '0', ',3268,423,500,506,');
INSERT INTO `cmf_regions` VALUES ('507', '500', '南澳县', '4', '0', '0', '0', ',3268,423,500,507,');
INSERT INTO `cmf_regions` VALUES ('508', '423', '汕尾市', '3', '0', '0', '0', ',3268,423,508,');
INSERT INTO `cmf_regions` VALUES ('509', '508', '城区', '4', '0', '0', '0', ',3268,423,508,509,');
INSERT INTO `cmf_regions` VALUES ('510', '508', '海丰县', '4', '0', '0', '0', ',3268,423,508,510,');
INSERT INTO `cmf_regions` VALUES ('511', '508', '陆河县', '4', '0', '0', '0', ',3268,423,508,511,');
INSERT INTO `cmf_regions` VALUES ('512', '508', '陆丰市', '4', '0', '0', '0', ',3268,423,508,512,');
INSERT INTO `cmf_regions` VALUES ('513', '423', '韶关市', '3', '0', '0', '0', ',3268,423,513,');
INSERT INTO `cmf_regions` VALUES ('514', '513', '武江区', '4', '0', '0', '0', ',3268,423,513,514,');
INSERT INTO `cmf_regions` VALUES ('515', '513', '浈江区', '4', '0', '0', '0', ',3268,423,513,515,');
INSERT INTO `cmf_regions` VALUES ('516', '513', '曲江区', '4', '0', '0', '0', ',3268,423,513,516,');
INSERT INTO `cmf_regions` VALUES ('517', '513', '始兴县', '4', '0', '0', '0', ',3268,423,513,517,');
INSERT INTO `cmf_regions` VALUES ('518', '513', '仁化县', '4', '0', '0', '0', ',3268,423,513,518,');
INSERT INTO `cmf_regions` VALUES ('519', '513', '翁源县', '4', '0', '0', '0', ',3268,423,513,519,');
INSERT INTO `cmf_regions` VALUES ('520', '513', '乳源瑶族自治县', '4', '0', '0', '0', ',3268,423,513,520,');
INSERT INTO `cmf_regions` VALUES ('521', '513', '新丰县', '4', '0', '0', '0', ',3268,423,513,521,');
INSERT INTO `cmf_regions` VALUES ('522', '513', '乐昌市', '4', '0', '0', '0', ',3268,423,513,522,');
INSERT INTO `cmf_regions` VALUES ('523', '513', '南雄市', '4', '0', '0', '0', ',3268,423,513,523,');
INSERT INTO `cmf_regions` VALUES ('524', '423', '深圳市', '3', '0', '0', '0', ',3268,423,524,');
INSERT INTO `cmf_regions` VALUES ('525', '524', '罗湖区', '4', '0', '0', '0', ',3268,423,524,525,');
INSERT INTO `cmf_regions` VALUES ('526', '524', '福田区', '4', '0', '0', '0', ',3268,423,524,526,');
INSERT INTO `cmf_regions` VALUES ('527', '524', '南山区', '4', '0', '0', '0', ',3268,423,524,527,');
INSERT INTO `cmf_regions` VALUES ('528', '524', '宝安区', '4', '0', '0', '0', ',3268,423,524,528,');
INSERT INTO `cmf_regions` VALUES ('529', '524', '龙岗区', '4', '0', '0', '0', ',3268,423,524,529,');
INSERT INTO `cmf_regions` VALUES ('530', '524', '盐田区', '4', '0', '0', '0', ',3268,423,524,530,');
INSERT INTO `cmf_regions` VALUES ('531', '423', '阳江市', '3', '0', '0', '0', ',3268,423,531,');
INSERT INTO `cmf_regions` VALUES ('532', '531', '江城区', '4', '0', '0', '0', ',3268,423,531,532,');
INSERT INTO `cmf_regions` VALUES ('533', '531', '阳西县', '4', '0', '0', '0', ',3268,423,531,533,');
INSERT INTO `cmf_regions` VALUES ('534', '531', '阳东县', '4', '0', '0', '0', ',3268,423,531,534,');
INSERT INTO `cmf_regions` VALUES ('535', '531', '阳春市', '4', '0', '0', '0', ',3268,423,531,535,');
INSERT INTO `cmf_regions` VALUES ('536', '423', '云浮市', '3', '0', '0', '0', ',3268,423,536,');
INSERT INTO `cmf_regions` VALUES ('537', '536', '云城区', '4', '0', '0', '0', ',3268,423,536,537,');
INSERT INTO `cmf_regions` VALUES ('538', '536', '新兴县', '4', '0', '0', '0', ',3268,423,536,538,');
INSERT INTO `cmf_regions` VALUES ('539', '536', '郁南县', '4', '0', '0', '0', ',3268,423,536,539,');
INSERT INTO `cmf_regions` VALUES ('540', '536', '云安县', '4', '0', '0', '0', ',3268,423,536,540,');
INSERT INTO `cmf_regions` VALUES ('541', '536', '罗定市', '4', '0', '0', '0', ',3268,423,536,541,');
INSERT INTO `cmf_regions` VALUES ('542', '423', '湛江市', '3', '0', '0', '0', ',3268,423,542,');
INSERT INTO `cmf_regions` VALUES ('543', '542', '赤坎区', '4', '0', '0', '0', ',3268,423,542,543,');
INSERT INTO `cmf_regions` VALUES ('544', '542', '霞山区', '4', '0', '0', '0', ',3268,423,542,544,');
INSERT INTO `cmf_regions` VALUES ('545', '542', '坡头区', '4', '0', '0', '0', ',3268,423,542,545,');
INSERT INTO `cmf_regions` VALUES ('546', '542', '麻章区', '4', '0', '0', '0', ',3268,423,542,546,');
INSERT INTO `cmf_regions` VALUES ('547', '542', '遂溪县', '4', '0', '0', '0', ',3268,423,542,547,');
INSERT INTO `cmf_regions` VALUES ('548', '542', '徐闻县', '4', '0', '0', '0', ',3268,423,542,548,');
INSERT INTO `cmf_regions` VALUES ('549', '542', '廉江市', '4', '0', '0', '0', ',3268,423,542,549,');
INSERT INTO `cmf_regions` VALUES ('550', '542', '雷州市', '4', '0', '0', '0', ',3268,423,542,550,');
INSERT INTO `cmf_regions` VALUES ('551', '542', '吴川市', '4', '0', '0', '0', ',3268,423,542,551,');
INSERT INTO `cmf_regions` VALUES ('552', '423', '肇庆市', '3', '0', '0', '0', ',3268,423,552,');
INSERT INTO `cmf_regions` VALUES ('553', '552', '端州区', '4', '0', '0', '0', ',3268,423,552,553,');
INSERT INTO `cmf_regions` VALUES ('554', '552', '鼎湖区', '4', '0', '0', '0', ',3268,423,552,554,');
INSERT INTO `cmf_regions` VALUES ('555', '552', '广宁县', '4', '0', '0', '0', ',3268,423,552,555,');
INSERT INTO `cmf_regions` VALUES ('556', '552', '怀集县', '4', '0', '0', '0', ',3268,423,552,556,');
INSERT INTO `cmf_regions` VALUES ('557', '552', '封开县', '4', '0', '0', '0', ',3268,423,552,557,');
INSERT INTO `cmf_regions` VALUES ('558', '552', '德庆县', '4', '0', '0', '0', ',3268,423,552,558,');
INSERT INTO `cmf_regions` VALUES ('559', '552', '高要市', '4', '0', '0', '0', ',3268,423,552,559,');
INSERT INTO `cmf_regions` VALUES ('560', '552', '四会市', '4', '0', '0', '0', ',3268,423,552,560,');
INSERT INTO `cmf_regions` VALUES ('561', '423', '中山市', '3', '0', '0', '0', ',3268,423,561,');
INSERT INTO `cmf_regions` VALUES ('562', '423', '珠海市', '3', '0', '0', '0', ',3268,423,562,');
INSERT INTO `cmf_regions` VALUES ('563', '562', '香洲区', '4', '0', '0', '0', ',3268,423,562,563,');
INSERT INTO `cmf_regions` VALUES ('564', '562', '斗门区', '4', '0', '0', '0', ',3268,423,562,564,');
INSERT INTO `cmf_regions` VALUES ('565', '562', '金湾区', '4', '0', '0', '0', ',3268,423,562,565,');
INSERT INTO `cmf_regions` VALUES ('566', '3268', '广西', '2', '0', '0', '0', ',3268,566,');
INSERT INTO `cmf_regions` VALUES ('567', '566', '南宁市', '3', '0', '0', '0', ',3268,566,567,');
INSERT INTO `cmf_regions` VALUES ('568', '567', '兴宁区', '4', '0', '0', '0', ',3268,566,567,568,');
INSERT INTO `cmf_regions` VALUES ('569', '567', '青秀区', '4', '0', '0', '0', ',3268,566,567,569,');
INSERT INTO `cmf_regions` VALUES ('570', '567', '江南区', '4', '0', '0', '0', ',3268,566,567,570,');
INSERT INTO `cmf_regions` VALUES ('571', '567', '西乡塘区', '4', '0', '0', '0', ',3268,566,567,571,');
INSERT INTO `cmf_regions` VALUES ('572', '567', '良庆区', '4', '0', '0', '0', ',3268,566,567,572,');
INSERT INTO `cmf_regions` VALUES ('573', '567', '邕宁区', '4', '0', '0', '0', ',3268,566,567,573,');
INSERT INTO `cmf_regions` VALUES ('574', '567', '武鸣县', '4', '0', '0', '0', ',3268,566,567,574,');
INSERT INTO `cmf_regions` VALUES ('575', '567', '隆安县', '4', '0', '0', '0', ',3268,566,567,575,');
INSERT INTO `cmf_regions` VALUES ('576', '567', '马山县', '4', '0', '0', '0', ',3268,566,567,576,');
INSERT INTO `cmf_regions` VALUES ('577', '567', '上林县', '4', '0', '0', '0', ',3268,566,567,577,');
INSERT INTO `cmf_regions` VALUES ('578', '567', '宾阳县', '4', '0', '0', '0', ',3268,566,567,578,');
INSERT INTO `cmf_regions` VALUES ('579', '567', '横县', '4', '0', '0', '0', ',3268,566,567,579,');
INSERT INTO `cmf_regions` VALUES ('580', '566', '百色市', '3', '0', '0', '0', ',3268,566,580,');
INSERT INTO `cmf_regions` VALUES ('581', '580', '右江区', '4', '0', '0', '0', ',3268,566,580,581,');
INSERT INTO `cmf_regions` VALUES ('582', '580', '田阳县', '4', '0', '0', '0', ',3268,566,580,582,');
INSERT INTO `cmf_regions` VALUES ('583', '580', '田东县', '4', '0', '0', '0', ',3268,566,580,583,');
INSERT INTO `cmf_regions` VALUES ('584', '580', '平果县', '4', '0', '0', '0', ',3268,566,580,584,');
INSERT INTO `cmf_regions` VALUES ('585', '580', '德保县', '4', '0', '0', '0', ',3268,566,580,585,');
INSERT INTO `cmf_regions` VALUES ('586', '580', '靖西县', '4', '0', '0', '0', ',3268,566,580,586,');
INSERT INTO `cmf_regions` VALUES ('587', '580', '那坡县', '4', '0', '0', '0', ',3268,566,580,587,');
INSERT INTO `cmf_regions` VALUES ('588', '580', '凌云县', '4', '0', '0', '0', ',3268,566,580,588,');
INSERT INTO `cmf_regions` VALUES ('589', '580', '乐业县', '4', '0', '0', '0', ',3268,566,580,589,');
INSERT INTO `cmf_regions` VALUES ('590', '580', '田林县', '4', '0', '0', '0', ',3268,566,580,590,');
INSERT INTO `cmf_regions` VALUES ('591', '580', '西林县', '4', '0', '0', '0', ',3268,566,580,591,');
INSERT INTO `cmf_regions` VALUES ('592', '580', '隆林各族自治县', '4', '0', '0', '0', ',3268,566,580,592,');
INSERT INTO `cmf_regions` VALUES ('593', '566', '北海市', '3', '0', '0', '0', ',3268,566,593,');
INSERT INTO `cmf_regions` VALUES ('594', '593', '海城区', '4', '0', '0', '0', ',3268,566,593,594,');
INSERT INTO `cmf_regions` VALUES ('595', '593', '银海区', '4', '0', '0', '0', ',3268,566,593,595,');
INSERT INTO `cmf_regions` VALUES ('596', '593', '铁山港区', '4', '0', '0', '0', ',3268,566,593,596,');
INSERT INTO `cmf_regions` VALUES ('597', '593', '合浦县', '4', '0', '0', '0', ',3268,566,593,597,');
INSERT INTO `cmf_regions` VALUES ('598', '566', '崇左市', '3', '0', '0', '0', ',3268,566,598,');
INSERT INTO `cmf_regions` VALUES ('599', '598', '江洲区', '4', '0', '0', '0', ',3268,566,598,599,');
INSERT INTO `cmf_regions` VALUES ('600', '598', '扶绥县', '4', '0', '0', '0', ',3268,566,598,600,');
INSERT INTO `cmf_regions` VALUES ('601', '598', '宁明县', '4', '0', '0', '0', ',3268,566,598,601,');
INSERT INTO `cmf_regions` VALUES ('602', '598', '龙州县', '4', '0', '0', '0', ',3268,566,598,602,');
INSERT INTO `cmf_regions` VALUES ('603', '598', '大新县', '4', '0', '0', '0', ',3268,566,598,603,');
INSERT INTO `cmf_regions` VALUES ('604', '598', '天等县', '4', '0', '0', '0', ',3268,566,598,604,');
INSERT INTO `cmf_regions` VALUES ('605', '598', '凭祥市', '4', '0', '0', '0', ',3268,566,598,605,');
INSERT INTO `cmf_regions` VALUES ('606', '566', '防城港市', '3', '0', '0', '0', ',3268,566,606,');
INSERT INTO `cmf_regions` VALUES ('607', '606', '港口区', '4', '0', '0', '0', ',3268,566,606,607,');
INSERT INTO `cmf_regions` VALUES ('608', '606', '防城区', '4', '0', '0', '0', ',3268,566,606,608,');
INSERT INTO `cmf_regions` VALUES ('609', '606', '上思县', '4', '0', '0', '0', ',3268,566,606,609,');
INSERT INTO `cmf_regions` VALUES ('610', '606', '东兴市', '4', '0', '0', '0', ',3268,566,606,610,');
INSERT INTO `cmf_regions` VALUES ('611', '566', '贵港市', '3', '0', '0', '0', ',3268,566,611,');
INSERT INTO `cmf_regions` VALUES ('612', '611', '港北区', '4', '0', '0', '0', ',3268,566,611,612,');
INSERT INTO `cmf_regions` VALUES ('613', '611', '港南区', '4', '0', '0', '0', ',3268,566,611,613,');
INSERT INTO `cmf_regions` VALUES ('614', '611', '覃塘区', '4', '0', '0', '0', ',3268,566,611,614,');
INSERT INTO `cmf_regions` VALUES ('615', '611', '平南县', '4', '0', '0', '0', ',3268,566,611,615,');
INSERT INTO `cmf_regions` VALUES ('616', '611', '桂平市', '4', '0', '0', '0', ',3268,566,611,616,');
INSERT INTO `cmf_regions` VALUES ('617', '566', '桂林市', '3', '0', '0', '0', ',3268,566,617,');
INSERT INTO `cmf_regions` VALUES ('618', '617', '秀峰区', '4', '0', '0', '0', ',3268,566,617,618,');
INSERT INTO `cmf_regions` VALUES ('619', '617', '叠彩区', '4', '0', '0', '0', ',3268,566,617,619,');
INSERT INTO `cmf_regions` VALUES ('620', '617', '象山区', '4', '0', '0', '0', ',3268,566,617,620,');
INSERT INTO `cmf_regions` VALUES ('621', '617', '七星区', '4', '0', '0', '0', ',3268,566,617,621,');
INSERT INTO `cmf_regions` VALUES ('622', '617', '雁山区', '4', '0', '0', '0', ',3268,566,617,622,');
INSERT INTO `cmf_regions` VALUES ('623', '617', '阳朔县', '4', '0', '0', '0', ',3268,566,617,623,');
INSERT INTO `cmf_regions` VALUES ('624', '617', '临桂县', '4', '0', '0', '0', ',3268,566,617,624,');
INSERT INTO `cmf_regions` VALUES ('625', '617', '灵川县', '4', '0', '0', '0', ',3268,566,617,625,');
INSERT INTO `cmf_regions` VALUES ('626', '617', '全州县', '4', '0', '0', '0', ',3268,566,617,626,');
INSERT INTO `cmf_regions` VALUES ('627', '617', '兴安县', '4', '0', '0', '0', ',3268,566,617,627,');
INSERT INTO `cmf_regions` VALUES ('628', '617', '永福县', '4', '0', '0', '0', ',3268,566,617,628,');
INSERT INTO `cmf_regions` VALUES ('629', '617', '灌阳县', '4', '0', '0', '0', ',3268,566,617,629,');
INSERT INTO `cmf_regions` VALUES ('630', '617', '龙胜各族自治县', '4', '0', '0', '0', ',3268,566,617,630,');
INSERT INTO `cmf_regions` VALUES ('631', '617', '资源县', '4', '0', '0', '0', ',3268,566,617,631,');
INSERT INTO `cmf_regions` VALUES ('632', '617', '平乐县', '4', '0', '0', '0', ',3268,566,617,632,');
INSERT INTO `cmf_regions` VALUES ('633', '617', '荔蒲县', '4', '0', '0', '0', ',3268,566,617,633,');
INSERT INTO `cmf_regions` VALUES ('634', '617', '恭城瑶族自治县', '4', '0', '0', '0', ',3268,566,617,634,');
INSERT INTO `cmf_regions` VALUES ('635', '566', '河池市', '3', '0', '0', '0', ',3268,566,635,');
INSERT INTO `cmf_regions` VALUES ('636', '635', '金城江区', '4', '0', '0', '0', ',3268,566,635,636,');
INSERT INTO `cmf_regions` VALUES ('637', '635', '南丹县', '4', '0', '0', '0', ',3268,566,635,637,');
INSERT INTO `cmf_regions` VALUES ('638', '635', '天峨县', '4', '0', '0', '0', ',3268,566,635,638,');
INSERT INTO `cmf_regions` VALUES ('639', '635', '凤山县', '4', '0', '0', '0', ',3268,566,635,639,');
INSERT INTO `cmf_regions` VALUES ('640', '635', '东兰县', '4', '0', '0', '0', ',3268,566,635,640,');
INSERT INTO `cmf_regions` VALUES ('641', '635', '罗城仫佬族自治县', '4', '0', '0', '0', ',3268,566,635,641,');
INSERT INTO `cmf_regions` VALUES ('642', '635', '环江毛南族自治县', '4', '0', '0', '0', ',3268,566,635,642,');
INSERT INTO `cmf_regions` VALUES ('643', '635', '巴马瑶族自治县', '4', '0', '0', '0', ',3268,566,635,643,');
INSERT INTO `cmf_regions` VALUES ('644', '635', '都安瑶族自治县', '4', '0', '0', '0', ',3268,566,635,644,');
INSERT INTO `cmf_regions` VALUES ('645', '635', '大化瑶族自治县', '4', '0', '0', '0', ',3268,566,635,645,');
INSERT INTO `cmf_regions` VALUES ('646', '635', '宜州市', '4', '0', '0', '0', ',3268,566,635,646,');
INSERT INTO `cmf_regions` VALUES ('647', '566', '贺州市', '3', '0', '0', '0', ',3268,566,647,');
INSERT INTO `cmf_regions` VALUES ('648', '647', '八步区', '4', '0', '0', '0', ',3268,566,647,648,');
INSERT INTO `cmf_regions` VALUES ('649', '647', '昭平县', '4', '0', '0', '0', ',3268,566,647,649,');
INSERT INTO `cmf_regions` VALUES ('650', '647', '钟山县', '4', '0', '0', '0', ',3268,566,647,650,');
INSERT INTO `cmf_regions` VALUES ('651', '647', '富川瑶族自治县', '4', '0', '0', '0', ',3268,566,647,651,');
INSERT INTO `cmf_regions` VALUES ('652', '566', '来宾市', '3', '0', '0', '0', ',3268,566,652,');
INSERT INTO `cmf_regions` VALUES ('653', '652', '兴宾区', '4', '0', '0', '0', ',3268,566,652,653,');
INSERT INTO `cmf_regions` VALUES ('654', '652', '忻城县', '4', '0', '0', '0', ',3268,566,652,654,');
INSERT INTO `cmf_regions` VALUES ('655', '652', '象州县', '4', '0', '0', '0', ',3268,566,652,655,');
INSERT INTO `cmf_regions` VALUES ('656', '652', '武宣县', '4', '0', '0', '0', ',3268,566,652,656,');
INSERT INTO `cmf_regions` VALUES ('657', '652', '金秀瑶族自治县', '4', '0', '0', '0', ',3268,566,652,657,');
INSERT INTO `cmf_regions` VALUES ('658', '652', '合山市', '4', '0', '0', '0', ',3268,566,652,658,');
INSERT INTO `cmf_regions` VALUES ('659', '566', '柳州市', '3', '0', '0', '0', ',3268,566,659,');
INSERT INTO `cmf_regions` VALUES ('660', '659', '城中区', '4', '0', '0', '0', ',3268,566,659,660,');
INSERT INTO `cmf_regions` VALUES ('661', '659', '鱼峰区', '4', '0', '0', '0', ',3268,566,659,661,');
INSERT INTO `cmf_regions` VALUES ('662', '659', '柳南区', '4', '0', '0', '0', ',3268,566,659,662,');
INSERT INTO `cmf_regions` VALUES ('663', '659', '柳北区', '4', '0', '0', '0', ',3268,566,659,663,');
INSERT INTO `cmf_regions` VALUES ('664', '659', '柳江县', '4', '0', '0', '0', ',3268,566,659,664,');
INSERT INTO `cmf_regions` VALUES ('665', '659', '柳城县', '4', '0', '0', '0', ',3268,566,659,665,');
INSERT INTO `cmf_regions` VALUES ('666', '659', '鹿寨县', '4', '0', '0', '0', ',3268,566,659,666,');
INSERT INTO `cmf_regions` VALUES ('667', '659', '融安县', '4', '0', '0', '0', ',3268,566,659,667,');
INSERT INTO `cmf_regions` VALUES ('668', '659', '融水苗族自治县', '4', '0', '0', '0', ',3268,566,659,668,');
INSERT INTO `cmf_regions` VALUES ('669', '659', '三江侗族自治县', '4', '0', '0', '0', ',3268,566,659,669,');
INSERT INTO `cmf_regions` VALUES ('670', '566', '钦州市', '3', '0', '0', '0', ',3268,566,670,');
INSERT INTO `cmf_regions` VALUES ('671', '670', '钦南区', '4', '0', '0', '0', ',3268,566,670,671,');
INSERT INTO `cmf_regions` VALUES ('672', '670', '钦北区', '4', '0', '0', '0', ',3268,566,670,672,');
INSERT INTO `cmf_regions` VALUES ('673', '670', '灵山县', '4', '0', '0', '0', ',3268,566,670,673,');
INSERT INTO `cmf_regions` VALUES ('674', '670', '浦北县', '4', '0', '0', '0', ',3268,566,670,674,');
INSERT INTO `cmf_regions` VALUES ('675', '566', '梧州市', '3', '0', '0', '0', ',3268,566,675,');
INSERT INTO `cmf_regions` VALUES ('676', '675', '万秀区', '4', '0', '0', '0', ',3268,566,675,676,');
INSERT INTO `cmf_regions` VALUES ('677', '675', '蝶山区', '4', '0', '0', '0', ',3268,566,675,677,');
INSERT INTO `cmf_regions` VALUES ('678', '675', '长洲区', '4', '0', '0', '0', ',3268,566,675,678,');
INSERT INTO `cmf_regions` VALUES ('679', '675', '苍梧县', '4', '0', '0', '0', ',3268,566,675,679,');
INSERT INTO `cmf_regions` VALUES ('680', '675', '藤县', '4', '0', '0', '0', ',3268,566,675,680,');
INSERT INTO `cmf_regions` VALUES ('681', '675', '蒙山县', '4', '0', '0', '0', ',3268,566,675,681,');
INSERT INTO `cmf_regions` VALUES ('682', '675', '岑溪市', '4', '0', '0', '0', ',3268,566,675,682,');
INSERT INTO `cmf_regions` VALUES ('683', '566', '玉林市', '3', '0', '0', '0', ',3268,566,683,');
INSERT INTO `cmf_regions` VALUES ('684', '683', '玉州区', '4', '0', '0', '0', ',3268,566,683,684,');
INSERT INTO `cmf_regions` VALUES ('685', '683', '容县', '4', '0', '0', '0', ',3268,566,683,685,');
INSERT INTO `cmf_regions` VALUES ('686', '683', '陆川县', '4', '0', '0', '0', ',3268,566,683,686,');
INSERT INTO `cmf_regions` VALUES ('687', '683', '博白县', '4', '0', '0', '0', ',3268,566,683,687,');
INSERT INTO `cmf_regions` VALUES ('688', '683', '兴业县', '4', '0', '0', '0', ',3268,566,683,688,');
INSERT INTO `cmf_regions` VALUES ('689', '683', '北流市', '4', '0', '0', '0', ',3268,566,683,689,');
INSERT INTO `cmf_regions` VALUES ('690', '3268', '贵州', '2', '0', '0', '0', ',3268,690,');
INSERT INTO `cmf_regions` VALUES ('691', '690', '贵阳市', '3', '0', '0', '0', ',3268,690,691,');
INSERT INTO `cmf_regions` VALUES ('692', '691', '南明区', '4', '0', '0', '0', ',3268,690,691,692,');
INSERT INTO `cmf_regions` VALUES ('693', '691', '云岩区', '4', '0', '0', '0', ',3268,690,691,693,');
INSERT INTO `cmf_regions` VALUES ('694', '691', '花溪区', '4', '0', '0', '0', ',3268,690,691,694,');
INSERT INTO `cmf_regions` VALUES ('695', '691', '乌当区', '4', '0', '0', '0', ',3268,690,691,695,');
INSERT INTO `cmf_regions` VALUES ('696', '691', '白云区', '4', '0', '0', '0', ',3268,690,691,696,');
INSERT INTO `cmf_regions` VALUES ('697', '691', '小河区', '4', '0', '0', '0', ',3268,690,691,697,');
INSERT INTO `cmf_regions` VALUES ('698', '691', '开阳县', '4', '0', '0', '0', ',3268,690,691,698,');
INSERT INTO `cmf_regions` VALUES ('699', '691', '息烽县', '4', '0', '0', '0', ',3268,690,691,699,');
INSERT INTO `cmf_regions` VALUES ('700', '691', '修文县', '4', '0', '0', '0', ',3268,690,691,700,');
INSERT INTO `cmf_regions` VALUES ('701', '691', '清镇市', '4', '0', '0', '0', ',3268,690,691,701,');
INSERT INTO `cmf_regions` VALUES ('702', '690', '安顺市', '3', '0', '0', '0', ',3268,690,702,');
INSERT INTO `cmf_regions` VALUES ('703', '702', '西秀区', '4', '0', '0', '0', ',3268,690,702,703,');
INSERT INTO `cmf_regions` VALUES ('704', '702', '平坝县', '4', '0', '0', '0', ',3268,690,702,704,');
INSERT INTO `cmf_regions` VALUES ('705', '702', '普定县', '4', '0', '0', '0', ',3268,690,702,705,');
INSERT INTO `cmf_regions` VALUES ('706', '702', '镇宁布依族苗族自治县', '4', '0', '0', '0', ',3268,690,702,706,');
INSERT INTO `cmf_regions` VALUES ('707', '702', '关岭布依族苗族自治县', '4', '0', '0', '0', ',3268,690,702,707,');
INSERT INTO `cmf_regions` VALUES ('708', '702', '紫云苗族布依族自治县', '4', '0', '0', '0', ',3268,690,702,708,');
INSERT INTO `cmf_regions` VALUES ('709', '690', '毕节地区', '3', '0', '0', '0', ',3268,690,709,');
INSERT INTO `cmf_regions` VALUES ('710', '709', '毕节市', '4', '0', '0', '0', ',3268,690,709,710,');
INSERT INTO `cmf_regions` VALUES ('711', '709', '大方县', '4', '0', '0', '0', ',3268,690,709,711,');
INSERT INTO `cmf_regions` VALUES ('712', '709', '黔西县', '4', '0', '0', '0', ',3268,690,709,712,');
INSERT INTO `cmf_regions` VALUES ('713', '709', '金沙县', '4', '0', '0', '0', ',3268,690,709,713,');
INSERT INTO `cmf_regions` VALUES ('714', '709', '织金县', '4', '0', '0', '0', ',3268,690,709,714,');
INSERT INTO `cmf_regions` VALUES ('715', '709', '纳雍县', '4', '0', '0', '0', ',3268,690,709,715,');
INSERT INTO `cmf_regions` VALUES ('716', '709', '威宁彝族回族苗族自治县', '4', '0', '0', '0', ',3268,690,709,716,');
INSERT INTO `cmf_regions` VALUES ('717', '709', '赫章县', '4', '0', '0', '0', ',3268,690,709,717,');
INSERT INTO `cmf_regions` VALUES ('718', '690', '六盘水市', '3', '0', '0', '0', ',3268,690,718,');
INSERT INTO `cmf_regions` VALUES ('719', '718', '钟山区', '4', '0', '0', '0', ',3268,690,718,719,');
INSERT INTO `cmf_regions` VALUES ('720', '718', '六枝特区', '4', '0', '0', '0', ',3268,690,718,720,');
INSERT INTO `cmf_regions` VALUES ('721', '718', '水城县', '4', '0', '0', '0', ',3268,690,718,721,');
INSERT INTO `cmf_regions` VALUES ('722', '718', '盘县', '4', '0', '0', '0', ',3268,690,718,722,');
INSERT INTO `cmf_regions` VALUES ('723', '690', '黔东南苗族侗族自治州', '3', '0', '0', '0', ',3268,690,723,');
INSERT INTO `cmf_regions` VALUES ('724', '723', '凯里市', '4', '0', '0', '0', ',3268,690,723,724,');
INSERT INTO `cmf_regions` VALUES ('725', '723', '黄平县', '4', '0', '0', '0', ',3268,690,723,725,');
INSERT INTO `cmf_regions` VALUES ('726', '723', '施秉县', '4', '0', '0', '0', ',3268,690,723,726,');
INSERT INTO `cmf_regions` VALUES ('727', '723', '三穗县', '4', '0', '0', '0', ',3268,690,723,727,');
INSERT INTO `cmf_regions` VALUES ('728', '723', '镇远县', '4', '0', '0', '0', ',3268,690,723,728,');
INSERT INTO `cmf_regions` VALUES ('729', '723', '岑巩县', '4', '0', '0', '0', ',3268,690,723,729,');
INSERT INTO `cmf_regions` VALUES ('730', '723', '天柱县', '4', '0', '0', '0', ',3268,690,723,730,');
INSERT INTO `cmf_regions` VALUES ('731', '723', '锦屏县', '4', '0', '0', '0', ',3268,690,723,731,');
INSERT INTO `cmf_regions` VALUES ('732', '723', '剑河县', '4', '0', '0', '0', ',3268,690,723,732,');
INSERT INTO `cmf_regions` VALUES ('733', '723', '台江县', '4', '0', '0', '0', ',3268,690,723,733,');
INSERT INTO `cmf_regions` VALUES ('734', '723', '黎平县', '4', '0', '0', '0', ',3268,690,723,734,');
INSERT INTO `cmf_regions` VALUES ('735', '723', '榕江县', '4', '0', '0', '0', ',3268,690,723,735,');
INSERT INTO `cmf_regions` VALUES ('736', '723', '从江县', '4', '0', '0', '0', ',3268,690,723,736,');
INSERT INTO `cmf_regions` VALUES ('737', '723', '雷山县', '4', '0', '0', '0', ',3268,690,723,737,');
INSERT INTO `cmf_regions` VALUES ('738', '723', '麻江县', '4', '0', '0', '0', ',3268,690,723,738,');
INSERT INTO `cmf_regions` VALUES ('739', '723', '丹寨县', '4', '0', '0', '0', ',3268,690,723,739,');
INSERT INTO `cmf_regions` VALUES ('740', '690', '黔南布依族苗族自治州', '3', '0', '0', '0', ',3268,690,740,');
INSERT INTO `cmf_regions` VALUES ('741', '740', '都匀市', '4', '0', '0', '0', ',3268,690,740,741,');
INSERT INTO `cmf_regions` VALUES ('742', '740', '福泉市', '4', '0', '0', '0', ',3268,690,740,742,');
INSERT INTO `cmf_regions` VALUES ('743', '740', '荔波县', '4', '0', '0', '0', ',3268,690,740,743,');
INSERT INTO `cmf_regions` VALUES ('744', '740', '贵定县', '4', '0', '0', '0', ',3268,690,740,744,');
INSERT INTO `cmf_regions` VALUES ('745', '740', '瓮安县', '4', '0', '0', '0', ',3268,690,740,745,');
INSERT INTO `cmf_regions` VALUES ('746', '740', '独山县', '4', '0', '0', '0', ',3268,690,740,746,');
INSERT INTO `cmf_regions` VALUES ('747', '740', '平塘县', '4', '0', '0', '0', ',3268,690,740,747,');
INSERT INTO `cmf_regions` VALUES ('748', '740', '罗甸县', '4', '0', '0', '0', ',3268,690,740,748,');
INSERT INTO `cmf_regions` VALUES ('749', '740', '长顺县', '4', '0', '0', '0', ',3268,690,740,749,');
INSERT INTO `cmf_regions` VALUES ('750', '740', '龙里县', '4', '0', '0', '0', ',3268,690,740,750,');
INSERT INTO `cmf_regions` VALUES ('751', '740', '惠水县', '4', '0', '0', '0', ',3268,690,740,751,');
INSERT INTO `cmf_regions` VALUES ('752', '740', '三都水族自治县', '4', '0', '0', '0', ',3268,690,740,752,');
INSERT INTO `cmf_regions` VALUES ('753', '690', '黔西南布依族苗族自治州', '3', '0', '0', '0', ',3268,690,753,');
INSERT INTO `cmf_regions` VALUES ('754', '753', '兴义市', '4', '0', '0', '0', ',3268,690,753,754,');
INSERT INTO `cmf_regions` VALUES ('755', '753', '兴仁县', '4', '0', '0', '0', ',3268,690,753,755,');
INSERT INTO `cmf_regions` VALUES ('756', '753', '普安县', '4', '0', '0', '0', ',3268,690,753,756,');
INSERT INTO `cmf_regions` VALUES ('757', '753', '晴隆县', '4', '0', '0', '0', ',3268,690,753,757,');
INSERT INTO `cmf_regions` VALUES ('758', '753', '贞丰县', '4', '0', '0', '0', ',3268,690,753,758,');
INSERT INTO `cmf_regions` VALUES ('759', '753', '望谟县', '4', '0', '0', '0', ',3268,690,753,759,');
INSERT INTO `cmf_regions` VALUES ('760', '753', '册亨县', '4', '0', '0', '0', ',3268,690,753,760,');
INSERT INTO `cmf_regions` VALUES ('761', '753', '安龙县', '4', '0', '0', '0', ',3268,690,753,761,');
INSERT INTO `cmf_regions` VALUES ('762', '690', '铜仁地区', '3', '0', '0', '0', ',3268,690,762,');
INSERT INTO `cmf_regions` VALUES ('763', '762', '铜仁市', '4', '0', '0', '0', ',3268,690,762,763,');
INSERT INTO `cmf_regions` VALUES ('764', '762', '江口县', '4', '0', '0', '0', ',3268,690,762,764,');
INSERT INTO `cmf_regions` VALUES ('765', '762', '玉屏侗族自治县', '4', '0', '0', '0', ',3268,690,762,765,');
INSERT INTO `cmf_regions` VALUES ('766', '762', '石阡县', '4', '0', '0', '0', ',3268,690,762,766,');
INSERT INTO `cmf_regions` VALUES ('767', '762', '思南县', '4', '0', '0', '0', ',3268,690,762,767,');
INSERT INTO `cmf_regions` VALUES ('768', '762', '印江土家族苗族自治县', '4', '0', '0', '0', ',3268,690,762,768,');
INSERT INTO `cmf_regions` VALUES ('769', '762', '德江县', '4', '0', '0', '0', ',3268,690,762,769,');
INSERT INTO `cmf_regions` VALUES ('770', '762', '沿河土家族自治县', '4', '0', '0', '0', ',3268,690,762,770,');
INSERT INTO `cmf_regions` VALUES ('771', '762', '松桃苗族自治县', '4', '0', '0', '0', ',3268,690,762,771,');
INSERT INTO `cmf_regions` VALUES ('772', '762', '万山特区', '4', '0', '0', '0', ',3268,690,762,772,');
INSERT INTO `cmf_regions` VALUES ('773', '690', '遵义市', '3', '0', '0', '0', ',3268,690,773,');
INSERT INTO `cmf_regions` VALUES ('774', '773', '红花岗区', '4', '0', '0', '0', ',3268,690,773,774,');
INSERT INTO `cmf_regions` VALUES ('775', '773', '汇川区', '4', '0', '0', '0', ',3268,690,773,775,');
INSERT INTO `cmf_regions` VALUES ('776', '773', '遵义县', '4', '0', '0', '0', ',3268,690,773,776,');
INSERT INTO `cmf_regions` VALUES ('777', '773', '桐梓县', '4', '0', '0', '0', ',3268,690,773,777,');
INSERT INTO `cmf_regions` VALUES ('778', '773', '绥阳县', '4', '0', '0', '0', ',3268,690,773,778,');
INSERT INTO `cmf_regions` VALUES ('779', '773', '正安县', '4', '0', '0', '0', ',3268,690,773,779,');
INSERT INTO `cmf_regions` VALUES ('780', '773', '道真仡佬族苗族自治县', '4', '0', '0', '0', ',3268,690,773,780,');
INSERT INTO `cmf_regions` VALUES ('781', '773', '务川仡佬族苗族自治县', '4', '0', '0', '0', ',3268,690,773,781,');
INSERT INTO `cmf_regions` VALUES ('782', '773', '凤冈县', '4', '0', '0', '0', ',3268,690,773,782,');
INSERT INTO `cmf_regions` VALUES ('783', '773', '湄潭县', '4', '0', '0', '0', ',3268,690,773,783,');
INSERT INTO `cmf_regions` VALUES ('784', '773', '余庆县', '4', '0', '0', '0', ',3268,690,773,784,');
INSERT INTO `cmf_regions` VALUES ('785', '773', '习水县', '4', '0', '0', '0', ',3268,690,773,785,');
INSERT INTO `cmf_regions` VALUES ('786', '773', '赤水市', '4', '0', '0', '0', ',3268,690,773,786,');
INSERT INTO `cmf_regions` VALUES ('787', '773', '仁怀市', '4', '0', '0', '0', ',3268,690,773,787,');
INSERT INTO `cmf_regions` VALUES ('788', '3268', '海南', '2', '0', '0', '0', ',3268,788,');
INSERT INTO `cmf_regions` VALUES ('789', '788', '海口市', '3', '0', '0', '0', ',3268,788,789,');
INSERT INTO `cmf_regions` VALUES ('790', '789', '秀英区', '4', '0', '0', '0', ',3268,788,789,790,');
INSERT INTO `cmf_regions` VALUES ('791', '789', '龙华区', '4', '0', '0', '0', ',3268,788,789,791,');
INSERT INTO `cmf_regions` VALUES ('792', '789', '琼山区', '4', '0', '0', '0', ',3268,788,789,792,');
INSERT INTO `cmf_regions` VALUES ('793', '789', '美兰区', '4', '0', '0', '0', ',3268,788,789,793,');
INSERT INTO `cmf_regions` VALUES ('794', '788', '白沙黎族自治县', '3', '0', '0', '0', ',3268,788,794,');
INSERT INTO `cmf_regions` VALUES ('795', '788', '保亭黎族苗族自治县', '3', '0', '0', '0', ',3268,788,795,');
INSERT INTO `cmf_regions` VALUES ('796', '788', '昌江黎族自治县', '3', '0', '0', '0', ',3268,788,796,');
INSERT INTO `cmf_regions` VALUES ('797', '788', '澄迈县', '3', '0', '0', '0', ',3268,788,797,');
INSERT INTO `cmf_regions` VALUES ('798', '788', '儋州市', '3', '0', '0', '0', ',3268,788,798,');
INSERT INTO `cmf_regions` VALUES ('799', '788', '定安县', '3', '0', '0', '0', ',3268,788,799,');
INSERT INTO `cmf_regions` VALUES ('800', '788', '东方市', '3', '0', '0', '0', ',3268,788,800,');
INSERT INTO `cmf_regions` VALUES ('801', '788', '乐东黎族自治县', '3', '0', '0', '0', ',3268,788,801,');
INSERT INTO `cmf_regions` VALUES ('802', '788', '临高县', '3', '0', '0', '0', ',3268,788,802,');
INSERT INTO `cmf_regions` VALUES ('803', '788', '陵水黎族自治县', '3', '0', '0', '0', ',3268,788,803,');
INSERT INTO `cmf_regions` VALUES ('804', '788', '南沙群岛', '3', '0', '0', '0', ',3268,788,804,');
INSERT INTO `cmf_regions` VALUES ('805', '788', '琼海市', '3', '0', '0', '0', ',3268,788,805,');
INSERT INTO `cmf_regions` VALUES ('806', '788', '琼中黎族苗族自治县', '3', '0', '0', '0', ',3268,788,806,');
INSERT INTO `cmf_regions` VALUES ('807', '788', '三亚市', '3', '0', '0', '0', ',3268,788,807,');
INSERT INTO `cmf_regions` VALUES ('808', '788', '屯昌县', '3', '0', '0', '0', ',3268,788,808,');
INSERT INTO `cmf_regions` VALUES ('809', '788', '万宁市', '3', '0', '0', '0', ',3268,788,809,');
INSERT INTO `cmf_regions` VALUES ('810', '788', '文昌市', '3', '0', '0', '0', ',3268,788,810,');
INSERT INTO `cmf_regions` VALUES ('811', '788', '五指山市', '3', '0', '0', '0', ',3268,788,811,');
INSERT INTO `cmf_regions` VALUES ('812', '788', '西沙群岛', '3', '0', '0', '0', ',3268,788,812,');
INSERT INTO `cmf_regions` VALUES ('813', '788', '中沙群岛的岛礁及其海域', '3', '0', '0', '0', ',3268,788,813,');
INSERT INTO `cmf_regions` VALUES ('814', '3268', '河北', '2', '0', '0', '0', ',3268,814,');
INSERT INTO `cmf_regions` VALUES ('815', '814', '石家庄市', '3', '0', '0', '0', ',3268,814,815,');
INSERT INTO `cmf_regions` VALUES ('816', '815', '长安区', '4', '0', '0', '0', ',3268,814,815,816,');
INSERT INTO `cmf_regions` VALUES ('817', '815', '桥东区', '4', '0', '0', '0', ',3268,814,815,817,');
INSERT INTO `cmf_regions` VALUES ('818', '815', '桥西区', '4', '0', '0', '0', ',3268,814,815,818,');
INSERT INTO `cmf_regions` VALUES ('819', '815', '新华区', '4', '0', '0', '0', ',3268,814,815,819,');
INSERT INTO `cmf_regions` VALUES ('820', '815', '井陉矿区', '4', '0', '0', '0', ',3268,814,815,820,');
INSERT INTO `cmf_regions` VALUES ('821', '815', '裕华区', '4', '0', '0', '0', ',3268,814,815,821,');
INSERT INTO `cmf_regions` VALUES ('822', '815', '井陉县', '4', '0', '0', '0', ',3268,814,815,822,');
INSERT INTO `cmf_regions` VALUES ('823', '815', '正定县', '4', '0', '0', '0', ',3268,814,815,823,');
INSERT INTO `cmf_regions` VALUES ('824', '815', '栾城县', '4', '0', '0', '0', ',3268,814,815,824,');
INSERT INTO `cmf_regions` VALUES ('825', '815', '行唐县', '4', '0', '0', '0', ',3268,814,815,825,');
INSERT INTO `cmf_regions` VALUES ('826', '815', '灵寿县', '4', '0', '0', '0', ',3268,814,815,826,');
INSERT INTO `cmf_regions` VALUES ('827', '815', '高邑县', '4', '0', '0', '0', ',3268,814,815,827,');
INSERT INTO `cmf_regions` VALUES ('828', '815', '深泽县', '4', '0', '0', '0', ',3268,814,815,828,');
INSERT INTO `cmf_regions` VALUES ('829', '815', '赞皇县', '4', '0', '0', '0', ',3268,814,815,829,');
INSERT INTO `cmf_regions` VALUES ('830', '815', '无极县', '4', '0', '0', '0', ',3268,814,815,830,');
INSERT INTO `cmf_regions` VALUES ('831', '815', '平山县', '4', '0', '0', '0', ',3268,814,815,831,');
INSERT INTO `cmf_regions` VALUES ('832', '815', '元氏县', '4', '0', '0', '0', ',3268,814,815,832,');
INSERT INTO `cmf_regions` VALUES ('833', '815', '赵县', '4', '0', '0', '0', ',3268,814,815,833,');
INSERT INTO `cmf_regions` VALUES ('834', '815', '辛集市', '4', '0', '0', '0', ',3268,814,815,834,');
INSERT INTO `cmf_regions` VALUES ('835', '815', '藁城市', '4', '0', '0', '0', ',3268,814,815,835,');
INSERT INTO `cmf_regions` VALUES ('836', '815', '晋州市', '4', '0', '0', '0', ',3268,814,815,836,');
INSERT INTO `cmf_regions` VALUES ('837', '815', '新乐市', '4', '0', '0', '0', ',3268,814,815,837,');
INSERT INTO `cmf_regions` VALUES ('838', '815', '鹿泉市', '4', '0', '0', '0', ',3268,814,815,838,');
INSERT INTO `cmf_regions` VALUES ('839', '814', '保定市', '3', '0', '0', '0', ',3268,814,839,');
INSERT INTO `cmf_regions` VALUES ('840', '839', '新市区', '4', '0', '0', '0', ',3268,814,839,840,');
INSERT INTO `cmf_regions` VALUES ('841', '839', '北市区', '4', '0', '0', '0', ',3268,814,839,841,');
INSERT INTO `cmf_regions` VALUES ('842', '839', '南市区', '4', '0', '0', '0', ',3268,814,839,842,');
INSERT INTO `cmf_regions` VALUES ('843', '839', '满城县', '4', '0', '0', '0', ',3268,814,839,843,');
INSERT INTO `cmf_regions` VALUES ('844', '839', '清苑县', '4', '0', '0', '0', ',3268,814,839,844,');
INSERT INTO `cmf_regions` VALUES ('845', '839', '涞水县', '4', '0', '0', '0', ',3268,814,839,845,');
INSERT INTO `cmf_regions` VALUES ('846', '839', '阜平县', '4', '0', '0', '0', ',3268,814,839,846,');
INSERT INTO `cmf_regions` VALUES ('847', '839', '徐水县', '4', '0', '0', '0', ',3268,814,839,847,');
INSERT INTO `cmf_regions` VALUES ('848', '839', '定兴县', '4', '0', '0', '0', ',3268,814,839,848,');
INSERT INTO `cmf_regions` VALUES ('849', '839', '唐县', '4', '0', '0', '0', ',3268,814,839,849,');
INSERT INTO `cmf_regions` VALUES ('850', '839', '高阳县', '4', '0', '0', '0', ',3268,814,839,850,');
INSERT INTO `cmf_regions` VALUES ('851', '839', '容城县', '4', '0', '0', '0', ',3268,814,839,851,');
INSERT INTO `cmf_regions` VALUES ('852', '839', '涞源县', '4', '0', '0', '0', ',3268,814,839,852,');
INSERT INTO `cmf_regions` VALUES ('853', '839', '望都县', '4', '0', '0', '0', ',3268,814,839,853,');
INSERT INTO `cmf_regions` VALUES ('854', '839', '安新县', '4', '0', '0', '0', ',3268,814,839,854,');
INSERT INTO `cmf_regions` VALUES ('855', '839', '易县', '4', '0', '0', '0', ',3268,814,839,855,');
INSERT INTO `cmf_regions` VALUES ('856', '839', '曲阳县', '4', '0', '0', '0', ',3268,814,839,856,');
INSERT INTO `cmf_regions` VALUES ('857', '839', '蠡县', '4', '0', '0', '0', ',3268,814,839,857,');
INSERT INTO `cmf_regions` VALUES ('858', '839', '顺平县', '4', '0', '0', '0', ',3268,814,839,858,');
INSERT INTO `cmf_regions` VALUES ('859', '839', '博野县', '4', '0', '0', '0', ',3268,814,839,859,');
INSERT INTO `cmf_regions` VALUES ('860', '839', '雄县', '4', '0', '0', '0', ',3268,814,839,860,');
INSERT INTO `cmf_regions` VALUES ('861', '839', '涿州市', '4', '0', '0', '0', ',3268,814,839,861,');
INSERT INTO `cmf_regions` VALUES ('862', '839', '定州市', '4', '0', '0', '0', ',3268,814,839,862,');
INSERT INTO `cmf_regions` VALUES ('863', '839', '安国市', '4', '0', '0', '0', ',3268,814,839,863,');
INSERT INTO `cmf_regions` VALUES ('864', '839', '高碑店市', '4', '0', '0', '0', ',3268,814,839,864,');
INSERT INTO `cmf_regions` VALUES ('865', '814', '沧州市', '3', '0', '0', '0', ',3268,814,865,');
INSERT INTO `cmf_regions` VALUES ('866', '865', '新华区', '4', '0', '0', '0', ',3268,814,865,866,');
INSERT INTO `cmf_regions` VALUES ('867', '865', '运河区', '4', '0', '0', '0', ',3268,814,865,867,');
INSERT INTO `cmf_regions` VALUES ('868', '865', '沧县', '4', '0', '0', '0', ',3268,814,865,868,');
INSERT INTO `cmf_regions` VALUES ('869', '865', '青县', '4', '0', '0', '0', ',3268,814,865,869,');
INSERT INTO `cmf_regions` VALUES ('870', '865', '东光县', '4', '0', '0', '0', ',3268,814,865,870,');
INSERT INTO `cmf_regions` VALUES ('871', '865', '海兴县', '4', '0', '0', '0', ',3268,814,865,871,');
INSERT INTO `cmf_regions` VALUES ('872', '865', '盐山县', '4', '0', '0', '0', ',3268,814,865,872,');
INSERT INTO `cmf_regions` VALUES ('873', '865', '肃宁县', '4', '0', '0', '0', ',3268,814,865,873,');
INSERT INTO `cmf_regions` VALUES ('874', '865', '南皮县', '4', '0', '0', '0', ',3268,814,865,874,');
INSERT INTO `cmf_regions` VALUES ('875', '865', '吴桥县', '4', '0', '0', '0', ',3268,814,865,875,');
INSERT INTO `cmf_regions` VALUES ('876', '865', '献县', '4', '0', '0', '0', ',3268,814,865,876,');
INSERT INTO `cmf_regions` VALUES ('877', '865', '孟村回族自治县', '4', '0', '0', '0', ',3268,814,865,877,');
INSERT INTO `cmf_regions` VALUES ('878', '865', '泊头市', '4', '0', '0', '0', ',3268,814,865,878,');
INSERT INTO `cmf_regions` VALUES ('879', '865', '任丘市', '4', '0', '0', '0', ',3268,814,865,879,');
INSERT INTO `cmf_regions` VALUES ('880', '865', '黄骅市', '4', '0', '0', '0', ',3268,814,865,880,');
INSERT INTO `cmf_regions` VALUES ('881', '865', '河间市', '4', '0', '0', '0', ',3268,814,865,881,');
INSERT INTO `cmf_regions` VALUES ('882', '814', '承德市', '3', '0', '0', '0', ',3268,814,882,');
INSERT INTO `cmf_regions` VALUES ('883', '882', '双桥区', '4', '0', '0', '0', ',3268,814,882,883,');
INSERT INTO `cmf_regions` VALUES ('884', '882', '双滦区', '4', '0', '0', '0', ',3268,814,882,884,');
INSERT INTO `cmf_regions` VALUES ('885', '882', '鹰手营子矿区', '4', '0', '0', '0', ',3268,814,882,885,');
INSERT INTO `cmf_regions` VALUES ('886', '882', '承德县', '4', '0', '0', '0', ',3268,814,882,886,');
INSERT INTO `cmf_regions` VALUES ('887', '882', '兴隆县', '4', '0', '0', '0', ',3268,814,882,887,');
INSERT INTO `cmf_regions` VALUES ('888', '882', '平泉县', '4', '0', '0', '0', ',3268,814,882,888,');
INSERT INTO `cmf_regions` VALUES ('889', '882', '滦平县', '4', '0', '0', '0', ',3268,814,882,889,');
INSERT INTO `cmf_regions` VALUES ('890', '882', '隆化县', '4', '0', '0', '0', ',3268,814,882,890,');
INSERT INTO `cmf_regions` VALUES ('891', '882', '丰宁满族自治县', '4', '0', '0', '0', ',3268,814,882,891,');
INSERT INTO `cmf_regions` VALUES ('892', '882', '宽城满族自治县', '4', '0', '0', '0', ',3268,814,882,892,');
INSERT INTO `cmf_regions` VALUES ('893', '882', '围场满族蒙古族自治县', '4', '0', '0', '0', ',3268,814,882,893,');
INSERT INTO `cmf_regions` VALUES ('894', '814', '邯郸市', '3', '0', '0', '0', ',3268,814,894,');
INSERT INTO `cmf_regions` VALUES ('895', '894', '邯山区', '4', '0', '0', '0', ',3268,814,894,895,');
INSERT INTO `cmf_regions` VALUES ('896', '894', '丛台区', '4', '0', '0', '0', ',3268,814,894,896,');
INSERT INTO `cmf_regions` VALUES ('897', '894', '复兴区', '4', '0', '0', '0', ',3268,814,894,897,');
INSERT INTO `cmf_regions` VALUES ('898', '894', '峰峰矿区', '4', '0', '0', '0', ',3268,814,894,898,');
INSERT INTO `cmf_regions` VALUES ('899', '894', '邯郸县', '4', '0', '0', '0', ',3268,814,894,899,');
INSERT INTO `cmf_regions` VALUES ('900', '894', '临漳县', '4', '0', '0', '0', ',3268,814,894,900,');
INSERT INTO `cmf_regions` VALUES ('901', '894', '成安县', '4', '0', '0', '0', ',3268,814,894,901,');
INSERT INTO `cmf_regions` VALUES ('902', '894', '大名县', '4', '0', '0', '0', ',3268,814,894,902,');
INSERT INTO `cmf_regions` VALUES ('903', '894', '涉县', '4', '0', '0', '0', ',3268,814,894,903,');
INSERT INTO `cmf_regions` VALUES ('904', '894', '磁县', '4', '0', '0', '0', ',3268,814,894,904,');
INSERT INTO `cmf_regions` VALUES ('905', '894', '肥乡县', '4', '0', '0', '0', ',3268,814,894,905,');
INSERT INTO `cmf_regions` VALUES ('906', '894', '永年县', '4', '0', '0', '0', ',3268,814,894,906,');
INSERT INTO `cmf_regions` VALUES ('907', '894', '邱县', '4', '0', '0', '0', ',3268,814,894,907,');
INSERT INTO `cmf_regions` VALUES ('908', '894', '鸡泽县', '4', '0', '0', '0', ',3268,814,894,908,');
INSERT INTO `cmf_regions` VALUES ('909', '894', '广平县', '4', '0', '0', '0', ',3268,814,894,909,');
INSERT INTO `cmf_regions` VALUES ('910', '894', '馆陶县', '4', '0', '0', '0', ',3268,814,894,910,');
INSERT INTO `cmf_regions` VALUES ('911', '894', '魏县', '4', '0', '0', '0', ',3268,814,894,911,');
INSERT INTO `cmf_regions` VALUES ('912', '894', '曲周县', '4', '0', '0', '0', ',3268,814,894,912,');
INSERT INTO `cmf_regions` VALUES ('913', '894', '武安市', '4', '0', '0', '0', ',3268,814,894,913,');
INSERT INTO `cmf_regions` VALUES ('914', '814', '衡水市', '3', '0', '0', '0', ',3268,814,914,');
INSERT INTO `cmf_regions` VALUES ('915', '914', '桃城区', '4', '0', '0', '0', ',3268,814,914,915,');
INSERT INTO `cmf_regions` VALUES ('916', '914', '枣强县', '4', '0', '0', '0', ',3268,814,914,916,');
INSERT INTO `cmf_regions` VALUES ('917', '914', '武邑县', '4', '0', '0', '0', ',3268,814,914,917,');
INSERT INTO `cmf_regions` VALUES ('918', '914', '武强县', '4', '0', '0', '0', ',3268,814,914,918,');
INSERT INTO `cmf_regions` VALUES ('919', '914', '饶阳县', '4', '0', '0', '0', ',3268,814,914,919,');
INSERT INTO `cmf_regions` VALUES ('920', '914', '安平县', '4', '0', '0', '0', ',3268,814,914,920,');
INSERT INTO `cmf_regions` VALUES ('921', '914', '故城县', '4', '0', '0', '0', ',3268,814,914,921,');
INSERT INTO `cmf_regions` VALUES ('922', '914', '景县', '4', '0', '0', '0', ',3268,814,914,922,');
INSERT INTO `cmf_regions` VALUES ('923', '914', '阜城县', '4', '0', '0', '0', ',3268,814,914,923,');
INSERT INTO `cmf_regions` VALUES ('924', '914', '冀州市', '4', '0', '0', '0', ',3268,814,914,924,');
INSERT INTO `cmf_regions` VALUES ('925', '914', '深州市', '4', '0', '0', '0', ',3268,814,914,925,');
INSERT INTO `cmf_regions` VALUES ('926', '814', '廊坊市', '3', '0', '0', '0', ',3268,814,926,');
INSERT INTO `cmf_regions` VALUES ('927', '926', '安次区', '4', '0', '0', '0', ',3268,814,926,927,');
INSERT INTO `cmf_regions` VALUES ('928', '926', '广阳区', '4', '0', '0', '0', ',3268,814,926,928,');
INSERT INTO `cmf_regions` VALUES ('929', '926', '固安县', '4', '0', '0', '0', ',3268,814,926,929,');
INSERT INTO `cmf_regions` VALUES ('930', '926', '永清县', '4', '0', '0', '0', ',3268,814,926,930,');
INSERT INTO `cmf_regions` VALUES ('931', '926', '香河县', '4', '0', '0', '0', ',3268,814,926,931,');
INSERT INTO `cmf_regions` VALUES ('932', '926', '大城县', '4', '0', '0', '0', ',3268,814,926,932,');
INSERT INTO `cmf_regions` VALUES ('933', '926', '文安县', '4', '0', '0', '0', ',3268,814,926,933,');
INSERT INTO `cmf_regions` VALUES ('934', '926', '大厂回族自治县', '4', '0', '0', '0', ',3268,814,926,934,');
INSERT INTO `cmf_regions` VALUES ('935', '926', '霸州市', '4', '0', '0', '0', ',3268,814,926,935,');
INSERT INTO `cmf_regions` VALUES ('936', '926', '三河市', '4', '0', '0', '0', ',3268,814,926,936,');
INSERT INTO `cmf_regions` VALUES ('937', '814', '秦皇岛市', '3', '0', '0', '0', ',3268,814,937,');
INSERT INTO `cmf_regions` VALUES ('938', '937', '海港区', '4', '0', '0', '0', ',3268,814,937,938,');
INSERT INTO `cmf_regions` VALUES ('939', '937', '山海关区', '4', '0', '0', '0', ',3268,814,937,939,');
INSERT INTO `cmf_regions` VALUES ('940', '937', '北戴河区', '4', '0', '0', '0', ',3268,814,937,940,');
INSERT INTO `cmf_regions` VALUES ('941', '937', '青龙满族自治县', '4', '0', '0', '0', ',3268,814,937,941,');
INSERT INTO `cmf_regions` VALUES ('942', '937', '昌黎县', '4', '0', '0', '0', ',3268,814,937,942,');
INSERT INTO `cmf_regions` VALUES ('943', '937', '抚宁县', '4', '0', '0', '0', ',3268,814,937,943,');
INSERT INTO `cmf_regions` VALUES ('944', '937', '卢龙县', '4', '0', '0', '0', ',3268,814,937,944,');
INSERT INTO `cmf_regions` VALUES ('945', '814', '唐山市', '3', '0', '0', '0', ',3268,814,945,');
INSERT INTO `cmf_regions` VALUES ('946', '945', '路南区', '4', '0', '0', '0', ',3268,814,945,946,');
INSERT INTO `cmf_regions` VALUES ('947', '945', '路北区', '4', '0', '0', '0', ',3268,814,945,947,');
INSERT INTO `cmf_regions` VALUES ('948', '945', '古冶区', '4', '0', '0', '0', ',3268,814,945,948,');
INSERT INTO `cmf_regions` VALUES ('949', '945', '开平区', '4', '0', '0', '0', ',3268,814,945,949,');
INSERT INTO `cmf_regions` VALUES ('950', '945', '丰南区', '4', '0', '0', '0', ',3268,814,945,950,');
INSERT INTO `cmf_regions` VALUES ('951', '945', '丰润区', '4', '0', '0', '0', ',3268,814,945,951,');
INSERT INTO `cmf_regions` VALUES ('952', '945', '滦县', '4', '0', '0', '0', ',3268,814,945,952,');
INSERT INTO `cmf_regions` VALUES ('953', '945', '滦南县', '4', '0', '0', '0', ',3268,814,945,953,');
INSERT INTO `cmf_regions` VALUES ('954', '945', '乐亭县', '4', '0', '0', '0', ',3268,814,945,954,');
INSERT INTO `cmf_regions` VALUES ('955', '945', '迁西县', '4', '0', '0', '0', ',3268,814,945,955,');
INSERT INTO `cmf_regions` VALUES ('956', '945', '玉田县', '4', '0', '0', '0', ',3268,814,945,956,');
INSERT INTO `cmf_regions` VALUES ('957', '945', '唐海县', '4', '0', '0', '0', ',3268,814,945,957,');
INSERT INTO `cmf_regions` VALUES ('958', '945', '遵化市', '4', '0', '0', '0', ',3268,814,945,958,');
INSERT INTO `cmf_regions` VALUES ('959', '945', '迁安市', '4', '0', '0', '0', ',3268,814,945,959,');
INSERT INTO `cmf_regions` VALUES ('960', '814', '邢台市', '3', '0', '0', '0', ',3268,814,960,');
INSERT INTO `cmf_regions` VALUES ('961', '960', '桥东区', '4', '0', '0', '0', ',3268,814,960,961,');
INSERT INTO `cmf_regions` VALUES ('962', '960', '桥西区', '4', '0', '0', '0', ',3268,814,960,962,');
INSERT INTO `cmf_regions` VALUES ('963', '960', '邢台县', '4', '0', '0', '0', ',3268,814,960,963,');
INSERT INTO `cmf_regions` VALUES ('964', '960', '临城县', '4', '0', '0', '0', ',3268,814,960,964,');
INSERT INTO `cmf_regions` VALUES ('965', '960', '内丘县', '4', '0', '0', '0', ',3268,814,960,965,');
INSERT INTO `cmf_regions` VALUES ('966', '960', '柏乡县', '4', '0', '0', '0', ',3268,814,960,966,');
INSERT INTO `cmf_regions` VALUES ('967', '960', '隆尧县', '4', '0', '0', '0', ',3268,814,960,967,');
INSERT INTO `cmf_regions` VALUES ('968', '960', '任县', '4', '0', '0', '0', ',3268,814,960,968,');
INSERT INTO `cmf_regions` VALUES ('969', '960', '南和县', '4', '0', '0', '0', ',3268,814,960,969,');
INSERT INTO `cmf_regions` VALUES ('970', '960', '宁晋县', '4', '0', '0', '0', ',3268,814,960,970,');
INSERT INTO `cmf_regions` VALUES ('971', '960', '巨鹿县', '4', '0', '0', '0', ',3268,814,960,971,');
INSERT INTO `cmf_regions` VALUES ('972', '960', '新河县', '4', '0', '0', '0', ',3268,814,960,972,');
INSERT INTO `cmf_regions` VALUES ('973', '960', '广宗县', '4', '0', '0', '0', ',3268,814,960,973,');
INSERT INTO `cmf_regions` VALUES ('974', '960', '平乡县', '4', '0', '0', '0', ',3268,814,960,974,');
INSERT INTO `cmf_regions` VALUES ('975', '960', '威县', '4', '0', '0', '0', ',3268,814,960,975,');
INSERT INTO `cmf_regions` VALUES ('976', '960', '清河县', '4', '0', '0', '0', ',3268,814,960,976,');
INSERT INTO `cmf_regions` VALUES ('977', '960', '临西县', '4', '0', '0', '0', ',3268,814,960,977,');
INSERT INTO `cmf_regions` VALUES ('978', '960', '南宫市', '4', '0', '0', '0', ',3268,814,960,978,');
INSERT INTO `cmf_regions` VALUES ('979', '960', '沙河市', '4', '0', '0', '0', ',3268,814,960,979,');
INSERT INTO `cmf_regions` VALUES ('980', '814', '张家口市', '3', '0', '0', '0', ',3268,814,980,');
INSERT INTO `cmf_regions` VALUES ('981', '980', '桥东区', '4', '0', '0', '0', ',3268,814,980,981,');
INSERT INTO `cmf_regions` VALUES ('982', '980', '桥西区', '4', '0', '0', '0', ',3268,814,980,982,');
INSERT INTO `cmf_regions` VALUES ('983', '980', '宣化区', '4', '0', '0', '0', ',3268,814,980,983,');
INSERT INTO `cmf_regions` VALUES ('984', '980', '下花园区', '4', '0', '0', '0', ',3268,814,980,984,');
INSERT INTO `cmf_regions` VALUES ('985', '980', '宣化县', '4', '0', '0', '0', ',3268,814,980,985,');
INSERT INTO `cmf_regions` VALUES ('986', '980', '张北县', '4', '0', '0', '0', ',3268,814,980,986,');
INSERT INTO `cmf_regions` VALUES ('987', '980', '康保县', '4', '0', '0', '0', ',3268,814,980,987,');
INSERT INTO `cmf_regions` VALUES ('988', '980', '沽源县', '4', '0', '0', '0', ',3268,814,980,988,');
INSERT INTO `cmf_regions` VALUES ('989', '980', '尚义县', '4', '0', '0', '0', ',3268,814,980,989,');
INSERT INTO `cmf_regions` VALUES ('990', '980', '蔚县', '4', '0', '0', '0', ',3268,814,980,990,');
INSERT INTO `cmf_regions` VALUES ('991', '980', '阳原县', '4', '0', '0', '0', ',3268,814,980,991,');
INSERT INTO `cmf_regions` VALUES ('992', '980', '怀安县', '4', '0', '0', '0', ',3268,814,980,992,');
INSERT INTO `cmf_regions` VALUES ('993', '980', '万全县', '4', '0', '0', '0', ',3268,814,980,993,');
INSERT INTO `cmf_regions` VALUES ('994', '980', '怀来县', '4', '0', '0', '0', ',3268,814,980,994,');
INSERT INTO `cmf_regions` VALUES ('995', '980', '涿鹿县', '4', '0', '0', '0', ',3268,814,980,995,');
INSERT INTO `cmf_regions` VALUES ('996', '980', '赤城县', '4', '0', '0', '0', ',3268,814,980,996,');
INSERT INTO `cmf_regions` VALUES ('997', '980', '崇礼县', '4', '0', '0', '0', ',3268,814,980,997,');
INSERT INTO `cmf_regions` VALUES ('998', '3268', '河南', '2', '0', '0', '0', ',3268,998,');
INSERT INTO `cmf_regions` VALUES ('999', '998', '郑州市', '3', '0', '0', '0', ',3268,998,999,');
INSERT INTO `cmf_regions` VALUES ('1000', '999', '中原区', '4', '0', '0', '0', ',3268,998,999,1000,');
INSERT INTO `cmf_regions` VALUES ('1001', '999', '二七区', '4', '0', '0', '0', ',3268,998,999,1001,');
INSERT INTO `cmf_regions` VALUES ('1002', '999', '管城回族区', '4', '0', '0', '0', ',3268,998,999,1002,');
INSERT INTO `cmf_regions` VALUES ('1003', '999', '金水区', '4', '0', '0', '0', ',3268,998,999,1003,');
INSERT INTO `cmf_regions` VALUES ('1004', '999', '上街区', '4', '0', '0', '0', ',3268,998,999,1004,');
INSERT INTO `cmf_regions` VALUES ('1005', '999', '邙山区', '4', '0', '0', '0', ',3268,998,999,1005,');
INSERT INTO `cmf_regions` VALUES ('1006', '999', '中牟县', '4', '0', '0', '0', ',3268,998,999,1006,');
INSERT INTO `cmf_regions` VALUES ('1007', '999', '巩义市', '4', '0', '0', '0', ',3268,998,999,1007,');
INSERT INTO `cmf_regions` VALUES ('1008', '999', '荥阳市', '4', '0', '0', '0', ',3268,998,999,1008,');
INSERT INTO `cmf_regions` VALUES ('1009', '999', '新密市', '4', '0', '0', '0', ',3268,998,999,1009,');
INSERT INTO `cmf_regions` VALUES ('1010', '999', '新郑市', '4', '0', '0', '0', ',3268,998,999,1010,');
INSERT INTO `cmf_regions` VALUES ('1011', '999', '登封市', '4', '0', '0', '0', ',3268,998,999,1011,');
INSERT INTO `cmf_regions` VALUES ('1012', '998', '安阳市', '3', '0', '0', '0', ',3268,998,1012,');
INSERT INTO `cmf_regions` VALUES ('1013', '1012', '文峰区', '4', '0', '0', '0', ',3268,998,1012,1013,');
INSERT INTO `cmf_regions` VALUES ('1014', '1012', '北关区', '4', '0', '0', '0', ',3268,998,1012,1014,');
INSERT INTO `cmf_regions` VALUES ('1015', '1012', '殷都区', '4', '0', '0', '0', ',3268,998,1012,1015,');
INSERT INTO `cmf_regions` VALUES ('1016', '1012', '龙安区', '4', '0', '0', '0', ',3268,998,1012,1016,');
INSERT INTO `cmf_regions` VALUES ('1017', '1012', '安阳县', '4', '0', '0', '0', ',3268,998,1012,1017,');
INSERT INTO `cmf_regions` VALUES ('1018', '1012', '汤阴县', '4', '0', '0', '0', ',3268,998,1012,1018,');
INSERT INTO `cmf_regions` VALUES ('1019', '1012', '滑县', '4', '0', '0', '0', ',3268,998,1012,1019,');
INSERT INTO `cmf_regions` VALUES ('1020', '1012', '内黄县', '4', '0', '0', '0', ',3268,998,1012,1020,');
INSERT INTO `cmf_regions` VALUES ('1021', '1012', '林州市', '4', '0', '0', '0', ',3268,998,1012,1021,');
INSERT INTO `cmf_regions` VALUES ('1022', '998', '鹤壁市', '3', '0', '0', '0', ',3268,998,1022,');
INSERT INTO `cmf_regions` VALUES ('1023', '1022', '鹤山区', '4', '0', '0', '0', ',3268,998,1022,1023,');
INSERT INTO `cmf_regions` VALUES ('1024', '1022', '山城区', '4', '0', '0', '0', ',3268,998,1022,1024,');
INSERT INTO `cmf_regions` VALUES ('1025', '1022', '淇滨区', '4', '0', '0', '0', ',3268,998,1022,1025,');
INSERT INTO `cmf_regions` VALUES ('1026', '1022', '浚县', '4', '0', '0', '0', ',3268,998,1022,1026,');
INSERT INTO `cmf_regions` VALUES ('1027', '1022', '淇县', '4', '0', '0', '0', ',3268,998,1022,1027,');
INSERT INTO `cmf_regions` VALUES ('1028', '998', '济源市', '3', '0', '0', '0', ',3268,998,1028,');
INSERT INTO `cmf_regions` VALUES ('1029', '998', '焦作市', '3', '0', '0', '0', ',3268,998,1029,');
INSERT INTO `cmf_regions` VALUES ('1030', '1029', '解放区', '4', '0', '0', '0', ',3268,998,1029,1030,');
INSERT INTO `cmf_regions` VALUES ('1031', '1029', '中站区', '4', '0', '0', '0', ',3268,998,1029,1031,');
INSERT INTO `cmf_regions` VALUES ('1032', '1029', '马村区', '4', '0', '0', '0', ',3268,998,1029,1032,');
INSERT INTO `cmf_regions` VALUES ('1033', '1029', '山阳区', '4', '0', '0', '0', ',3268,998,1029,1033,');
INSERT INTO `cmf_regions` VALUES ('1034', '1029', '修武县', '4', '0', '0', '0', ',3268,998,1029,1034,');
INSERT INTO `cmf_regions` VALUES ('1035', '1029', '博爱县', '4', '0', '0', '0', ',3268,998,1029,1035,');
INSERT INTO `cmf_regions` VALUES ('1036', '1029', '武陟县', '4', '0', '0', '0', ',3268,998,1029,1036,');
INSERT INTO `cmf_regions` VALUES ('1037', '1029', '温县', '4', '0', '0', '0', ',3268,998,1029,1037,');
INSERT INTO `cmf_regions` VALUES ('1038', '1029', '济源市', '4', '0', '0', '0', ',3268,998,1029,1038,');
INSERT INTO `cmf_regions` VALUES ('1039', '1029', '沁阳市', '4', '0', '0', '0', ',3268,998,1029,1039,');
INSERT INTO `cmf_regions` VALUES ('1040', '1029', '孟州市', '4', '0', '0', '0', ',3268,998,1029,1040,');
INSERT INTO `cmf_regions` VALUES ('1041', '998', '开封市', '3', '0', '0', '0', ',3268,998,1041,');
INSERT INTO `cmf_regions` VALUES ('1042', '1041', '龙亭区', '4', '0', '0', '0', ',3268,998,1041,1042,');
INSERT INTO `cmf_regions` VALUES ('1043', '1041', '顺河回族区', '4', '0', '0', '0', ',3268,998,1041,1043,');
INSERT INTO `cmf_regions` VALUES ('1044', '1041', '鼓楼区', '4', '0', '0', '0', ',3268,998,1041,1044,');
INSERT INTO `cmf_regions` VALUES ('1045', '1041', '南关区', '4', '0', '0', '0', ',3268,998,1041,1045,');
INSERT INTO `cmf_regions` VALUES ('1046', '1041', '郊区', '4', '0', '0', '0', ',3268,998,1041,1046,');
INSERT INTO `cmf_regions` VALUES ('1047', '1041', '杞县', '4', '0', '0', '0', ',3268,998,1041,1047,');
INSERT INTO `cmf_regions` VALUES ('1048', '1041', '通许县', '4', '0', '0', '0', ',3268,998,1041,1048,');
INSERT INTO `cmf_regions` VALUES ('1049', '1041', '尉氏县', '4', '0', '0', '0', ',3268,998,1041,1049,');
INSERT INTO `cmf_regions` VALUES ('1050', '1041', '开封县', '4', '0', '0', '0', ',3268,998,1041,1050,');
INSERT INTO `cmf_regions` VALUES ('1051', '1041', '兰考县', '4', '0', '0', '0', ',3268,998,1041,1051,');
INSERT INTO `cmf_regions` VALUES ('1052', '998', '洛阳市', '3', '0', '0', '0', ',3268,998,1052,');
INSERT INTO `cmf_regions` VALUES ('1053', '1052', '老城区', '4', '0', '0', '0', ',3268,998,1052,1053,');
INSERT INTO `cmf_regions` VALUES ('1054', '1052', '西工区', '4', '0', '0', '0', ',3268,998,1052,1054,');
INSERT INTO `cmf_regions` VALUES ('1055', '1052', '廛河回族区', '4', '0', '0', '0', ',3268,998,1052,1055,');
INSERT INTO `cmf_regions` VALUES ('1056', '1052', '涧西区', '4', '0', '0', '0', ',3268,998,1052,1056,');
INSERT INTO `cmf_regions` VALUES ('1057', '1052', '吉利区', '4', '0', '0', '0', ',3268,998,1052,1057,');
INSERT INTO `cmf_regions` VALUES ('1058', '1052', '洛龙区', '4', '0', '0', '0', ',3268,998,1052,1058,');
INSERT INTO `cmf_regions` VALUES ('1059', '1052', '孟津县', '4', '0', '0', '0', ',3268,998,1052,1059,');
INSERT INTO `cmf_regions` VALUES ('1060', '1052', '新安县', '4', '0', '0', '0', ',3268,998,1052,1060,');
INSERT INTO `cmf_regions` VALUES ('1061', '1052', '栾川县', '4', '0', '0', '0', ',3268,998,1052,1061,');
INSERT INTO `cmf_regions` VALUES ('1062', '1052', '嵩县', '4', '0', '0', '0', ',3268,998,1052,1062,');
INSERT INTO `cmf_regions` VALUES ('1063', '1052', '汝阳县', '4', '0', '0', '0', ',3268,998,1052,1063,');
INSERT INTO `cmf_regions` VALUES ('1064', '1052', '宜阳县', '4', '0', '0', '0', ',3268,998,1052,1064,');
INSERT INTO `cmf_regions` VALUES ('1065', '1052', '洛宁县', '4', '0', '0', '0', ',3268,998,1052,1065,');
INSERT INTO `cmf_regions` VALUES ('1066', '1052', '伊川县', '4', '0', '0', '0', ',3268,998,1052,1066,');
INSERT INTO `cmf_regions` VALUES ('1067', '1052', '偃师市', '4', '0', '0', '0', ',3268,998,1052,1067,');
INSERT INTO `cmf_regions` VALUES ('1068', '998', '漯河市', '3', '0', '0', '0', ',3268,998,1068,');
INSERT INTO `cmf_regions` VALUES ('1069', '1068', '源汇区', '4', '0', '0', '0', ',3268,998,1068,1069,');
INSERT INTO `cmf_regions` VALUES ('1070', '1068', '郾城区', '4', '0', '0', '0', ',3268,998,1068,1070,');
INSERT INTO `cmf_regions` VALUES ('1071', '1068', '召陵区', '4', '0', '0', '0', ',3268,998,1068,1071,');
INSERT INTO `cmf_regions` VALUES ('1072', '1068', '舞阳县', '4', '0', '0', '0', ',3268,998,1068,1072,');
INSERT INTO `cmf_regions` VALUES ('1073', '1068', '临颍县', '4', '0', '0', '0', ',3268,998,1068,1073,');
INSERT INTO `cmf_regions` VALUES ('1074', '998', '南阳市', '3', '0', '0', '0', ',3268,998,1074,');
INSERT INTO `cmf_regions` VALUES ('1075', '1074', '宛城区', '4', '0', '0', '0', ',3268,998,1074,1075,');
INSERT INTO `cmf_regions` VALUES ('1076', '1074', '卧龙区', '4', '0', '0', '0', ',3268,998,1074,1076,');
INSERT INTO `cmf_regions` VALUES ('1077', '1074', '南召县', '4', '0', '0', '0', ',3268,998,1074,1077,');
INSERT INTO `cmf_regions` VALUES ('1078', '1074', '方城县', '4', '0', '0', '0', ',3268,998,1074,1078,');
INSERT INTO `cmf_regions` VALUES ('1079', '1074', '西峡县', '4', '0', '0', '0', ',3268,998,1074,1079,');
INSERT INTO `cmf_regions` VALUES ('1080', '1074', '镇平县', '4', '0', '0', '0', ',3268,998,1074,1080,');
INSERT INTO `cmf_regions` VALUES ('1081', '1074', '内乡县', '4', '0', '0', '0', ',3268,998,1074,1081,');
INSERT INTO `cmf_regions` VALUES ('1082', '1074', '淅川县', '4', '0', '0', '0', ',3268,998,1074,1082,');
INSERT INTO `cmf_regions` VALUES ('1083', '1074', '社旗县', '4', '0', '0', '0', ',3268,998,1074,1083,');
INSERT INTO `cmf_regions` VALUES ('1084', '1074', '唐河县', '4', '0', '0', '0', ',3268,998,1074,1084,');
INSERT INTO `cmf_regions` VALUES ('1085', '1074', '新野县', '4', '0', '0', '0', ',3268,998,1074,1085,');
INSERT INTO `cmf_regions` VALUES ('1086', '1074', '桐柏县', '4', '0', '0', '0', ',3268,998,1074,1086,');
INSERT INTO `cmf_regions` VALUES ('1087', '1074', '邓州市', '4', '0', '0', '0', ',3268,998,1074,1087,');
INSERT INTO `cmf_regions` VALUES ('1088', '998', '平顶山市', '3', '0', '0', '0', ',3268,998,1088,');
INSERT INTO `cmf_regions` VALUES ('1089', '1088', '新华区', '4', '0', '0', '0', ',3268,998,1088,1089,');
INSERT INTO `cmf_regions` VALUES ('1090', '1088', '卫东区', '4', '0', '0', '0', ',3268,998,1088,1090,');
INSERT INTO `cmf_regions` VALUES ('1091', '1088', '石龙区', '4', '0', '0', '0', ',3268,998,1088,1091,');
INSERT INTO `cmf_regions` VALUES ('1092', '1088', '湛河区', '4', '0', '0', '0', ',3268,998,1088,1092,');
INSERT INTO `cmf_regions` VALUES ('1093', '1088', '宝丰县', '4', '0', '0', '0', ',3268,998,1088,1093,');
INSERT INTO `cmf_regions` VALUES ('1094', '1088', '叶县', '4', '0', '0', '0', ',3268,998,1088,1094,');
INSERT INTO `cmf_regions` VALUES ('1095', '1088', '鲁山县', '4', '0', '0', '0', ',3268,998,1088,1095,');
INSERT INTO `cmf_regions` VALUES ('1096', '1088', '郏县', '4', '0', '0', '0', ',3268,998,1088,1096,');
INSERT INTO `cmf_regions` VALUES ('1097', '1088', '舞钢市', '4', '0', '0', '0', ',3268,998,1088,1097,');
INSERT INTO `cmf_regions` VALUES ('1098', '1088', '汝州市', '4', '0', '0', '0', ',3268,998,1088,1098,');
INSERT INTO `cmf_regions` VALUES ('1099', '998', '濮阳市', '3', '0', '0', '0', ',3268,998,1099,');
INSERT INTO `cmf_regions` VALUES ('1100', '1099', '华龙区', '4', '0', '0', '0', ',3268,998,1099,1100,');
INSERT INTO `cmf_regions` VALUES ('1101', '1099', '清丰县', '4', '0', '0', '0', ',3268,998,1099,1101,');
INSERT INTO `cmf_regions` VALUES ('1102', '1099', '南乐县', '4', '0', '0', '0', ',3268,998,1099,1102,');
INSERT INTO `cmf_regions` VALUES ('1103', '1099', '范县', '4', '0', '0', '0', ',3268,998,1099,1103,');
INSERT INTO `cmf_regions` VALUES ('1104', '1099', '台前县', '4', '0', '0', '0', ',3268,998,1099,1104,');
INSERT INTO `cmf_regions` VALUES ('1105', '1099', '濮阳县', '4', '0', '0', '0', ',3268,998,1099,1105,');
INSERT INTO `cmf_regions` VALUES ('1106', '998', '三门峡市', '3', '0', '0', '0', ',3268,998,1106,');
INSERT INTO `cmf_regions` VALUES ('1107', '1106', '湖滨区', '4', '0', '0', '0', ',3268,998,1106,1107,');
INSERT INTO `cmf_regions` VALUES ('1108', '1106', '渑池县', '4', '0', '0', '0', ',3268,998,1106,1108,');
INSERT INTO `cmf_regions` VALUES ('1109', '1106', '陕县', '4', '0', '0', '0', ',3268,998,1106,1109,');
INSERT INTO `cmf_regions` VALUES ('1110', '1106', '卢氏县', '4', '0', '0', '0', ',3268,998,1106,1110,');
INSERT INTO `cmf_regions` VALUES ('1111', '1106', '义马市', '4', '0', '0', '0', ',3268,998,1106,1111,');
INSERT INTO `cmf_regions` VALUES ('1112', '1106', '灵宝市', '4', '0', '0', '0', ',3268,998,1106,1112,');
INSERT INTO `cmf_regions` VALUES ('1113', '998', '商丘市', '3', '0', '0', '0', ',3268,998,1113,');
INSERT INTO `cmf_regions` VALUES ('1114', '1113', '梁园区', '4', '0', '0', '0', ',3268,998,1113,1114,');
INSERT INTO `cmf_regions` VALUES ('1115', '1113', '睢阳区', '4', '0', '0', '0', ',3268,998,1113,1115,');
INSERT INTO `cmf_regions` VALUES ('1116', '1113', '民权县', '4', '0', '0', '0', ',3268,998,1113,1116,');
INSERT INTO `cmf_regions` VALUES ('1117', '1113', '睢县', '4', '0', '0', '0', ',3268,998,1113,1117,');
INSERT INTO `cmf_regions` VALUES ('1118', '1113', '宁陵县', '4', '0', '0', '0', ',3268,998,1113,1118,');
INSERT INTO `cmf_regions` VALUES ('1119', '1113', '柘城县', '4', '0', '0', '0', ',3268,998,1113,1119,');
INSERT INTO `cmf_regions` VALUES ('1120', '1113', '虞城县', '4', '0', '0', '0', ',3268,998,1113,1120,');
INSERT INTO `cmf_regions` VALUES ('1121', '1113', '夏邑县', '4', '0', '0', '0', ',3268,998,1113,1121,');
INSERT INTO `cmf_regions` VALUES ('1122', '1113', '永城市', '4', '0', '0', '0', ',3268,998,1113,1122,');
INSERT INTO `cmf_regions` VALUES ('1123', '998', '新乡市', '3', '0', '0', '0', ',3268,998,1123,');
INSERT INTO `cmf_regions` VALUES ('1124', '1123', '红旗区', '4', '0', '0', '0', ',3268,998,1123,1124,');
INSERT INTO `cmf_regions` VALUES ('1125', '1123', '卫滨区', '4', '0', '0', '0', ',3268,998,1123,1125,');
INSERT INTO `cmf_regions` VALUES ('1126', '1123', '凤泉区', '4', '0', '0', '0', ',3268,998,1123,1126,');
INSERT INTO `cmf_regions` VALUES ('1127', '1123', '牧野区', '4', '0', '0', '0', ',3268,998,1123,1127,');
INSERT INTO `cmf_regions` VALUES ('1128', '1123', '新乡县', '4', '0', '0', '0', ',3268,998,1123,1128,');
INSERT INTO `cmf_regions` VALUES ('1129', '1123', '获嘉县', '4', '0', '0', '0', ',3268,998,1123,1129,');
INSERT INTO `cmf_regions` VALUES ('1130', '1123', '原阳县', '4', '0', '0', '0', ',3268,998,1123,1130,');
INSERT INTO `cmf_regions` VALUES ('1131', '1123', '延津县', '4', '0', '0', '0', ',3268,998,1123,1131,');
INSERT INTO `cmf_regions` VALUES ('1132', '1123', '封丘县', '4', '0', '0', '0', ',3268,998,1123,1132,');
INSERT INTO `cmf_regions` VALUES ('1133', '1123', '长垣县', '4', '0', '0', '0', ',3268,998,1123,1133,');
INSERT INTO `cmf_regions` VALUES ('1134', '1123', '卫辉市', '4', '0', '0', '0', ',3268,998,1123,1134,');
INSERT INTO `cmf_regions` VALUES ('1135', '1123', '辉县市', '4', '0', '0', '0', ',3268,998,1123,1135,');
INSERT INTO `cmf_regions` VALUES ('1136', '998', '信阳市', '3', '0', '0', '0', ',3268,998,1136,');
INSERT INTO `cmf_regions` VALUES ('1137', '1136', '师河区', '4', '0', '0', '0', ',3268,998,1136,1137,');
INSERT INTO `cmf_regions` VALUES ('1138', '1136', '平桥区', '4', '0', '0', '0', ',3268,998,1136,1138,');
INSERT INTO `cmf_regions` VALUES ('1139', '1136', '罗山县', '4', '0', '0', '0', ',3268,998,1136,1139,');
INSERT INTO `cmf_regions` VALUES ('1140', '1136', '光山县', '4', '0', '0', '0', ',3268,998,1136,1140,');
INSERT INTO `cmf_regions` VALUES ('1141', '1136', '新县', '4', '0', '0', '0', ',3268,998,1136,1141,');
INSERT INTO `cmf_regions` VALUES ('1142', '1136', '商城县', '4', '0', '0', '0', ',3268,998,1136,1142,');
INSERT INTO `cmf_regions` VALUES ('1143', '1136', '固始县', '4', '0', '0', '0', ',3268,998,1136,1143,');
INSERT INTO `cmf_regions` VALUES ('1144', '1136', '潢川县', '4', '0', '0', '0', ',3268,998,1136,1144,');
INSERT INTO `cmf_regions` VALUES ('1145', '1136', '淮滨县', '4', '0', '0', '0', ',3268,998,1136,1145,');
INSERT INTO `cmf_regions` VALUES ('1146', '1136', '息县', '4', '0', '0', '0', ',3268,998,1136,1146,');
INSERT INTO `cmf_regions` VALUES ('1147', '998', '许昌市', '3', '0', '0', '0', ',3268,998,1147,');
INSERT INTO `cmf_regions` VALUES ('1148', '1147', '魏都区', '4', '0', '0', '0', ',3268,998,1147,1148,');
INSERT INTO `cmf_regions` VALUES ('1149', '1147', '许昌县', '4', '0', '0', '0', ',3268,998,1147,1149,');
INSERT INTO `cmf_regions` VALUES ('1150', '1147', '鄢陵县', '4', '0', '0', '0', ',3268,998,1147,1150,');
INSERT INTO `cmf_regions` VALUES ('1151', '1147', '襄城县', '4', '0', '0', '0', ',3268,998,1147,1151,');
INSERT INTO `cmf_regions` VALUES ('1152', '1147', '禹州市', '4', '0', '0', '0', ',3268,998,1147,1152,');
INSERT INTO `cmf_regions` VALUES ('1153', '1147', '长葛市', '4', '0', '0', '0', ',3268,998,1147,1153,');
INSERT INTO `cmf_regions` VALUES ('1154', '998', '周口市', '3', '0', '0', '0', ',3268,998,1154,');
INSERT INTO `cmf_regions` VALUES ('1155', '1154', '川汇区', '4', '0', '0', '0', ',3268,998,1154,1155,');
INSERT INTO `cmf_regions` VALUES ('1156', '1154', '扶沟县', '4', '0', '0', '0', ',3268,998,1154,1156,');
INSERT INTO `cmf_regions` VALUES ('1157', '1154', '西华县', '4', '0', '0', '0', ',3268,998,1154,1157,');
INSERT INTO `cmf_regions` VALUES ('1158', '1154', '商水县', '4', '0', '0', '0', ',3268,998,1154,1158,');
INSERT INTO `cmf_regions` VALUES ('1159', '1154', '沈丘县', '4', '0', '0', '0', ',3268,998,1154,1159,');
INSERT INTO `cmf_regions` VALUES ('1160', '1154', '郸城县', '4', '0', '0', '0', ',3268,998,1154,1160,');
INSERT INTO `cmf_regions` VALUES ('1161', '1154', '淮阳县', '4', '0', '0', '0', ',3268,998,1154,1161,');
INSERT INTO `cmf_regions` VALUES ('1162', '1154', '太康县', '4', '0', '0', '0', ',3268,998,1154,1162,');
INSERT INTO `cmf_regions` VALUES ('1163', '1154', '鹿邑县', '4', '0', '0', '0', ',3268,998,1154,1163,');
INSERT INTO `cmf_regions` VALUES ('1164', '1154', '项城市', '4', '0', '0', '0', ',3268,998,1154,1164,');
INSERT INTO `cmf_regions` VALUES ('1165', '998', '驻马店市', '3', '0', '0', '0', ',3268,998,1165,');
INSERT INTO `cmf_regions` VALUES ('1166', '1165', '驿城区', '4', '0', '0', '0', ',3268,998,1165,1166,');
INSERT INTO `cmf_regions` VALUES ('1167', '1165', '西平县', '4', '0', '0', '0', ',3268,998,1165,1167,');
INSERT INTO `cmf_regions` VALUES ('1168', '1165', '上蔡县', '4', '0', '0', '0', ',3268,998,1165,1168,');
INSERT INTO `cmf_regions` VALUES ('1169', '1165', '平舆县', '4', '0', '0', '0', ',3268,998,1165,1169,');
INSERT INTO `cmf_regions` VALUES ('1170', '1165', '正阳县', '4', '0', '0', '0', ',3268,998,1165,1170,');
INSERT INTO `cmf_regions` VALUES ('1171', '1165', '确山县', '4', '0', '0', '0', ',3268,998,1165,1171,');
INSERT INTO `cmf_regions` VALUES ('1172', '1165', '泌阳县', '4', '0', '0', '0', ',3268,998,1165,1172,');
INSERT INTO `cmf_regions` VALUES ('1173', '1165', '汝南县', '4', '0', '0', '0', ',3268,998,1165,1173,');
INSERT INTO `cmf_regions` VALUES ('1174', '1165', '遂平县', '4', '0', '0', '0', ',3268,998,1165,1174,');
INSERT INTO `cmf_regions` VALUES ('1175', '1165', '新蔡县', '4', '0', '0', '0', ',3268,998,1165,1175,');
INSERT INTO `cmf_regions` VALUES ('1176', '3268', '黑龙江', '2', '0', '0', '0', ',3268,1176,');
INSERT INTO `cmf_regions` VALUES ('1177', '1176', '哈尔滨市', '3', '0', '0', '0', ',3268,1176,1177,');
INSERT INTO `cmf_regions` VALUES ('1178', '1177', '道里区', '4', '0', '0', '0', ',3268,1176,1177,1178,');
INSERT INTO `cmf_regions` VALUES ('1179', '1177', '南岗区', '4', '0', '0', '0', ',3268,1176,1177,1179,');
INSERT INTO `cmf_regions` VALUES ('1180', '1177', '道外区', '4', '0', '0', '0', ',3268,1176,1177,1180,');
INSERT INTO `cmf_regions` VALUES ('1181', '1177', '香坊区', '4', '0', '0', '0', ',3268,1176,1177,1181,');
INSERT INTO `cmf_regions` VALUES ('1182', '1177', '动力区', '4', '0', '0', '0', ',3268,1176,1177,1182,');
INSERT INTO `cmf_regions` VALUES ('1183', '1177', '平房区', '4', '0', '0', '0', ',3268,1176,1177,1183,');
INSERT INTO `cmf_regions` VALUES ('1184', '1177', '松北区', '4', '0', '0', '0', ',3268,1176,1177,1184,');
INSERT INTO `cmf_regions` VALUES ('1185', '1177', '呼兰区', '4', '0', '0', '0', ',3268,1176,1177,1185,');
INSERT INTO `cmf_regions` VALUES ('1186', '1177', '依兰县', '4', '0', '0', '0', ',3268,1176,1177,1186,');
INSERT INTO `cmf_regions` VALUES ('1187', '1177', '方正县', '4', '0', '0', '0', ',3268,1176,1177,1187,');
INSERT INTO `cmf_regions` VALUES ('1188', '1177', '宾县', '4', '0', '0', '0', ',3268,1176,1177,1188,');
INSERT INTO `cmf_regions` VALUES ('1189', '1177', '巴彦县', '4', '0', '0', '0', ',3268,1176,1177,1189,');
INSERT INTO `cmf_regions` VALUES ('1190', '1177', '木兰县', '4', '0', '0', '0', ',3268,1176,1177,1190,');
INSERT INTO `cmf_regions` VALUES ('1191', '1177', '通河县', '4', '0', '0', '0', ',3268,1176,1177,1191,');
INSERT INTO `cmf_regions` VALUES ('1192', '1177', '延寿县', '4', '0', '0', '0', ',3268,1176,1177,1192,');
INSERT INTO `cmf_regions` VALUES ('1193', '1177', '阿城市', '4', '0', '0', '0', ',3268,1176,1177,1193,');
INSERT INTO `cmf_regions` VALUES ('1194', '1177', '双城市', '4', '0', '0', '0', ',3268,1176,1177,1194,');
INSERT INTO `cmf_regions` VALUES ('1195', '1177', '尚志市', '4', '0', '0', '0', ',3268,1176,1177,1195,');
INSERT INTO `cmf_regions` VALUES ('1196', '1177', '五常市', '4', '0', '0', '0', ',3268,1176,1177,1196,');
INSERT INTO `cmf_regions` VALUES ('1197', '1176', '大庆市', '3', '0', '0', '0', ',3268,1176,1197,');
INSERT INTO `cmf_regions` VALUES ('1198', '1197', '萨尔图区', '4', '0', '0', '0', ',3268,1176,1197,1198,');
INSERT INTO `cmf_regions` VALUES ('1199', '1197', '龙凤区', '4', '0', '0', '0', ',3268,1176,1197,1199,');
INSERT INTO `cmf_regions` VALUES ('1200', '1197', '让胡路区', '4', '0', '0', '0', ',3268,1176,1197,1200,');
INSERT INTO `cmf_regions` VALUES ('1201', '1197', '红岗区', '4', '0', '0', '0', ',3268,1176,1197,1201,');
INSERT INTO `cmf_regions` VALUES ('1202', '1197', '大同区', '4', '0', '0', '0', ',3268,1176,1197,1202,');
INSERT INTO `cmf_regions` VALUES ('1203', '1197', '肇州县', '4', '0', '0', '0', ',3268,1176,1197,1203,');
INSERT INTO `cmf_regions` VALUES ('1204', '1197', '肇源县', '4', '0', '0', '0', ',3268,1176,1197,1204,');
INSERT INTO `cmf_regions` VALUES ('1205', '1197', '林甸县', '4', '0', '0', '0', ',3268,1176,1197,1205,');
INSERT INTO `cmf_regions` VALUES ('1206', '1197', '杜尔伯特蒙古族自治县', '4', '0', '0', '0', ',3268,1176,1197,1206,');
INSERT INTO `cmf_regions` VALUES ('1207', '1176', '大兴安岭地区', '3', '0', '0', '0', ',3268,1176,1207,');
INSERT INTO `cmf_regions` VALUES ('1208', '1207', '呼玛县', '4', '0', '0', '0', ',3268,1176,1207,1208,');
INSERT INTO `cmf_regions` VALUES ('1209', '1207', '塔河县', '4', '0', '0', '0', ',3268,1176,1207,1209,');
INSERT INTO `cmf_regions` VALUES ('1210', '1207', '漠河县', '4', '0', '0', '0', ',3268,1176,1207,1210,');
INSERT INTO `cmf_regions` VALUES ('1211', '1176', '鹤岗市', '3', '0', '0', '0', ',3268,1176,1211,');
INSERT INTO `cmf_regions` VALUES ('1212', '1211', '向阳区', '4', '0', '0', '0', ',3268,1176,1211,1212,');
INSERT INTO `cmf_regions` VALUES ('1213', '1211', '工农区', '4', '0', '0', '0', ',3268,1176,1211,1213,');
INSERT INTO `cmf_regions` VALUES ('1214', '1211', '南山区', '4', '0', '0', '0', ',3268,1176,1211,1214,');
INSERT INTO `cmf_regions` VALUES ('1215', '1211', '兴安区', '4', '0', '0', '0', ',3268,1176,1211,1215,');
INSERT INTO `cmf_regions` VALUES ('1216', '1211', '东山区', '4', '0', '0', '0', ',3268,1176,1211,1216,');
INSERT INTO `cmf_regions` VALUES ('1217', '1211', '兴山区', '4', '0', '0', '0', ',3268,1176,1211,1217,');
INSERT INTO `cmf_regions` VALUES ('1218', '1211', '萝北县', '4', '0', '0', '0', ',3268,1176,1211,1218,');
INSERT INTO `cmf_regions` VALUES ('1219', '1211', '绥滨县', '4', '0', '0', '0', ',3268,1176,1211,1219,');
INSERT INTO `cmf_regions` VALUES ('1220', '1176', '黑河市', '3', '0', '0', '0', ',3268,1176,1220,');
INSERT INTO `cmf_regions` VALUES ('1221', '1220', '爱辉区', '4', '0', '0', '0', ',3268,1176,1220,1221,');
INSERT INTO `cmf_regions` VALUES ('1222', '1220', '嫩江县', '4', '0', '0', '0', ',3268,1176,1220,1222,');
INSERT INTO `cmf_regions` VALUES ('1223', '1220', '逊克县', '4', '0', '0', '0', ',3268,1176,1220,1223,');
INSERT INTO `cmf_regions` VALUES ('1224', '1220', '孙吴县', '4', '0', '0', '0', ',3268,1176,1220,1224,');
INSERT INTO `cmf_regions` VALUES ('1225', '1220', '北安市', '4', '0', '0', '0', ',3268,1176,1220,1225,');
INSERT INTO `cmf_regions` VALUES ('1226', '1220', '五大连池市', '4', '0', '0', '0', ',3268,1176,1220,1226,');
INSERT INTO `cmf_regions` VALUES ('1227', '1176', '鸡西市', '3', '0', '0', '0', ',3268,1176,1227,');
INSERT INTO `cmf_regions` VALUES ('1228', '1227', '鸡冠区', '4', '0', '0', '0', ',3268,1176,1227,1228,');
INSERT INTO `cmf_regions` VALUES ('1229', '1227', '恒山区', '4', '0', '0', '0', ',3268,1176,1227,1229,');
INSERT INTO `cmf_regions` VALUES ('1230', '1227', '滴道区', '4', '0', '0', '0', ',3268,1176,1227,1230,');
INSERT INTO `cmf_regions` VALUES ('1231', '1227', '梨树区', '4', '0', '0', '0', ',3268,1176,1227,1231,');
INSERT INTO `cmf_regions` VALUES ('1232', '1227', '城子河区', '4', '0', '0', '0', ',3268,1176,1227,1232,');
INSERT INTO `cmf_regions` VALUES ('1233', '1227', '麻山区', '4', '0', '0', '0', ',3268,1176,1227,1233,');
INSERT INTO `cmf_regions` VALUES ('1234', '1227', '鸡东县', '4', '0', '0', '0', ',3268,1176,1227,1234,');
INSERT INTO `cmf_regions` VALUES ('1235', '1227', '虎林市', '4', '0', '0', '0', ',3268,1176,1227,1235,');
INSERT INTO `cmf_regions` VALUES ('1236', '1227', '密山市', '4', '0', '0', '0', ',3268,1176,1227,1236,');
INSERT INTO `cmf_regions` VALUES ('1237', '1176', '佳木斯市', '3', '0', '0', '0', ',3268,1176,1237,');
INSERT INTO `cmf_regions` VALUES ('1238', '1237', '永红区', '4', '0', '0', '0', ',3268,1176,1237,1238,');
INSERT INTO `cmf_regions` VALUES ('1239', '1237', '向阳区', '4', '0', '0', '0', ',3268,1176,1237,1239,');
INSERT INTO `cmf_regions` VALUES ('1240', '1237', '前进区', '4', '0', '0', '0', ',3268,1176,1237,1240,');
INSERT INTO `cmf_regions` VALUES ('1241', '1237', '东风区', '4', '0', '0', '0', ',3268,1176,1237,1241,');
INSERT INTO `cmf_regions` VALUES ('1242', '1237', '郊区', '4', '0', '0', '0', ',3268,1176,1237,1242,');
INSERT INTO `cmf_regions` VALUES ('1243', '1237', '桦南县', '4', '0', '0', '0', ',3268,1176,1237,1243,');
INSERT INTO `cmf_regions` VALUES ('1244', '1237', '桦川县', '4', '0', '0', '0', ',3268,1176,1237,1244,');
INSERT INTO `cmf_regions` VALUES ('1245', '1237', '汤原县', '4', '0', '0', '0', ',3268,1176,1237,1245,');
INSERT INTO `cmf_regions` VALUES ('1246', '1237', '抚远县', '4', '0', '0', '0', ',3268,1176,1237,1246,');
INSERT INTO `cmf_regions` VALUES ('1247', '1237', '同江市', '4', '0', '0', '0', ',3268,1176,1237,1247,');
INSERT INTO `cmf_regions` VALUES ('1248', '1237', '富锦市', '4', '0', '0', '0', ',3268,1176,1237,1248,');
INSERT INTO `cmf_regions` VALUES ('1249', '1176', '牡丹江市', '3', '0', '0', '0', ',3268,1176,1249,');
INSERT INTO `cmf_regions` VALUES ('1250', '1249', '东安区', '4', '0', '0', '0', ',3268,1176,1249,1250,');
INSERT INTO `cmf_regions` VALUES ('1251', '1249', '阳明区', '4', '0', '0', '0', ',3268,1176,1249,1251,');
INSERT INTO `cmf_regions` VALUES ('1252', '1249', '爱民区', '4', '0', '0', '0', ',3268,1176,1249,1252,');
INSERT INTO `cmf_regions` VALUES ('1253', '1249', '西安区', '4', '0', '0', '0', ',3268,1176,1249,1253,');
INSERT INTO `cmf_regions` VALUES ('1254', '1249', '东宁县', '4', '0', '0', '0', ',3268,1176,1249,1254,');
INSERT INTO `cmf_regions` VALUES ('1255', '1249', '林口县', '4', '0', '0', '0', ',3268,1176,1249,1255,');
INSERT INTO `cmf_regions` VALUES ('1256', '1249', '绥芬河市', '4', '0', '0', '0', ',3268,1176,1249,1256,');
INSERT INTO `cmf_regions` VALUES ('1257', '1249', '海林市', '4', '0', '0', '0', ',3268,1176,1249,1257,');
INSERT INTO `cmf_regions` VALUES ('1258', '1249', '宁安市', '4', '0', '0', '0', ',3268,1176,1249,1258,');
INSERT INTO `cmf_regions` VALUES ('1259', '1249', '穆棱市', '4', '0', '0', '0', ',3268,1176,1249,1259,');
INSERT INTO `cmf_regions` VALUES ('1260', '1176', '七台河市', '3', '0', '0', '0', ',3268,1176,1260,');
INSERT INTO `cmf_regions` VALUES ('1261', '1260', '新兴区', '4', '0', '0', '0', ',3268,1176,1260,1261,');
INSERT INTO `cmf_regions` VALUES ('1262', '1260', '桃山区', '4', '0', '0', '0', ',3268,1176,1260,1262,');
INSERT INTO `cmf_regions` VALUES ('1263', '1260', '茄子河区', '4', '0', '0', '0', ',3268,1176,1260,1263,');
INSERT INTO `cmf_regions` VALUES ('1264', '1260', '勃利县', '4', '0', '0', '0', ',3268,1176,1260,1264,');
INSERT INTO `cmf_regions` VALUES ('1265', '1176', '齐齐哈尔市', '3', '0', '0', '0', ',3268,1176,1265,');
INSERT INTO `cmf_regions` VALUES ('1266', '1265', '龙沙区', '4', '0', '0', '0', ',3268,1176,1265,1266,');
INSERT INTO `cmf_regions` VALUES ('1267', '1265', '建华区', '4', '0', '0', '0', ',3268,1176,1265,1267,');
INSERT INTO `cmf_regions` VALUES ('1268', '1265', '铁锋区', '4', '0', '0', '0', ',3268,1176,1265,1268,');
INSERT INTO `cmf_regions` VALUES ('1269', '1265', '昂昂溪区', '4', '0', '0', '0', ',3268,1176,1265,1269,');
INSERT INTO `cmf_regions` VALUES ('1270', '1265', '富拉尔基区', '4', '0', '0', '0', ',3268,1176,1265,1270,');
INSERT INTO `cmf_regions` VALUES ('1271', '1265', '碾子山区', '4', '0', '0', '0', ',3268,1176,1265,1271,');
INSERT INTO `cmf_regions` VALUES ('1272', '1265', '梅里斯达斡尔族区', '4', '0', '0', '0', ',3268,1176,1265,1272,');
INSERT INTO `cmf_regions` VALUES ('1273', '1265', '龙江县', '4', '0', '0', '0', ',3268,1176,1265,1273,');
INSERT INTO `cmf_regions` VALUES ('1274', '1265', '依安县', '4', '0', '0', '0', ',3268,1176,1265,1274,');
INSERT INTO `cmf_regions` VALUES ('1275', '1265', '泰来县', '4', '0', '0', '0', ',3268,1176,1265,1275,');
INSERT INTO `cmf_regions` VALUES ('1276', '1265', '甘南县', '4', '0', '0', '0', ',3268,1176,1265,1276,');
INSERT INTO `cmf_regions` VALUES ('1277', '1265', '富裕县', '4', '0', '0', '0', ',3268,1176,1265,1277,');
INSERT INTO `cmf_regions` VALUES ('1278', '1265', '克山县', '4', '0', '0', '0', ',3268,1176,1265,1278,');
INSERT INTO `cmf_regions` VALUES ('1279', '1265', '克东县', '4', '0', '0', '0', ',3268,1176,1265,1279,');
INSERT INTO `cmf_regions` VALUES ('1280', '1265', '拜泉县', '4', '0', '0', '0', ',3268,1176,1265,1280,');
INSERT INTO `cmf_regions` VALUES ('1281', '1265', '讷河市', '4', '0', '0', '0', ',3268,1176,1265,1281,');
INSERT INTO `cmf_regions` VALUES ('1282', '1176', '双鸭山市', '3', '0', '0', '0', ',3268,1176,1282,');
INSERT INTO `cmf_regions` VALUES ('1283', '1282', '尖山区', '4', '0', '0', '0', ',3268,1176,1282,1283,');
INSERT INTO `cmf_regions` VALUES ('1284', '1282', '岭东区', '4', '0', '0', '0', ',3268,1176,1282,1284,');
INSERT INTO `cmf_regions` VALUES ('1285', '1282', '四方台区', '4', '0', '0', '0', ',3268,1176,1282,1285,');
INSERT INTO `cmf_regions` VALUES ('1286', '1282', '宝山区', '4', '0', '0', '0', ',3268,1176,1282,1286,');
INSERT INTO `cmf_regions` VALUES ('1287', '1282', '集贤县', '4', '0', '0', '0', ',3268,1176,1282,1287,');
INSERT INTO `cmf_regions` VALUES ('1288', '1282', '友谊县', '4', '0', '0', '0', ',3268,1176,1282,1288,');
INSERT INTO `cmf_regions` VALUES ('1289', '1282', '宝清县', '4', '0', '0', '0', ',3268,1176,1282,1289,');
INSERT INTO `cmf_regions` VALUES ('1290', '1282', '饶河县', '4', '0', '0', '0', ',3268,1176,1282,1290,');
INSERT INTO `cmf_regions` VALUES ('1291', '1176', '绥化市', '3', '0', '0', '0', ',3268,1176,1291,');
INSERT INTO `cmf_regions` VALUES ('1292', '1291', '北林区', '4', '0', '0', '0', ',3268,1176,1291,1292,');
INSERT INTO `cmf_regions` VALUES ('1293', '1291', '望奎县', '4', '0', '0', '0', ',3268,1176,1291,1293,');
INSERT INTO `cmf_regions` VALUES ('1294', '1291', '兰西县', '4', '0', '0', '0', ',3268,1176,1291,1294,');
INSERT INTO `cmf_regions` VALUES ('1295', '1291', '青冈县', '4', '0', '0', '0', ',3268,1176,1291,1295,');
INSERT INTO `cmf_regions` VALUES ('1296', '1291', '庆安县', '4', '0', '0', '0', ',3268,1176,1291,1296,');
INSERT INTO `cmf_regions` VALUES ('1297', '1291', '明水县', '4', '0', '0', '0', ',3268,1176,1291,1297,');
INSERT INTO `cmf_regions` VALUES ('1298', '1291', '绥棱县', '4', '0', '0', '0', ',3268,1176,1291,1298,');
INSERT INTO `cmf_regions` VALUES ('1299', '1291', '安达市', '4', '0', '0', '0', ',3268,1176,1291,1299,');
INSERT INTO `cmf_regions` VALUES ('1300', '1291', '肇东市', '4', '0', '0', '0', ',3268,1176,1291,1300,');
INSERT INTO `cmf_regions` VALUES ('1301', '1291', '海伦市', '4', '0', '0', '0', ',3268,1176,1291,1301,');
INSERT INTO `cmf_regions` VALUES ('1302', '1176', '伊春市', '3', '0', '0', '0', ',3268,1176,1302,');
INSERT INTO `cmf_regions` VALUES ('1303', '1302', '伊春区', '4', '0', '0', '0', ',3268,1176,1302,1303,');
INSERT INTO `cmf_regions` VALUES ('1304', '1302', '南岔区', '4', '0', '0', '0', ',3268,1176,1302,1304,');
INSERT INTO `cmf_regions` VALUES ('1305', '1302', '友好区', '4', '0', '0', '0', ',3268,1176,1302,1305,');
INSERT INTO `cmf_regions` VALUES ('1306', '1302', '西林区', '4', '0', '0', '0', ',3268,1176,1302,1306,');
INSERT INTO `cmf_regions` VALUES ('1307', '1302', '翠峦区', '4', '0', '0', '0', ',3268,1176,1302,1307,');
INSERT INTO `cmf_regions` VALUES ('1308', '1302', '新青区', '4', '0', '0', '0', ',3268,1176,1302,1308,');
INSERT INTO `cmf_regions` VALUES ('1309', '1302', '美溪区', '4', '0', '0', '0', ',3268,1176,1302,1309,');
INSERT INTO `cmf_regions` VALUES ('1310', '1302', '金山屯区', '4', '0', '0', '0', ',3268,1176,1302,1310,');
INSERT INTO `cmf_regions` VALUES ('1311', '1302', '五营区', '4', '0', '0', '0', ',3268,1176,1302,1311,');
INSERT INTO `cmf_regions` VALUES ('1312', '1302', '乌马河区', '4', '0', '0', '0', ',3268,1176,1302,1312,');
INSERT INTO `cmf_regions` VALUES ('1313', '1302', '汤旺河区', '4', '0', '0', '0', ',3268,1176,1302,1313,');
INSERT INTO `cmf_regions` VALUES ('1314', '1302', '带岭区', '4', '0', '0', '0', ',3268,1176,1302,1314,');
INSERT INTO `cmf_regions` VALUES ('1315', '1302', '乌伊岭区', '4', '0', '0', '0', ',3268,1176,1302,1315,');
INSERT INTO `cmf_regions` VALUES ('1316', '1302', '红星区', '4', '0', '0', '0', ',3268,1176,1302,1316,');
INSERT INTO `cmf_regions` VALUES ('1317', '1302', '上甘岭区', '4', '0', '0', '0', ',3268,1176,1302,1317,');
INSERT INTO `cmf_regions` VALUES ('1318', '1302', '嘉荫县', '4', '0', '0', '0', ',3268,1176,1302,1318,');
INSERT INTO `cmf_regions` VALUES ('1319', '1302', '铁力市', '4', '0', '0', '0', ',3268,1176,1302,1319,');
INSERT INTO `cmf_regions` VALUES ('1320', '3268', '湖北', '2', '0', '0', '0', ',3268,1320,');
INSERT INTO `cmf_regions` VALUES ('1321', '1320', '武汉市', '3', '0', '0', '0', ',3268,1320,1321,');
INSERT INTO `cmf_regions` VALUES ('1322', '1321', '江岸区', '4', '0', '0', '0', ',3268,1320,1321,1322,');
INSERT INTO `cmf_regions` VALUES ('1323', '1321', '江汉区', '4', '0', '0', '0', ',3268,1320,1321,1323,');
INSERT INTO `cmf_regions` VALUES ('1324', '1321', '乔口区', '4', '0', '0', '0', ',3268,1320,1321,1324,');
INSERT INTO `cmf_regions` VALUES ('1325', '1321', '汉阳区', '4', '0', '0', '0', ',3268,1320,1321,1325,');
INSERT INTO `cmf_regions` VALUES ('1326', '1321', '武昌区', '4', '0', '0', '0', ',3268,1320,1321,1326,');
INSERT INTO `cmf_regions` VALUES ('1327', '1321', '青山区', '4', '0', '0', '0', ',3268,1320,1321,1327,');
INSERT INTO `cmf_regions` VALUES ('1328', '1321', '洪山区', '4', '0', '0', '0', ',3268,1320,1321,1328,');
INSERT INTO `cmf_regions` VALUES ('1329', '1321', '东西湖区', '4', '0', '0', '0', ',3268,1320,1321,1329,');
INSERT INTO `cmf_regions` VALUES ('1330', '1321', '汉南区', '4', '0', '0', '0', ',3268,1320,1321,1330,');
INSERT INTO `cmf_regions` VALUES ('1331', '1321', '蔡甸区', '4', '0', '0', '0', ',3268,1320,1321,1331,');
INSERT INTO `cmf_regions` VALUES ('1332', '1321', '江夏区', '4', '0', '0', '0', ',3268,1320,1321,1332,');
INSERT INTO `cmf_regions` VALUES ('1333', '1321', '黄陂区', '4', '0', '0', '0', ',3268,1320,1321,1333,');
INSERT INTO `cmf_regions` VALUES ('1334', '1321', '新洲区', '4', '0', '0', '0', ',3268,1320,1321,1334,');
INSERT INTO `cmf_regions` VALUES ('1335', '1320', '鄂州市', '3', '0', '0', '0', ',3268,1320,1335,');
INSERT INTO `cmf_regions` VALUES ('1336', '1335', '梁子湖区', '4', '0', '0', '0', ',3268,1320,1335,1336,');
INSERT INTO `cmf_regions` VALUES ('1337', '1335', '华容区', '4', '0', '0', '0', ',3268,1320,1335,1337,');
INSERT INTO `cmf_regions` VALUES ('1338', '1335', '鄂城区', '4', '0', '0', '0', ',3268,1320,1335,1338,');
INSERT INTO `cmf_regions` VALUES ('1339', '1320', '恩施土家族苗族自治州', '3', '0', '0', '0', ',3268,1320,1339,');
INSERT INTO `cmf_regions` VALUES ('1340', '1339', '恩施市', '4', '0', '0', '0', ',3268,1320,1339,1340,');
INSERT INTO `cmf_regions` VALUES ('1341', '1339', '利川市', '4', '0', '0', '0', ',3268,1320,1339,1341,');
INSERT INTO `cmf_regions` VALUES ('1342', '1339', '建始县', '4', '0', '0', '0', ',3268,1320,1339,1342,');
INSERT INTO `cmf_regions` VALUES ('1343', '1339', '巴东县', '4', '0', '0', '0', ',3268,1320,1339,1343,');
INSERT INTO `cmf_regions` VALUES ('1344', '1339', '宣恩县', '4', '0', '0', '0', ',3268,1320,1339,1344,');
INSERT INTO `cmf_regions` VALUES ('1345', '1339', '咸丰县', '4', '0', '0', '0', ',3268,1320,1339,1345,');
INSERT INTO `cmf_regions` VALUES ('1346', '1339', '来凤县', '4', '0', '0', '0', ',3268,1320,1339,1346,');
INSERT INTO `cmf_regions` VALUES ('1347', '1339', '鹤峰县', '4', '0', '0', '0', ',3268,1320,1339,1347,');
INSERT INTO `cmf_regions` VALUES ('1348', '1320', '黄冈市', '3', '0', '0', '0', ',3268,1320,1348,');
INSERT INTO `cmf_regions` VALUES ('1349', '1348', '黄州区', '4', '0', '0', '0', ',3268,1320,1348,1349,');
INSERT INTO `cmf_regions` VALUES ('1350', '1348', '团风县', '4', '0', '0', '0', ',3268,1320,1348,1350,');
INSERT INTO `cmf_regions` VALUES ('1351', '1348', '红安县', '4', '0', '0', '0', ',3268,1320,1348,1351,');
INSERT INTO `cmf_regions` VALUES ('1352', '1348', '罗田县', '4', '0', '0', '0', ',3268,1320,1348,1352,');
INSERT INTO `cmf_regions` VALUES ('1353', '1348', '英山县', '4', '0', '0', '0', ',3268,1320,1348,1353,');
INSERT INTO `cmf_regions` VALUES ('1354', '1348', '浠水县', '4', '0', '0', '0', ',3268,1320,1348,1354,');
INSERT INTO `cmf_regions` VALUES ('1355', '1348', '蕲春县', '4', '0', '0', '0', ',3268,1320,1348,1355,');
INSERT INTO `cmf_regions` VALUES ('1356', '1348', '黄梅县', '4', '0', '0', '0', ',3268,1320,1348,1356,');
INSERT INTO `cmf_regions` VALUES ('1357', '1348', '麻城市', '4', '0', '0', '0', ',3268,1320,1348,1357,');
INSERT INTO `cmf_regions` VALUES ('1358', '1348', '武穴市', '4', '0', '0', '0', ',3268,1320,1348,1358,');
INSERT INTO `cmf_regions` VALUES ('1359', '1320', '黄石市', '3', '0', '0', '0', ',3268,1320,1359,');
INSERT INTO `cmf_regions` VALUES ('1360', '1359', '黄石港区', '4', '0', '0', '0', ',3268,1320,1359,1360,');
INSERT INTO `cmf_regions` VALUES ('1361', '1359', '西塞山区', '4', '0', '0', '0', ',3268,1320,1359,1361,');
INSERT INTO `cmf_regions` VALUES ('1362', '1359', '下陆区', '4', '0', '0', '0', ',3268,1320,1359,1362,');
INSERT INTO `cmf_regions` VALUES ('1363', '1359', '铁山区', '4', '0', '0', '0', ',3268,1320,1359,1363,');
INSERT INTO `cmf_regions` VALUES ('1364', '1359', '阳新县', '4', '0', '0', '0', ',3268,1320,1359,1364,');
INSERT INTO `cmf_regions` VALUES ('1365', '1359', '大冶市', '4', '0', '0', '0', ',3268,1320,1359,1365,');
INSERT INTO `cmf_regions` VALUES ('1366', '1320', '荆门市', '3', '0', '0', '0', ',3268,1320,1366,');
INSERT INTO `cmf_regions` VALUES ('1367', '1366', '东宝区', '4', '0', '0', '0', ',3268,1320,1366,1367,');
INSERT INTO `cmf_regions` VALUES ('1368', '1366', '掇刀区', '4', '0', '0', '0', ',3268,1320,1366,1368,');
INSERT INTO `cmf_regions` VALUES ('1369', '1366', '京山县', '4', '0', '0', '0', ',3268,1320,1366,1369,');
INSERT INTO `cmf_regions` VALUES ('1370', '1366', '沙洋县', '4', '0', '0', '0', ',3268,1320,1366,1370,');
INSERT INTO `cmf_regions` VALUES ('1371', '1366', '钟祥市', '4', '0', '0', '0', ',3268,1320,1366,1371,');
INSERT INTO `cmf_regions` VALUES ('1372', '1320', '荆州市', '3', '0', '0', '0', ',3268,1320,1372,');
INSERT INTO `cmf_regions` VALUES ('1373', '1372', '沙市区', '4', '0', '0', '0', ',3268,1320,1372,1373,');
INSERT INTO `cmf_regions` VALUES ('1374', '1372', '荆州区', '4', '0', '0', '0', ',3268,1320,1372,1374,');
INSERT INTO `cmf_regions` VALUES ('1375', '1372', '公安县', '4', '0', '0', '0', ',3268,1320,1372,1375,');
INSERT INTO `cmf_regions` VALUES ('1376', '1372', '监利县', '4', '0', '0', '0', ',3268,1320,1372,1376,');
INSERT INTO `cmf_regions` VALUES ('1377', '1372', '江陵县', '4', '0', '0', '0', ',3268,1320,1372,1377,');
INSERT INTO `cmf_regions` VALUES ('1378', '1372', '石首市', '4', '0', '0', '0', ',3268,1320,1372,1378,');
INSERT INTO `cmf_regions` VALUES ('1379', '1372', '洪湖市', '4', '0', '0', '0', ',3268,1320,1372,1379,');
INSERT INTO `cmf_regions` VALUES ('1380', '1372', '松滋市', '4', '0', '0', '0', ',3268,1320,1372,1380,');
INSERT INTO `cmf_regions` VALUES ('1381', '1320', '潜江市', '3', '0', '0', '0', ',3268,1320,1381,');
INSERT INTO `cmf_regions` VALUES ('1382', '1320', '神农架林区', '3', '0', '0', '0', ',3268,1320,1382,');
INSERT INTO `cmf_regions` VALUES ('1383', '1320', '十堰市', '3', '0', '0', '0', ',3268,1320,1383,');
INSERT INTO `cmf_regions` VALUES ('1384', '1383', '茅箭区', '4', '0', '0', '0', ',3268,1320,1383,1384,');
INSERT INTO `cmf_regions` VALUES ('1385', '1383', '张湾区', '4', '0', '0', '0', ',3268,1320,1383,1385,');
INSERT INTO `cmf_regions` VALUES ('1386', '1383', '郧县', '4', '0', '0', '0', ',3268,1320,1383,1386,');
INSERT INTO `cmf_regions` VALUES ('1387', '1383', '郧西县', '4', '0', '0', '0', ',3268,1320,1383,1387,');
INSERT INTO `cmf_regions` VALUES ('1388', '1383', '竹山县', '4', '0', '0', '0', ',3268,1320,1383,1388,');
INSERT INTO `cmf_regions` VALUES ('1389', '1383', '竹溪县', '4', '0', '0', '0', ',3268,1320,1383,1389,');
INSERT INTO `cmf_regions` VALUES ('1390', '1383', '房县', '4', '0', '0', '0', ',3268,1320,1383,1390,');
INSERT INTO `cmf_regions` VALUES ('1391', '1383', '丹江口市', '4', '0', '0', '0', ',3268,1320,1383,1391,');
INSERT INTO `cmf_regions` VALUES ('1392', '1320', '随州市', '3', '0', '0', '0', ',3268,1320,1392,');
INSERT INTO `cmf_regions` VALUES ('1393', '1392', '曾都区', '4', '0', '0', '0', ',3268,1320,1392,1393,');
INSERT INTO `cmf_regions` VALUES ('1394', '1392', '广水市', '4', '0', '0', '0', ',3268,1320,1392,1394,');
INSERT INTO `cmf_regions` VALUES ('1395', '1320', '天门市', '3', '0', '0', '0', ',3268,1320,1395,');
INSERT INTO `cmf_regions` VALUES ('1396', '1320', '仙桃市', '3', '0', '0', '0', ',3268,1320,1396,');
INSERT INTO `cmf_regions` VALUES ('1397', '1320', '咸宁市', '3', '0', '0', '0', ',3268,1320,1397,');
INSERT INTO `cmf_regions` VALUES ('1398', '1397', '咸安区', '4', '0', '0', '0', ',3268,1320,1397,1398,');
INSERT INTO `cmf_regions` VALUES ('1399', '1397', '嘉鱼县', '4', '0', '0', '0', ',3268,1320,1397,1399,');
INSERT INTO `cmf_regions` VALUES ('1400', '1397', '通城县', '4', '0', '0', '0', ',3268,1320,1397,1400,');
INSERT INTO `cmf_regions` VALUES ('1401', '1397', '崇阳县', '4', '0', '0', '0', ',3268,1320,1397,1401,');
INSERT INTO `cmf_regions` VALUES ('1402', '1397', '通山县', '4', '0', '0', '0', ',3268,1320,1397,1402,');
INSERT INTO `cmf_regions` VALUES ('1403', '1397', '赤壁市', '4', '0', '0', '0', ',3268,1320,1397,1403,');
INSERT INTO `cmf_regions` VALUES ('1404', '1320', '襄樊市', '3', '0', '0', '0', ',3268,1320,1404,');
INSERT INTO `cmf_regions` VALUES ('1405', '1404', '襄城区', '4', '0', '0', '0', ',3268,1320,1404,1405,');
INSERT INTO `cmf_regions` VALUES ('1406', '1404', '樊城区', '4', '0', '0', '0', ',3268,1320,1404,1406,');
INSERT INTO `cmf_regions` VALUES ('1407', '1404', '襄阳区', '4', '0', '0', '0', ',3268,1320,1404,1407,');
INSERT INTO `cmf_regions` VALUES ('1408', '1404', '南漳县', '4', '0', '0', '0', ',3268,1320,1404,1408,');
INSERT INTO `cmf_regions` VALUES ('1409', '1404', '谷城县', '4', '0', '0', '0', ',3268,1320,1404,1409,');
INSERT INTO `cmf_regions` VALUES ('1410', '1404', '保康县', '4', '0', '0', '0', ',3268,1320,1404,1410,');
INSERT INTO `cmf_regions` VALUES ('1411', '1404', '老河口市', '4', '0', '0', '0', ',3268,1320,1404,1411,');
INSERT INTO `cmf_regions` VALUES ('1412', '1404', '枣阳市', '4', '0', '0', '0', ',3268,1320,1404,1412,');
INSERT INTO `cmf_regions` VALUES ('1413', '1404', '宜城市', '4', '0', '0', '0', ',3268,1320,1404,1413,');
INSERT INTO `cmf_regions` VALUES ('1414', '1320', '孝感市', '3', '0', '0', '0', ',3268,1320,1414,');
INSERT INTO `cmf_regions` VALUES ('1415', '1414', '孝南区', '4', '0', '0', '0', ',3268,1320,1414,1415,');
INSERT INTO `cmf_regions` VALUES ('1416', '1414', '孝昌县', '4', '0', '0', '0', ',3268,1320,1414,1416,');
INSERT INTO `cmf_regions` VALUES ('1417', '1414', '大悟县', '4', '0', '0', '0', ',3268,1320,1414,1417,');
INSERT INTO `cmf_regions` VALUES ('1418', '1414', '云梦县', '4', '0', '0', '0', ',3268,1320,1414,1418,');
INSERT INTO `cmf_regions` VALUES ('1419', '1414', '应城市', '4', '0', '0', '0', ',3268,1320,1414,1419,');
INSERT INTO `cmf_regions` VALUES ('1420', '1414', '安陆市', '4', '0', '0', '0', ',3268,1320,1414,1420,');
INSERT INTO `cmf_regions` VALUES ('1421', '1414', '汉川市', '4', '0', '0', '0', ',3268,1320,1414,1421,');
INSERT INTO `cmf_regions` VALUES ('1422', '1320', '宜昌市', '3', '0', '0', '0', ',3268,1320,1422,');
INSERT INTO `cmf_regions` VALUES ('1423', '1422', '西陵区', '4', '0', '0', '0', ',3268,1320,1422,1423,');
INSERT INTO `cmf_regions` VALUES ('1424', '1422', '伍家岗区', '4', '0', '0', '0', ',3268,1320,1422,1424,');
INSERT INTO `cmf_regions` VALUES ('1425', '1422', '点军区', '4', '0', '0', '0', ',3268,1320,1422,1425,');
INSERT INTO `cmf_regions` VALUES ('1426', '1422', '猇亭区', '4', '0', '0', '0', ',3268,1320,1422,1426,');
INSERT INTO `cmf_regions` VALUES ('1427', '1422', '夷陵区', '4', '0', '0', '0', ',3268,1320,1422,1427,');
INSERT INTO `cmf_regions` VALUES ('1428', '1422', '远安县', '4', '0', '0', '0', ',3268,1320,1422,1428,');
INSERT INTO `cmf_regions` VALUES ('1429', '1422', '兴山县', '4', '0', '0', '0', ',3268,1320,1422,1429,');
INSERT INTO `cmf_regions` VALUES ('1430', '1422', '秭归县', '4', '0', '0', '0', ',3268,1320,1422,1430,');
INSERT INTO `cmf_regions` VALUES ('1431', '1422', '长阳土家族自治县', '4', '0', '0', '0', ',3268,1320,1422,1431,');
INSERT INTO `cmf_regions` VALUES ('1432', '1422', '五峰土家族自治县', '4', '0', '0', '0', ',3268,1320,1422,1432,');
INSERT INTO `cmf_regions` VALUES ('1433', '1422', '宜都市', '4', '0', '0', '0', ',3268,1320,1422,1433,');
INSERT INTO `cmf_regions` VALUES ('1434', '1422', '当阳市', '4', '0', '0', '0', ',3268,1320,1422,1434,');
INSERT INTO `cmf_regions` VALUES ('1435', '1422', '枝江市', '4', '0', '0', '0', ',3268,1320,1422,1435,');
INSERT INTO `cmf_regions` VALUES ('1436', '3268', '湖南', '2', '0', '0', '0', ',3268,1436,');
INSERT INTO `cmf_regions` VALUES ('1437', '1436', '长沙市', '3', '0', '0', '0', ',3268,1436,1437,');
INSERT INTO `cmf_regions` VALUES ('1438', '1437', '芙蓉区', '4', '0', '0', '0', ',3268,1436,1437,1438,');
INSERT INTO `cmf_regions` VALUES ('1439', '1437', '天心区', '4', '0', '0', '0', ',3268,1436,1437,1439,');
INSERT INTO `cmf_regions` VALUES ('1440', '1437', '岳麓区', '4', '0', '0', '0', ',3268,1436,1437,1440,');
INSERT INTO `cmf_regions` VALUES ('1441', '1437', '开福区', '4', '0', '0', '0', ',3268,1436,1437,1441,');
INSERT INTO `cmf_regions` VALUES ('1442', '1437', '雨花区', '4', '0', '0', '0', ',3268,1436,1437,1442,');
INSERT INTO `cmf_regions` VALUES ('1443', '1437', '长沙县', '4', '0', '0', '0', ',3268,1436,1437,1443,');
INSERT INTO `cmf_regions` VALUES ('1444', '1437', '望城县', '4', '0', '0', '0', ',3268,1436,1437,1444,');
INSERT INTO `cmf_regions` VALUES ('1445', '1437', '宁乡县', '4', '0', '0', '0', ',3268,1436,1437,1445,');
INSERT INTO `cmf_regions` VALUES ('1446', '1437', '浏阳市', '4', '0', '0', '0', ',3268,1436,1437,1446,');
INSERT INTO `cmf_regions` VALUES ('1447', '1436', '常德市', '3', '0', '0', '0', ',3268,1436,1447,');
INSERT INTO `cmf_regions` VALUES ('1448', '1447', '武陵区', '4', '0', '0', '0', ',3268,1436,1447,1448,');
INSERT INTO `cmf_regions` VALUES ('1449', '1447', '鼎城区', '4', '0', '0', '0', ',3268,1436,1447,1449,');
INSERT INTO `cmf_regions` VALUES ('1450', '1447', '安乡县', '4', '0', '0', '0', ',3268,1436,1447,1450,');
INSERT INTO `cmf_regions` VALUES ('1451', '1447', '汉寿县', '4', '0', '0', '0', ',3268,1436,1447,1451,');
INSERT INTO `cmf_regions` VALUES ('1452', '1447', '澧县', '4', '0', '0', '0', ',3268,1436,1447,1452,');
INSERT INTO `cmf_regions` VALUES ('1453', '1447', '临澧县', '4', '0', '0', '0', ',3268,1436,1447,1453,');
INSERT INTO `cmf_regions` VALUES ('1454', '1447', '桃源县', '4', '0', '0', '0', ',3268,1436,1447,1454,');
INSERT INTO `cmf_regions` VALUES ('1455', '1447', '石门县', '4', '0', '0', '0', ',3268,1436,1447,1455,');
INSERT INTO `cmf_regions` VALUES ('1456', '1447', '津市市', '4', '0', '0', '0', ',3268,1436,1447,1456,');
INSERT INTO `cmf_regions` VALUES ('1457', '1436', '郴州市', '3', '0', '0', '0', ',3268,1436,1457,');
INSERT INTO `cmf_regions` VALUES ('1458', '1457', '北湖区', '4', '0', '0', '0', ',3268,1436,1457,1458,');
INSERT INTO `cmf_regions` VALUES ('1459', '1457', '苏仙区', '4', '0', '0', '0', ',3268,1436,1457,1459,');
INSERT INTO `cmf_regions` VALUES ('1460', '1457', '桂阳县', '4', '0', '0', '0', ',3268,1436,1457,1460,');
INSERT INTO `cmf_regions` VALUES ('1461', '1457', '宜章县', '4', '0', '0', '0', ',3268,1436,1457,1461,');
INSERT INTO `cmf_regions` VALUES ('1462', '1457', '永兴县', '4', '0', '0', '0', ',3268,1436,1457,1462,');
INSERT INTO `cmf_regions` VALUES ('1463', '1457', '嘉禾县', '4', '0', '0', '0', ',3268,1436,1457,1463,');
INSERT INTO `cmf_regions` VALUES ('1464', '1457', '临武县', '4', '0', '0', '0', ',3268,1436,1457,1464,');
INSERT INTO `cmf_regions` VALUES ('1465', '1457', '汝城县', '4', '0', '0', '0', ',3268,1436,1457,1465,');
INSERT INTO `cmf_regions` VALUES ('1466', '1457', '桂东县', '4', '0', '0', '0', ',3268,1436,1457,1466,');
INSERT INTO `cmf_regions` VALUES ('1467', '1457', '安仁县', '4', '0', '0', '0', ',3268,1436,1457,1467,');
INSERT INTO `cmf_regions` VALUES ('1468', '1457', '资兴市', '4', '0', '0', '0', ',3268,1436,1457,1468,');
INSERT INTO `cmf_regions` VALUES ('1469', '1436', '衡阳市', '3', '0', '0', '0', ',3268,1436,1469,');
INSERT INTO `cmf_regions` VALUES ('1470', '1469', '珠晖区', '4', '0', '0', '0', ',3268,1436,1469,1470,');
INSERT INTO `cmf_regions` VALUES ('1471', '1469', '雁峰区', '4', '0', '0', '0', ',3268,1436,1469,1471,');
INSERT INTO `cmf_regions` VALUES ('1472', '1469', '石鼓区', '4', '0', '0', '0', ',3268,1436,1469,1472,');
INSERT INTO `cmf_regions` VALUES ('1473', '1469', '蒸湘区', '4', '0', '0', '0', ',3268,1436,1469,1473,');
INSERT INTO `cmf_regions` VALUES ('1474', '1469', '南岳区', '4', '0', '0', '0', ',3268,1436,1469,1474,');
INSERT INTO `cmf_regions` VALUES ('1475', '1469', '衡阳县', '4', '0', '0', '0', ',3268,1436,1469,1475,');
INSERT INTO `cmf_regions` VALUES ('1476', '1469', '衡南县', '4', '0', '0', '0', ',3268,1436,1469,1476,');
INSERT INTO `cmf_regions` VALUES ('1477', '1469', '衡山县', '4', '0', '0', '0', ',3268,1436,1469,1477,');
INSERT INTO `cmf_regions` VALUES ('1478', '1469', '衡东县', '4', '0', '0', '0', ',3268,1436,1469,1478,');
INSERT INTO `cmf_regions` VALUES ('1479', '1469', '祁东县', '4', '0', '0', '0', ',3268,1436,1469,1479,');
INSERT INTO `cmf_regions` VALUES ('1480', '1469', '耒阳市', '4', '0', '0', '0', ',3268,1436,1469,1480,');
INSERT INTO `cmf_regions` VALUES ('1481', '1469', '常宁市', '4', '0', '0', '0', ',3268,1436,1469,1481,');
INSERT INTO `cmf_regions` VALUES ('1482', '1436', '怀化市', '3', '0', '0', '0', ',3268,1436,1482,');
INSERT INTO `cmf_regions` VALUES ('1483', '1482', '鹤城区', '4', '0', '0', '0', ',3268,1436,1482,1483,');
INSERT INTO `cmf_regions` VALUES ('1484', '1482', '中方县', '4', '0', '0', '0', ',3268,1436,1482,1484,');
INSERT INTO `cmf_regions` VALUES ('1485', '1482', '沅陵县', '4', '0', '0', '0', ',3268,1436,1482,1485,');
INSERT INTO `cmf_regions` VALUES ('1486', '1482', '辰溪县', '4', '0', '0', '0', ',3268,1436,1482,1486,');
INSERT INTO `cmf_regions` VALUES ('1487', '1482', '溆浦县', '4', '0', '0', '0', ',3268,1436,1482,1487,');
INSERT INTO `cmf_regions` VALUES ('1488', '1482', '会同县', '4', '0', '0', '0', ',3268,1436,1482,1488,');
INSERT INTO `cmf_regions` VALUES ('1489', '1482', '麻阳苗族自治县', '4', '0', '0', '0', ',3268,1436,1482,1489,');
INSERT INTO `cmf_regions` VALUES ('1490', '1482', '新晃侗族自治县', '4', '0', '0', '0', ',3268,1436,1482,1490,');
INSERT INTO `cmf_regions` VALUES ('1491', '1482', '芷江侗族自治县', '4', '0', '0', '0', ',3268,1436,1482,1491,');
INSERT INTO `cmf_regions` VALUES ('1492', '1482', '靖州苗族侗族自治县', '4', '0', '0', '0', ',3268,1436,1482,1492,');
INSERT INTO `cmf_regions` VALUES ('1493', '1482', '通道侗族自治县', '4', '0', '0', '0', ',3268,1436,1482,1493,');
INSERT INTO `cmf_regions` VALUES ('1494', '1482', '洪江市', '4', '0', '0', '0', ',3268,1436,1482,1494,');
INSERT INTO `cmf_regions` VALUES ('1495', '1436', '娄底市', '3', '0', '0', '0', ',3268,1436,1495,');
INSERT INTO `cmf_regions` VALUES ('1496', '1495', '娄星区', '4', '0', '0', '0', ',3268,1436,1495,1496,');
INSERT INTO `cmf_regions` VALUES ('1497', '1495', '双峰县', '4', '0', '0', '0', ',3268,1436,1495,1497,');
INSERT INTO `cmf_regions` VALUES ('1498', '1495', '新化县', '4', '0', '0', '0', ',3268,1436,1495,1498,');
INSERT INTO `cmf_regions` VALUES ('1499', '1495', '冷水江市', '4', '0', '0', '0', ',3268,1436,1495,1499,');
INSERT INTO `cmf_regions` VALUES ('1500', '1495', '涟源市', '4', '0', '0', '0', ',3268,1436,1495,1500,');
INSERT INTO `cmf_regions` VALUES ('1501', '1436', '邵阳市', '3', '0', '0', '0', ',3268,1436,1501,');
INSERT INTO `cmf_regions` VALUES ('1502', '1501', '双清区', '4', '0', '0', '0', ',3268,1436,1501,1502,');
INSERT INTO `cmf_regions` VALUES ('1503', '1501', '大祥区', '4', '0', '0', '0', ',3268,1436,1501,1503,');
INSERT INTO `cmf_regions` VALUES ('1504', '1501', '北塔区', '4', '0', '0', '0', ',3268,1436,1501,1504,');
INSERT INTO `cmf_regions` VALUES ('1505', '1501', '邵东县', '4', '0', '0', '0', ',3268,1436,1501,1505,');
INSERT INTO `cmf_regions` VALUES ('1506', '1501', '新邵县', '4', '0', '0', '0', ',3268,1436,1501,1506,');
INSERT INTO `cmf_regions` VALUES ('1507', '1501', '邵阳县', '4', '0', '0', '0', ',3268,1436,1501,1507,');
INSERT INTO `cmf_regions` VALUES ('1508', '1501', '隆回县', '4', '0', '0', '0', ',3268,1436,1501,1508,');
INSERT INTO `cmf_regions` VALUES ('1509', '1501', '洞口县', '4', '0', '0', '0', ',3268,1436,1501,1509,');
INSERT INTO `cmf_regions` VALUES ('1510', '1501', '绥宁县', '4', '0', '0', '0', ',3268,1436,1501,1510,');
INSERT INTO `cmf_regions` VALUES ('1511', '1501', '新宁县', '4', '0', '0', '0', ',3268,1436,1501,1511,');
INSERT INTO `cmf_regions` VALUES ('1512', '1501', '城步苗族自治县', '4', '0', '0', '0', ',3268,1436,1501,1512,');
INSERT INTO `cmf_regions` VALUES ('1513', '1501', '武冈市', '4', '0', '0', '0', ',3268,1436,1501,1513,');
INSERT INTO `cmf_regions` VALUES ('1514', '1436', '湘潭市', '3', '0', '0', '0', ',3268,1436,1514,');
INSERT INTO `cmf_regions` VALUES ('1515', '1514', '雨湖区', '4', '0', '0', '0', ',3268,1436,1514,1515,');
INSERT INTO `cmf_regions` VALUES ('1516', '1514', '岳塘区', '4', '0', '0', '0', ',3268,1436,1514,1516,');
INSERT INTO `cmf_regions` VALUES ('1517', '1514', '湘潭县', '4', '0', '0', '0', ',3268,1436,1514,1517,');
INSERT INTO `cmf_regions` VALUES ('1518', '1514', '湘乡市', '4', '0', '0', '0', ',3268,1436,1514,1518,');
INSERT INTO `cmf_regions` VALUES ('1519', '1514', '韶山市', '4', '0', '0', '0', ',3268,1436,1514,1519,');
INSERT INTO `cmf_regions` VALUES ('1520', '1436', '湘西土家族苗族自治州', '3', '0', '0', '0', ',3268,1436,1520,');
INSERT INTO `cmf_regions` VALUES ('1521', '1520', '吉首市', '4', '0', '0', '0', ',3268,1436,1520,1521,');
INSERT INTO `cmf_regions` VALUES ('1522', '1520', '泸溪县', '4', '0', '0', '0', ',3268,1436,1520,1522,');
INSERT INTO `cmf_regions` VALUES ('1523', '1520', '凤凰县', '4', '0', '0', '0', ',3268,1436,1520,1523,');
INSERT INTO `cmf_regions` VALUES ('1524', '1520', '花垣县', '4', '0', '0', '0', ',3268,1436,1520,1524,');
INSERT INTO `cmf_regions` VALUES ('1525', '1520', '保靖县', '4', '0', '0', '0', ',3268,1436,1520,1525,');
INSERT INTO `cmf_regions` VALUES ('1526', '1520', '古丈县', '4', '0', '0', '0', ',3268,1436,1520,1526,');
INSERT INTO `cmf_regions` VALUES ('1527', '1520', '永顺县', '4', '0', '0', '0', ',3268,1436,1520,1527,');
INSERT INTO `cmf_regions` VALUES ('1528', '1520', '龙山县', '4', '0', '0', '0', ',3268,1436,1520,1528,');
INSERT INTO `cmf_regions` VALUES ('1529', '1436', '益阳市', '3', '0', '0', '0', ',3268,1436,1529,');
INSERT INTO `cmf_regions` VALUES ('1530', '1529', '资阳区', '4', '0', '0', '0', ',3268,1436,1529,1530,');
INSERT INTO `cmf_regions` VALUES ('1531', '1529', '赫山区', '4', '0', '0', '0', ',3268,1436,1529,1531,');
INSERT INTO `cmf_regions` VALUES ('1532', '1529', '南县', '4', '0', '0', '0', ',3268,1436,1529,1532,');
INSERT INTO `cmf_regions` VALUES ('1533', '1529', '桃江县', '4', '0', '0', '0', ',3268,1436,1529,1533,');
INSERT INTO `cmf_regions` VALUES ('1534', '1529', '安化县', '4', '0', '0', '0', ',3268,1436,1529,1534,');
INSERT INTO `cmf_regions` VALUES ('1535', '1529', '沅江市', '4', '0', '0', '0', ',3268,1436,1529,1535,');
INSERT INTO `cmf_regions` VALUES ('1536', '1436', '永州市', '3', '0', '0', '0', ',3268,1436,1536,');
INSERT INTO `cmf_regions` VALUES ('1537', '1536', '芝山区', '4', '0', '0', '0', ',3268,1436,1536,1537,');
INSERT INTO `cmf_regions` VALUES ('1538', '1536', '冷水滩区', '4', '0', '0', '0', ',3268,1436,1536,1538,');
INSERT INTO `cmf_regions` VALUES ('1539', '1536', '祁阳县', '4', '0', '0', '0', ',3268,1436,1536,1539,');
INSERT INTO `cmf_regions` VALUES ('1540', '1536', '东安县', '4', '0', '0', '0', ',3268,1436,1536,1540,');
INSERT INTO `cmf_regions` VALUES ('1541', '1536', '双牌县', '4', '0', '0', '0', ',3268,1436,1536,1541,');
INSERT INTO `cmf_regions` VALUES ('1542', '1536', '道县', '4', '0', '0', '0', ',3268,1436,1536,1542,');
INSERT INTO `cmf_regions` VALUES ('1543', '1536', '江永县', '4', '0', '0', '0', ',3268,1436,1536,1543,');
INSERT INTO `cmf_regions` VALUES ('1544', '1536', '宁远县', '4', '0', '0', '0', ',3268,1436,1536,1544,');
INSERT INTO `cmf_regions` VALUES ('1545', '1536', '蓝山县', '4', '0', '0', '0', ',3268,1436,1536,1545,');
INSERT INTO `cmf_regions` VALUES ('1546', '1536', '新田县', '4', '0', '0', '0', ',3268,1436,1536,1546,');
INSERT INTO `cmf_regions` VALUES ('1547', '1536', '江华瑶族自治县', '4', '0', '0', '0', ',3268,1436,1536,1547,');
INSERT INTO `cmf_regions` VALUES ('1548', '1436', '岳阳市', '3', '0', '0', '0', ',3268,1436,1548,');
INSERT INTO `cmf_regions` VALUES ('1549', '1548', '岳阳楼区', '4', '0', '0', '0', ',3268,1436,1548,1549,');
INSERT INTO `cmf_regions` VALUES ('1550', '1548', '云溪区', '4', '0', '0', '0', ',3268,1436,1548,1550,');
INSERT INTO `cmf_regions` VALUES ('1551', '1548', '君山区', '4', '0', '0', '0', ',3268,1436,1548,1551,');
INSERT INTO `cmf_regions` VALUES ('1552', '1548', '岳阳县', '4', '0', '0', '0', ',3268,1436,1548,1552,');
INSERT INTO `cmf_regions` VALUES ('1553', '1548', '华容县', '4', '0', '0', '0', ',3268,1436,1548,1553,');
INSERT INTO `cmf_regions` VALUES ('1554', '1548', '湘阴县', '4', '0', '0', '0', ',3268,1436,1548,1554,');
INSERT INTO `cmf_regions` VALUES ('1555', '1548', '平江县', '4', '0', '0', '0', ',3268,1436,1548,1555,');
INSERT INTO `cmf_regions` VALUES ('1556', '1548', '汨罗市', '4', '0', '0', '0', ',3268,1436,1548,1556,');
INSERT INTO `cmf_regions` VALUES ('1557', '1548', '临湘市', '4', '0', '0', '0', ',3268,1436,1548,1557,');
INSERT INTO `cmf_regions` VALUES ('1558', '1436', '张家界市', '3', '0', '0', '0', ',3268,1436,1558,');
INSERT INTO `cmf_regions` VALUES ('1559', '1558', '永定区', '4', '0', '0', '0', ',3268,1436,1558,1559,');
INSERT INTO `cmf_regions` VALUES ('1560', '1558', '武陵源区', '4', '0', '0', '0', ',3268,1436,1558,1560,');
INSERT INTO `cmf_regions` VALUES ('1561', '1558', '慈利县', '4', '0', '0', '0', ',3268,1436,1558,1561,');
INSERT INTO `cmf_regions` VALUES ('1562', '1558', '桑植县', '4', '0', '0', '0', ',3268,1436,1558,1562,');
INSERT INTO `cmf_regions` VALUES ('1563', '1436', '株洲市', '3', '0', '0', '0', ',3268,1436,1563,');
INSERT INTO `cmf_regions` VALUES ('1564', '1563', '荷塘区', '4', '0', '0', '0', ',3268,1436,1563,1564,');
INSERT INTO `cmf_regions` VALUES ('1565', '1563', '芦淞区', '4', '0', '0', '0', ',3268,1436,1563,1565,');
INSERT INTO `cmf_regions` VALUES ('1566', '1563', '石峰区', '4', '0', '0', '0', ',3268,1436,1563,1566,');
INSERT INTO `cmf_regions` VALUES ('1567', '1563', '天元区', '4', '0', '0', '0', ',3268,1436,1563,1567,');
INSERT INTO `cmf_regions` VALUES ('1568', '1563', '株洲县', '4', '0', '0', '0', ',3268,1436,1563,1568,');
INSERT INTO `cmf_regions` VALUES ('1569', '1563', '攸县', '4', '0', '0', '0', ',3268,1436,1563,1569,');
INSERT INTO `cmf_regions` VALUES ('1570', '1563', '茶陵县', '4', '0', '0', '0', ',3268,1436,1563,1570,');
INSERT INTO `cmf_regions` VALUES ('1571', '1563', '炎陵县', '4', '0', '0', '0', ',3268,1436,1563,1571,');
INSERT INTO `cmf_regions` VALUES ('1572', '1563', '醴陵市', '4', '0', '0', '0', ',3268,1436,1563,1572,');
INSERT INTO `cmf_regions` VALUES ('1573', '3268', '吉林', '2', '0', '0', '0', ',3268,1573,');
INSERT INTO `cmf_regions` VALUES ('1574', '1573', '长春市', '3', '0', '0', '0', ',3268,1573,1574,');
INSERT INTO `cmf_regions` VALUES ('1575', '1574', '南关区', '4', '0', '0', '0', ',3268,1573,1574,1575,');
INSERT INTO `cmf_regions` VALUES ('1576', '1574', '宽城区', '4', '0', '0', '0', ',3268,1573,1574,1576,');
INSERT INTO `cmf_regions` VALUES ('1577', '1574', '朝阳区', '4', '0', '0', '0', ',3268,1573,1574,1577,');
INSERT INTO `cmf_regions` VALUES ('1578', '1574', '二道区', '4', '0', '0', '0', ',3268,1573,1574,1578,');
INSERT INTO `cmf_regions` VALUES ('1579', '1574', '绿园区', '4', '0', '0', '0', ',3268,1573,1574,1579,');
INSERT INTO `cmf_regions` VALUES ('1580', '1574', '双阳区', '4', '0', '0', '0', ',3268,1573,1574,1580,');
INSERT INTO `cmf_regions` VALUES ('1581', '1574', '农安县', '4', '0', '0', '0', ',3268,1573,1574,1581,');
INSERT INTO `cmf_regions` VALUES ('1582', '1574', '九台市', '4', '0', '0', '0', ',3268,1573,1574,1582,');
INSERT INTO `cmf_regions` VALUES ('1583', '1574', '榆树市', '4', '0', '0', '0', ',3268,1573,1574,1583,');
INSERT INTO `cmf_regions` VALUES ('1584', '1574', '德惠市', '4', '0', '0', '0', ',3268,1573,1574,1584,');
INSERT INTO `cmf_regions` VALUES ('1585', '1573', '白城市', '3', '0', '0', '0', ',3268,1573,1585,');
INSERT INTO `cmf_regions` VALUES ('1586', '1585', '洮北区', '4', '0', '0', '0', ',3268,1573,1585,1586,');
INSERT INTO `cmf_regions` VALUES ('1587', '1585', '镇赉县', '4', '0', '0', '0', ',3268,1573,1585,1587,');
INSERT INTO `cmf_regions` VALUES ('1588', '1585', '通榆县', '4', '0', '0', '0', ',3268,1573,1585,1588,');
INSERT INTO `cmf_regions` VALUES ('1589', '1585', '洮南市', '4', '0', '0', '0', ',3268,1573,1585,1589,');
INSERT INTO `cmf_regions` VALUES ('1590', '1585', '大安市', '4', '0', '0', '0', ',3268,1573,1585,1590,');
INSERT INTO `cmf_regions` VALUES ('1591', '1573', '白山市', '3', '0', '0', '0', ',3268,1573,1591,');
INSERT INTO `cmf_regions` VALUES ('1592', '1591', '八道江区', '4', '0', '0', '0', ',3268,1573,1591,1592,');
INSERT INTO `cmf_regions` VALUES ('1593', '1591', '抚松县', '4', '0', '0', '0', ',3268,1573,1591,1593,');
INSERT INTO `cmf_regions` VALUES ('1594', '1591', '靖宇县', '4', '0', '0', '0', ',3268,1573,1591,1594,');
INSERT INTO `cmf_regions` VALUES ('1595', '1591', '长白朝鲜族自治县', '4', '0', '0', '0', ',3268,1573,1591,1595,');
INSERT INTO `cmf_regions` VALUES ('1596', '1591', '江源县', '4', '0', '0', '0', ',3268,1573,1591,1596,');
INSERT INTO `cmf_regions` VALUES ('1597', '1591', '临江市', '4', '0', '0', '0', ',3268,1573,1591,1597,');
INSERT INTO `cmf_regions` VALUES ('1598', '1573', '吉林市', '3', '0', '0', '0', ',3268,1573,1598,');
INSERT INTO `cmf_regions` VALUES ('1599', '1598', '昌邑区', '4', '0', '0', '0', ',3268,1573,1598,1599,');
INSERT INTO `cmf_regions` VALUES ('1600', '1598', '龙潭区', '4', '0', '0', '0', ',3268,1573,1598,1600,');
INSERT INTO `cmf_regions` VALUES ('1601', '1598', '船营区', '4', '0', '0', '0', ',3268,1573,1598,1601,');
INSERT INTO `cmf_regions` VALUES ('1602', '1598', '丰满区', '4', '0', '0', '0', ',3268,1573,1598,1602,');
INSERT INTO `cmf_regions` VALUES ('1603', '1598', '永吉县', '4', '0', '0', '0', ',3268,1573,1598,1603,');
INSERT INTO `cmf_regions` VALUES ('1604', '1598', '蛟河市', '4', '0', '0', '0', ',3268,1573,1598,1604,');
INSERT INTO `cmf_regions` VALUES ('1605', '1598', '桦甸市', '4', '0', '0', '0', ',3268,1573,1598,1605,');
INSERT INTO `cmf_regions` VALUES ('1606', '1598', '舒兰市', '4', '0', '0', '0', ',3268,1573,1598,1606,');
INSERT INTO `cmf_regions` VALUES ('1607', '1598', '磐石市', '4', '0', '0', '0', ',3268,1573,1598,1607,');
INSERT INTO `cmf_regions` VALUES ('1608', '1573', '辽源市', '3', '0', '0', '0', ',3268,1573,1608,');
INSERT INTO `cmf_regions` VALUES ('1609', '1608', '龙山区', '4', '0', '0', '0', ',3268,1573,1608,1609,');
INSERT INTO `cmf_regions` VALUES ('1610', '1608', '西安区', '4', '0', '0', '0', ',3268,1573,1608,1610,');
INSERT INTO `cmf_regions` VALUES ('1611', '1608', '东丰县', '4', '0', '0', '0', ',3268,1573,1608,1611,');
INSERT INTO `cmf_regions` VALUES ('1612', '1608', '东辽县', '4', '0', '0', '0', ',3268,1573,1608,1612,');
INSERT INTO `cmf_regions` VALUES ('1613', '1573', '四平市', '3', '0', '0', '0', ',3268,1573,1613,');
INSERT INTO `cmf_regions` VALUES ('1614', '1613', '铁西区', '4', '0', '0', '0', ',3268,1573,1613,1614,');
INSERT INTO `cmf_regions` VALUES ('1615', '1613', '铁东区', '4', '0', '0', '0', ',3268,1573,1613,1615,');
INSERT INTO `cmf_regions` VALUES ('1616', '1613', '梨树县', '4', '0', '0', '0', ',3268,1573,1613,1616,');
INSERT INTO `cmf_regions` VALUES ('1617', '1613', '伊通满族自治县', '4', '0', '0', '0', ',3268,1573,1613,1617,');
INSERT INTO `cmf_regions` VALUES ('1618', '1613', '公主岭市', '4', '0', '0', '0', ',3268,1573,1613,1618,');
INSERT INTO `cmf_regions` VALUES ('1619', '1613', '双辽市', '4', '0', '0', '0', ',3268,1573,1613,1619,');
INSERT INTO `cmf_regions` VALUES ('1620', '1573', '松原市', '3', '0', '0', '0', ',3268,1573,1620,');
INSERT INTO `cmf_regions` VALUES ('1621', '1620', '宁江区', '4', '0', '0', '0', ',3268,1573,1620,1621,');
INSERT INTO `cmf_regions` VALUES ('1622', '1620', '前郭尔罗斯蒙古族自治县', '4', '0', '0', '0', ',3268,1573,1620,1622,');
INSERT INTO `cmf_regions` VALUES ('1623', '1620', '长岭县', '4', '0', '0', '0', ',3268,1573,1620,1623,');
INSERT INTO `cmf_regions` VALUES ('1624', '1620', '乾安县', '4', '0', '0', '0', ',3268,1573,1620,1624,');
INSERT INTO `cmf_regions` VALUES ('1625', '1620', '扶余县', '4', '0', '0', '0', ',3268,1573,1620,1625,');
INSERT INTO `cmf_regions` VALUES ('1626', '1573', '通化市', '3', '0', '0', '0', ',3268,1573,1626,');
INSERT INTO `cmf_regions` VALUES ('1627', '1626', '东昌区', '4', '0', '0', '0', ',3268,1573,1626,1627,');
INSERT INTO `cmf_regions` VALUES ('1628', '1626', '二道江区', '4', '0', '0', '0', ',3268,1573,1626,1628,');
INSERT INTO `cmf_regions` VALUES ('1629', '1626', '通化县', '4', '0', '0', '0', ',3268,1573,1626,1629,');
INSERT INTO `cmf_regions` VALUES ('1630', '1626', '辉南县', '4', '0', '0', '0', ',3268,1573,1626,1630,');
INSERT INTO `cmf_regions` VALUES ('1631', '1626', '柳河县', '4', '0', '0', '0', ',3268,1573,1626,1631,');
INSERT INTO `cmf_regions` VALUES ('1632', '1626', '梅河口市', '4', '0', '0', '0', ',3268,1573,1626,1632,');
INSERT INTO `cmf_regions` VALUES ('1633', '1626', '集安市', '4', '0', '0', '0', ',3268,1573,1626,1633,');
INSERT INTO `cmf_regions` VALUES ('1634', '1573', '延边朝鲜族自治州', '3', '0', '0', '0', ',3268,1573,1634,');
INSERT INTO `cmf_regions` VALUES ('1635', '1634', '延吉市', '4', '0', '0', '0', ',3268,1573,1634,1635,');
INSERT INTO `cmf_regions` VALUES ('1636', '1634', '图们市', '4', '0', '0', '0', ',3268,1573,1634,1636,');
INSERT INTO `cmf_regions` VALUES ('1637', '1634', '敦化市', '4', '0', '0', '0', ',3268,1573,1634,1637,');
INSERT INTO `cmf_regions` VALUES ('1638', '1634', '珲春市', '4', '0', '0', '0', ',3268,1573,1634,1638,');
INSERT INTO `cmf_regions` VALUES ('1639', '1634', '龙井市', '4', '0', '0', '0', ',3268,1573,1634,1639,');
INSERT INTO `cmf_regions` VALUES ('1640', '1634', '和龙市', '4', '0', '0', '0', ',3268,1573,1634,1640,');
INSERT INTO `cmf_regions` VALUES ('1641', '1634', '汪清县', '4', '0', '0', '0', ',3268,1573,1634,1641,');
INSERT INTO `cmf_regions` VALUES ('1642', '1634', '安图县', '4', '0', '0', '0', ',3268,1573,1634,1642,');
INSERT INTO `cmf_regions` VALUES ('1643', '3268', '江苏', '2', '0', '0', '0', ',3268,1643,');
INSERT INTO `cmf_regions` VALUES ('1644', '1643', '南京市', '3', '0', '0', '0', ',3268,1643,1644,');
INSERT INTO `cmf_regions` VALUES ('1645', '1644', '玄武区', '4', '0', '0', '0', ',3268,1643,1644,1645,');
INSERT INTO `cmf_regions` VALUES ('1646', '1644', '白下区', '4', '0', '0', '0', ',3268,1643,1644,1646,');
INSERT INTO `cmf_regions` VALUES ('1647', '1644', '秦淮区', '4', '0', '0', '0', ',3268,1643,1644,1647,');
INSERT INTO `cmf_regions` VALUES ('1648', '1644', '建邺区', '4', '0', '0', '0', ',3268,1643,1644,1648,');
INSERT INTO `cmf_regions` VALUES ('1649', '1644', '鼓楼区', '4', '0', '0', '0', ',3268,1643,1644,1649,');
INSERT INTO `cmf_regions` VALUES ('1650', '1644', '下关区', '4', '0', '0', '0', ',3268,1643,1644,1650,');
INSERT INTO `cmf_regions` VALUES ('1651', '1644', '浦口区', '4', '0', '0', '0', ',3268,1643,1644,1651,');
INSERT INTO `cmf_regions` VALUES ('1652', '1644', '栖霞区', '4', '0', '0', '0', ',3268,1643,1644,1652,');
INSERT INTO `cmf_regions` VALUES ('1653', '1644', '雨花台区', '4', '0', '0', '0', ',3268,1643,1644,1653,');
INSERT INTO `cmf_regions` VALUES ('1654', '1644', '江宁区', '4', '0', '0', '0', ',3268,1643,1644,1654,');
INSERT INTO `cmf_regions` VALUES ('1655', '1644', '六合区', '4', '0', '0', '0', ',3268,1643,1644,1655,');
INSERT INTO `cmf_regions` VALUES ('1656', '1644', '溧水县', '4', '0', '0', '0', ',3268,1643,1644,1656,');
INSERT INTO `cmf_regions` VALUES ('1657', '1644', '高淳县', '4', '0', '0', '0', ',3268,1643,1644,1657,');
INSERT INTO `cmf_regions` VALUES ('1658', '1643', '常州市', '3', '0', '0', '0', ',3268,1643,1658,');
INSERT INTO `cmf_regions` VALUES ('1659', '1658', '天宁区', '4', '0', '0', '0', ',3268,1643,1658,1659,');
INSERT INTO `cmf_regions` VALUES ('1660', '1658', '钟楼区', '4', '0', '0', '0', ',3268,1643,1658,1660,');
INSERT INTO `cmf_regions` VALUES ('1661', '1658', '戚墅堰区', '4', '0', '0', '0', ',3268,1643,1658,1661,');
INSERT INTO `cmf_regions` VALUES ('1662', '1658', '新北区', '4', '0', '0', '0', ',3268,1643,1658,1662,');
INSERT INTO `cmf_regions` VALUES ('1663', '1658', '武进区', '4', '0', '0', '0', ',3268,1643,1658,1663,');
INSERT INTO `cmf_regions` VALUES ('1664', '1658', '溧阳市', '4', '0', '0', '0', ',3268,1643,1658,1664,');
INSERT INTO `cmf_regions` VALUES ('1665', '1658', '金坛市', '4', '0', '0', '0', ',3268,1643,1658,1665,');
INSERT INTO `cmf_regions` VALUES ('1666', '1643', '淮安市', '3', '0', '0', '0', ',3268,1643,1666,');
INSERT INTO `cmf_regions` VALUES ('1667', '1666', '清河区', '4', '0', '0', '0', ',3268,1643,1666,1667,');
INSERT INTO `cmf_regions` VALUES ('1668', '1666', '楚州区', '4', '0', '0', '0', ',3268,1643,1666,1668,');
INSERT INTO `cmf_regions` VALUES ('1669', '1666', '淮阴区', '4', '0', '0', '0', ',3268,1643,1666,1669,');
INSERT INTO `cmf_regions` VALUES ('1670', '1666', '清浦区', '4', '0', '0', '0', ',3268,1643,1666,1670,');
INSERT INTO `cmf_regions` VALUES ('1671', '1666', '涟水县', '4', '0', '0', '0', ',3268,1643,1666,1671,');
INSERT INTO `cmf_regions` VALUES ('1672', '1666', '洪泽县', '4', '0', '0', '0', ',3268,1643,1666,1672,');
INSERT INTO `cmf_regions` VALUES ('1673', '1666', '盱眙县', '4', '0', '0', '0', ',3268,1643,1666,1673,');
INSERT INTO `cmf_regions` VALUES ('1674', '1666', '金湖县', '4', '0', '0', '0', ',3268,1643,1666,1674,');
INSERT INTO `cmf_regions` VALUES ('1675', '1643', '连云港市', '3', '0', '0', '0', ',3268,1643,1675,');
INSERT INTO `cmf_regions` VALUES ('1676', '1675', '连云区', '4', '0', '0', '0', ',3268,1643,1675,1676,');
INSERT INTO `cmf_regions` VALUES ('1677', '1675', '新浦区', '4', '0', '0', '0', ',3268,1643,1675,1677,');
INSERT INTO `cmf_regions` VALUES ('1678', '1675', '海州区', '4', '0', '0', '0', ',3268,1643,1675,1678,');
INSERT INTO `cmf_regions` VALUES ('1679', '1675', '赣榆县', '4', '0', '0', '0', ',3268,1643,1675,1679,');
INSERT INTO `cmf_regions` VALUES ('1680', '1675', '东海县', '4', '0', '0', '0', ',3268,1643,1675,1680,');
INSERT INTO `cmf_regions` VALUES ('1681', '1675', '灌云县', '4', '0', '0', '0', ',3268,1643,1675,1681,');
INSERT INTO `cmf_regions` VALUES ('1682', '1675', '灌南县', '4', '0', '0', '0', ',3268,1643,1675,1682,');
INSERT INTO `cmf_regions` VALUES ('1683', '1643', '南通市', '3', '0', '0', '0', ',3268,1643,1683,');
INSERT INTO `cmf_regions` VALUES ('1684', '1683', '崇川区', '4', '0', '0', '0', ',3268,1643,1683,1684,');
INSERT INTO `cmf_regions` VALUES ('1685', '1683', '港闸区', '4', '0', '0', '0', ',3268,1643,1683,1685,');
INSERT INTO `cmf_regions` VALUES ('1686', '1683', '海安县', '4', '0', '0', '0', ',3268,1643,1683,1686,');
INSERT INTO `cmf_regions` VALUES ('1687', '1683', '如东县', '4', '0', '0', '0', ',3268,1643,1683,1687,');
INSERT INTO `cmf_regions` VALUES ('1688', '1683', '启东市', '4', '0', '0', '0', ',3268,1643,1683,1688,');
INSERT INTO `cmf_regions` VALUES ('1689', '1683', '如皋市', '4', '0', '0', '0', ',3268,1643,1683,1689,');
INSERT INTO `cmf_regions` VALUES ('1690', '1683', '通州市', '4', '0', '0', '0', ',3268,1643,1683,1690,');
INSERT INTO `cmf_regions` VALUES ('1691', '1683', '海门市', '4', '0', '0', '0', ',3268,1643,1683,1691,');
INSERT INTO `cmf_regions` VALUES ('1692', '1643', '苏州市', '3', '0', '0', '0', ',3268,1643,1692,');
INSERT INTO `cmf_regions` VALUES ('1693', '1692', '沧浪区', '4', '0', '0', '0', ',3268,1643,1692,1693,');
INSERT INTO `cmf_regions` VALUES ('1694', '1692', '平江区', '4', '0', '0', '0', ',3268,1643,1692,1694,');
INSERT INTO `cmf_regions` VALUES ('1695', '1692', '金阊区', '4', '0', '0', '0', ',3268,1643,1692,1695,');
INSERT INTO `cmf_regions` VALUES ('1696', '1692', '虎丘区', '4', '0', '0', '0', ',3268,1643,1692,1696,');
INSERT INTO `cmf_regions` VALUES ('1697', '1692', '吴中区', '4', '0', '0', '0', ',3268,1643,1692,1697,');
INSERT INTO `cmf_regions` VALUES ('1698', '1692', '相城区', '4', '0', '0', '0', ',3268,1643,1692,1698,');
INSERT INTO `cmf_regions` VALUES ('1699', '1692', '常熟市', '4', '0', '0', '0', ',3268,1643,1692,1699,');
INSERT INTO `cmf_regions` VALUES ('1700', '1692', '张家港市', '4', '0', '0', '0', ',3268,1643,1692,1700,');
INSERT INTO `cmf_regions` VALUES ('1701', '1692', '昆山市', '4', '0', '0', '0', ',3268,1643,1692,1701,');
INSERT INTO `cmf_regions` VALUES ('1702', '1692', '吴江市', '4', '0', '0', '0', ',3268,1643,1692,1702,');
INSERT INTO `cmf_regions` VALUES ('1703', '1692', '太仓市', '4', '0', '0', '0', ',3268,1643,1692,1703,');
INSERT INTO `cmf_regions` VALUES ('1704', '1643', '宿迁市', '3', '0', '0', '0', ',3268,1643,1704,');
INSERT INTO `cmf_regions` VALUES ('1705', '1704', '宿城区', '4', '0', '0', '0', ',3268,1643,1704,1705,');
INSERT INTO `cmf_regions` VALUES ('1706', '1704', '宿豫区', '4', '0', '0', '0', ',3268,1643,1704,1706,');
INSERT INTO `cmf_regions` VALUES ('1707', '1704', '沭阳县', '4', '0', '0', '0', ',3268,1643,1704,1707,');
INSERT INTO `cmf_regions` VALUES ('1708', '1704', '泗阳县', '4', '0', '0', '0', ',3268,1643,1704,1708,');
INSERT INTO `cmf_regions` VALUES ('1709', '1704', '泗洪县', '4', '0', '0', '0', ',3268,1643,1704,1709,');
INSERT INTO `cmf_regions` VALUES ('1710', '1643', '泰州市', '3', '0', '0', '0', ',3268,1643,1710,');
INSERT INTO `cmf_regions` VALUES ('1711', '1710', '海陵区', '4', '0', '0', '0', ',3268,1643,1710,1711,');
INSERT INTO `cmf_regions` VALUES ('1712', '1710', '高港区', '4', '0', '0', '0', ',3268,1643,1710,1712,');
INSERT INTO `cmf_regions` VALUES ('1713', '1710', '兴化市', '4', '0', '0', '0', ',3268,1643,1710,1713,');
INSERT INTO `cmf_regions` VALUES ('1714', '1710', '靖江市', '4', '0', '0', '0', ',3268,1643,1710,1714,');
INSERT INTO `cmf_regions` VALUES ('1715', '1710', '泰兴市', '4', '0', '0', '0', ',3268,1643,1710,1715,');
INSERT INTO `cmf_regions` VALUES ('1716', '1710', '姜堰市', '4', '0', '0', '0', ',3268,1643,1710,1716,');
INSERT INTO `cmf_regions` VALUES ('1717', '1643', '无锡市', '3', '0', '0', '0', ',3268,1643,1717,');
INSERT INTO `cmf_regions` VALUES ('1718', '1717', '崇安区', '4', '0', '0', '0', ',3268,1643,1717,1718,');
INSERT INTO `cmf_regions` VALUES ('1719', '1717', '南长区', '4', '0', '0', '0', ',3268,1643,1717,1719,');
INSERT INTO `cmf_regions` VALUES ('1720', '1717', '北塘区', '4', '0', '0', '0', ',3268,1643,1717,1720,');
INSERT INTO `cmf_regions` VALUES ('1721', '1717', '锡山区', '4', '0', '0', '0', ',3268,1643,1717,1721,');
INSERT INTO `cmf_regions` VALUES ('1722', '1717', '惠山区', '4', '0', '0', '0', ',3268,1643,1717,1722,');
INSERT INTO `cmf_regions` VALUES ('1723', '1717', '滨湖区', '4', '0', '0', '0', ',3268,1643,1717,1723,');
INSERT INTO `cmf_regions` VALUES ('1724', '1717', '江阴市', '4', '0', '0', '0', ',3268,1643,1717,1724,');
INSERT INTO `cmf_regions` VALUES ('1725', '1717', '宜兴市', '4', '0', '0', '0', ',3268,1643,1717,1725,');
INSERT INTO `cmf_regions` VALUES ('1726', '1643', '徐州市', '3', '0', '0', '0', ',3268,1643,1726,');
INSERT INTO `cmf_regions` VALUES ('1727', '1726', '鼓楼区', '4', '0', '0', '0', ',3268,1643,1726,1727,');
INSERT INTO `cmf_regions` VALUES ('1728', '1726', '云龙区', '4', '0', '0', '0', ',3268,1643,1726,1728,');
INSERT INTO `cmf_regions` VALUES ('1729', '1726', '九里区', '4', '0', '0', '0', ',3268,1643,1726,1729,');
INSERT INTO `cmf_regions` VALUES ('1730', '1726', '贾汪区', '4', '0', '0', '0', ',3268,1643,1726,1730,');
INSERT INTO `cmf_regions` VALUES ('1731', '1726', '泉山区', '4', '0', '0', '0', ',3268,1643,1726,1731,');
INSERT INTO `cmf_regions` VALUES ('1732', '1726', '丰县', '4', '0', '0', '0', ',3268,1643,1726,1732,');
INSERT INTO `cmf_regions` VALUES ('1733', '1726', '沛县', '4', '0', '0', '0', ',3268,1643,1726,1733,');
INSERT INTO `cmf_regions` VALUES ('1734', '1726', '铜山县', '4', '0', '0', '0', ',3268,1643,1726,1734,');
INSERT INTO `cmf_regions` VALUES ('1735', '1726', '睢宁县', '4', '0', '0', '0', ',3268,1643,1726,1735,');
INSERT INTO `cmf_regions` VALUES ('1736', '1726', '新沂市', '4', '0', '0', '0', ',3268,1643,1726,1736,');
INSERT INTO `cmf_regions` VALUES ('1737', '1726', '邳州市', '4', '0', '0', '0', ',3268,1643,1726,1737,');
INSERT INTO `cmf_regions` VALUES ('1738', '1643', '盐城市', '3', '0', '0', '0', ',3268,1643,1738,');
INSERT INTO `cmf_regions` VALUES ('1739', '1738', '亭湖区', '4', '0', '0', '0', ',3268,1643,1738,1739,');
INSERT INTO `cmf_regions` VALUES ('1740', '1738', '盐都区', '4', '0', '0', '0', ',3268,1643,1738,1740,');
INSERT INTO `cmf_regions` VALUES ('1741', '1738', '响水县', '4', '0', '0', '0', ',3268,1643,1738,1741,');
INSERT INTO `cmf_regions` VALUES ('1742', '1738', '滨海县', '4', '0', '0', '0', ',3268,1643,1738,1742,');
INSERT INTO `cmf_regions` VALUES ('1743', '1738', '阜宁县', '4', '0', '0', '0', ',3268,1643,1738,1743,');
INSERT INTO `cmf_regions` VALUES ('1744', '1738', '射阳县', '4', '0', '0', '0', ',3268,1643,1738,1744,');
INSERT INTO `cmf_regions` VALUES ('1745', '1738', '建湖县', '4', '0', '0', '0', ',3268,1643,1738,1745,');
INSERT INTO `cmf_regions` VALUES ('1746', '1738', '东台市', '4', '0', '0', '0', ',3268,1643,1738,1746,');
INSERT INTO `cmf_regions` VALUES ('1747', '1738', '大丰市', '4', '0', '0', '0', ',3268,1643,1738,1747,');
INSERT INTO `cmf_regions` VALUES ('1748', '1643', '扬州市', '3', '0', '0', '0', ',3268,1643,1748,');
INSERT INTO `cmf_regions` VALUES ('1749', '1748', '广陵区', '4', '0', '0', '0', ',3268,1643,1748,1749,');
INSERT INTO `cmf_regions` VALUES ('1750', '1748', '邗江区', '4', '0', '0', '0', ',3268,1643,1748,1750,');
INSERT INTO `cmf_regions` VALUES ('1751', '1748', '郊区', '4', '0', '0', '0', ',3268,1643,1748,1751,');
INSERT INTO `cmf_regions` VALUES ('1752', '1748', '宝应县', '4', '0', '0', '0', ',3268,1643,1748,1752,');
INSERT INTO `cmf_regions` VALUES ('1753', '1748', '仪征市', '4', '0', '0', '0', ',3268,1643,1748,1753,');
INSERT INTO `cmf_regions` VALUES ('1754', '1748', '高邮市', '4', '0', '0', '0', ',3268,1643,1748,1754,');
INSERT INTO `cmf_regions` VALUES ('1755', '1748', '江都市', '4', '0', '0', '0', ',3268,1643,1748,1755,');
INSERT INTO `cmf_regions` VALUES ('1756', '1643', '镇江市', '3', '0', '0', '0', ',3268,1643,1756,');
INSERT INTO `cmf_regions` VALUES ('1757', '1756', '京口区', '4', '0', '0', '0', ',3268,1643,1756,1757,');
INSERT INTO `cmf_regions` VALUES ('1758', '1756', '润州区', '4', '0', '0', '0', ',3268,1643,1756,1758,');
INSERT INTO `cmf_regions` VALUES ('1759', '1756', '丹徒区', '4', '0', '0', '0', ',3268,1643,1756,1759,');
INSERT INTO `cmf_regions` VALUES ('1760', '1756', '丹阳市', '4', '0', '0', '0', ',3268,1643,1756,1760,');
INSERT INTO `cmf_regions` VALUES ('1761', '1756', '扬中市', '4', '0', '0', '0', ',3268,1643,1756,1761,');
INSERT INTO `cmf_regions` VALUES ('1762', '1756', '句容市', '4', '0', '0', '0', ',3268,1643,1756,1762,');
INSERT INTO `cmf_regions` VALUES ('1763', '3268', '江西', '2', '0', '0', '0', ',3268,1763,');
INSERT INTO `cmf_regions` VALUES ('1764', '1763', '南昌市', '3', '0', '0', '0', ',3268,1763,1764,');
INSERT INTO `cmf_regions` VALUES ('1765', '1764', '东湖区', '4', '0', '0', '0', ',3268,1763,1764,1765,');
INSERT INTO `cmf_regions` VALUES ('1766', '1764', '西湖区', '4', '0', '0', '0', ',3268,1763,1764,1766,');
INSERT INTO `cmf_regions` VALUES ('1767', '1764', '青云谱区', '4', '0', '0', '0', ',3268,1763,1764,1767,');
INSERT INTO `cmf_regions` VALUES ('1768', '1764', '湾里区', '4', '0', '0', '0', ',3268,1763,1764,1768,');
INSERT INTO `cmf_regions` VALUES ('1769', '1764', '青山湖区', '4', '0', '0', '0', ',3268,1763,1764,1769,');
INSERT INTO `cmf_regions` VALUES ('1770', '1764', '南昌县', '4', '0', '0', '0', ',3268,1763,1764,1770,');
INSERT INTO `cmf_regions` VALUES ('1771', '1764', '新建县', '4', '0', '0', '0', ',3268,1763,1764,1771,');
INSERT INTO `cmf_regions` VALUES ('1772', '1764', '安义县', '4', '0', '0', '0', ',3268,1763,1764,1772,');
INSERT INTO `cmf_regions` VALUES ('1773', '1764', '进贤县', '4', '0', '0', '0', ',3268,1763,1764,1773,');
INSERT INTO `cmf_regions` VALUES ('1774', '1763', '抚州市', '3', '0', '0', '0', ',3268,1763,1774,');
INSERT INTO `cmf_regions` VALUES ('1775', '1774', '临川区', '4', '0', '0', '0', ',3268,1763,1774,1775,');
INSERT INTO `cmf_regions` VALUES ('1776', '1774', '南城县', '4', '0', '0', '0', ',3268,1763,1774,1776,');
INSERT INTO `cmf_regions` VALUES ('1777', '1774', '黎川县', '4', '0', '0', '0', ',3268,1763,1774,1777,');
INSERT INTO `cmf_regions` VALUES ('1778', '1774', '南丰县', '4', '0', '0', '0', ',3268,1763,1774,1778,');
INSERT INTO `cmf_regions` VALUES ('1779', '1774', '崇仁县', '4', '0', '0', '0', ',3268,1763,1774,1779,');
INSERT INTO `cmf_regions` VALUES ('1780', '1774', '乐安县', '4', '0', '0', '0', ',3268,1763,1774,1780,');
INSERT INTO `cmf_regions` VALUES ('1781', '1774', '宜黄县', '4', '0', '0', '0', ',3268,1763,1774,1781,');
INSERT INTO `cmf_regions` VALUES ('1782', '1774', '金溪县', '4', '0', '0', '0', ',3268,1763,1774,1782,');
INSERT INTO `cmf_regions` VALUES ('1783', '1774', '资溪县', '4', '0', '0', '0', ',3268,1763,1774,1783,');
INSERT INTO `cmf_regions` VALUES ('1784', '1774', '东乡县', '4', '0', '0', '0', ',3268,1763,1774,1784,');
INSERT INTO `cmf_regions` VALUES ('1785', '1774', '广昌县', '4', '0', '0', '0', ',3268,1763,1774,1785,');
INSERT INTO `cmf_regions` VALUES ('1786', '1763', '赣州市', '3', '0', '0', '0', ',3268,1763,1786,');
INSERT INTO `cmf_regions` VALUES ('1787', '1786', '章贡区', '4', '0', '0', '0', ',3268,1763,1786,1787,');
INSERT INTO `cmf_regions` VALUES ('1788', '1786', '赣县', '4', '0', '0', '0', ',3268,1763,1786,1788,');
INSERT INTO `cmf_regions` VALUES ('1789', '1786', '信丰县', '4', '0', '0', '0', ',3268,1763,1786,1789,');
INSERT INTO `cmf_regions` VALUES ('1790', '1786', '大余县', '4', '0', '0', '0', ',3268,1763,1786,1790,');
INSERT INTO `cmf_regions` VALUES ('1791', '1786', '上犹县', '4', '0', '0', '0', ',3268,1763,1786,1791,');
INSERT INTO `cmf_regions` VALUES ('1792', '1786', '崇义县', '4', '0', '0', '0', ',3268,1763,1786,1792,');
INSERT INTO `cmf_regions` VALUES ('1793', '1786', '安远县', '4', '0', '0', '0', ',3268,1763,1786,1793,');
INSERT INTO `cmf_regions` VALUES ('1794', '1786', '龙南县', '4', '0', '0', '0', ',3268,1763,1786,1794,');
INSERT INTO `cmf_regions` VALUES ('1795', '1786', '定南县', '4', '0', '0', '0', ',3268,1763,1786,1795,');
INSERT INTO `cmf_regions` VALUES ('1796', '1786', '全南县', '4', '0', '0', '0', ',3268,1763,1786,1796,');
INSERT INTO `cmf_regions` VALUES ('1797', '1786', '宁都县', '4', '0', '0', '0', ',3268,1763,1786,1797,');
INSERT INTO `cmf_regions` VALUES ('1798', '1786', '于都县', '4', '0', '0', '0', ',3268,1763,1786,1798,');
INSERT INTO `cmf_regions` VALUES ('1799', '1786', '兴国县', '4', '0', '0', '0', ',3268,1763,1786,1799,');
INSERT INTO `cmf_regions` VALUES ('1800', '1786', '会昌县', '4', '0', '0', '0', ',3268,1763,1786,1800,');
INSERT INTO `cmf_regions` VALUES ('1801', '1786', '寻乌县', '4', '0', '0', '0', ',3268,1763,1786,1801,');
INSERT INTO `cmf_regions` VALUES ('1802', '1786', '石城县', '4', '0', '0', '0', ',3268,1763,1786,1802,');
INSERT INTO `cmf_regions` VALUES ('1803', '1786', '瑞金市', '4', '0', '0', '0', ',3268,1763,1786,1803,');
INSERT INTO `cmf_regions` VALUES ('1804', '1786', '南康市', '4', '0', '0', '0', ',3268,1763,1786,1804,');
INSERT INTO `cmf_regions` VALUES ('1805', '1763', '吉安市', '3', '0', '0', '0', ',3268,1763,1805,');
INSERT INTO `cmf_regions` VALUES ('1806', '1805', '吉州区', '4', '0', '0', '0', ',3268,1763,1805,1806,');
INSERT INTO `cmf_regions` VALUES ('1807', '1805', '青原区', '4', '0', '0', '0', ',3268,1763,1805,1807,');
INSERT INTO `cmf_regions` VALUES ('1808', '1805', '吉安县', '4', '0', '0', '0', ',3268,1763,1805,1808,');
INSERT INTO `cmf_regions` VALUES ('1809', '1805', '吉水县', '4', '0', '0', '0', ',3268,1763,1805,1809,');
INSERT INTO `cmf_regions` VALUES ('1810', '1805', '峡江县', '4', '0', '0', '0', ',3268,1763,1805,1810,');
INSERT INTO `cmf_regions` VALUES ('1811', '1805', '新干县', '4', '0', '0', '0', ',3268,1763,1805,1811,');
INSERT INTO `cmf_regions` VALUES ('1812', '1805', '永丰县', '4', '0', '0', '0', ',3268,1763,1805,1812,');
INSERT INTO `cmf_regions` VALUES ('1813', '1805', '泰和县', '4', '0', '0', '0', ',3268,1763,1805,1813,');
INSERT INTO `cmf_regions` VALUES ('1814', '1805', '遂川县', '4', '0', '0', '0', ',3268,1763,1805,1814,');
INSERT INTO `cmf_regions` VALUES ('1815', '1805', '万安县', '4', '0', '0', '0', ',3268,1763,1805,1815,');
INSERT INTO `cmf_regions` VALUES ('1816', '1805', '安福县', '4', '0', '0', '0', ',3268,1763,1805,1816,');
INSERT INTO `cmf_regions` VALUES ('1817', '1805', '永新县', '4', '0', '0', '0', ',3268,1763,1805,1817,');
INSERT INTO `cmf_regions` VALUES ('1818', '1805', '井冈山市', '4', '0', '0', '0', ',3268,1763,1805,1818,');
INSERT INTO `cmf_regions` VALUES ('1819', '1763', '景德镇市', '3', '0', '0', '0', ',3268,1763,1819,');
INSERT INTO `cmf_regions` VALUES ('1820', '1819', '昌江区', '4', '0', '0', '0', ',3268,1763,1819,1820,');
INSERT INTO `cmf_regions` VALUES ('1821', '1819', '珠山区', '4', '0', '0', '0', ',3268,1763,1819,1821,');
INSERT INTO `cmf_regions` VALUES ('1822', '1819', '浮梁县', '4', '0', '0', '0', ',3268,1763,1819,1822,');
INSERT INTO `cmf_regions` VALUES ('1823', '1819', '乐平市', '4', '0', '0', '0', ',3268,1763,1819,1823,');
INSERT INTO `cmf_regions` VALUES ('1824', '1763', '九江市', '3', '0', '0', '0', ',3268,1763,1824,');
INSERT INTO `cmf_regions` VALUES ('1825', '1824', '庐山区', '4', '0', '0', '0', ',3268,1763,1824,1825,');
INSERT INTO `cmf_regions` VALUES ('1826', '1824', '浔阳区', '4', '0', '0', '0', ',3268,1763,1824,1826,');
INSERT INTO `cmf_regions` VALUES ('1827', '1824', '九江县', '4', '0', '0', '0', ',3268,1763,1824,1827,');
INSERT INTO `cmf_regions` VALUES ('1828', '1824', '武宁县', '4', '0', '0', '0', ',3268,1763,1824,1828,');
INSERT INTO `cmf_regions` VALUES ('1829', '1824', '修水县', '4', '0', '0', '0', ',3268,1763,1824,1829,');
INSERT INTO `cmf_regions` VALUES ('1830', '1824', '永修县', '4', '0', '0', '0', ',3268,1763,1824,1830,');
INSERT INTO `cmf_regions` VALUES ('1831', '1824', '德安县', '4', '0', '0', '0', ',3268,1763,1824,1831,');
INSERT INTO `cmf_regions` VALUES ('1832', '1824', '星子县', '4', '0', '0', '0', ',3268,1763,1824,1832,');
INSERT INTO `cmf_regions` VALUES ('1833', '1824', '都昌县', '4', '0', '0', '0', ',3268,1763,1824,1833,');
INSERT INTO `cmf_regions` VALUES ('1834', '1824', '湖口县', '4', '0', '0', '0', ',3268,1763,1824,1834,');
INSERT INTO `cmf_regions` VALUES ('1835', '1824', '彭泽县', '4', '0', '0', '0', ',3268,1763,1824,1835,');
INSERT INTO `cmf_regions` VALUES ('1836', '1824', '瑞昌市', '4', '0', '0', '0', ',3268,1763,1824,1836,');
INSERT INTO `cmf_regions` VALUES ('1837', '1763', '萍乡市', '3', '0', '0', '0', ',3268,1763,1837,');
INSERT INTO `cmf_regions` VALUES ('1838', '1837', '安源区', '4', '0', '0', '0', ',3268,1763,1837,1838,');
INSERT INTO `cmf_regions` VALUES ('1839', '1837', '湘东区', '4', '0', '0', '0', ',3268,1763,1837,1839,');
INSERT INTO `cmf_regions` VALUES ('1840', '1837', '莲花县', '4', '0', '0', '0', ',3268,1763,1837,1840,');
INSERT INTO `cmf_regions` VALUES ('1841', '1837', '上栗县', '4', '0', '0', '0', ',3268,1763,1837,1841,');
INSERT INTO `cmf_regions` VALUES ('1842', '1837', '芦溪县', '4', '0', '0', '0', ',3268,1763,1837,1842,');
INSERT INTO `cmf_regions` VALUES ('1843', '1763', '上饶市', '3', '0', '0', '0', ',3268,1763,1843,');
INSERT INTO `cmf_regions` VALUES ('1844', '1843', '信州区', '4', '0', '0', '0', ',3268,1763,1843,1844,');
INSERT INTO `cmf_regions` VALUES ('1845', '1843', '上饶县', '4', '0', '0', '0', ',3268,1763,1843,1845,');
INSERT INTO `cmf_regions` VALUES ('1846', '1843', '广丰县', '4', '0', '0', '0', ',3268,1763,1843,1846,');
INSERT INTO `cmf_regions` VALUES ('1847', '1843', '玉山县', '4', '0', '0', '0', ',3268,1763,1843,1847,');
INSERT INTO `cmf_regions` VALUES ('1848', '1843', '铅山县', '4', '0', '0', '0', ',3268,1763,1843,1848,');
INSERT INTO `cmf_regions` VALUES ('1849', '1843', '横峰县', '4', '0', '0', '0', ',3268,1763,1843,1849,');
INSERT INTO `cmf_regions` VALUES ('1850', '1843', '弋阳县', '4', '0', '0', '0', ',3268,1763,1843,1850,');
INSERT INTO `cmf_regions` VALUES ('1851', '1843', '余干县', '4', '0', '0', '0', ',3268,1763,1843,1851,');
INSERT INTO `cmf_regions` VALUES ('1852', '1843', '鄱阳县', '4', '0', '0', '0', ',3268,1763,1843,1852,');
INSERT INTO `cmf_regions` VALUES ('1853', '1843', '万年县', '4', '0', '0', '0', ',3268,1763,1843,1853,');
INSERT INTO `cmf_regions` VALUES ('1854', '1843', '婺源县', '4', '0', '0', '0', ',3268,1763,1843,1854,');
INSERT INTO `cmf_regions` VALUES ('1855', '1843', '德兴市', '4', '0', '0', '0', ',3268,1763,1843,1855,');
INSERT INTO `cmf_regions` VALUES ('1856', '1763', '新余市', '3', '0', '0', '0', ',3268,1763,1856,');
INSERT INTO `cmf_regions` VALUES ('1857', '1856', '渝水区', '4', '0', '0', '0', ',3268,1763,1856,1857,');
INSERT INTO `cmf_regions` VALUES ('1858', '1856', '分宜县', '4', '0', '0', '0', ',3268,1763,1856,1858,');
INSERT INTO `cmf_regions` VALUES ('1859', '1763', '宜春市', '3', '0', '0', '0', ',3268,1763,1859,');
INSERT INTO `cmf_regions` VALUES ('1860', '1859', '袁州区', '4', '0', '0', '0', ',3268,1763,1859,1860,');
INSERT INTO `cmf_regions` VALUES ('1861', '1859', '奉新县', '4', '0', '0', '0', ',3268,1763,1859,1861,');
INSERT INTO `cmf_regions` VALUES ('1862', '1859', '万载县', '4', '0', '0', '0', ',3268,1763,1859,1862,');
INSERT INTO `cmf_regions` VALUES ('1863', '1859', '上高县', '4', '0', '0', '0', ',3268,1763,1859,1863,');
INSERT INTO `cmf_regions` VALUES ('1864', '1859', '宜丰县', '4', '0', '0', '0', ',3268,1763,1859,1864,');
INSERT INTO `cmf_regions` VALUES ('1865', '1859', '靖安县', '4', '0', '0', '0', ',3268,1763,1859,1865,');
INSERT INTO `cmf_regions` VALUES ('1866', '1859', '铜鼓县', '4', '0', '0', '0', ',3268,1763,1859,1866,');
INSERT INTO `cmf_regions` VALUES ('1867', '1859', '丰城市', '4', '0', '0', '0', ',3268,1763,1859,1867,');
INSERT INTO `cmf_regions` VALUES ('1868', '1859', '樟树市', '4', '0', '0', '0', ',3268,1763,1859,1868,');
INSERT INTO `cmf_regions` VALUES ('1869', '1859', '高安市', '4', '0', '0', '0', ',3268,1763,1859,1869,');
INSERT INTO `cmf_regions` VALUES ('1870', '1763', '鹰潭市', '3', '0', '0', '0', ',3268,1763,1870,');
INSERT INTO `cmf_regions` VALUES ('1871', '1870', '月湖区', '4', '0', '0', '0', ',3268,1763,1870,1871,');
INSERT INTO `cmf_regions` VALUES ('1872', '1870', '余江县', '4', '0', '0', '0', ',3268,1763,1870,1872,');
INSERT INTO `cmf_regions` VALUES ('1873', '1870', '贵溪市', '4', '0', '0', '0', ',3268,1763,1870,1873,');
INSERT INTO `cmf_regions` VALUES ('1874', '3268', '辽宁', '2', '0', '0', '0', ',3268,1874,');
INSERT INTO `cmf_regions` VALUES ('1875', '1874', '沈阳市', '3', '0', '0', '0', ',3268,1874,1875,');
INSERT INTO `cmf_regions` VALUES ('1876', '1875', '和平区', '4', '0', '0', '0', ',3268,1874,1875,1876,');
INSERT INTO `cmf_regions` VALUES ('1877', '1875', '沈河区', '4', '0', '0', '0', ',3268,1874,1875,1877,');
INSERT INTO `cmf_regions` VALUES ('1878', '1875', '大东区', '4', '0', '0', '0', ',3268,1874,1875,1878,');
INSERT INTO `cmf_regions` VALUES ('1879', '1875', '皇姑区', '4', '0', '0', '0', ',3268,1874,1875,1879,');
INSERT INTO `cmf_regions` VALUES ('1880', '1875', '铁西区', '4', '0', '0', '0', ',3268,1874,1875,1880,');
INSERT INTO `cmf_regions` VALUES ('1881', '1875', '苏家屯区', '4', '0', '0', '0', ',3268,1874,1875,1881,');
INSERT INTO `cmf_regions` VALUES ('1882', '1875', '东陵区', '4', '0', '0', '0', ',3268,1874,1875,1882,');
INSERT INTO `cmf_regions` VALUES ('1883', '1875', '新城子区', '4', '0', '0', '0', ',3268,1874,1875,1883,');
INSERT INTO `cmf_regions` VALUES ('1884', '1875', '于洪区', '4', '0', '0', '0', ',3268,1874,1875,1884,');
INSERT INTO `cmf_regions` VALUES ('1885', '1875', '辽中县', '4', '0', '0', '0', ',3268,1874,1875,1885,');
INSERT INTO `cmf_regions` VALUES ('1886', '1875', '康平县', '4', '0', '0', '0', ',3268,1874,1875,1886,');
INSERT INTO `cmf_regions` VALUES ('1887', '1875', '法库县', '4', '0', '0', '0', ',3268,1874,1875,1887,');
INSERT INTO `cmf_regions` VALUES ('1888', '1875', '新民市', '4', '0', '0', '0', ',3268,1874,1875,1888,');
INSERT INTO `cmf_regions` VALUES ('1889', '1874', '鞍山市', '3', '0', '0', '0', ',3268,1874,1889,');
INSERT INTO `cmf_regions` VALUES ('1890', '1889', '铁东区', '4', '0', '0', '0', ',3268,1874,1889,1890,');
INSERT INTO `cmf_regions` VALUES ('1891', '1889', '铁西区', '4', '0', '0', '0', ',3268,1874,1889,1891,');
INSERT INTO `cmf_regions` VALUES ('1892', '1889', '立山区', '4', '0', '0', '0', ',3268,1874,1889,1892,');
INSERT INTO `cmf_regions` VALUES ('1893', '1889', '千山区', '4', '0', '0', '0', ',3268,1874,1889,1893,');
INSERT INTO `cmf_regions` VALUES ('1894', '1889', '台安县', '4', '0', '0', '0', ',3268,1874,1889,1894,');
INSERT INTO `cmf_regions` VALUES ('1895', '1889', '岫岩满族自治县', '4', '0', '0', '0', ',3268,1874,1889,1895,');
INSERT INTO `cmf_regions` VALUES ('1896', '1889', '海城市', '4', '0', '0', '0', ',3268,1874,1889,1896,');
INSERT INTO `cmf_regions` VALUES ('1897', '1874', '本溪市', '3', '0', '0', '0', ',3268,1874,1897,');
INSERT INTO `cmf_regions` VALUES ('1898', '1897', '平山区', '4', '0', '0', '0', ',3268,1874,1897,1898,');
INSERT INTO `cmf_regions` VALUES ('1899', '1897', '溪湖区', '4', '0', '0', '0', ',3268,1874,1897,1899,');
INSERT INTO `cmf_regions` VALUES ('1900', '1897', '明山区', '4', '0', '0', '0', ',3268,1874,1897,1900,');
INSERT INTO `cmf_regions` VALUES ('1901', '1897', '南芬区', '4', '0', '0', '0', ',3268,1874,1897,1901,');
INSERT INTO `cmf_regions` VALUES ('1902', '1897', '本溪满族自治县', '4', '0', '0', '0', ',3268,1874,1897,1902,');
INSERT INTO `cmf_regions` VALUES ('1903', '1897', '桓仁满族自治县', '4', '0', '0', '0', ',3268,1874,1897,1903,');
INSERT INTO `cmf_regions` VALUES ('1904', '1874', '朝阳市', '3', '0', '0', '0', ',3268,1874,1904,');
INSERT INTO `cmf_regions` VALUES ('1905', '1904', '双塔区', '4', '0', '0', '0', ',3268,1874,1904,1905,');
INSERT INTO `cmf_regions` VALUES ('1906', '1904', '龙城区', '4', '0', '0', '0', ',3268,1874,1904,1906,');
INSERT INTO `cmf_regions` VALUES ('1907', '1904', '朝阳县', '4', '0', '0', '0', ',3268,1874,1904,1907,');
INSERT INTO `cmf_regions` VALUES ('1908', '1904', '建平县', '4', '0', '0', '0', ',3268,1874,1904,1908,');
INSERT INTO `cmf_regions` VALUES ('1909', '1904', '喀喇沁左翼蒙古族自治县', '4', '0', '0', '0', ',3268,1874,1904,1909,');
INSERT INTO `cmf_regions` VALUES ('1910', '1904', '北票市', '4', '0', '0', '0', ',3268,1874,1904,1910,');
INSERT INTO `cmf_regions` VALUES ('1911', '1904', '凌源市', '4', '0', '0', '0', ',3268,1874,1904,1911,');
INSERT INTO `cmf_regions` VALUES ('1912', '1874', '大连市', '3', '0', '0', '0', ',3268,1874,1912,');
INSERT INTO `cmf_regions` VALUES ('1913', '1912', '中山区', '4', '0', '0', '0', ',3268,1874,1912,1913,');
INSERT INTO `cmf_regions` VALUES ('1914', '1912', '西岗区', '4', '0', '0', '0', ',3268,1874,1912,1914,');
INSERT INTO `cmf_regions` VALUES ('1915', '1912', '沙河口区', '4', '0', '0', '0', ',3268,1874,1912,1915,');
INSERT INTO `cmf_regions` VALUES ('1916', '1912', '甘井子区', '4', '0', '0', '0', ',3268,1874,1912,1916,');
INSERT INTO `cmf_regions` VALUES ('1917', '1912', '旅顺口区', '4', '0', '0', '0', ',3268,1874,1912,1917,');
INSERT INTO `cmf_regions` VALUES ('1918', '1912', '金州区', '4', '0', '0', '0', ',3268,1874,1912,1918,');
INSERT INTO `cmf_regions` VALUES ('1919', '1912', '长海县', '4', '0', '0', '0', ',3268,1874,1912,1919,');
INSERT INTO `cmf_regions` VALUES ('1920', '1912', '瓦房店市', '4', '0', '0', '0', ',3268,1874,1912,1920,');
INSERT INTO `cmf_regions` VALUES ('1921', '1912', '普兰店市', '4', '0', '0', '0', ',3268,1874,1912,1921,');
INSERT INTO `cmf_regions` VALUES ('1922', '1912', '庄河市', '4', '0', '0', '0', ',3268,1874,1912,1922,');
INSERT INTO `cmf_regions` VALUES ('1923', '1874', '丹东市', '3', '0', '0', '0', ',3268,1874,1923,');
INSERT INTO `cmf_regions` VALUES ('1924', '1923', '元宝区', '4', '0', '0', '0', ',3268,1874,1923,1924,');
INSERT INTO `cmf_regions` VALUES ('1925', '1923', '振兴区', '4', '0', '0', '0', ',3268,1874,1923,1925,');
INSERT INTO `cmf_regions` VALUES ('1926', '1923', '振安区', '4', '0', '0', '0', ',3268,1874,1923,1926,');
INSERT INTO `cmf_regions` VALUES ('1927', '1923', '宽甸满族自治县', '4', '0', '0', '0', ',3268,1874,1923,1927,');
INSERT INTO `cmf_regions` VALUES ('1928', '1923', '东港市', '4', '0', '0', '0', ',3268,1874,1923,1928,');
INSERT INTO `cmf_regions` VALUES ('1929', '1923', '凤城市', '4', '0', '0', '0', ',3268,1874,1923,1929,');
INSERT INTO `cmf_regions` VALUES ('1930', '1874', '抚顺市', '3', '0', '0', '0', ',3268,1874,1930,');
INSERT INTO `cmf_regions` VALUES ('1931', '1930', '新抚区', '4', '0', '0', '0', ',3268,1874,1930,1931,');
INSERT INTO `cmf_regions` VALUES ('1932', '1930', '东洲区', '4', '0', '0', '0', ',3268,1874,1930,1932,');
INSERT INTO `cmf_regions` VALUES ('1933', '1930', '望花区', '4', '0', '0', '0', ',3268,1874,1930,1933,');
INSERT INTO `cmf_regions` VALUES ('1934', '1930', '顺城区', '4', '0', '0', '0', ',3268,1874,1930,1934,');
INSERT INTO `cmf_regions` VALUES ('1935', '1930', '抚顺县', '4', '0', '0', '0', ',3268,1874,1930,1935,');
INSERT INTO `cmf_regions` VALUES ('1936', '1930', '新宾满族自治县', '4', '0', '0', '0', ',3268,1874,1930,1936,');
INSERT INTO `cmf_regions` VALUES ('1937', '1930', '清原满族自治县', '4', '0', '0', '0', ',3268,1874,1930,1937,');
INSERT INTO `cmf_regions` VALUES ('1938', '1874', '阜新市', '3', '0', '0', '0', ',3268,1874,1938,');
INSERT INTO `cmf_regions` VALUES ('1939', '1938', '海州区', '4', '0', '0', '0', ',3268,1874,1938,1939,');
INSERT INTO `cmf_regions` VALUES ('1940', '1938', '新邱区', '4', '0', '0', '0', ',3268,1874,1938,1940,');
INSERT INTO `cmf_regions` VALUES ('1941', '1938', '太平区', '4', '0', '0', '0', ',3268,1874,1938,1941,');
INSERT INTO `cmf_regions` VALUES ('1942', '1938', '清河门区', '4', '0', '0', '0', ',3268,1874,1938,1942,');
INSERT INTO `cmf_regions` VALUES ('1943', '1938', '细河区', '4', '0', '0', '0', ',3268,1874,1938,1943,');
INSERT INTO `cmf_regions` VALUES ('1944', '1938', '阜新蒙古族自治县', '4', '0', '0', '0', ',3268,1874,1938,1944,');
INSERT INTO `cmf_regions` VALUES ('1945', '1938', '彰武县', '4', '0', '0', '0', ',3268,1874,1938,1945,');
INSERT INTO `cmf_regions` VALUES ('1946', '1874', '葫芦岛市', '3', '0', '0', '0', ',3268,1874,1946,');
INSERT INTO `cmf_regions` VALUES ('1947', '1946', '连山区', '4', '0', '0', '0', ',3268,1874,1946,1947,');
INSERT INTO `cmf_regions` VALUES ('1948', '1946', '龙港区', '4', '0', '0', '0', ',3268,1874,1946,1948,');
INSERT INTO `cmf_regions` VALUES ('1949', '1946', '南票区', '4', '0', '0', '0', ',3268,1874,1946,1949,');
INSERT INTO `cmf_regions` VALUES ('1950', '1946', '绥中县', '4', '0', '0', '0', ',3268,1874,1946,1950,');
INSERT INTO `cmf_regions` VALUES ('1951', '1946', '建昌县', '4', '0', '0', '0', ',3268,1874,1946,1951,');
INSERT INTO `cmf_regions` VALUES ('1952', '1946', '兴城市', '4', '0', '0', '0', ',3268,1874,1946,1952,');
INSERT INTO `cmf_regions` VALUES ('1953', '1874', '锦州市', '3', '0', '0', '0', ',3268,1874,1953,');
INSERT INTO `cmf_regions` VALUES ('1954', '1953', '古塔区', '4', '0', '0', '0', ',3268,1874,1953,1954,');
INSERT INTO `cmf_regions` VALUES ('1955', '1953', '凌河区', '4', '0', '0', '0', ',3268,1874,1953,1955,');
INSERT INTO `cmf_regions` VALUES ('1956', '1953', '太和区', '4', '0', '0', '0', ',3268,1874,1953,1956,');
INSERT INTO `cmf_regions` VALUES ('1957', '1953', '黑山县', '4', '0', '0', '0', ',3268,1874,1953,1957,');
INSERT INTO `cmf_regions` VALUES ('1958', '1953', '义县', '4', '0', '0', '0', ',3268,1874,1953,1958,');
INSERT INTO `cmf_regions` VALUES ('1959', '1953', '凌海市', '4', '0', '0', '0', ',3268,1874,1953,1959,');
INSERT INTO `cmf_regions` VALUES ('1960', '1953', '北宁市', '4', '0', '0', '0', ',3268,1874,1953,1960,');
INSERT INTO `cmf_regions` VALUES ('1961', '1874', '辽阳市', '3', '0', '0', '0', ',3268,1874,1961,');
INSERT INTO `cmf_regions` VALUES ('1962', '1961', '白塔区', '4', '0', '0', '0', ',3268,1874,1961,1962,');
INSERT INTO `cmf_regions` VALUES ('1963', '1961', '文圣区', '4', '0', '0', '0', ',3268,1874,1961,1963,');
INSERT INTO `cmf_regions` VALUES ('1964', '1961', '宏伟区', '4', '0', '0', '0', ',3268,1874,1961,1964,');
INSERT INTO `cmf_regions` VALUES ('1965', '1961', '弓长岭区', '4', '0', '0', '0', ',3268,1874,1961,1965,');
INSERT INTO `cmf_regions` VALUES ('1966', '1961', '太子河区', '4', '0', '0', '0', ',3268,1874,1961,1966,');
INSERT INTO `cmf_regions` VALUES ('1967', '1961', '辽阳县', '4', '0', '0', '0', ',3268,1874,1961,1967,');
INSERT INTO `cmf_regions` VALUES ('1968', '1961', '灯塔市', '4', '0', '0', '0', ',3268,1874,1961,1968,');
INSERT INTO `cmf_regions` VALUES ('1969', '1874', '盘锦市', '3', '0', '0', '0', ',3268,1874,1969,');
INSERT INTO `cmf_regions` VALUES ('1970', '1969', '双台子区', '4', '0', '0', '0', ',3268,1874,1969,1970,');
INSERT INTO `cmf_regions` VALUES ('1971', '1969', '兴隆台区', '4', '0', '0', '0', ',3268,1874,1969,1971,');
INSERT INTO `cmf_regions` VALUES ('1972', '1969', '大洼县', '4', '0', '0', '0', ',3268,1874,1969,1972,');
INSERT INTO `cmf_regions` VALUES ('1973', '1969', '盘山县', '4', '0', '0', '0', ',3268,1874,1969,1973,');
INSERT INTO `cmf_regions` VALUES ('1974', '1874', '铁岭市', '3', '0', '0', '0', ',3268,1874,1974,');
INSERT INTO `cmf_regions` VALUES ('1975', '1974', '银州区', '4', '0', '0', '0', ',3268,1874,1974,1975,');
INSERT INTO `cmf_regions` VALUES ('1976', '1974', '清河区', '4', '0', '0', '0', ',3268,1874,1974,1976,');
INSERT INTO `cmf_regions` VALUES ('1977', '1974', '铁岭县', '4', '0', '0', '0', ',3268,1874,1974,1977,');
INSERT INTO `cmf_regions` VALUES ('1978', '1974', '西丰县', '4', '0', '0', '0', ',3268,1874,1974,1978,');
INSERT INTO `cmf_regions` VALUES ('1979', '1974', '昌图县', '4', '0', '0', '0', ',3268,1874,1974,1979,');
INSERT INTO `cmf_regions` VALUES ('1980', '1974', '调兵山市', '4', '0', '0', '0', ',3268,1874,1974,1980,');
INSERT INTO `cmf_regions` VALUES ('1981', '1974', '开原市', '4', '0', '0', '0', ',3268,1874,1974,1981,');
INSERT INTO `cmf_regions` VALUES ('1982', '1874', '营口市', '3', '0', '0', '0', ',3268,1874,1982,');
INSERT INTO `cmf_regions` VALUES ('1983', '1982', '站前区', '4', '0', '0', '0', ',3268,1874,1982,1983,');
INSERT INTO `cmf_regions` VALUES ('1984', '1982', '西市区', '4', '0', '0', '0', ',3268,1874,1982,1984,');
INSERT INTO `cmf_regions` VALUES ('1985', '1982', '鲅鱼圈区', '4', '0', '0', '0', ',3268,1874,1982,1985,');
INSERT INTO `cmf_regions` VALUES ('1986', '1982', '老边区', '4', '0', '0', '0', ',3268,1874,1982,1986,');
INSERT INTO `cmf_regions` VALUES ('1987', '1982', '盖州市', '4', '0', '0', '0', ',3268,1874,1982,1987,');
INSERT INTO `cmf_regions` VALUES ('1988', '1982', '大石桥市', '4', '0', '0', '0', ',3268,1874,1982,1988,');
INSERT INTO `cmf_regions` VALUES ('1989', '3268', '内蒙古', '2', '0', '0', '0', ',3268,1989,');
INSERT INTO `cmf_regions` VALUES ('1990', '1989', '呼和浩特市', '3', '0', '0', '0', ',3268,1989,1990,');
INSERT INTO `cmf_regions` VALUES ('1991', '1990', '新城区', '4', '0', '0', '0', ',3268,1989,1990,1991,');
INSERT INTO `cmf_regions` VALUES ('1992', '1990', '回民区', '4', '0', '0', '0', ',3268,1989,1990,1992,');
INSERT INTO `cmf_regions` VALUES ('1993', '1990', '玉泉区', '4', '0', '0', '0', ',3268,1989,1990,1993,');
INSERT INTO `cmf_regions` VALUES ('1994', '1990', '赛罕区', '4', '0', '0', '0', ',3268,1989,1990,1994,');
INSERT INTO `cmf_regions` VALUES ('1995', '1990', '土默特左旗', '4', '0', '0', '0', ',3268,1989,1990,1995,');
INSERT INTO `cmf_regions` VALUES ('1996', '1990', '托克托县', '4', '0', '0', '0', ',3268,1989,1990,1996,');
INSERT INTO `cmf_regions` VALUES ('1997', '1990', '和林格尔县', '4', '0', '0', '0', ',3268,1989,1990,1997,');
INSERT INTO `cmf_regions` VALUES ('1998', '1990', '清水河县', '4', '0', '0', '0', ',3268,1989,1990,1998,');
INSERT INTO `cmf_regions` VALUES ('1999', '1990', '武川县', '4', '0', '0', '0', ',3268,1989,1990,1999,');
INSERT INTO `cmf_regions` VALUES ('2000', '1989', '阿拉善盟', '3', '0', '0', '0', ',3268,1989,2000,');
INSERT INTO `cmf_regions` VALUES ('2001', '2000', '阿拉善左旗', '4', '0', '0', '0', ',3268,1989,2000,2001,');
INSERT INTO `cmf_regions` VALUES ('2002', '2000', '阿拉善右旗', '4', '0', '0', '0', ',3268,1989,2000,2002,');
INSERT INTO `cmf_regions` VALUES ('2003', '2000', '额济纳旗', '4', '0', '0', '0', ',3268,1989,2000,2003,');
INSERT INTO `cmf_regions` VALUES ('2004', '1989', '巴彦淖尔市', '3', '0', '0', '0', ',3268,1989,2004,');
INSERT INTO `cmf_regions` VALUES ('2005', '2004', '临河区', '4', '0', '0', '0', ',3268,1989,2004,2005,');
INSERT INTO `cmf_regions` VALUES ('2006', '2004', '五原县', '4', '0', '0', '0', ',3268,1989,2004,2006,');
INSERT INTO `cmf_regions` VALUES ('2007', '2004', '磴口县', '4', '0', '0', '0', ',3268,1989,2004,2007,');
INSERT INTO `cmf_regions` VALUES ('2008', '2004', '乌拉特前旗', '4', '0', '0', '0', ',3268,1989,2004,2008,');
INSERT INTO `cmf_regions` VALUES ('2009', '2004', '乌拉特中旗', '4', '0', '0', '0', ',3268,1989,2004,2009,');
INSERT INTO `cmf_regions` VALUES ('2010', '2004', '乌拉特后旗', '4', '0', '0', '0', ',3268,1989,2004,2010,');
INSERT INTO `cmf_regions` VALUES ('2011', '2004', '杭锦后旗', '4', '0', '0', '0', ',3268,1989,2004,2011,');
INSERT INTO `cmf_regions` VALUES ('2012', '1989', '包头市', '3', '0', '0', '0', ',3268,1989,2012,');
INSERT INTO `cmf_regions` VALUES ('2013', '2012', '东河区', '4', '0', '0', '0', ',3268,1989,2012,2013,');
INSERT INTO `cmf_regions` VALUES ('2014', '2012', '昆都仑区', '4', '0', '0', '0', ',3268,1989,2012,2014,');
INSERT INTO `cmf_regions` VALUES ('2015', '2012', '青山区', '4', '0', '0', '0', ',3268,1989,2012,2015,');
INSERT INTO `cmf_regions` VALUES ('2016', '2012', '石拐区', '4', '0', '0', '0', ',3268,1989,2012,2016,');
INSERT INTO `cmf_regions` VALUES ('2017', '2012', '白云矿区', '4', '0', '0', '0', ',3268,1989,2012,2017,');
INSERT INTO `cmf_regions` VALUES ('2018', '2012', '九原区', '4', '0', '0', '0', ',3268,1989,2012,2018,');
INSERT INTO `cmf_regions` VALUES ('2019', '2012', '土默特右旗', '4', '0', '0', '0', ',3268,1989,2012,2019,');
INSERT INTO `cmf_regions` VALUES ('2020', '2012', '固阳县', '4', '0', '0', '0', ',3268,1989,2012,2020,');
INSERT INTO `cmf_regions` VALUES ('2021', '2012', '达尔罕茂明安联合旗', '4', '0', '0', '0', ',3268,1989,2012,2021,');
INSERT INTO `cmf_regions` VALUES ('2022', '1989', '赤峰市', '3', '0', '0', '0', ',3268,1989,2022,');
INSERT INTO `cmf_regions` VALUES ('2023', '2022', '红山区', '4', '0', '0', '0', ',3268,1989,2022,2023,');
INSERT INTO `cmf_regions` VALUES ('2024', '2022', '元宝山区', '4', '0', '0', '0', ',3268,1989,2022,2024,');
INSERT INTO `cmf_regions` VALUES ('2025', '2022', '松山区', '4', '0', '0', '0', ',3268,1989,2022,2025,');
INSERT INTO `cmf_regions` VALUES ('2026', '2022', '阿鲁科尔沁旗', '4', '0', '0', '0', ',3268,1989,2022,2026,');
INSERT INTO `cmf_regions` VALUES ('2027', '2022', '巴林左旗', '4', '0', '0', '0', ',3268,1989,2022,2027,');
INSERT INTO `cmf_regions` VALUES ('2028', '2022', '巴林右旗', '4', '0', '0', '0', ',3268,1989,2022,2028,');
INSERT INTO `cmf_regions` VALUES ('2029', '2022', '林西县', '4', '0', '0', '0', ',3268,1989,2022,2029,');
INSERT INTO `cmf_regions` VALUES ('2030', '2022', '克什克腾旗', '4', '0', '0', '0', ',3268,1989,2022,2030,');
INSERT INTO `cmf_regions` VALUES ('2031', '2022', '翁牛特旗', '4', '0', '0', '0', ',3268,1989,2022,2031,');
INSERT INTO `cmf_regions` VALUES ('2032', '2022', '喀喇沁旗', '4', '0', '0', '0', ',3268,1989,2022,2032,');
INSERT INTO `cmf_regions` VALUES ('2033', '2022', '宁城县', '4', '0', '0', '0', ',3268,1989,2022,2033,');
INSERT INTO `cmf_regions` VALUES ('2034', '2022', '敖汉旗', '4', '0', '0', '0', ',3268,1989,2022,2034,');
INSERT INTO `cmf_regions` VALUES ('2035', '1989', '鄂尔多斯市', '3', '0', '0', '0', ',3268,1989,2035,');
INSERT INTO `cmf_regions` VALUES ('2036', '2035', '东胜区', '4', '0', '0', '0', ',3268,1989,2035,2036,');
INSERT INTO `cmf_regions` VALUES ('2037', '2035', '达拉特旗', '4', '0', '0', '0', ',3268,1989,2035,2037,');
INSERT INTO `cmf_regions` VALUES ('2038', '2035', '准格尔旗', '4', '0', '0', '0', ',3268,1989,2035,2038,');
INSERT INTO `cmf_regions` VALUES ('2039', '2035', '鄂托克前旗', '4', '0', '0', '0', ',3268,1989,2035,2039,');
INSERT INTO `cmf_regions` VALUES ('2040', '2035', '鄂托克旗', '4', '0', '0', '0', ',3268,1989,2035,2040,');
INSERT INTO `cmf_regions` VALUES ('2041', '2035', '杭锦旗', '4', '0', '0', '0', ',3268,1989,2035,2041,');
INSERT INTO `cmf_regions` VALUES ('2042', '2035', '乌审旗', '4', '0', '0', '0', ',3268,1989,2035,2042,');
INSERT INTO `cmf_regions` VALUES ('2043', '2035', '伊金霍洛旗', '4', '0', '0', '0', ',3268,1989,2035,2043,');
INSERT INTO `cmf_regions` VALUES ('2044', '1989', '呼伦贝尔市', '3', '0', '0', '0', ',3268,1989,2044,');
INSERT INTO `cmf_regions` VALUES ('2045', '2044', '海拉尔区', '4', '0', '0', '0', ',3268,1989,2044,2045,');
INSERT INTO `cmf_regions` VALUES ('2046', '2044', '阿荣旗', '4', '0', '0', '0', ',3268,1989,2044,2046,');
INSERT INTO `cmf_regions` VALUES ('2047', '2044', '莫力达瓦达斡尔族自治旗', '4', '0', '0', '0', ',3268,1989,2044,2047,');
INSERT INTO `cmf_regions` VALUES ('2048', '2044', '鄂伦春自治旗', '4', '0', '0', '0', ',3268,1989,2044,2048,');
INSERT INTO `cmf_regions` VALUES ('2049', '2044', '鄂温克族自治旗', '4', '0', '0', '0', ',3268,1989,2044,2049,');
INSERT INTO `cmf_regions` VALUES ('2050', '2044', '陈巴尔虎旗', '4', '0', '0', '0', ',3268,1989,2044,2050,');
INSERT INTO `cmf_regions` VALUES ('2051', '2044', '新巴尔虎左旗', '4', '0', '0', '0', ',3268,1989,2044,2051,');
INSERT INTO `cmf_regions` VALUES ('2052', '2044', '新巴尔虎右旗', '4', '0', '0', '0', ',3268,1989,2044,2052,');
INSERT INTO `cmf_regions` VALUES ('2053', '2044', '满洲里市', '4', '0', '0', '0', ',3268,1989,2044,2053,');
INSERT INTO `cmf_regions` VALUES ('2054', '2044', '牙克石市', '4', '0', '0', '0', ',3268,1989,2044,2054,');
INSERT INTO `cmf_regions` VALUES ('2055', '2044', '扎兰屯市', '4', '0', '0', '0', ',3268,1989,2044,2055,');
INSERT INTO `cmf_regions` VALUES ('2056', '2044', '额尔古纳市', '4', '0', '0', '0', ',3268,1989,2044,2056,');
INSERT INTO `cmf_regions` VALUES ('2057', '2044', '根河市', '4', '0', '0', '0', ',3268,1989,2044,2057,');
INSERT INTO `cmf_regions` VALUES ('2058', '1989', '通辽市', '3', '0', '0', '0', ',3268,1989,2058,');
INSERT INTO `cmf_regions` VALUES ('2059', '2058', '科尔沁区', '4', '0', '0', '0', ',3268,1989,2058,2059,');
INSERT INTO `cmf_regions` VALUES ('2060', '2058', '科尔沁左翼中旗', '4', '0', '0', '0', ',3268,1989,2058,2060,');
INSERT INTO `cmf_regions` VALUES ('2061', '2058', '科尔沁左翼后旗', '4', '0', '0', '0', ',3268,1989,2058,2061,');
INSERT INTO `cmf_regions` VALUES ('2062', '2058', '开鲁县', '4', '0', '0', '0', ',3268,1989,2058,2062,');
INSERT INTO `cmf_regions` VALUES ('2063', '2058', '库伦旗', '4', '0', '0', '0', ',3268,1989,2058,2063,');
INSERT INTO `cmf_regions` VALUES ('2064', '2058', '奈曼旗', '4', '0', '0', '0', ',3268,1989,2058,2064,');
INSERT INTO `cmf_regions` VALUES ('2065', '2058', '扎鲁特旗', '4', '0', '0', '0', ',3268,1989,2058,2065,');
INSERT INTO `cmf_regions` VALUES ('2066', '2058', '霍林郭勒市', '4', '0', '0', '0', ',3268,1989,2058,2066,');
INSERT INTO `cmf_regions` VALUES ('2067', '1989', '乌海市', '3', '0', '0', '0', ',3268,1989,2067,');
INSERT INTO `cmf_regions` VALUES ('2068', '2067', '海勃湾区', '4', '0', '0', '0', ',3268,1989,2067,2068,');
INSERT INTO `cmf_regions` VALUES ('2069', '2067', '海南区', '4', '0', '0', '0', ',3268,1989,2067,2069,');
INSERT INTO `cmf_regions` VALUES ('2070', '2067', '乌达区', '4', '0', '0', '0', ',3268,1989,2067,2070,');
INSERT INTO `cmf_regions` VALUES ('2071', '1989', '乌兰察布市', '3', '0', '0', '0', ',3268,1989,2071,');
INSERT INTO `cmf_regions` VALUES ('2072', '2071', '集宁区', '4', '0', '0', '0', ',3268,1989,2071,2072,');
INSERT INTO `cmf_regions` VALUES ('2073', '2071', '卓资县', '4', '0', '0', '0', ',3268,1989,2071,2073,');
INSERT INTO `cmf_regions` VALUES ('2074', '2071', '化德县', '4', '0', '0', '0', ',3268,1989,2071,2074,');
INSERT INTO `cmf_regions` VALUES ('2075', '2071', '商都县', '4', '0', '0', '0', ',3268,1989,2071,2075,');
INSERT INTO `cmf_regions` VALUES ('2076', '2071', '兴和县', '4', '0', '0', '0', ',3268,1989,2071,2076,');
INSERT INTO `cmf_regions` VALUES ('2077', '2071', '凉城县', '4', '0', '0', '0', ',3268,1989,2071,2077,');
INSERT INTO `cmf_regions` VALUES ('2078', '2071', '察哈尔右翼前旗', '4', '0', '0', '0', ',3268,1989,2071,2078,');
INSERT INTO `cmf_regions` VALUES ('2079', '2071', '察哈尔右翼中旗', '4', '0', '0', '0', ',3268,1989,2071,2079,');
INSERT INTO `cmf_regions` VALUES ('2080', '2071', '察哈尔右翼后旗', '4', '0', '0', '0', ',3268,1989,2071,2080,');
INSERT INTO `cmf_regions` VALUES ('2081', '2071', '四子王旗', '4', '0', '0', '0', ',3268,1989,2071,2081,');
INSERT INTO `cmf_regions` VALUES ('2082', '2071', '丰镇市', '4', '0', '0', '0', ',3268,1989,2071,2082,');
INSERT INTO `cmf_regions` VALUES ('2083', '1989', '锡林郭勒盟', '3', '0', '0', '0', ',3268,1989,2083,');
INSERT INTO `cmf_regions` VALUES ('2084', '2083', '二连浩特市', '4', '0', '0', '0', ',3268,1989,2083,2084,');
INSERT INTO `cmf_regions` VALUES ('2085', '2083', '锡林浩特市', '4', '0', '0', '0', ',3268,1989,2083,2085,');
INSERT INTO `cmf_regions` VALUES ('2086', '2083', '阿巴嘎旗', '4', '0', '0', '0', ',3268,1989,2083,2086,');
INSERT INTO `cmf_regions` VALUES ('2087', '2083', '苏尼特左旗', '4', '0', '0', '0', ',3268,1989,2083,2087,');
INSERT INTO `cmf_regions` VALUES ('2088', '2083', '苏尼特右旗', '4', '0', '0', '0', ',3268,1989,2083,2088,');
INSERT INTO `cmf_regions` VALUES ('2089', '2083', '东乌珠穆沁旗', '4', '0', '0', '0', ',3268,1989,2083,2089,');
INSERT INTO `cmf_regions` VALUES ('2090', '2083', '西乌珠穆沁旗', '4', '0', '0', '0', ',3268,1989,2083,2090,');
INSERT INTO `cmf_regions` VALUES ('2091', '2083', '太仆寺旗', '4', '0', '0', '0', ',3268,1989,2083,2091,');
INSERT INTO `cmf_regions` VALUES ('2092', '2083', '镶黄旗', '4', '0', '0', '0', ',3268,1989,2083,2092,');
INSERT INTO `cmf_regions` VALUES ('2093', '2083', '正镶白旗', '4', '0', '0', '0', ',3268,1989,2083,2093,');
INSERT INTO `cmf_regions` VALUES ('2094', '2083', '正蓝旗', '4', '0', '0', '0', ',3268,1989,2083,2094,');
INSERT INTO `cmf_regions` VALUES ('2095', '2083', '多伦县', '4', '0', '0', '0', ',3268,1989,2083,2095,');
INSERT INTO `cmf_regions` VALUES ('2096', '1989', '兴安盟', '3', '0', '0', '0', ',3268,1989,2096,');
INSERT INTO `cmf_regions` VALUES ('2097', '2096', '乌兰浩特市', '4', '0', '0', '0', ',3268,1989,2096,2097,');
INSERT INTO `cmf_regions` VALUES ('2098', '2096', '阿尔山市', '4', '0', '0', '0', ',3268,1989,2096,2098,');
INSERT INTO `cmf_regions` VALUES ('2099', '2096', '科尔沁右翼前旗', '4', '0', '0', '0', ',3268,1989,2096,2099,');
INSERT INTO `cmf_regions` VALUES ('2100', '2096', '科尔沁右翼中旗', '4', '0', '0', '0', ',3268,1989,2096,2100,');
INSERT INTO `cmf_regions` VALUES ('2101', '2096', '扎赉特旗', '4', '0', '0', '0', ',3268,1989,2096,2101,');
INSERT INTO `cmf_regions` VALUES ('2102', '2096', '突泉县', '4', '0', '0', '0', ',3268,1989,2096,2102,');
INSERT INTO `cmf_regions` VALUES ('2103', '3268', '宁夏', '2', '0', '0', '0', ',3268,2103,');
INSERT INTO `cmf_regions` VALUES ('2104', '2103', '银川市', '3', '0', '0', '0', ',3268,2103,2104,');
INSERT INTO `cmf_regions` VALUES ('2105', '2104', '兴庆区', '4', '0', '0', '0', ',3268,2103,2104,2105,');
INSERT INTO `cmf_regions` VALUES ('2106', '2104', '西夏区', '4', '0', '0', '0', ',3268,2103,2104,2106,');
INSERT INTO `cmf_regions` VALUES ('2107', '2104', '金凤区', '4', '0', '0', '0', ',3268,2103,2104,2107,');
INSERT INTO `cmf_regions` VALUES ('2108', '2104', '永宁县', '4', '0', '0', '0', ',3268,2103,2104,2108,');
INSERT INTO `cmf_regions` VALUES ('2109', '2104', '贺兰县', '4', '0', '0', '0', ',3268,2103,2104,2109,');
INSERT INTO `cmf_regions` VALUES ('2110', '2104', '灵武市', '4', '0', '0', '0', ',3268,2103,2104,2110,');
INSERT INTO `cmf_regions` VALUES ('2111', '2103', '固原市', '3', '0', '0', '0', ',3268,2103,2111,');
INSERT INTO `cmf_regions` VALUES ('2112', '2111', '原州区', '4', '0', '0', '0', ',3268,2103,2111,2112,');
INSERT INTO `cmf_regions` VALUES ('2113', '2111', '西吉县', '4', '0', '0', '0', ',3268,2103,2111,2113,');
INSERT INTO `cmf_regions` VALUES ('2114', '2111', '隆德县', '4', '0', '0', '0', ',3268,2103,2111,2114,');
INSERT INTO `cmf_regions` VALUES ('2115', '2111', '泾源县', '4', '0', '0', '0', ',3268,2103,2111,2115,');
INSERT INTO `cmf_regions` VALUES ('2116', '2111', '彭阳县', '4', '0', '0', '0', ',3268,2103,2111,2116,');
INSERT INTO `cmf_regions` VALUES ('2117', '2103', '石嘴山市', '3', '0', '0', '0', ',3268,2103,2117,');
INSERT INTO `cmf_regions` VALUES ('2118', '2117', '大武口区', '4', '0', '0', '0', ',3268,2103,2117,2118,');
INSERT INTO `cmf_regions` VALUES ('2119', '2117', '惠农区', '4', '0', '0', '0', ',3268,2103,2117,2119,');
INSERT INTO `cmf_regions` VALUES ('2120', '2117', '平罗县', '4', '0', '0', '0', ',3268,2103,2117,2120,');
INSERT INTO `cmf_regions` VALUES ('2121', '2103', '吴忠市', '3', '0', '0', '0', ',3268,2103,2121,');
INSERT INTO `cmf_regions` VALUES ('2122', '2121', '利通区', '4', '0', '0', '0', ',3268,2103,2121,2122,');
INSERT INTO `cmf_regions` VALUES ('2123', '2121', '盐池县', '4', '0', '0', '0', ',3268,2103,2121,2123,');
INSERT INTO `cmf_regions` VALUES ('2124', '2121', '同心县', '4', '0', '0', '0', ',3268,2103,2121,2124,');
INSERT INTO `cmf_regions` VALUES ('2125', '2121', '青铜峡市', '4', '0', '0', '0', ',3268,2103,2121,2125,');
INSERT INTO `cmf_regions` VALUES ('2126', '2103', '中卫市', '3', '0', '0', '0', ',3268,2103,2126,');
INSERT INTO `cmf_regions` VALUES ('2127', '2126', '沙坡头区', '4', '0', '0', '0', ',3268,2103,2126,2127,');
INSERT INTO `cmf_regions` VALUES ('2128', '2126', '中宁县', '4', '0', '0', '0', ',3268,2103,2126,2128,');
INSERT INTO `cmf_regions` VALUES ('2129', '2126', '海原县', '4', '0', '0', '0', ',3268,2103,2126,2129,');
INSERT INTO `cmf_regions` VALUES ('2130', '3268', '青海', '2', '0', '0', '0', ',3268,2130,');
INSERT INTO `cmf_regions` VALUES ('2131', '2130', '西宁市', '3', '0', '0', '0', ',3268,2130,2131,');
INSERT INTO `cmf_regions` VALUES ('2132', '2131', '城东区', '4', '0', '0', '0', ',3268,2130,2131,2132,');
INSERT INTO `cmf_regions` VALUES ('2133', '2131', '城中区', '4', '0', '0', '0', ',3268,2130,2131,2133,');
INSERT INTO `cmf_regions` VALUES ('2134', '2131', '城西区', '4', '0', '0', '0', ',3268,2130,2131,2134,');
INSERT INTO `cmf_regions` VALUES ('2135', '2131', '城北区', '4', '0', '0', '0', ',3268,2130,2131,2135,');
INSERT INTO `cmf_regions` VALUES ('2136', '2131', '大通回族土族自治县', '4', '0', '0', '0', ',3268,2130,2131,2136,');
INSERT INTO `cmf_regions` VALUES ('2137', '2131', '湟中县', '4', '0', '0', '0', ',3268,2130,2131,2137,');
INSERT INTO `cmf_regions` VALUES ('2138', '2131', '湟源县', '4', '0', '0', '0', ',3268,2130,2131,2138,');
INSERT INTO `cmf_regions` VALUES ('2139', '2130', '果洛藏族自治州', '3', '0', '0', '0', ',3268,2130,2139,');
INSERT INTO `cmf_regions` VALUES ('2140', '2139', '玛沁县', '4', '0', '0', '0', ',3268,2130,2139,2140,');
INSERT INTO `cmf_regions` VALUES ('2141', '2139', '班玛县', '4', '0', '0', '0', ',3268,2130,2139,2141,');
INSERT INTO `cmf_regions` VALUES ('2142', '2139', '甘德县', '4', '0', '0', '0', ',3268,2130,2139,2142,');
INSERT INTO `cmf_regions` VALUES ('2143', '2139', '达日县', '4', '0', '0', '0', ',3268,2130,2139,2143,');
INSERT INTO `cmf_regions` VALUES ('2144', '2139', '久治县', '4', '0', '0', '0', ',3268,2130,2139,2144,');
INSERT INTO `cmf_regions` VALUES ('2145', '2139', '玛多县', '4', '0', '0', '0', ',3268,2130,2139,2145,');
INSERT INTO `cmf_regions` VALUES ('2146', '2130', '海北藏族自治州', '3', '0', '0', '0', ',3268,2130,2146,');
INSERT INTO `cmf_regions` VALUES ('2147', '2146', '门源回族自治县', '4', '0', '0', '0', ',3268,2130,2146,2147,');
INSERT INTO `cmf_regions` VALUES ('2148', '2146', '祁连县', '4', '0', '0', '0', ',3268,2130,2146,2148,');
INSERT INTO `cmf_regions` VALUES ('2149', '2146', '海晏县', '4', '0', '0', '0', ',3268,2130,2146,2149,');
INSERT INTO `cmf_regions` VALUES ('2150', '2146', '刚察县', '4', '0', '0', '0', ',3268,2130,2146,2150,');
INSERT INTO `cmf_regions` VALUES ('2151', '2130', '海东地区', '3', '0', '0', '0', ',3268,2130,2151,');
INSERT INTO `cmf_regions` VALUES ('2152', '2151', '平安县', '4', '0', '0', '0', ',3268,2130,2151,2152,');
INSERT INTO `cmf_regions` VALUES ('2153', '2151', '民和回族土族自治县', '4', '0', '0', '0', ',3268,2130,2151,2153,');
INSERT INTO `cmf_regions` VALUES ('2154', '2151', '乐都县', '4', '0', '0', '0', ',3268,2130,2151,2154,');
INSERT INTO `cmf_regions` VALUES ('2155', '2151', '互助土族自治县', '4', '0', '0', '0', ',3268,2130,2151,2155,');
INSERT INTO `cmf_regions` VALUES ('2156', '2151', '化隆回族自治县', '4', '0', '0', '0', ',3268,2130,2151,2156,');
INSERT INTO `cmf_regions` VALUES ('2157', '2151', '循化撒拉族自治县', '4', '0', '0', '0', ',3268,2130,2151,2157,');
INSERT INTO `cmf_regions` VALUES ('2158', '2130', '海南藏族自治州', '3', '0', '0', '0', ',3268,2130,2158,');
INSERT INTO `cmf_regions` VALUES ('2159', '2158', '共和县', '4', '0', '0', '0', ',3268,2130,2158,2159,');
INSERT INTO `cmf_regions` VALUES ('2160', '2158', '同德县', '4', '0', '0', '0', ',3268,2130,2158,2160,');
INSERT INTO `cmf_regions` VALUES ('2161', '2158', '贵德县', '4', '0', '0', '0', ',3268,2130,2158,2161,');
INSERT INTO `cmf_regions` VALUES ('2162', '2158', '兴海县', '4', '0', '0', '0', ',3268,2130,2158,2162,');
INSERT INTO `cmf_regions` VALUES ('2163', '2158', '贵南县', '4', '0', '0', '0', ',3268,2130,2158,2163,');
INSERT INTO `cmf_regions` VALUES ('2164', '2130', '海西蒙古族藏族自治州', '3', '0', '0', '0', ',3268,2130,2164,');
INSERT INTO `cmf_regions` VALUES ('2165', '2164', '格尔木市', '4', '0', '0', '0', ',3268,2130,2164,2165,');
INSERT INTO `cmf_regions` VALUES ('2166', '2164', '德令哈市', '4', '0', '0', '0', ',3268,2130,2164,2166,');
INSERT INTO `cmf_regions` VALUES ('2167', '2164', '乌兰县', '4', '0', '0', '0', ',3268,2130,2164,2167,');
INSERT INTO `cmf_regions` VALUES ('2168', '2164', '都兰县', '4', '0', '0', '0', ',3268,2130,2164,2168,');
INSERT INTO `cmf_regions` VALUES ('2169', '2164', '天峻县', '4', '0', '0', '0', ',3268,2130,2164,2169,');
INSERT INTO `cmf_regions` VALUES ('2170', '2130', '黄南藏族自治州', '3', '0', '0', '0', ',3268,2130,2170,');
INSERT INTO `cmf_regions` VALUES ('2171', '2170', '同仁县', '4', '0', '0', '0', ',3268,2130,2170,2171,');
INSERT INTO `cmf_regions` VALUES ('2172', '2170', '尖扎县', '4', '0', '0', '0', ',3268,2130,2170,2172,');
INSERT INTO `cmf_regions` VALUES ('2173', '2170', '泽库县', '4', '0', '0', '0', ',3268,2130,2170,2173,');
INSERT INTO `cmf_regions` VALUES ('2174', '2170', '河南蒙古族自治县', '4', '0', '0', '0', ',3268,2130,2170,2174,');
INSERT INTO `cmf_regions` VALUES ('2175', '2130', '玉树藏族自治州', '3', '0', '0', '0', ',3268,2130,2175,');
INSERT INTO `cmf_regions` VALUES ('2176', '2175', '玉树县', '4', '0', '0', '0', ',3268,2130,2175,2176,');
INSERT INTO `cmf_regions` VALUES ('2177', '2175', '杂多县', '4', '0', '0', '0', ',3268,2130,2175,2177,');
INSERT INTO `cmf_regions` VALUES ('2178', '2175', '称多县', '4', '0', '0', '0', ',3268,2130,2175,2178,');
INSERT INTO `cmf_regions` VALUES ('2179', '2175', '治多县', '4', '0', '0', '0', ',3268,2130,2175,2179,');
INSERT INTO `cmf_regions` VALUES ('2180', '2175', '囊谦县', '4', '0', '0', '0', ',3268,2130,2175,2180,');
INSERT INTO `cmf_regions` VALUES ('2181', '2175', '曲麻莱县', '4', '0', '0', '0', ',3268,2130,2175,2181,');
INSERT INTO `cmf_regions` VALUES ('2182', '3268', '山东', '2', '0', '0', '0', ',3268,2182,');
INSERT INTO `cmf_regions` VALUES ('2183', '2182', '济南市', '3', '0', '0', '0', ',3268,2182,2183,');
INSERT INTO `cmf_regions` VALUES ('2184', '2183', '历下区', '4', '0', '0', '0', ',3268,2182,2183,2184,');
INSERT INTO `cmf_regions` VALUES ('2185', '2183', '市中区', '4', '0', '0', '0', ',3268,2182,2183,2185,');
INSERT INTO `cmf_regions` VALUES ('2186', '2183', '槐荫区', '4', '0', '0', '0', ',3268,2182,2183,2186,');
INSERT INTO `cmf_regions` VALUES ('2187', '2183', '天桥区', '4', '0', '0', '0', ',3268,2182,2183,2187,');
INSERT INTO `cmf_regions` VALUES ('2188', '2183', '历城区', '4', '0', '0', '0', ',3268,2182,2183,2188,');
INSERT INTO `cmf_regions` VALUES ('2189', '2183', '长清区', '4', '0', '0', '0', ',3268,2182,2183,2189,');
INSERT INTO `cmf_regions` VALUES ('2190', '2183', '平阴县', '4', '0', '0', '0', ',3268,2182,2183,2190,');
INSERT INTO `cmf_regions` VALUES ('2191', '2183', '济阳县', '4', '0', '0', '0', ',3268,2182,2183,2191,');
INSERT INTO `cmf_regions` VALUES ('2192', '2183', '商河县', '4', '0', '0', '0', ',3268,2182,2183,2192,');
INSERT INTO `cmf_regions` VALUES ('2193', '2183', '章丘市', '4', '0', '0', '0', ',3268,2182,2183,2193,');
INSERT INTO `cmf_regions` VALUES ('2194', '2182', '滨州市', '3', '0', '0', '0', ',3268,2182,2194,');
INSERT INTO `cmf_regions` VALUES ('2195', '2194', '滨城区', '4', '0', '0', '0', ',3268,2182,2194,2195,');
INSERT INTO `cmf_regions` VALUES ('2196', '2194', '惠民县', '4', '0', '0', '0', ',3268,2182,2194,2196,');
INSERT INTO `cmf_regions` VALUES ('2197', '2194', '阳信县', '4', '0', '0', '0', ',3268,2182,2194,2197,');
INSERT INTO `cmf_regions` VALUES ('2198', '2194', '无棣县', '4', '0', '0', '0', ',3268,2182,2194,2198,');
INSERT INTO `cmf_regions` VALUES ('2199', '2194', '沾化县', '4', '0', '0', '0', ',3268,2182,2194,2199,');
INSERT INTO `cmf_regions` VALUES ('2200', '2194', '博兴县', '4', '0', '0', '0', ',3268,2182,2194,2200,');
INSERT INTO `cmf_regions` VALUES ('2201', '2194', '邹平县', '4', '0', '0', '0', ',3268,2182,2194,2201,');
INSERT INTO `cmf_regions` VALUES ('2202', '2182', '德州市', '3', '0', '0', '0', ',3268,2182,2202,');
INSERT INTO `cmf_regions` VALUES ('2203', '2202', '德城区', '4', '0', '0', '0', ',3268,2182,2202,2203,');
INSERT INTO `cmf_regions` VALUES ('2204', '2202', '陵县', '4', '0', '0', '0', ',3268,2182,2202,2204,');
INSERT INTO `cmf_regions` VALUES ('2205', '2202', '宁津县', '4', '0', '0', '0', ',3268,2182,2202,2205,');
INSERT INTO `cmf_regions` VALUES ('2206', '2202', '庆云县', '4', '0', '0', '0', ',3268,2182,2202,2206,');
INSERT INTO `cmf_regions` VALUES ('2207', '2202', '临邑县', '4', '0', '0', '0', ',3268,2182,2202,2207,');
INSERT INTO `cmf_regions` VALUES ('2208', '2202', '齐河县', '4', '0', '0', '0', ',3268,2182,2202,2208,');
INSERT INTO `cmf_regions` VALUES ('2209', '2202', '平原县', '4', '0', '0', '0', ',3268,2182,2202,2209,');
INSERT INTO `cmf_regions` VALUES ('2210', '2202', '夏津县', '4', '0', '0', '0', ',3268,2182,2202,2210,');
INSERT INTO `cmf_regions` VALUES ('2211', '2202', '武城县', '4', '0', '0', '0', ',3268,2182,2202,2211,');
INSERT INTO `cmf_regions` VALUES ('2212', '2202', '乐陵市', '4', '0', '0', '0', ',3268,2182,2202,2212,');
INSERT INTO `cmf_regions` VALUES ('2213', '2202', '禹城市', '4', '0', '0', '0', ',3268,2182,2202,2213,');
INSERT INTO `cmf_regions` VALUES ('2214', '2182', '东营市', '3', '0', '0', '0', ',3268,2182,2214,');
INSERT INTO `cmf_regions` VALUES ('2215', '2214', '东营区', '4', '0', '0', '0', ',3268,2182,2214,2215,');
INSERT INTO `cmf_regions` VALUES ('2216', '2214', '河口区', '4', '0', '0', '0', ',3268,2182,2214,2216,');
INSERT INTO `cmf_regions` VALUES ('2217', '2214', '垦利县', '4', '0', '0', '0', ',3268,2182,2214,2217,');
INSERT INTO `cmf_regions` VALUES ('2218', '2214', '利津县', '4', '0', '0', '0', ',3268,2182,2214,2218,');
INSERT INTO `cmf_regions` VALUES ('2219', '2214', '广饶县', '4', '0', '0', '0', ',3268,2182,2214,2219,');
INSERT INTO `cmf_regions` VALUES ('2220', '2182', '菏泽市', '3', '0', '0', '0', ',3268,2182,2220,');
INSERT INTO `cmf_regions` VALUES ('2221', '2220', '牡丹区', '4', '0', '0', '0', ',3268,2182,2220,2221,');
INSERT INTO `cmf_regions` VALUES ('2222', '2220', '曹县', '4', '0', '0', '0', ',3268,2182,2220,2222,');
INSERT INTO `cmf_regions` VALUES ('2223', '2220', '单县', '4', '0', '0', '0', ',3268,2182,2220,2223,');
INSERT INTO `cmf_regions` VALUES ('2224', '2220', '成武县', '4', '0', '0', '0', ',3268,2182,2220,2224,');
INSERT INTO `cmf_regions` VALUES ('2225', '2220', '巨野县', '4', '0', '0', '0', ',3268,2182,2220,2225,');
INSERT INTO `cmf_regions` VALUES ('2226', '2220', '郓城县', '4', '0', '0', '0', ',3268,2182,2220,2226,');
INSERT INTO `cmf_regions` VALUES ('2227', '2220', '鄄城县', '4', '0', '0', '0', ',3268,2182,2220,2227,');
INSERT INTO `cmf_regions` VALUES ('2228', '2220', '定陶县', '4', '0', '0', '0', ',3268,2182,2220,2228,');
INSERT INTO `cmf_regions` VALUES ('2229', '2220', '东明县', '4', '0', '0', '0', ',3268,2182,2220,2229,');
INSERT INTO `cmf_regions` VALUES ('2230', '2182', '济宁市', '3', '0', '0', '0', ',3268,2182,2230,');
INSERT INTO `cmf_regions` VALUES ('2231', '2230', '市中区', '4', '0', '0', '0', ',3268,2182,2230,2231,');
INSERT INTO `cmf_regions` VALUES ('2232', '2230', '任城区', '4', '0', '0', '0', ',3268,2182,2230,2232,');
INSERT INTO `cmf_regions` VALUES ('2233', '2230', '微山县', '4', '0', '0', '0', ',3268,2182,2230,2233,');
INSERT INTO `cmf_regions` VALUES ('2234', '2230', '鱼台县', '4', '0', '0', '0', ',3268,2182,2230,2234,');
INSERT INTO `cmf_regions` VALUES ('2235', '2230', '金乡县', '4', '0', '0', '0', ',3268,2182,2230,2235,');
INSERT INTO `cmf_regions` VALUES ('2236', '2230', '嘉祥县', '4', '0', '0', '0', ',3268,2182,2230,2236,');
INSERT INTO `cmf_regions` VALUES ('2237', '2230', '汶上县', '4', '0', '0', '0', ',3268,2182,2230,2237,');
INSERT INTO `cmf_regions` VALUES ('2238', '2230', '泗水县', '4', '0', '0', '0', ',3268,2182,2230,2238,');
INSERT INTO `cmf_regions` VALUES ('2239', '2230', '梁山县', '4', '0', '0', '0', ',3268,2182,2230,2239,');
INSERT INTO `cmf_regions` VALUES ('2240', '2230', '曲阜市', '4', '0', '0', '0', ',3268,2182,2230,2240,');
INSERT INTO `cmf_regions` VALUES ('2241', '2230', '兖州市', '4', '0', '0', '0', ',3268,2182,2230,2241,');
INSERT INTO `cmf_regions` VALUES ('2242', '2230', '邹城市', '4', '0', '0', '0', ',3268,2182,2230,2242,');
INSERT INTO `cmf_regions` VALUES ('2243', '2182', '莱芜市', '3', '0', '0', '0', ',3268,2182,2243,');
INSERT INTO `cmf_regions` VALUES ('2244', '2243', '莱城区', '4', '0', '0', '0', ',3268,2182,2243,2244,');
INSERT INTO `cmf_regions` VALUES ('2245', '2243', '钢城区', '4', '0', '0', '0', ',3268,2182,2243,2245,');
INSERT INTO `cmf_regions` VALUES ('2246', '2182', '聊城市', '3', '0', '0', '0', ',3268,2182,2246,');
INSERT INTO `cmf_regions` VALUES ('2247', '2246', '东昌府区', '4', '0', '0', '0', ',3268,2182,2246,2247,');
INSERT INTO `cmf_regions` VALUES ('2248', '2246', '阳谷县', '4', '0', '0', '0', ',3268,2182,2246,2248,');
INSERT INTO `cmf_regions` VALUES ('2249', '2246', '莘县', '4', '0', '0', '0', ',3268,2182,2246,2249,');
INSERT INTO `cmf_regions` VALUES ('2250', '2246', '茌平县', '4', '0', '0', '0', ',3268,2182,2246,2250,');
INSERT INTO `cmf_regions` VALUES ('2251', '2246', '东阿县', '4', '0', '0', '0', ',3268,2182,2246,2251,');
INSERT INTO `cmf_regions` VALUES ('2252', '2246', '冠县', '4', '0', '0', '0', ',3268,2182,2246,2252,');
INSERT INTO `cmf_regions` VALUES ('2253', '2246', '高唐县', '4', '0', '0', '0', ',3268,2182,2246,2253,');
INSERT INTO `cmf_regions` VALUES ('2254', '2246', '临清市', '4', '0', '0', '0', ',3268,2182,2246,2254,');
INSERT INTO `cmf_regions` VALUES ('2255', '2182', '临沂市', '3', '0', '0', '0', ',3268,2182,2255,');
INSERT INTO `cmf_regions` VALUES ('2256', '2255', '兰山区', '4', '0', '0', '0', ',3268,2182,2255,2256,');
INSERT INTO `cmf_regions` VALUES ('2257', '2255', '罗庄区', '4', '0', '0', '0', ',3268,2182,2255,2257,');
INSERT INTO `cmf_regions` VALUES ('2258', '2255', '河东区', '4', '0', '0', '0', ',3268,2182,2255,2258,');
INSERT INTO `cmf_regions` VALUES ('2259', '2255', '沂南县', '4', '0', '0', '0', ',3268,2182,2255,2259,');
INSERT INTO `cmf_regions` VALUES ('2260', '2255', '郯城县', '4', '0', '0', '0', ',3268,2182,2255,2260,');
INSERT INTO `cmf_regions` VALUES ('2261', '2255', '沂水县', '4', '0', '0', '0', ',3268,2182,2255,2261,');
INSERT INTO `cmf_regions` VALUES ('2262', '2255', '苍山县', '4', '0', '0', '0', ',3268,2182,2255,2262,');
INSERT INTO `cmf_regions` VALUES ('2263', '2255', '费县', '4', '0', '0', '0', ',3268,2182,2255,2263,');
INSERT INTO `cmf_regions` VALUES ('2264', '2255', '平邑县', '4', '0', '0', '0', ',3268,2182,2255,2264,');
INSERT INTO `cmf_regions` VALUES ('2265', '2255', '莒南县', '4', '0', '0', '0', ',3268,2182,2255,2265,');
INSERT INTO `cmf_regions` VALUES ('2266', '2255', '蒙阴县', '4', '0', '0', '0', ',3268,2182,2255,2266,');
INSERT INTO `cmf_regions` VALUES ('2267', '2255', '临沭县', '4', '0', '0', '0', ',3268,2182,2255,2267,');
INSERT INTO `cmf_regions` VALUES ('2268', '2182', '青岛市', '3', '0', '0', '0', ',3268,2182,2268,');
INSERT INTO `cmf_regions` VALUES ('2269', '2268', '市南区', '4', '0', '0', '0', ',3268,2182,2268,2269,');
INSERT INTO `cmf_regions` VALUES ('2270', '2268', '市北区', '4', '0', '0', '0', ',3268,2182,2268,2270,');
INSERT INTO `cmf_regions` VALUES ('2271', '2268', '四方区', '4', '0', '0', '0', ',3268,2182,2268,2271,');
INSERT INTO `cmf_regions` VALUES ('2272', '2268', '黄岛区', '4', '0', '0', '0', ',3268,2182,2268,2272,');
INSERT INTO `cmf_regions` VALUES ('2273', '2268', '崂山区', '4', '0', '0', '0', ',3268,2182,2268,2273,');
INSERT INTO `cmf_regions` VALUES ('2274', '2268', '李沧区', '4', '0', '0', '0', ',3268,2182,2268,2274,');
INSERT INTO `cmf_regions` VALUES ('2275', '2268', '城阳区', '4', '0', '0', '0', ',3268,2182,2268,2275,');
INSERT INTO `cmf_regions` VALUES ('2276', '2268', '胶州市', '4', '0', '0', '0', ',3268,2182,2268,2276,');
INSERT INTO `cmf_regions` VALUES ('2277', '2268', '即墨市', '4', '0', '0', '0', ',3268,2182,2268,2277,');
INSERT INTO `cmf_regions` VALUES ('2278', '2268', '平度市', '4', '0', '0', '0', ',3268,2182,2268,2278,');
INSERT INTO `cmf_regions` VALUES ('2279', '2268', '胶南市', '4', '0', '0', '0', ',3268,2182,2268,2279,');
INSERT INTO `cmf_regions` VALUES ('2280', '2268', '莱西市', '4', '0', '0', '0', ',3268,2182,2268,2280,');
INSERT INTO `cmf_regions` VALUES ('2281', '2182', '日照市', '3', '0', '0', '0', ',3268,2182,2281,');
INSERT INTO `cmf_regions` VALUES ('2282', '2281', '东港区', '4', '0', '0', '0', ',3268,2182,2281,2282,');
INSERT INTO `cmf_regions` VALUES ('2283', '2281', '岚山区', '4', '0', '0', '0', ',3268,2182,2281,2283,');
INSERT INTO `cmf_regions` VALUES ('2284', '2281', '五莲县', '4', '0', '0', '0', ',3268,2182,2281,2284,');
INSERT INTO `cmf_regions` VALUES ('2285', '2281', '莒县', '4', '0', '0', '0', ',3268,2182,2281,2285,');
INSERT INTO `cmf_regions` VALUES ('2286', '2182', '泰安市', '3', '0', '0', '0', ',3268,2182,2286,');
INSERT INTO `cmf_regions` VALUES ('2287', '2286', '泰山区', '4', '0', '0', '0', ',3268,2182,2286,2287,');
INSERT INTO `cmf_regions` VALUES ('2288', '2286', '岱岳区', '4', '0', '0', '0', ',3268,2182,2286,2288,');
INSERT INTO `cmf_regions` VALUES ('2289', '2286', '宁阳县', '4', '0', '0', '0', ',3268,2182,2286,2289,');
INSERT INTO `cmf_regions` VALUES ('2290', '2286', '东平县', '4', '0', '0', '0', ',3268,2182,2286,2290,');
INSERT INTO `cmf_regions` VALUES ('2291', '2286', '新泰市', '4', '0', '0', '0', ',3268,2182,2286,2291,');
INSERT INTO `cmf_regions` VALUES ('2292', '2286', '肥城市', '4', '0', '0', '0', ',3268,2182,2286,2292,');
INSERT INTO `cmf_regions` VALUES ('2293', '2182', '威海市', '3', '0', '0', '0', ',3268,2182,2293,');
INSERT INTO `cmf_regions` VALUES ('2294', '2293', '环翠区', '4', '0', '0', '0', ',3268,2182,2293,2294,');
INSERT INTO `cmf_regions` VALUES ('2295', '2293', '文登市', '4', '0', '0', '0', ',3268,2182,2293,2295,');
INSERT INTO `cmf_regions` VALUES ('2296', '2293', '荣成市', '4', '0', '0', '0', ',3268,2182,2293,2296,');
INSERT INTO `cmf_regions` VALUES ('2297', '2293', '乳山市', '4', '0', '0', '0', ',3268,2182,2293,2297,');
INSERT INTO `cmf_regions` VALUES ('2298', '2182', '潍坊市', '3', '0', '0', '0', ',3268,2182,2298,');
INSERT INTO `cmf_regions` VALUES ('2299', '2298', '潍城区', '4', '0', '0', '0', ',3268,2182,2298,2299,');
INSERT INTO `cmf_regions` VALUES ('2300', '2298', '寒亭区', '4', '0', '0', '0', ',3268,2182,2298,2300,');
INSERT INTO `cmf_regions` VALUES ('2301', '2298', '坊子区', '4', '0', '0', '0', ',3268,2182,2298,2301,');
INSERT INTO `cmf_regions` VALUES ('2302', '2298', '奎文区', '4', '0', '0', '0', ',3268,2182,2298,2302,');
INSERT INTO `cmf_regions` VALUES ('2303', '2298', '临朐县', '4', '0', '0', '0', ',3268,2182,2298,2303,');
INSERT INTO `cmf_regions` VALUES ('2304', '2298', '昌乐县', '4', '0', '0', '0', ',3268,2182,2298,2304,');
INSERT INTO `cmf_regions` VALUES ('2305', '2298', '青州市', '4', '0', '0', '0', ',3268,2182,2298,2305,');
INSERT INTO `cmf_regions` VALUES ('2306', '2298', '诸城市', '4', '0', '0', '0', ',3268,2182,2298,2306,');
INSERT INTO `cmf_regions` VALUES ('2307', '2298', '寿光市', '4', '0', '0', '0', ',3268,2182,2298,2307,');
INSERT INTO `cmf_regions` VALUES ('2308', '2298', '安丘市', '4', '0', '0', '0', ',3268,2182,2298,2308,');
INSERT INTO `cmf_regions` VALUES ('2309', '2298', '高密市', '4', '0', '0', '0', ',3268,2182,2298,2309,');
INSERT INTO `cmf_regions` VALUES ('2310', '2298', '昌邑市', '4', '0', '0', '0', ',3268,2182,2298,2310,');
INSERT INTO `cmf_regions` VALUES ('2311', '2182', '烟台市', '3', '0', '0', '0', ',3268,2182,2311,');
INSERT INTO `cmf_regions` VALUES ('2312', '2311', '芝罘区', '4', '0', '0', '0', ',3268,2182,2311,2312,');
INSERT INTO `cmf_regions` VALUES ('2313', '2311', '福山区', '4', '0', '0', '0', ',3268,2182,2311,2313,');
INSERT INTO `cmf_regions` VALUES ('2314', '2311', '牟平区', '4', '0', '0', '0', ',3268,2182,2311,2314,');
INSERT INTO `cmf_regions` VALUES ('2315', '2311', '莱山区', '4', '0', '0', '0', ',3268,2182,2311,2315,');
INSERT INTO `cmf_regions` VALUES ('2316', '2311', '长岛县', '4', '0', '0', '0', ',3268,2182,2311,2316,');
INSERT INTO `cmf_regions` VALUES ('2317', '2311', '龙口市', '4', '0', '0', '0', ',3268,2182,2311,2317,');
INSERT INTO `cmf_regions` VALUES ('2318', '2311', '莱阳市', '4', '0', '0', '0', ',3268,2182,2311,2318,');
INSERT INTO `cmf_regions` VALUES ('2319', '2311', '莱州市', '4', '0', '0', '0', ',3268,2182,2311,2319,');
INSERT INTO `cmf_regions` VALUES ('2320', '2311', '蓬莱市', '4', '0', '0', '0', ',3268,2182,2311,2320,');
INSERT INTO `cmf_regions` VALUES ('2321', '2311', '招远市', '4', '0', '0', '0', ',3268,2182,2311,2321,');
INSERT INTO `cmf_regions` VALUES ('2322', '2311', '栖霞市', '4', '0', '0', '0', ',3268,2182,2311,2322,');
INSERT INTO `cmf_regions` VALUES ('2323', '2311', '海阳市', '4', '0', '0', '0', ',3268,2182,2311,2323,');
INSERT INTO `cmf_regions` VALUES ('2324', '2182', '枣庄市', '3', '0', '0', '0', ',3268,2182,2324,');
INSERT INTO `cmf_regions` VALUES ('2325', '2324', '市中区', '4', '0', '0', '0', ',3268,2182,2324,2325,');
INSERT INTO `cmf_regions` VALUES ('2326', '2324', '薛城区', '4', '0', '0', '0', ',3268,2182,2324,2326,');
INSERT INTO `cmf_regions` VALUES ('2327', '2324', '峄城区', '4', '0', '0', '0', ',3268,2182,2324,2327,');
INSERT INTO `cmf_regions` VALUES ('2328', '2324', '台儿庄区', '4', '0', '0', '0', ',3268,2182,2324,2328,');
INSERT INTO `cmf_regions` VALUES ('2329', '2324', '山亭区', '4', '0', '0', '0', ',3268,2182,2324,2329,');
INSERT INTO `cmf_regions` VALUES ('2330', '2324', '滕州市', '4', '0', '0', '0', ',3268,2182,2324,2330,');
INSERT INTO `cmf_regions` VALUES ('2331', '2182', '淄博市', '3', '0', '0', '0', ',3268,2182,2331,');
INSERT INTO `cmf_regions` VALUES ('2332', '2331', '淄川区', '4', '0', '0', '0', ',3268,2182,2331,2332,');
INSERT INTO `cmf_regions` VALUES ('2333', '2331', '张店区', '4', '0', '0', '0', ',3268,2182,2331,2333,');
INSERT INTO `cmf_regions` VALUES ('2334', '2331', '博山区', '4', '0', '0', '0', ',3268,2182,2331,2334,');
INSERT INTO `cmf_regions` VALUES ('2335', '2331', '临淄区', '4', '0', '0', '0', ',3268,2182,2331,2335,');
INSERT INTO `cmf_regions` VALUES ('2336', '2331', '周村区', '4', '0', '0', '0', ',3268,2182,2331,2336,');
INSERT INTO `cmf_regions` VALUES ('2337', '2331', '桓台县', '4', '0', '0', '0', ',3268,2182,2331,2337,');
INSERT INTO `cmf_regions` VALUES ('2338', '2331', '高青县', '4', '0', '0', '0', ',3268,2182,2331,2338,');
INSERT INTO `cmf_regions` VALUES ('2339', '2331', '沂源县', '4', '0', '0', '0', ',3268,2182,2331,2339,');
INSERT INTO `cmf_regions` VALUES ('2340', '3268', '山西', '2', '0', '0', '0', ',3268,2340,');
INSERT INTO `cmf_regions` VALUES ('2341', '2340', '太原市', '3', '0', '0', '0', ',3268,2340,2341,');
INSERT INTO `cmf_regions` VALUES ('2342', '2341', '小店区', '4', '0', '0', '0', ',3268,2340,2341,2342,');
INSERT INTO `cmf_regions` VALUES ('2343', '2341', '迎泽区', '4', '0', '0', '0', ',3268,2340,2341,2343,');
INSERT INTO `cmf_regions` VALUES ('2344', '2341', '杏花岭区', '4', '0', '0', '0', ',3268,2340,2341,2344,');
INSERT INTO `cmf_regions` VALUES ('2345', '2341', '尖草坪区', '4', '0', '0', '0', ',3268,2340,2341,2345,');
INSERT INTO `cmf_regions` VALUES ('2346', '2341', '万柏林区', '4', '0', '0', '0', ',3268,2340,2341,2346,');
INSERT INTO `cmf_regions` VALUES ('2347', '2341', '晋源区', '4', '0', '0', '0', ',3268,2340,2341,2347,');
INSERT INTO `cmf_regions` VALUES ('2348', '2341', '清徐县', '4', '0', '0', '0', ',3268,2340,2341,2348,');
INSERT INTO `cmf_regions` VALUES ('2349', '2341', '阳曲县', '4', '0', '0', '0', ',3268,2340,2341,2349,');
INSERT INTO `cmf_regions` VALUES ('2350', '2341', '娄烦县', '4', '0', '0', '0', ',3268,2340,2341,2350,');
INSERT INTO `cmf_regions` VALUES ('2351', '2341', '古交市', '4', '0', '0', '0', ',3268,2340,2341,2351,');
INSERT INTO `cmf_regions` VALUES ('2352', '2340', '长治市', '3', '0', '0', '0', ',3268,2340,2352,');
INSERT INTO `cmf_regions` VALUES ('2353', '2352', '城区', '4', '0', '0', '0', ',3268,2340,2352,2353,');
INSERT INTO `cmf_regions` VALUES ('2354', '2352', '郊区', '4', '0', '0', '0', ',3268,2340,2352,2354,');
INSERT INTO `cmf_regions` VALUES ('2355', '2352', '长治县', '4', '0', '0', '0', ',3268,2340,2352,2355,');
INSERT INTO `cmf_regions` VALUES ('2356', '2352', '襄垣县', '4', '0', '0', '0', ',3268,2340,2352,2356,');
INSERT INTO `cmf_regions` VALUES ('2357', '2352', '屯留县', '4', '0', '0', '0', ',3268,2340,2352,2357,');
INSERT INTO `cmf_regions` VALUES ('2358', '2352', '平顺县', '4', '0', '0', '0', ',3268,2340,2352,2358,');
INSERT INTO `cmf_regions` VALUES ('2359', '2352', '黎城县', '4', '0', '0', '0', ',3268,2340,2352,2359,');
INSERT INTO `cmf_regions` VALUES ('2360', '2352', '壶关县', '4', '0', '0', '0', ',3268,2340,2352,2360,');
INSERT INTO `cmf_regions` VALUES ('2361', '2352', '长子县', '4', '0', '0', '0', ',3268,2340,2352,2361,');
INSERT INTO `cmf_regions` VALUES ('2362', '2352', '武乡县', '4', '0', '0', '0', ',3268,2340,2352,2362,');
INSERT INTO `cmf_regions` VALUES ('2363', '2352', '沁县', '4', '0', '0', '0', ',3268,2340,2352,2363,');
INSERT INTO `cmf_regions` VALUES ('2364', '2352', '沁源县', '4', '0', '0', '0', ',3268,2340,2352,2364,');
INSERT INTO `cmf_regions` VALUES ('2365', '2352', '潞城市', '4', '0', '0', '0', ',3268,2340,2352,2365,');
INSERT INTO `cmf_regions` VALUES ('2366', '2340', '大同市', '3', '0', '0', '0', ',3268,2340,2366,');
INSERT INTO `cmf_regions` VALUES ('2367', '2366', '城区', '4', '0', '0', '0', ',3268,2340,2366,2367,');
INSERT INTO `cmf_regions` VALUES ('2368', '2366', '矿区', '4', '0', '0', '0', ',3268,2340,2366,2368,');
INSERT INTO `cmf_regions` VALUES ('2369', '2366', '南郊区', '4', '0', '0', '0', ',3268,2340,2366,2369,');
INSERT INTO `cmf_regions` VALUES ('2370', '2366', '新荣区', '4', '0', '0', '0', ',3268,2340,2366,2370,');
INSERT INTO `cmf_regions` VALUES ('2371', '2366', '阳高县', '4', '0', '0', '0', ',3268,2340,2366,2371,');
INSERT INTO `cmf_regions` VALUES ('2372', '2366', '天镇县', '4', '0', '0', '0', ',3268,2340,2366,2372,');
INSERT INTO `cmf_regions` VALUES ('2373', '2366', '广灵县', '4', '0', '0', '0', ',3268,2340,2366,2373,');
INSERT INTO `cmf_regions` VALUES ('2374', '2366', '灵丘县', '4', '0', '0', '0', ',3268,2340,2366,2374,');
INSERT INTO `cmf_regions` VALUES ('2375', '2366', '浑源县', '4', '0', '0', '0', ',3268,2340,2366,2375,');
INSERT INTO `cmf_regions` VALUES ('2376', '2366', '左云县', '4', '0', '0', '0', ',3268,2340,2366,2376,');
INSERT INTO `cmf_regions` VALUES ('2377', '2366', '大同县', '4', '0', '0', '0', ',3268,2340,2366,2377,');
INSERT INTO `cmf_regions` VALUES ('2378', '2340', '晋城市', '3', '0', '0', '0', ',3268,2340,2378,');
INSERT INTO `cmf_regions` VALUES ('2379', '2378', '城区', '4', '0', '0', '0', ',3268,2340,2378,2379,');
INSERT INTO `cmf_regions` VALUES ('2380', '2378', '沁水县', '4', '0', '0', '0', ',3268,2340,2378,2380,');
INSERT INTO `cmf_regions` VALUES ('2381', '2378', '阳城县', '4', '0', '0', '0', ',3268,2340,2378,2381,');
INSERT INTO `cmf_regions` VALUES ('2382', '2378', '陵川县', '4', '0', '0', '0', ',3268,2340,2378,2382,');
INSERT INTO `cmf_regions` VALUES ('2383', '2378', '泽州县', '4', '0', '0', '0', ',3268,2340,2378,2383,');
INSERT INTO `cmf_regions` VALUES ('2384', '2378', '高平市', '4', '0', '0', '0', ',3268,2340,2378,2384,');
INSERT INTO `cmf_regions` VALUES ('2385', '2340', '晋中市', '3', '0', '0', '0', ',3268,2340,2385,');
INSERT INTO `cmf_regions` VALUES ('2386', '2385', '榆次区', '4', '0', '0', '0', ',3268,2340,2385,2386,');
INSERT INTO `cmf_regions` VALUES ('2387', '2385', '榆社县', '4', '0', '0', '0', ',3268,2340,2385,2387,');
INSERT INTO `cmf_regions` VALUES ('2388', '2385', '左权县', '4', '0', '0', '0', ',3268,2340,2385,2388,');
INSERT INTO `cmf_regions` VALUES ('2389', '2385', '和顺县', '4', '0', '0', '0', ',3268,2340,2385,2389,');
INSERT INTO `cmf_regions` VALUES ('2390', '2385', '昔阳县', '4', '0', '0', '0', ',3268,2340,2385,2390,');
INSERT INTO `cmf_regions` VALUES ('2391', '2385', '寿阳县', '4', '0', '0', '0', ',3268,2340,2385,2391,');
INSERT INTO `cmf_regions` VALUES ('2392', '2385', '太谷县', '4', '0', '0', '0', ',3268,2340,2385,2392,');
INSERT INTO `cmf_regions` VALUES ('2393', '2385', '祁县', '4', '0', '0', '0', ',3268,2340,2385,2393,');
INSERT INTO `cmf_regions` VALUES ('2394', '2385', '平遥县', '4', '0', '0', '0', ',3268,2340,2385,2394,');
INSERT INTO `cmf_regions` VALUES ('2395', '2385', '灵石县', '4', '0', '0', '0', ',3268,2340,2385,2395,');
INSERT INTO `cmf_regions` VALUES ('2396', '2385', '介休市', '4', '0', '0', '0', ',3268,2340,2385,2396,');
INSERT INTO `cmf_regions` VALUES ('2397', '2340', '临汾市', '3', '0', '0', '0', ',3268,2340,2397,');
INSERT INTO `cmf_regions` VALUES ('2398', '2397', '尧都区', '4', '0', '0', '0', ',3268,2340,2397,2398,');
INSERT INTO `cmf_regions` VALUES ('2399', '2397', '曲沃县', '4', '0', '0', '0', ',3268,2340,2397,2399,');
INSERT INTO `cmf_regions` VALUES ('2400', '2397', '翼城县', '4', '0', '0', '0', ',3268,2340,2397,2400,');
INSERT INTO `cmf_regions` VALUES ('2401', '2397', '襄汾县', '4', '0', '0', '0', ',3268,2340,2397,2401,');
INSERT INTO `cmf_regions` VALUES ('2402', '2397', '洪洞县', '4', '0', '0', '0', ',3268,2340,2397,2402,');
INSERT INTO `cmf_regions` VALUES ('2403', '2397', '古县', '4', '0', '0', '0', ',3268,2340,2397,2403,');
INSERT INTO `cmf_regions` VALUES ('2404', '2397', '安泽县', '4', '0', '0', '0', ',3268,2340,2397,2404,');
INSERT INTO `cmf_regions` VALUES ('2405', '2397', '浮山县', '4', '0', '0', '0', ',3268,2340,2397,2405,');
INSERT INTO `cmf_regions` VALUES ('2406', '2397', '吉县', '4', '0', '0', '0', ',3268,2340,2397,2406,');
INSERT INTO `cmf_regions` VALUES ('2407', '2397', '乡宁县', '4', '0', '0', '0', ',3268,2340,2397,2407,');
INSERT INTO `cmf_regions` VALUES ('2408', '2397', '大宁县', '4', '0', '0', '0', ',3268,2340,2397,2408,');
INSERT INTO `cmf_regions` VALUES ('2409', '2397', '隰县', '4', '0', '0', '0', ',3268,2340,2397,2409,');
INSERT INTO `cmf_regions` VALUES ('2410', '2397', '永和县', '4', '0', '0', '0', ',3268,2340,2397,2410,');
INSERT INTO `cmf_regions` VALUES ('2411', '2397', '蒲县', '4', '0', '0', '0', ',3268,2340,2397,2411,');
INSERT INTO `cmf_regions` VALUES ('2412', '2397', '汾西县', '4', '0', '0', '0', ',3268,2340,2397,2412,');
INSERT INTO `cmf_regions` VALUES ('2413', '2397', '侯马市', '4', '0', '0', '0', ',3268,2340,2397,2413,');
INSERT INTO `cmf_regions` VALUES ('2414', '2397', '霍州市', '4', '0', '0', '0', ',3268,2340,2397,2414,');
INSERT INTO `cmf_regions` VALUES ('2415', '2340', '吕梁市', '3', '0', '0', '0', ',3268,2340,2415,');
INSERT INTO `cmf_regions` VALUES ('2416', '2415', '离石区', '4', '0', '0', '0', ',3268,2340,2415,2416,');
INSERT INTO `cmf_regions` VALUES ('2417', '2415', '文水县', '4', '0', '0', '0', ',3268,2340,2415,2417,');
INSERT INTO `cmf_regions` VALUES ('2418', '2415', '交城县', '4', '0', '0', '0', ',3268,2340,2415,2418,');
INSERT INTO `cmf_regions` VALUES ('2419', '2415', '兴县', '4', '0', '0', '0', ',3268,2340,2415,2419,');
INSERT INTO `cmf_regions` VALUES ('2420', '2415', '临县', '4', '0', '0', '0', ',3268,2340,2415,2420,');
INSERT INTO `cmf_regions` VALUES ('2421', '2415', '柳林县', '4', '0', '0', '0', ',3268,2340,2415,2421,');
INSERT INTO `cmf_regions` VALUES ('2422', '2415', '石楼县', '4', '0', '0', '0', ',3268,2340,2415,2422,');
INSERT INTO `cmf_regions` VALUES ('2423', '2415', '岚县', '4', '0', '0', '0', ',3268,2340,2415,2423,');
INSERT INTO `cmf_regions` VALUES ('2424', '2415', '方山县', '4', '0', '0', '0', ',3268,2340,2415,2424,');
INSERT INTO `cmf_regions` VALUES ('2425', '2415', '中阳县', '4', '0', '0', '0', ',3268,2340,2415,2425,');
INSERT INTO `cmf_regions` VALUES ('2426', '2415', '交口县', '4', '0', '0', '0', ',3268,2340,2415,2426,');
INSERT INTO `cmf_regions` VALUES ('2427', '2415', '孝义市', '4', '0', '0', '0', ',3268,2340,2415,2427,');
INSERT INTO `cmf_regions` VALUES ('2428', '2415', '汾阳市', '4', '0', '0', '0', ',3268,2340,2415,2428,');
INSERT INTO `cmf_regions` VALUES ('2429', '2340', '朔州市', '3', '0', '0', '0', ',3268,2340,2429,');
INSERT INTO `cmf_regions` VALUES ('2430', '2429', '朔城区', '4', '0', '0', '0', ',3268,2340,2429,2430,');
INSERT INTO `cmf_regions` VALUES ('2431', '2429', '平鲁区', '4', '0', '0', '0', ',3268,2340,2429,2431,');
INSERT INTO `cmf_regions` VALUES ('2432', '2429', '山阴县', '4', '0', '0', '0', ',3268,2340,2429,2432,');
INSERT INTO `cmf_regions` VALUES ('2433', '2429', '应县', '4', '0', '0', '0', ',3268,2340,2429,2433,');
INSERT INTO `cmf_regions` VALUES ('2434', '2429', '右玉县', '4', '0', '0', '0', ',3268,2340,2429,2434,');
INSERT INTO `cmf_regions` VALUES ('2435', '2429', '怀仁县', '4', '0', '0', '0', ',3268,2340,2429,2435,');
INSERT INTO `cmf_regions` VALUES ('2436', '2340', '忻州市', '3', '0', '0', '0', ',3268,2340,2436,');
INSERT INTO `cmf_regions` VALUES ('2437', '2436', '忻府区', '4', '0', '0', '0', ',3268,2340,2436,2437,');
INSERT INTO `cmf_regions` VALUES ('2438', '2436', '定襄县', '4', '0', '0', '0', ',3268,2340,2436,2438,');
INSERT INTO `cmf_regions` VALUES ('2439', '2436', '五台县', '4', '0', '0', '0', ',3268,2340,2436,2439,');
INSERT INTO `cmf_regions` VALUES ('2440', '2436', '代县', '4', '0', '0', '0', ',3268,2340,2436,2440,');
INSERT INTO `cmf_regions` VALUES ('2441', '2436', '繁峙县', '4', '0', '0', '0', ',3268,2340,2436,2441,');
INSERT INTO `cmf_regions` VALUES ('2442', '2436', '宁武县', '4', '0', '0', '0', ',3268,2340,2436,2442,');
INSERT INTO `cmf_regions` VALUES ('2443', '2436', '静乐县', '4', '0', '0', '0', ',3268,2340,2436,2443,');
INSERT INTO `cmf_regions` VALUES ('2444', '2436', '神池县', '4', '0', '0', '0', ',3268,2340,2436,2444,');
INSERT INTO `cmf_regions` VALUES ('2445', '2436', '五寨县', '4', '0', '0', '0', ',3268,2340,2436,2445,');
INSERT INTO `cmf_regions` VALUES ('2446', '2436', '岢岚县', '4', '0', '0', '0', ',3268,2340,2436,2446,');
INSERT INTO `cmf_regions` VALUES ('2447', '2436', '河曲县', '4', '0', '0', '0', ',3268,2340,2436,2447,');
INSERT INTO `cmf_regions` VALUES ('2448', '2436', '保德县', '4', '0', '0', '0', ',3268,2340,2436,2448,');
INSERT INTO `cmf_regions` VALUES ('2449', '2436', '偏关县', '4', '0', '0', '0', ',3268,2340,2436,2449,');
INSERT INTO `cmf_regions` VALUES ('2450', '2436', '原平市', '4', '0', '0', '0', ',3268,2340,2436,2450,');
INSERT INTO `cmf_regions` VALUES ('2451', '2340', '阳泉市', '3', '0', '0', '0', ',3268,2340,2451,');
INSERT INTO `cmf_regions` VALUES ('2452', '2451', '城区', '4', '0', '0', '0', ',3268,2340,2451,2452,');
INSERT INTO `cmf_regions` VALUES ('2453', '2451', '矿区', '4', '0', '0', '0', ',3268,2340,2451,2453,');
INSERT INTO `cmf_regions` VALUES ('2454', '2451', '郊区', '4', '0', '0', '0', ',3268,2340,2451,2454,');
INSERT INTO `cmf_regions` VALUES ('2455', '2451', '平定县', '4', '0', '0', '0', ',3268,2340,2451,2455,');
INSERT INTO `cmf_regions` VALUES ('2456', '2451', '盂县', '4', '0', '0', '0', ',3268,2340,2451,2456,');
INSERT INTO `cmf_regions` VALUES ('2457', '2340', '运城市', '3', '0', '0', '0', ',3268,2340,2457,');
INSERT INTO `cmf_regions` VALUES ('2458', '2457', '盐湖区', '4', '0', '0', '0', ',3268,2340,2457,2458,');
INSERT INTO `cmf_regions` VALUES ('2459', '2457', '临猗县', '4', '0', '0', '0', ',3268,2340,2457,2459,');
INSERT INTO `cmf_regions` VALUES ('2460', '2457', '万荣县', '4', '0', '0', '0', ',3268,2340,2457,2460,');
INSERT INTO `cmf_regions` VALUES ('2461', '2457', '闻喜县', '4', '0', '0', '0', ',3268,2340,2457,2461,');
INSERT INTO `cmf_regions` VALUES ('2462', '2457', '稷山县', '4', '0', '0', '0', ',3268,2340,2457,2462,');
INSERT INTO `cmf_regions` VALUES ('2463', '2457', '新绛县', '4', '0', '0', '0', ',3268,2340,2457,2463,');
INSERT INTO `cmf_regions` VALUES ('2464', '2457', '绛县', '4', '0', '0', '0', ',3268,2340,2457,2464,');
INSERT INTO `cmf_regions` VALUES ('2465', '2457', '垣曲县', '4', '0', '0', '0', ',3268,2340,2457,2465,');
INSERT INTO `cmf_regions` VALUES ('2466', '2457', '夏县', '4', '0', '0', '0', ',3268,2340,2457,2466,');
INSERT INTO `cmf_regions` VALUES ('2467', '2457', '平陆县', '4', '0', '0', '0', ',3268,2340,2457,2467,');
INSERT INTO `cmf_regions` VALUES ('2468', '2457', '芮城县', '4', '0', '0', '0', ',3268,2340,2457,2468,');
INSERT INTO `cmf_regions` VALUES ('2469', '2457', '永济市', '4', '0', '0', '0', ',3268,2340,2457,2469,');
INSERT INTO `cmf_regions` VALUES ('2470', '2457', '河津市', '4', '0', '0', '0', ',3268,2340,2457,2470,');
INSERT INTO `cmf_regions` VALUES ('2471', '3268', '陕西', '2', '0', '0', '0', ',3268,2471,');
INSERT INTO `cmf_regions` VALUES ('2472', '2471', '西安市', '3', '0', '0', '0', ',3268,2471,2472,');
INSERT INTO `cmf_regions` VALUES ('2473', '2472', '新城区', '4', '0', '0', '0', ',3268,2471,2472,2473,');
INSERT INTO `cmf_regions` VALUES ('2474', '2472', '碑林区', '4', '0', '0', '0', ',3268,2471,2472,2474,');
INSERT INTO `cmf_regions` VALUES ('2475', '2472', '莲湖区', '4', '0', '0', '0', ',3268,2471,2472,2475,');
INSERT INTO `cmf_regions` VALUES ('2476', '2472', '灞桥区', '4', '0', '0', '0', ',3268,2471,2472,2476,');
INSERT INTO `cmf_regions` VALUES ('2477', '2472', '未央区', '4', '0', '0', '0', ',3268,2471,2472,2477,');
INSERT INTO `cmf_regions` VALUES ('2478', '2472', '雁塔区', '4', '0', '0', '0', ',3268,2471,2472,2478,');
INSERT INTO `cmf_regions` VALUES ('2479', '2472', '阎良区', '4', '0', '0', '0', ',3268,2471,2472,2479,');
INSERT INTO `cmf_regions` VALUES ('2480', '2472', '临潼区', '4', '0', '0', '0', ',3268,2471,2472,2480,');
INSERT INTO `cmf_regions` VALUES ('2481', '2472', '长安区', '4', '0', '0', '0', ',3268,2471,2472,2481,');
INSERT INTO `cmf_regions` VALUES ('2482', '2472', '蓝田县', '4', '0', '0', '0', ',3268,2471,2472,2482,');
INSERT INTO `cmf_regions` VALUES ('2483', '2472', '周至县', '4', '0', '0', '0', ',3268,2471,2472,2483,');
INSERT INTO `cmf_regions` VALUES ('2484', '2472', '户县', '4', '0', '0', '0', ',3268,2471,2472,2484,');
INSERT INTO `cmf_regions` VALUES ('2485', '2472', '高陵县', '4', '0', '0', '0', ',3268,2471,2472,2485,');
INSERT INTO `cmf_regions` VALUES ('2486', '2471', '安康市', '3', '0', '0', '0', ',3268,2471,2486,');
INSERT INTO `cmf_regions` VALUES ('2487', '2486', '汉滨区', '4', '0', '0', '0', ',3268,2471,2486,2487,');
INSERT INTO `cmf_regions` VALUES ('2488', '2486', '汉阴县', '4', '0', '0', '0', ',3268,2471,2486,2488,');
INSERT INTO `cmf_regions` VALUES ('2489', '2486', '石泉县', '4', '0', '0', '0', ',3268,2471,2486,2489,');
INSERT INTO `cmf_regions` VALUES ('2490', '2486', '宁陕县', '4', '0', '0', '0', ',3268,2471,2486,2490,');
INSERT INTO `cmf_regions` VALUES ('2491', '2486', '紫阳县', '4', '0', '0', '0', ',3268,2471,2486,2491,');
INSERT INTO `cmf_regions` VALUES ('2492', '2486', '岚皋县', '4', '0', '0', '0', ',3268,2471,2486,2492,');
INSERT INTO `cmf_regions` VALUES ('2493', '2486', '平利县', '4', '0', '0', '0', ',3268,2471,2486,2493,');
INSERT INTO `cmf_regions` VALUES ('2494', '2486', '镇坪县', '4', '0', '0', '0', ',3268,2471,2486,2494,');
INSERT INTO `cmf_regions` VALUES ('2495', '2486', '旬阳县', '4', '0', '0', '0', ',3268,2471,2486,2495,');
INSERT INTO `cmf_regions` VALUES ('2496', '2486', '白河县', '4', '0', '0', '0', ',3268,2471,2486,2496,');
INSERT INTO `cmf_regions` VALUES ('2497', '2471', '宝鸡市', '3', '0', '0', '0', ',3268,2471,2497,');
INSERT INTO `cmf_regions` VALUES ('2498', '2497', '渭滨区', '4', '0', '0', '0', ',3268,2471,2497,2498,');
INSERT INTO `cmf_regions` VALUES ('2499', '2497', '金台区', '4', '0', '0', '0', ',3268,2471,2497,2499,');
INSERT INTO `cmf_regions` VALUES ('2500', '2497', '陈仓区', '4', '0', '0', '0', ',3268,2471,2497,2500,');
INSERT INTO `cmf_regions` VALUES ('2501', '2497', '凤翔县', '4', '0', '0', '0', ',3268,2471,2497,2501,');
INSERT INTO `cmf_regions` VALUES ('2502', '2497', '岐山县', '4', '0', '0', '0', ',3268,2471,2497,2502,');
INSERT INTO `cmf_regions` VALUES ('2503', '2497', '扶风县', '4', '0', '0', '0', ',3268,2471,2497,2503,');
INSERT INTO `cmf_regions` VALUES ('2504', '2497', '眉县', '4', '0', '0', '0', ',3268,2471,2497,2504,');
INSERT INTO `cmf_regions` VALUES ('2505', '2497', '陇县', '4', '0', '0', '0', ',3268,2471,2497,2505,');
INSERT INTO `cmf_regions` VALUES ('2506', '2497', '千阳县', '4', '0', '0', '0', ',3268,2471,2497,2506,');
INSERT INTO `cmf_regions` VALUES ('2507', '2497', '麟游县', '4', '0', '0', '0', ',3268,2471,2497,2507,');
INSERT INTO `cmf_regions` VALUES ('2508', '2497', '凤县', '4', '0', '0', '0', ',3268,2471,2497,2508,');
INSERT INTO `cmf_regions` VALUES ('2509', '2497', '太白县', '4', '0', '0', '0', ',3268,2471,2497,2509,');
INSERT INTO `cmf_regions` VALUES ('2510', '2471', '汉中市', '3', '0', '0', '0', ',3268,2471,2510,');
INSERT INTO `cmf_regions` VALUES ('2511', '2510', '汉台区', '4', '0', '0', '0', ',3268,2471,2510,2511,');
INSERT INTO `cmf_regions` VALUES ('2512', '2510', '南郑县', '4', '0', '0', '0', ',3268,2471,2510,2512,');
INSERT INTO `cmf_regions` VALUES ('2513', '2510', '城固县', '4', '0', '0', '0', ',3268,2471,2510,2513,');
INSERT INTO `cmf_regions` VALUES ('2514', '2510', '洋县', '4', '0', '0', '0', ',3268,2471,2510,2514,');
INSERT INTO `cmf_regions` VALUES ('2515', '2510', '西乡县', '4', '0', '0', '0', ',3268,2471,2510,2515,');
INSERT INTO `cmf_regions` VALUES ('2516', '2510', '勉县', '4', '0', '0', '0', ',3268,2471,2510,2516,');
INSERT INTO `cmf_regions` VALUES ('2517', '2510', '宁强县', '4', '0', '0', '0', ',3268,2471,2510,2517,');
INSERT INTO `cmf_regions` VALUES ('2518', '2510', '略阳县', '4', '0', '0', '0', ',3268,2471,2510,2518,');
INSERT INTO `cmf_regions` VALUES ('2519', '2510', '镇巴县', '4', '0', '0', '0', ',3268,2471,2510,2519,');
INSERT INTO `cmf_regions` VALUES ('2520', '2510', '留坝县', '4', '0', '0', '0', ',3268,2471,2510,2520,');
INSERT INTO `cmf_regions` VALUES ('2521', '2510', '佛坪县', '4', '0', '0', '0', ',3268,2471,2510,2521,');
INSERT INTO `cmf_regions` VALUES ('2522', '2471', '商洛市', '3', '0', '0', '0', ',3268,2471,2522,');
INSERT INTO `cmf_regions` VALUES ('2523', '2522', '商州区', '4', '0', '0', '0', ',3268,2471,2522,2523,');
INSERT INTO `cmf_regions` VALUES ('2524', '2522', '洛南县', '4', '0', '0', '0', ',3268,2471,2522,2524,');
INSERT INTO `cmf_regions` VALUES ('2525', '2522', '丹凤县', '4', '0', '0', '0', ',3268,2471,2522,2525,');
INSERT INTO `cmf_regions` VALUES ('2526', '2522', '商南县', '4', '0', '0', '0', ',3268,2471,2522,2526,');
INSERT INTO `cmf_regions` VALUES ('2527', '2522', '山阳县', '4', '0', '0', '0', ',3268,2471,2522,2527,');
INSERT INTO `cmf_regions` VALUES ('2528', '2522', '镇安县', '4', '0', '0', '0', ',3268,2471,2522,2528,');
INSERT INTO `cmf_regions` VALUES ('2529', '2522', '柞水县', '4', '0', '0', '0', ',3268,2471,2522,2529,');
INSERT INTO `cmf_regions` VALUES ('2530', '2471', '铜川市', '3', '0', '0', '0', ',3268,2471,2530,');
INSERT INTO `cmf_regions` VALUES ('2531', '2530', '王益区', '4', '0', '0', '0', ',3268,2471,2530,2531,');
INSERT INTO `cmf_regions` VALUES ('2532', '2530', '印台区', '4', '0', '0', '0', ',3268,2471,2530,2532,');
INSERT INTO `cmf_regions` VALUES ('2533', '2530', '耀州区', '4', '0', '0', '0', ',3268,2471,2530,2533,');
INSERT INTO `cmf_regions` VALUES ('2534', '2530', '宜君县', '4', '0', '0', '0', ',3268,2471,2530,2534,');
INSERT INTO `cmf_regions` VALUES ('2535', '2471', '渭南市', '3', '0', '0', '0', ',3268,2471,2535,');
INSERT INTO `cmf_regions` VALUES ('2536', '2535', '临渭区', '4', '0', '0', '0', ',3268,2471,2535,2536,');
INSERT INTO `cmf_regions` VALUES ('2537', '2535', '华县', '4', '0', '0', '0', ',3268,2471,2535,2537,');
INSERT INTO `cmf_regions` VALUES ('2538', '2535', '潼关县', '4', '0', '0', '0', ',3268,2471,2535,2538,');
INSERT INTO `cmf_regions` VALUES ('2539', '2535', '大荔县', '4', '0', '0', '0', ',3268,2471,2535,2539,');
INSERT INTO `cmf_regions` VALUES ('2540', '2535', '合阳县', '4', '0', '0', '0', ',3268,2471,2535,2540,');
INSERT INTO `cmf_regions` VALUES ('2541', '2535', '澄城县', '4', '0', '0', '0', ',3268,2471,2535,2541,');
INSERT INTO `cmf_regions` VALUES ('2542', '2535', '蒲城县', '4', '0', '0', '0', ',3268,2471,2535,2542,');
INSERT INTO `cmf_regions` VALUES ('2543', '2535', '白水县', '4', '0', '0', '0', ',3268,2471,2535,2543,');
INSERT INTO `cmf_regions` VALUES ('2544', '2535', '富平县', '4', '0', '0', '0', ',3268,2471,2535,2544,');
INSERT INTO `cmf_regions` VALUES ('2545', '2535', '韩城市', '4', '0', '0', '0', ',3268,2471,2535,2545,');
INSERT INTO `cmf_regions` VALUES ('2546', '2535', '华阴市', '4', '0', '0', '0', ',3268,2471,2535,2546,');
INSERT INTO `cmf_regions` VALUES ('2547', '2471', '咸阳市', '3', '0', '0', '0', ',3268,2471,2547,');
INSERT INTO `cmf_regions` VALUES ('2548', '2547', '秦都区', '4', '0', '0', '0', ',3268,2471,2547,2548,');
INSERT INTO `cmf_regions` VALUES ('2549', '2547', '杨凌区', '4', '0', '0', '0', ',3268,2471,2547,2549,');
INSERT INTO `cmf_regions` VALUES ('2550', '2547', '渭城区', '4', '0', '0', '0', ',3268,2471,2547,2550,');
INSERT INTO `cmf_regions` VALUES ('2551', '2547', '三原县', '4', '0', '0', '0', ',3268,2471,2547,2551,');
INSERT INTO `cmf_regions` VALUES ('2552', '2547', '泾阳县', '4', '0', '0', '0', ',3268,2471,2547,2552,');
INSERT INTO `cmf_regions` VALUES ('2553', '2547', '乾县', '4', '0', '0', '0', ',3268,2471,2547,2553,');
INSERT INTO `cmf_regions` VALUES ('2554', '2547', '礼泉县', '4', '0', '0', '0', ',3268,2471,2547,2554,');
INSERT INTO `cmf_regions` VALUES ('2555', '2547', '永寿县', '4', '0', '0', '0', ',3268,2471,2547,2555,');
INSERT INTO `cmf_regions` VALUES ('2556', '2547', '彬县', '4', '0', '0', '0', ',3268,2471,2547,2556,');
INSERT INTO `cmf_regions` VALUES ('2557', '2547', '长武县', '4', '0', '0', '0', ',3268,2471,2547,2557,');
INSERT INTO `cmf_regions` VALUES ('2558', '2547', '旬邑县', '4', '0', '0', '0', ',3268,2471,2547,2558,');
INSERT INTO `cmf_regions` VALUES ('2559', '2547', '淳化县', '4', '0', '0', '0', ',3268,2471,2547,2559,');
INSERT INTO `cmf_regions` VALUES ('2560', '2547', '武功县', '4', '0', '0', '0', ',3268,2471,2547,2560,');
INSERT INTO `cmf_regions` VALUES ('2561', '2547', '兴平市', '4', '0', '0', '0', ',3268,2471,2547,2561,');
INSERT INTO `cmf_regions` VALUES ('2562', '2471', '延安市', '3', '0', '0', '0', ',3268,2471,2562,');
INSERT INTO `cmf_regions` VALUES ('2563', '2562', '宝塔区', '4', '0', '0', '0', ',3268,2471,2562,2563,');
INSERT INTO `cmf_regions` VALUES ('2564', '2562', '延长县', '4', '0', '0', '0', ',3268,2471,2562,2564,');
INSERT INTO `cmf_regions` VALUES ('2565', '2562', '延川县', '4', '0', '0', '0', ',3268,2471,2562,2565,');
INSERT INTO `cmf_regions` VALUES ('2566', '2562', '子长县', '4', '0', '0', '0', ',3268,2471,2562,2566,');
INSERT INTO `cmf_regions` VALUES ('2567', '2562', '安塞县', '4', '0', '0', '0', ',3268,2471,2562,2567,');
INSERT INTO `cmf_regions` VALUES ('2568', '2562', '志丹县', '4', '0', '0', '0', ',3268,2471,2562,2568,');
INSERT INTO `cmf_regions` VALUES ('2569', '2562', '吴旗县', '4', '0', '0', '0', ',3268,2471,2562,2569,');
INSERT INTO `cmf_regions` VALUES ('2570', '2562', '甘泉县', '4', '0', '0', '0', ',3268,2471,2562,2570,');
INSERT INTO `cmf_regions` VALUES ('2571', '2562', '富县', '4', '0', '0', '0', ',3268,2471,2562,2571,');
INSERT INTO `cmf_regions` VALUES ('2572', '2562', '洛川县', '4', '0', '0', '0', ',3268,2471,2562,2572,');
INSERT INTO `cmf_regions` VALUES ('2573', '2562', '宜川县', '4', '0', '0', '0', ',3268,2471,2562,2573,');
INSERT INTO `cmf_regions` VALUES ('2574', '2562', '黄龙县', '4', '0', '0', '0', ',3268,2471,2562,2574,');
INSERT INTO `cmf_regions` VALUES ('2575', '2562', '黄陵县', '4', '0', '0', '0', ',3268,2471,2562,2575,');
INSERT INTO `cmf_regions` VALUES ('2576', '2471', '榆林市', '3', '0', '0', '0', ',3268,2471,2576,');
INSERT INTO `cmf_regions` VALUES ('2577', '2576', '榆阳区', '4', '0', '0', '0', ',3268,2471,2576,2577,');
INSERT INTO `cmf_regions` VALUES ('2578', '2576', '神木县', '4', '0', '0', '0', ',3268,2471,2576,2578,');
INSERT INTO `cmf_regions` VALUES ('2579', '2576', '府谷县', '4', '0', '0', '0', ',3268,2471,2576,2579,');
INSERT INTO `cmf_regions` VALUES ('2580', '2576', '横山县', '4', '0', '0', '0', ',3268,2471,2576,2580,');
INSERT INTO `cmf_regions` VALUES ('2581', '2576', '靖边县', '4', '0', '0', '0', ',3268,2471,2576,2581,');
INSERT INTO `cmf_regions` VALUES ('2582', '2576', '定边县', '4', '0', '0', '0', ',3268,2471,2576,2582,');
INSERT INTO `cmf_regions` VALUES ('2583', '2576', '绥德县', '4', '0', '0', '0', ',3268,2471,2576,2583,');
INSERT INTO `cmf_regions` VALUES ('2584', '2576', '米脂县', '4', '0', '0', '0', ',3268,2471,2576,2584,');
INSERT INTO `cmf_regions` VALUES ('2585', '2576', '佳县', '4', '0', '0', '0', ',3268,2471,2576,2585,');
INSERT INTO `cmf_regions` VALUES ('2586', '2576', '吴堡县', '4', '0', '0', '0', ',3268,2471,2576,2586,');
INSERT INTO `cmf_regions` VALUES ('2587', '2576', '清涧县', '4', '0', '0', '0', ',3268,2471,2576,2587,');
INSERT INTO `cmf_regions` VALUES ('2588', '2576', '子洲县', '4', '0', '0', '0', ',3268,2471,2576,2588,');
INSERT INTO `cmf_regions` VALUES ('2589', '3268', '四川', '2', '0', '0', '0', ',3268,2589,');
INSERT INTO `cmf_regions` VALUES ('2590', '2589', '成都市', '3', '0', '0', '0', ',3268,2589,2590,');
INSERT INTO `cmf_regions` VALUES ('2591', '2590', '锦江区', '4', '0', '0', '0', ',3268,2589,2590,2591,');
INSERT INTO `cmf_regions` VALUES ('2592', '2590', '青羊区', '4', '0', '0', '0', ',3268,2589,2590,2592,');
INSERT INTO `cmf_regions` VALUES ('2593', '2590', '金牛区', '4', '0', '0', '0', ',3268,2589,2590,2593,');
INSERT INTO `cmf_regions` VALUES ('2594', '2590', '武侯区', '4', '0', '0', '0', ',3268,2589,2590,2594,');
INSERT INTO `cmf_regions` VALUES ('2595', '2590', '成华区', '4', '0', '0', '0', ',3268,2589,2590,2595,');
INSERT INTO `cmf_regions` VALUES ('2596', '2590', '龙泉驿区', '4', '0', '0', '0', ',3268,2589,2590,2596,');
INSERT INTO `cmf_regions` VALUES ('2597', '2590', '青白江区', '4', '0', '0', '0', ',3268,2589,2590,2597,');
INSERT INTO `cmf_regions` VALUES ('2598', '2590', '新都区', '4', '0', '0', '0', ',3268,2589,2590,2598,');
INSERT INTO `cmf_regions` VALUES ('2599', '2590', '温江区', '4', '0', '0', '0', ',3268,2589,2590,2599,');
INSERT INTO `cmf_regions` VALUES ('2600', '2590', '金堂县', '4', '0', '0', '0', ',3268,2589,2590,2600,');
INSERT INTO `cmf_regions` VALUES ('2601', '2590', '双流县', '4', '0', '0', '0', ',3268,2589,2590,2601,');
INSERT INTO `cmf_regions` VALUES ('2602', '2590', '郫县', '4', '0', '0', '0', ',3268,2589,2590,2602,');
INSERT INTO `cmf_regions` VALUES ('2603', '2590', '大邑县', '4', '0', '0', '0', ',3268,2589,2590,2603,');
INSERT INTO `cmf_regions` VALUES ('2604', '2590', '蒲江县', '4', '0', '0', '0', ',3268,2589,2590,2604,');
INSERT INTO `cmf_regions` VALUES ('2605', '2590', '新津县', '4', '0', '0', '0', ',3268,2589,2590,2605,');
INSERT INTO `cmf_regions` VALUES ('2606', '2590', '都江堰市', '4', '0', '0', '0', ',3268,2589,2590,2606,');
INSERT INTO `cmf_regions` VALUES ('2607', '2590', '彭州市', '4', '0', '0', '0', ',3268,2589,2590,2607,');
INSERT INTO `cmf_regions` VALUES ('2608', '2590', '邛崃市', '4', '0', '0', '0', ',3268,2589,2590,2608,');
INSERT INTO `cmf_regions` VALUES ('2609', '2590', '崇州市', '4', '0', '0', '0', ',3268,2589,2590,2609,');
INSERT INTO `cmf_regions` VALUES ('2610', '2589', '阿坝藏族羌族自治州', '3', '0', '0', '0', ',3268,2589,2610,');
INSERT INTO `cmf_regions` VALUES ('2611', '2610', '汶川县', '4', '0', '0', '0', ',3268,2589,2610,2611,');
INSERT INTO `cmf_regions` VALUES ('2612', '2610', '理县', '4', '0', '0', '0', ',3268,2589,2610,2612,');
INSERT INTO `cmf_regions` VALUES ('2613', '2610', '茂县', '4', '0', '0', '0', ',3268,2589,2610,2613,');
INSERT INTO `cmf_regions` VALUES ('2614', '2610', '松潘县', '4', '0', '0', '0', ',3268,2589,2610,2614,');
INSERT INTO `cmf_regions` VALUES ('2615', '2610', '九寨沟县', '4', '0', '0', '0', ',3268,2589,2610,2615,');
INSERT INTO `cmf_regions` VALUES ('2616', '2610', '金川县', '4', '0', '0', '0', ',3268,2589,2610,2616,');
INSERT INTO `cmf_regions` VALUES ('2617', '2610', '小金县', '4', '0', '0', '0', ',3268,2589,2610,2617,');
INSERT INTO `cmf_regions` VALUES ('2618', '2610', '黑水县', '4', '0', '0', '0', ',3268,2589,2610,2618,');
INSERT INTO `cmf_regions` VALUES ('2619', '2610', '马尔康县', '4', '0', '0', '0', ',3268,2589,2610,2619,');
INSERT INTO `cmf_regions` VALUES ('2620', '2610', '壤塘县', '4', '0', '0', '0', ',3268,2589,2610,2620,');
INSERT INTO `cmf_regions` VALUES ('2621', '2610', '阿坝县', '4', '0', '0', '0', ',3268,2589,2610,2621,');
INSERT INTO `cmf_regions` VALUES ('2622', '2610', '若尔盖县', '4', '0', '0', '0', ',3268,2589,2610,2622,');
INSERT INTO `cmf_regions` VALUES ('2623', '2610', '红原县', '4', '0', '0', '0', ',3268,2589,2610,2623,');
INSERT INTO `cmf_regions` VALUES ('2624', '2589', '巴中市', '3', '0', '0', '0', ',3268,2589,2624,');
INSERT INTO `cmf_regions` VALUES ('2625', '2624', '巴州区', '4', '0', '0', '0', ',3268,2589,2624,2625,');
INSERT INTO `cmf_regions` VALUES ('2626', '2624', '通江县', '4', '0', '0', '0', ',3268,2589,2624,2626,');
INSERT INTO `cmf_regions` VALUES ('2627', '2624', '南江县', '4', '0', '0', '0', ',3268,2589,2624,2627,');
INSERT INTO `cmf_regions` VALUES ('2628', '2624', '平昌县', '4', '0', '0', '0', ',3268,2589,2624,2628,');
INSERT INTO `cmf_regions` VALUES ('2629', '2589', '达州市', '3', '0', '0', '0', ',3268,2589,2629,');
INSERT INTO `cmf_regions` VALUES ('2630', '2629', '通川区', '4', '0', '0', '0', ',3268,2589,2629,2630,');
INSERT INTO `cmf_regions` VALUES ('2631', '2629', '达县', '4', '0', '0', '0', ',3268,2589,2629,2631,');
INSERT INTO `cmf_regions` VALUES ('2632', '2629', '宣汉县', '4', '0', '0', '0', ',3268,2589,2629,2632,');
INSERT INTO `cmf_regions` VALUES ('2633', '2629', '开江县', '4', '0', '0', '0', ',3268,2589,2629,2633,');
INSERT INTO `cmf_regions` VALUES ('2634', '2629', '大竹县', '4', '0', '0', '0', ',3268,2589,2629,2634,');
INSERT INTO `cmf_regions` VALUES ('2635', '2629', '渠县', '4', '0', '0', '0', ',3268,2589,2629,2635,');
INSERT INTO `cmf_regions` VALUES ('2636', '2629', '万源市', '4', '0', '0', '0', ',3268,2589,2629,2636,');
INSERT INTO `cmf_regions` VALUES ('2637', '2589', '德阳市', '3', '0', '0', '0', ',3268,2589,2637,');
INSERT INTO `cmf_regions` VALUES ('2638', '2637', '旌阳区', '4', '0', '0', '0', ',3268,2589,2637,2638,');
INSERT INTO `cmf_regions` VALUES ('2639', '2637', '中江县', '4', '0', '0', '0', ',3268,2589,2637,2639,');
INSERT INTO `cmf_regions` VALUES ('2640', '2637', '罗江县', '4', '0', '0', '0', ',3268,2589,2637,2640,');
INSERT INTO `cmf_regions` VALUES ('2641', '2637', '广汉市', '4', '0', '0', '0', ',3268,2589,2637,2641,');
INSERT INTO `cmf_regions` VALUES ('2642', '2637', '什邡市', '4', '0', '0', '0', ',3268,2589,2637,2642,');
INSERT INTO `cmf_regions` VALUES ('2643', '2637', '绵竹市', '4', '0', '0', '0', ',3268,2589,2637,2643,');
INSERT INTO `cmf_regions` VALUES ('2644', '2589', '甘孜藏族自治州', '3', '0', '0', '0', ',3268,2589,2644,');
INSERT INTO `cmf_regions` VALUES ('2645', '2644', '康定县', '4', '0', '0', '0', ',3268,2589,2644,2645,');
INSERT INTO `cmf_regions` VALUES ('2646', '2644', '泸定县', '4', '0', '0', '0', ',3268,2589,2644,2646,');
INSERT INTO `cmf_regions` VALUES ('2647', '2644', '丹巴县', '4', '0', '0', '0', ',3268,2589,2644,2647,');
INSERT INTO `cmf_regions` VALUES ('2648', '2644', '九龙县', '4', '0', '0', '0', ',3268,2589,2644,2648,');
INSERT INTO `cmf_regions` VALUES ('2649', '2644', '雅江县', '4', '0', '0', '0', ',3268,2589,2644,2649,');
INSERT INTO `cmf_regions` VALUES ('2650', '2644', '道孚县', '4', '0', '0', '0', ',3268,2589,2644,2650,');
INSERT INTO `cmf_regions` VALUES ('2651', '2644', '炉霍县', '4', '0', '0', '0', ',3268,2589,2644,2651,');
INSERT INTO `cmf_regions` VALUES ('2652', '2644', '甘孜县', '4', '0', '0', '0', ',3268,2589,2644,2652,');
INSERT INTO `cmf_regions` VALUES ('2653', '2644', '新龙县', '4', '0', '0', '0', ',3268,2589,2644,2653,');
INSERT INTO `cmf_regions` VALUES ('2654', '2644', '德格县', '4', '0', '0', '0', ',3268,2589,2644,2654,');
INSERT INTO `cmf_regions` VALUES ('2655', '2644', '白玉县', '4', '0', '0', '0', ',3268,2589,2644,2655,');
INSERT INTO `cmf_regions` VALUES ('2656', '2644', '石渠县', '4', '0', '0', '0', ',3268,2589,2644,2656,');
INSERT INTO `cmf_regions` VALUES ('2657', '2644', '色达县', '4', '0', '0', '0', ',3268,2589,2644,2657,');
INSERT INTO `cmf_regions` VALUES ('2658', '2644', '理塘县', '4', '0', '0', '0', ',3268,2589,2644,2658,');
INSERT INTO `cmf_regions` VALUES ('2659', '2644', '巴塘县', '4', '0', '0', '0', ',3268,2589,2644,2659,');
INSERT INTO `cmf_regions` VALUES ('2660', '2644', '乡城县', '4', '0', '0', '0', ',3268,2589,2644,2660,');
INSERT INTO `cmf_regions` VALUES ('2661', '2644', '稻城县', '4', '0', '0', '0', ',3268,2589,2644,2661,');
INSERT INTO `cmf_regions` VALUES ('2662', '2644', '得荣县', '4', '0', '0', '0', ',3268,2589,2644,2662,');
INSERT INTO `cmf_regions` VALUES ('2663', '2589', '广安市', '3', '0', '0', '0', ',3268,2589,2663,');
INSERT INTO `cmf_regions` VALUES ('2664', '2663', '广安区', '4', '0', '0', '0', ',3268,2589,2663,2664,');
INSERT INTO `cmf_regions` VALUES ('2665', '2663', '岳池县', '4', '0', '0', '0', ',3268,2589,2663,2665,');
INSERT INTO `cmf_regions` VALUES ('2666', '2663', '武胜县', '4', '0', '0', '0', ',3268,2589,2663,2666,');
INSERT INTO `cmf_regions` VALUES ('2667', '2663', '邻水县', '4', '0', '0', '0', ',3268,2589,2663,2667,');
INSERT INTO `cmf_regions` VALUES ('2668', '2663', '华莹市', '4', '0', '0', '0', ',3268,2589,2663,2668,');
INSERT INTO `cmf_regions` VALUES ('2669', '2589', '广元市', '3', '0', '0', '0', ',3268,2589,2669,');
INSERT INTO `cmf_regions` VALUES ('2670', '2669', '市中区', '4', '0', '0', '0', ',3268,2589,2669,2670,');
INSERT INTO `cmf_regions` VALUES ('2671', '2669', '元坝区', '4', '0', '0', '0', ',3268,2589,2669,2671,');
INSERT INTO `cmf_regions` VALUES ('2672', '2669', '朝天区', '4', '0', '0', '0', ',3268,2589,2669,2672,');
INSERT INTO `cmf_regions` VALUES ('2673', '2669', '旺苍县', '4', '0', '0', '0', ',3268,2589,2669,2673,');
INSERT INTO `cmf_regions` VALUES ('2674', '2669', '青川县', '4', '0', '0', '0', ',3268,2589,2669,2674,');
INSERT INTO `cmf_regions` VALUES ('2675', '2669', '剑阁县', '4', '0', '0', '0', ',3268,2589,2669,2675,');
INSERT INTO `cmf_regions` VALUES ('2676', '2669', '苍溪县', '4', '0', '0', '0', ',3268,2589,2669,2676,');
INSERT INTO `cmf_regions` VALUES ('2677', '2589', '乐山市', '3', '0', '0', '0', ',3268,2589,2677,');
INSERT INTO `cmf_regions` VALUES ('2678', '2677', '市中区', '4', '0', '0', '0', ',3268,2589,2677,2678,');
INSERT INTO `cmf_regions` VALUES ('2679', '2677', '沙湾区', '4', '0', '0', '0', ',3268,2589,2677,2679,');
INSERT INTO `cmf_regions` VALUES ('2680', '2677', '五通桥区', '4', '0', '0', '0', ',3268,2589,2677,2680,');
INSERT INTO `cmf_regions` VALUES ('2681', '2677', '金口河区', '4', '0', '0', '0', ',3268,2589,2677,2681,');
INSERT INTO `cmf_regions` VALUES ('2682', '2677', '犍为县', '4', '0', '0', '0', ',3268,2589,2677,2682,');
INSERT INTO `cmf_regions` VALUES ('2683', '2677', '井研县', '4', '0', '0', '0', ',3268,2589,2677,2683,');
INSERT INTO `cmf_regions` VALUES ('2684', '2677', '夹江县', '4', '0', '0', '0', ',3268,2589,2677,2684,');
INSERT INTO `cmf_regions` VALUES ('2685', '2677', '沐川县', '4', '0', '0', '0', ',3268,2589,2677,2685,');
INSERT INTO `cmf_regions` VALUES ('2686', '2677', '峨边彝族自治县', '4', '0', '0', '0', ',3268,2589,2677,2686,');
INSERT INTO `cmf_regions` VALUES ('2687', '2677', '马边彝族自治县', '4', '0', '0', '0', ',3268,2589,2677,2687,');
INSERT INTO `cmf_regions` VALUES ('2688', '2677', '峨眉山市', '4', '0', '0', '0', ',3268,2589,2677,2688,');
INSERT INTO `cmf_regions` VALUES ('2689', '2589', '凉山彝族自治州', '3', '0', '0', '0', ',3268,2589,2689,');
INSERT INTO `cmf_regions` VALUES ('2690', '2689', '西昌市', '4', '0', '0', '0', ',3268,2589,2689,2690,');
INSERT INTO `cmf_regions` VALUES ('2691', '2689', '木里藏族自治县', '4', '0', '0', '0', ',3268,2589,2689,2691,');
INSERT INTO `cmf_regions` VALUES ('2692', '2689', '盐源县', '4', '0', '0', '0', ',3268,2589,2689,2692,');
INSERT INTO `cmf_regions` VALUES ('2693', '2689', '德昌县', '4', '0', '0', '0', ',3268,2589,2689,2693,');
INSERT INTO `cmf_regions` VALUES ('2694', '2689', '会理县', '4', '0', '0', '0', ',3268,2589,2689,2694,');
INSERT INTO `cmf_regions` VALUES ('2695', '2689', '会东县', '4', '0', '0', '0', ',3268,2589,2689,2695,');
INSERT INTO `cmf_regions` VALUES ('2696', '2689', '宁南县', '4', '0', '0', '0', ',3268,2589,2689,2696,');
INSERT INTO `cmf_regions` VALUES ('2697', '2689', '普格县', '4', '0', '0', '0', ',3268,2589,2689,2697,');
INSERT INTO `cmf_regions` VALUES ('2698', '2689', '布拖县', '4', '0', '0', '0', ',3268,2589,2689,2698,');
INSERT INTO `cmf_regions` VALUES ('2699', '2689', '金阳县', '4', '0', '0', '0', ',3268,2589,2689,2699,');
INSERT INTO `cmf_regions` VALUES ('2700', '2689', '昭觉县', '4', '0', '0', '0', ',3268,2589,2689,2700,');
INSERT INTO `cmf_regions` VALUES ('2701', '2689', '喜德县', '4', '0', '0', '0', ',3268,2589,2689,2701,');
INSERT INTO `cmf_regions` VALUES ('2702', '2689', '冕宁县', '4', '0', '0', '0', ',3268,2589,2689,2702,');
INSERT INTO `cmf_regions` VALUES ('2703', '2689', '越西县', '4', '0', '0', '0', ',3268,2589,2689,2703,');
INSERT INTO `cmf_regions` VALUES ('2704', '2689', '甘洛县', '4', '0', '0', '0', ',3268,2589,2689,2704,');
INSERT INTO `cmf_regions` VALUES ('2705', '2689', '美姑县', '4', '0', '0', '0', ',3268,2589,2689,2705,');
INSERT INTO `cmf_regions` VALUES ('2706', '2689', '雷波县', '4', '0', '0', '0', ',3268,2589,2689,2706,');
INSERT INTO `cmf_regions` VALUES ('2707', '2589', '泸州市', '3', '0', '0', '0', ',3268,2589,2707,');
INSERT INTO `cmf_regions` VALUES ('2708', '2707', '江阳区', '4', '0', '0', '0', ',3268,2589,2707,2708,');
INSERT INTO `cmf_regions` VALUES ('2709', '2707', '纳溪区', '4', '0', '0', '0', ',3268,2589,2707,2709,');
INSERT INTO `cmf_regions` VALUES ('2710', '2707', '龙马潭区', '4', '0', '0', '0', ',3268,2589,2707,2710,');
INSERT INTO `cmf_regions` VALUES ('2711', '2707', '泸县', '4', '0', '0', '0', ',3268,2589,2707,2711,');
INSERT INTO `cmf_regions` VALUES ('2712', '2707', '合江县', '4', '0', '0', '0', ',3268,2589,2707,2712,');
INSERT INTO `cmf_regions` VALUES ('2713', '2707', '叙永县', '4', '0', '0', '0', ',3268,2589,2707,2713,');
INSERT INTO `cmf_regions` VALUES ('2714', '2707', '古蔺县', '4', '0', '0', '0', ',3268,2589,2707,2714,');
INSERT INTO `cmf_regions` VALUES ('2715', '2589', '眉山市', '3', '0', '0', '0', ',3268,2589,2715,');
INSERT INTO `cmf_regions` VALUES ('2716', '2715', '东坡区', '4', '0', '0', '0', ',3268,2589,2715,2716,');
INSERT INTO `cmf_regions` VALUES ('2717', '2715', '仁寿县', '4', '0', '0', '0', ',3268,2589,2715,2717,');
INSERT INTO `cmf_regions` VALUES ('2718', '2715', '彭山县', '4', '0', '0', '0', ',3268,2589,2715,2718,');
INSERT INTO `cmf_regions` VALUES ('2719', '2715', '洪雅县', '4', '0', '0', '0', ',3268,2589,2715,2719,');
INSERT INTO `cmf_regions` VALUES ('2720', '2715', '丹棱县', '4', '0', '0', '0', ',3268,2589,2715,2720,');
INSERT INTO `cmf_regions` VALUES ('2721', '2715', '青神县', '4', '0', '0', '0', ',3268,2589,2715,2721,');
INSERT INTO `cmf_regions` VALUES ('2722', '2589', '绵阳市', '3', '0', '0', '0', ',3268,2589,2722,');
INSERT INTO `cmf_regions` VALUES ('2723', '2722', '涪城区', '4', '0', '0', '0', ',3268,2589,2722,2723,');
INSERT INTO `cmf_regions` VALUES ('2724', '2722', '游仙区', '4', '0', '0', '0', ',3268,2589,2722,2724,');
INSERT INTO `cmf_regions` VALUES ('2725', '2722', '三台县', '4', '0', '0', '0', ',3268,2589,2722,2725,');
INSERT INTO `cmf_regions` VALUES ('2726', '2722', '盐亭县', '4', '0', '0', '0', ',3268,2589,2722,2726,');
INSERT INTO `cmf_regions` VALUES ('2727', '2722', '安县', '4', '0', '0', '0', ',3268,2589,2722,2727,');
INSERT INTO `cmf_regions` VALUES ('2728', '2722', '梓潼县', '4', '0', '0', '0', ',3268,2589,2722,2728,');
INSERT INTO `cmf_regions` VALUES ('2729', '2722', '北川羌族自治县', '4', '0', '0', '0', ',3268,2589,2722,2729,');
INSERT INTO `cmf_regions` VALUES ('2730', '2722', '平武县', '4', '0', '0', '0', ',3268,2589,2722,2730,');
INSERT INTO `cmf_regions` VALUES ('2731', '2722', '江油市', '4', '0', '0', '0', ',3268,2589,2722,2731,');
INSERT INTO `cmf_regions` VALUES ('2732', '2589', '内江市', '3', '0', '0', '0', ',3268,2589,2732,');
INSERT INTO `cmf_regions` VALUES ('2733', '2732', '市中区', '4', '0', '0', '0', ',3268,2589,2732,2733,');
INSERT INTO `cmf_regions` VALUES ('2734', '2732', '东兴区', '4', '0', '0', '0', ',3268,2589,2732,2734,');
INSERT INTO `cmf_regions` VALUES ('2735', '2732', '威远县', '4', '0', '0', '0', ',3268,2589,2732,2735,');
INSERT INTO `cmf_regions` VALUES ('2736', '2732', '资中县', '4', '0', '0', '0', ',3268,2589,2732,2736,');
INSERT INTO `cmf_regions` VALUES ('2737', '2732', '隆昌县', '4', '0', '0', '0', ',3268,2589,2732,2737,');
INSERT INTO `cmf_regions` VALUES ('2738', '2589', '南充市', '3', '0', '0', '0', ',3268,2589,2738,');
INSERT INTO `cmf_regions` VALUES ('2739', '2738', '顺庆区', '4', '0', '0', '0', ',3268,2589,2738,2739,');
INSERT INTO `cmf_regions` VALUES ('2740', '2738', '高坪区', '4', '0', '0', '0', ',3268,2589,2738,2740,');
INSERT INTO `cmf_regions` VALUES ('2741', '2738', '嘉陵区', '4', '0', '0', '0', ',3268,2589,2738,2741,');
INSERT INTO `cmf_regions` VALUES ('2742', '2738', '南部县', '4', '0', '0', '0', ',3268,2589,2738,2742,');
INSERT INTO `cmf_regions` VALUES ('2743', '2738', '营山县', '4', '0', '0', '0', ',3268,2589,2738,2743,');
INSERT INTO `cmf_regions` VALUES ('2744', '2738', '蓬安县', '4', '0', '0', '0', ',3268,2589,2738,2744,');
INSERT INTO `cmf_regions` VALUES ('2745', '2738', '仪陇县', '4', '0', '0', '0', ',3268,2589,2738,2745,');
INSERT INTO `cmf_regions` VALUES ('2746', '2738', '西充县', '4', '0', '0', '0', ',3268,2589,2738,2746,');
INSERT INTO `cmf_regions` VALUES ('2747', '2738', '阆中市', '4', '0', '0', '0', ',3268,2589,2738,2747,');
INSERT INTO `cmf_regions` VALUES ('2748', '2589', '攀枝花市', '3', '0', '0', '0', ',3268,2589,2748,');
INSERT INTO `cmf_regions` VALUES ('2749', '2748', '东区', '4', '0', '0', '0', ',3268,2589,2748,2749,');
INSERT INTO `cmf_regions` VALUES ('2750', '2748', '西区', '4', '0', '0', '0', ',3268,2589,2748,2750,');
INSERT INTO `cmf_regions` VALUES ('2751', '2748', '仁和区', '4', '0', '0', '0', ',3268,2589,2748,2751,');
INSERT INTO `cmf_regions` VALUES ('2752', '2748', '米易县', '4', '0', '0', '0', ',3268,2589,2748,2752,');
INSERT INTO `cmf_regions` VALUES ('2753', '2748', '盐边县', '4', '0', '0', '0', ',3268,2589,2748,2753,');
INSERT INTO `cmf_regions` VALUES ('2754', '2589', '遂宁市', '3', '0', '0', '0', ',3268,2589,2754,');
INSERT INTO `cmf_regions` VALUES ('2755', '2754', '船山区', '4', '0', '0', '0', ',3268,2589,2754,2755,');
INSERT INTO `cmf_regions` VALUES ('2756', '2754', '安居区', '4', '0', '0', '0', ',3268,2589,2754,2756,');
INSERT INTO `cmf_regions` VALUES ('2757', '2754', '蓬溪县', '4', '0', '0', '0', ',3268,2589,2754,2757,');
INSERT INTO `cmf_regions` VALUES ('2758', '2754', '射洪县', '4', '0', '0', '0', ',3268,2589,2754,2758,');
INSERT INTO `cmf_regions` VALUES ('2759', '2754', '大英县', '4', '0', '0', '0', ',3268,2589,2754,2759,');
INSERT INTO `cmf_regions` VALUES ('2760', '2589', '雅安市', '3', '0', '0', '0', ',3268,2589,2760,');
INSERT INTO `cmf_regions` VALUES ('2761', '2760', '雨城区', '4', '0', '0', '0', ',3268,2589,2760,2761,');
INSERT INTO `cmf_regions` VALUES ('2762', '2760', '名山县', '4', '0', '0', '0', ',3268,2589,2760,2762,');
INSERT INTO `cmf_regions` VALUES ('2763', '2760', '荥经县', '4', '0', '0', '0', ',3268,2589,2760,2763,');
INSERT INTO `cmf_regions` VALUES ('2764', '2760', '汉源县', '4', '0', '0', '0', ',3268,2589,2760,2764,');
INSERT INTO `cmf_regions` VALUES ('2765', '2760', '石棉县', '4', '0', '0', '0', ',3268,2589,2760,2765,');
INSERT INTO `cmf_regions` VALUES ('2766', '2760', '天全县', '4', '0', '0', '0', ',3268,2589,2760,2766,');
INSERT INTO `cmf_regions` VALUES ('2767', '2760', '芦山县', '4', '0', '0', '0', ',3268,2589,2760,2767,');
INSERT INTO `cmf_regions` VALUES ('2768', '2760', '宝兴县', '4', '0', '0', '0', ',3268,2589,2760,2768,');
INSERT INTO `cmf_regions` VALUES ('2769', '2589', '宜宾市', '3', '0', '0', '0', ',3268,2589,2769,');
INSERT INTO `cmf_regions` VALUES ('2770', '2769', '翠屏区', '4', '0', '0', '0', ',3268,2589,2769,2770,');
INSERT INTO `cmf_regions` VALUES ('2771', '2769', '宜宾县', '4', '0', '0', '0', ',3268,2589,2769,2771,');
INSERT INTO `cmf_regions` VALUES ('2772', '2769', '南溪县', '4', '0', '0', '0', ',3268,2589,2769,2772,');
INSERT INTO `cmf_regions` VALUES ('2773', '2769', '江安县', '4', '0', '0', '0', ',3268,2589,2769,2773,');
INSERT INTO `cmf_regions` VALUES ('2774', '2769', '长宁县', '4', '0', '0', '0', ',3268,2589,2769,2774,');
INSERT INTO `cmf_regions` VALUES ('2775', '2769', '高县', '4', '0', '0', '0', ',3268,2589,2769,2775,');
INSERT INTO `cmf_regions` VALUES ('2776', '2769', '珙县', '4', '0', '0', '0', ',3268,2589,2769,2776,');
INSERT INTO `cmf_regions` VALUES ('2777', '2769', '筠连县', '4', '0', '0', '0', ',3268,2589,2769,2777,');
INSERT INTO `cmf_regions` VALUES ('2778', '2769', '兴文县', '4', '0', '0', '0', ',3268,2589,2769,2778,');
INSERT INTO `cmf_regions` VALUES ('2779', '2769', '屏山县', '4', '0', '0', '0', ',3268,2589,2769,2779,');
INSERT INTO `cmf_regions` VALUES ('2780', '2589', '资阳市', '3', '0', '0', '0', ',3268,2589,2780,');
INSERT INTO `cmf_regions` VALUES ('2781', '2780', '雁江区', '4', '0', '0', '0', ',3268,2589,2780,2781,');
INSERT INTO `cmf_regions` VALUES ('2782', '2780', '安岳县', '4', '0', '0', '0', ',3268,2589,2780,2782,');
INSERT INTO `cmf_regions` VALUES ('2783', '2780', '乐至县', '4', '0', '0', '0', ',3268,2589,2780,2783,');
INSERT INTO `cmf_regions` VALUES ('2784', '2780', '简阳市', '4', '0', '0', '0', ',3268,2589,2780,2784,');
INSERT INTO `cmf_regions` VALUES ('2785', '2589', '自贡市', '3', '0', '0', '0', ',3268,2589,2785,');
INSERT INTO `cmf_regions` VALUES ('2786', '2785', '自流井区', '4', '0', '0', '0', ',3268,2589,2785,2786,');
INSERT INTO `cmf_regions` VALUES ('2787', '2785', '贡井区', '4', '0', '0', '0', ',3268,2589,2785,2787,');
INSERT INTO `cmf_regions` VALUES ('2788', '2785', '大安区', '4', '0', '0', '0', ',3268,2589,2785,2788,');
INSERT INTO `cmf_regions` VALUES ('2789', '2785', '沿滩区', '4', '0', '0', '0', ',3268,2589,2785,2789,');
INSERT INTO `cmf_regions` VALUES ('2790', '2785', '荣县', '4', '0', '0', '0', ',3268,2589,2785,2790,');
INSERT INTO `cmf_regions` VALUES ('2791', '2785', '富顺县', '4', '0', '0', '0', ',3268,2589,2785,2791,');
INSERT INTO `cmf_regions` VALUES ('2792', '3268', '西藏', '2', '0', '0', '0', ',3268,2792,');
INSERT INTO `cmf_regions` VALUES ('2793', '2792', '拉萨市', '3', '0', '0', '0', ',3268,2792,2793,');
INSERT INTO `cmf_regions` VALUES ('2794', '2793', '城关区', '4', '0', '0', '0', ',3268,2792,2793,2794,');
INSERT INTO `cmf_regions` VALUES ('2795', '2793', '林周县', '4', '0', '0', '0', ',3268,2792,2793,2795,');
INSERT INTO `cmf_regions` VALUES ('2796', '2793', '当雄县', '4', '0', '0', '0', ',3268,2792,2793,2796,');
INSERT INTO `cmf_regions` VALUES ('2797', '2793', '尼木县', '4', '0', '0', '0', ',3268,2792,2793,2797,');
INSERT INTO `cmf_regions` VALUES ('2798', '2793', '曲水县', '4', '0', '0', '0', ',3268,2792,2793,2798,');
INSERT INTO `cmf_regions` VALUES ('2799', '2793', '堆龙德庆县', '4', '0', '0', '0', ',3268,2792,2793,2799,');
INSERT INTO `cmf_regions` VALUES ('2800', '2793', '达孜县', '4', '0', '0', '0', ',3268,2792,2793,2800,');
INSERT INTO `cmf_regions` VALUES ('2801', '2793', '墨竹工卡县', '4', '0', '0', '0', ',3268,2792,2793,2801,');
INSERT INTO `cmf_regions` VALUES ('2802', '2792', '阿里地区', '3', '0', '0', '0', ',3268,2792,2802,');
INSERT INTO `cmf_regions` VALUES ('2803', '2802', '普兰县', '4', '0', '0', '0', ',3268,2792,2802,2803,');
INSERT INTO `cmf_regions` VALUES ('2804', '2802', '札达县', '4', '0', '0', '0', ',3268,2792,2802,2804,');
INSERT INTO `cmf_regions` VALUES ('2805', '2802', '噶尔县', '4', '0', '0', '0', ',3268,2792,2802,2805,');
INSERT INTO `cmf_regions` VALUES ('2806', '2802', '日土县', '4', '0', '0', '0', ',3268,2792,2802,2806,');
INSERT INTO `cmf_regions` VALUES ('2807', '2802', '革吉县', '4', '0', '0', '0', ',3268,2792,2802,2807,');
INSERT INTO `cmf_regions` VALUES ('2808', '2802', '改则县', '4', '0', '0', '0', ',3268,2792,2802,2808,');
INSERT INTO `cmf_regions` VALUES ('2809', '2802', '措勤县', '4', '0', '0', '0', ',3268,2792,2802,2809,');
INSERT INTO `cmf_regions` VALUES ('2810', '2792', '昌都地区', '3', '0', '0', '0', ',3268,2792,2810,');
INSERT INTO `cmf_regions` VALUES ('2811', '2810', '昌都县', '4', '0', '0', '0', ',3268,2792,2810,2811,');
INSERT INTO `cmf_regions` VALUES ('2812', '2810', '江达县', '4', '0', '0', '0', ',3268,2792,2810,2812,');
INSERT INTO `cmf_regions` VALUES ('2813', '2810', '贡觉县', '4', '0', '0', '0', ',3268,2792,2810,2813,');
INSERT INTO `cmf_regions` VALUES ('2814', '2810', '类乌齐县', '4', '0', '0', '0', ',3268,2792,2810,2814,');
INSERT INTO `cmf_regions` VALUES ('2815', '2810', '丁青县', '4', '0', '0', '0', ',3268,2792,2810,2815,');
INSERT INTO `cmf_regions` VALUES ('2816', '2810', '察雅县', '4', '0', '0', '0', ',3268,2792,2810,2816,');
INSERT INTO `cmf_regions` VALUES ('2817', '2810', '八宿县', '4', '0', '0', '0', ',3268,2792,2810,2817,');
INSERT INTO `cmf_regions` VALUES ('2818', '2810', '左贡县', '4', '0', '0', '0', ',3268,2792,2810,2818,');
INSERT INTO `cmf_regions` VALUES ('2819', '2810', '芒康县', '4', '0', '0', '0', ',3268,2792,2810,2819,');
INSERT INTO `cmf_regions` VALUES ('2820', '2810', '洛隆县', '4', '0', '0', '0', ',3268,2792,2810,2820,');
INSERT INTO `cmf_regions` VALUES ('2821', '2810', '边坝县', '4', '0', '0', '0', ',3268,2792,2810,2821,');
INSERT INTO `cmf_regions` VALUES ('2822', '2792', '林芝地区', '3', '0', '0', '0', ',3268,2792,2822,');
INSERT INTO `cmf_regions` VALUES ('2823', '2822', '林芝县', '4', '0', '0', '0', ',3268,2792,2822,2823,');
INSERT INTO `cmf_regions` VALUES ('2824', '2822', '工布江达县', '4', '0', '0', '0', ',3268,2792,2822,2824,');
INSERT INTO `cmf_regions` VALUES ('2825', '2822', '米林县', '4', '0', '0', '0', ',3268,2792,2822,2825,');
INSERT INTO `cmf_regions` VALUES ('2826', '2822', '墨脱县', '4', '0', '0', '0', ',3268,2792,2822,2826,');
INSERT INTO `cmf_regions` VALUES ('2827', '2822', '波密县', '4', '0', '0', '0', ',3268,2792,2822,2827,');
INSERT INTO `cmf_regions` VALUES ('2828', '2822', '察隅县', '4', '0', '0', '0', ',3268,2792,2822,2828,');
INSERT INTO `cmf_regions` VALUES ('2829', '2822', '朗县', '4', '0', '0', '0', ',3268,2792,2822,2829,');
INSERT INTO `cmf_regions` VALUES ('2830', '2792', '那曲地区', '3', '0', '0', '0', ',3268,2792,2830,');
INSERT INTO `cmf_regions` VALUES ('2831', '2830', '那曲县', '4', '0', '0', '0', ',3268,2792,2830,2831,');
INSERT INTO `cmf_regions` VALUES ('2832', '2830', '嘉黎县', '4', '0', '0', '0', ',3268,2792,2830,2832,');
INSERT INTO `cmf_regions` VALUES ('2833', '2830', '比如县', '4', '0', '0', '0', ',3268,2792,2830,2833,');
INSERT INTO `cmf_regions` VALUES ('2834', '2830', '聂荣县', '4', '0', '0', '0', ',3268,2792,2830,2834,');
INSERT INTO `cmf_regions` VALUES ('2835', '2830', '安多县', '4', '0', '0', '0', ',3268,2792,2830,2835,');
INSERT INTO `cmf_regions` VALUES ('2836', '2830', '申扎县', '4', '0', '0', '0', ',3268,2792,2830,2836,');
INSERT INTO `cmf_regions` VALUES ('2837', '2830', '索县', '4', '0', '0', '0', ',3268,2792,2830,2837,');
INSERT INTO `cmf_regions` VALUES ('2838', '2830', '班戈县', '4', '0', '0', '0', ',3268,2792,2830,2838,');
INSERT INTO `cmf_regions` VALUES ('2839', '2830', '巴青县', '4', '0', '0', '0', ',3268,2792,2830,2839,');
INSERT INTO `cmf_regions` VALUES ('2840', '2830', '尼玛县', '4', '0', '0', '0', ',3268,2792,2830,2840,');
INSERT INTO `cmf_regions` VALUES ('2841', '2792', '日喀则地区', '3', '0', '0', '0', ',3268,2792,2841,');
INSERT INTO `cmf_regions` VALUES ('2842', '2841', '日喀则市', '4', '0', '0', '0', ',3268,2792,2841,2842,');
INSERT INTO `cmf_regions` VALUES ('2843', '2841', '南木林县', '4', '0', '0', '0', ',3268,2792,2841,2843,');
INSERT INTO `cmf_regions` VALUES ('2844', '2841', '江孜县', '4', '0', '0', '0', ',3268,2792,2841,2844,');
INSERT INTO `cmf_regions` VALUES ('2845', '2841', '定日县', '4', '0', '0', '0', ',3268,2792,2841,2845,');
INSERT INTO `cmf_regions` VALUES ('2846', '2841', '萨迦县', '4', '0', '0', '0', ',3268,2792,2841,2846,');
INSERT INTO `cmf_regions` VALUES ('2847', '2841', '拉孜县', '4', '0', '0', '0', ',3268,2792,2841,2847,');
INSERT INTO `cmf_regions` VALUES ('2848', '2841', '昂仁县', '4', '0', '0', '0', ',3268,2792,2841,2848,');
INSERT INTO `cmf_regions` VALUES ('2849', '2841', '谢通门县', '4', '0', '0', '0', ',3268,2792,2841,2849,');
INSERT INTO `cmf_regions` VALUES ('2850', '2841', '白朗县', '4', '0', '0', '0', ',3268,2792,2841,2850,');
INSERT INTO `cmf_regions` VALUES ('2851', '2841', '仁布县', '4', '0', '0', '0', ',3268,2792,2841,2851,');
INSERT INTO `cmf_regions` VALUES ('2852', '2841', '康马县', '4', '0', '0', '0', ',3268,2792,2841,2852,');
INSERT INTO `cmf_regions` VALUES ('2853', '2841', '定结县', '4', '0', '0', '0', ',3268,2792,2841,2853,');
INSERT INTO `cmf_regions` VALUES ('2854', '2841', '仲巴县', '4', '0', '0', '0', ',3268,2792,2841,2854,');
INSERT INTO `cmf_regions` VALUES ('2855', '2841', '亚东县', '4', '0', '0', '0', ',3268,2792,2841,2855,');
INSERT INTO `cmf_regions` VALUES ('2856', '2841', '吉隆县', '4', '0', '0', '0', ',3268,2792,2841,2856,');
INSERT INTO `cmf_regions` VALUES ('2857', '2841', '聂拉木县', '4', '0', '0', '0', ',3268,2792,2841,2857,');
INSERT INTO `cmf_regions` VALUES ('2858', '2841', '萨嘎县', '4', '0', '0', '0', ',3268,2792,2841,2858,');
INSERT INTO `cmf_regions` VALUES ('2859', '2841', '岗巴县', '4', '0', '0', '0', ',3268,2792,2841,2859,');
INSERT INTO `cmf_regions` VALUES ('2860', '2792', '山南地区', '3', '0', '0', '0', ',3268,2792,2860,');
INSERT INTO `cmf_regions` VALUES ('2861', '2860', '乃东县', '4', '0', '0', '0', ',3268,2792,2860,2861,');
INSERT INTO `cmf_regions` VALUES ('2862', '2860', '扎囊县', '4', '0', '0', '0', ',3268,2792,2860,2862,');
INSERT INTO `cmf_regions` VALUES ('2863', '2860', '贡嘎县', '4', '0', '0', '0', ',3268,2792,2860,2863,');
INSERT INTO `cmf_regions` VALUES ('2864', '2860', '桑日县', '4', '0', '0', '0', ',3268,2792,2860,2864,');
INSERT INTO `cmf_regions` VALUES ('2865', '2860', '琼结县', '4', '0', '0', '0', ',3268,2792,2860,2865,');
INSERT INTO `cmf_regions` VALUES ('2866', '2860', '曲松县', '4', '0', '0', '0', ',3268,2792,2860,2866,');
INSERT INTO `cmf_regions` VALUES ('2867', '2860', '措美县', '4', '0', '0', '0', ',3268,2792,2860,2867,');
INSERT INTO `cmf_regions` VALUES ('2868', '2860', '洛扎县', '4', '0', '0', '0', ',3268,2792,2860,2868,');
INSERT INTO `cmf_regions` VALUES ('2869', '2860', '加查县', '4', '0', '0', '0', ',3268,2792,2860,2869,');
INSERT INTO `cmf_regions` VALUES ('2870', '2860', '隆子县', '4', '0', '0', '0', ',3268,2792,2860,2870,');
INSERT INTO `cmf_regions` VALUES ('2871', '2860', '错那县', '4', '0', '0', '0', ',3268,2792,2860,2871,');
INSERT INTO `cmf_regions` VALUES ('2872', '2860', '浪卡子县', '4', '0', '0', '0', ',3268,2792,2860,2872,');
INSERT INTO `cmf_regions` VALUES ('2873', '3268', '新疆', '2', '0', '0', '0', ',3268,2873,');
INSERT INTO `cmf_regions` VALUES ('2874', '2873', '乌鲁木齐市', '3', '0', '0', '0', ',3268,2873,2874,');
INSERT INTO `cmf_regions` VALUES ('2875', '2874', '天山区', '4', '0', '0', '0', ',3268,2873,2874,2875,');
INSERT INTO `cmf_regions` VALUES ('2876', '2874', '沙依巴克区', '4', '0', '0', '0', ',3268,2873,2874,2876,');
INSERT INTO `cmf_regions` VALUES ('2877', '2874', '新市区', '4', '0', '0', '0', ',3268,2873,2874,2877,');
INSERT INTO `cmf_regions` VALUES ('2878', '2874', '水磨沟区', '4', '0', '0', '0', ',3268,2873,2874,2878,');
INSERT INTO `cmf_regions` VALUES ('2879', '2874', '头屯河区', '4', '0', '0', '0', ',3268,2873,2874,2879,');
INSERT INTO `cmf_regions` VALUES ('2880', '2874', '达坂城区', '4', '0', '0', '0', ',3268,2873,2874,2880,');
INSERT INTO `cmf_regions` VALUES ('2881', '2874', '东山区', '4', '0', '0', '0', ',3268,2873,2874,2881,');
INSERT INTO `cmf_regions` VALUES ('2882', '2874', '乌鲁木齐县', '4', '0', '0', '0', ',3268,2873,2874,2882,');
INSERT INTO `cmf_regions` VALUES ('2883', '2873', '阿克苏地区', '3', '0', '0', '0', ',3268,2873,2883,');
INSERT INTO `cmf_regions` VALUES ('2884', '2883', '阿克苏市', '4', '0', '0', '0', ',3268,2873,2883,2884,');
INSERT INTO `cmf_regions` VALUES ('2885', '2883', '温宿县', '4', '0', '0', '0', ',3268,2873,2883,2885,');
INSERT INTO `cmf_regions` VALUES ('2886', '2883', '库车县', '4', '0', '0', '0', ',3268,2873,2883,2886,');
INSERT INTO `cmf_regions` VALUES ('2887', '2883', '沙雅县', '4', '0', '0', '0', ',3268,2873,2883,2887,');
INSERT INTO `cmf_regions` VALUES ('2888', '2883', '新和县', '4', '0', '0', '0', ',3268,2873,2883,2888,');
INSERT INTO `cmf_regions` VALUES ('2889', '2883', '拜城县', '4', '0', '0', '0', ',3268,2873,2883,2889,');
INSERT INTO `cmf_regions` VALUES ('2890', '2883', '乌什县', '4', '0', '0', '0', ',3268,2873,2883,2890,');
INSERT INTO `cmf_regions` VALUES ('2891', '2883', '阿瓦提县', '4', '0', '0', '0', ',3268,2873,2883,2891,');
INSERT INTO `cmf_regions` VALUES ('2892', '2883', '柯坪县', '4', '0', '0', '0', ',3268,2873,2883,2892,');
INSERT INTO `cmf_regions` VALUES ('2893', '2873', '阿拉尔市', '3', '0', '0', '0', ',3268,2873,2893,');
INSERT INTO `cmf_regions` VALUES ('2894', '2873', '阿勒泰地区', '3', '0', '0', '0', ',3268,2873,2894,');
INSERT INTO `cmf_regions` VALUES ('2895', '2894', '阿勒泰市', '4', '0', '0', '0', ',3268,2873,2894,2895,');
INSERT INTO `cmf_regions` VALUES ('2896', '2894', '布尔津县', '4', '0', '0', '0', ',3268,2873,2894,2896,');
INSERT INTO `cmf_regions` VALUES ('2897', '2894', '富蕴县', '4', '0', '0', '0', ',3268,2873,2894,2897,');
INSERT INTO `cmf_regions` VALUES ('2898', '2894', '福海县', '4', '0', '0', '0', ',3268,2873,2894,2898,');
INSERT INTO `cmf_regions` VALUES ('2899', '2894', '哈巴河县', '4', '0', '0', '0', ',3268,2873,2894,2899,');
INSERT INTO `cmf_regions` VALUES ('2900', '2894', '青河县', '4', '0', '0', '0', ',3268,2873,2894,2900,');
INSERT INTO `cmf_regions` VALUES ('2901', '2894', '吉木乃县', '4', '0', '0', '0', ',3268,2873,2894,2901,');
INSERT INTO `cmf_regions` VALUES ('2902', '2873', '巴音郭楞蒙古自治州', '3', '0', '0', '0', ',3268,2873,2902,');
INSERT INTO `cmf_regions` VALUES ('2903', '2902', '库尔勒市', '4', '0', '0', '0', ',3268,2873,2902,2903,');
INSERT INTO `cmf_regions` VALUES ('2904', '2902', '轮台县', '4', '0', '0', '0', ',3268,2873,2902,2904,');
INSERT INTO `cmf_regions` VALUES ('2905', '2902', '尉犁县', '4', '0', '0', '0', ',3268,2873,2902,2905,');
INSERT INTO `cmf_regions` VALUES ('2906', '2902', '若羌县', '4', '0', '0', '0', ',3268,2873,2902,2906,');
INSERT INTO `cmf_regions` VALUES ('2907', '2902', '且末县', '4', '0', '0', '0', ',3268,2873,2902,2907,');
INSERT INTO `cmf_regions` VALUES ('2908', '2902', '焉耆回族自治县', '4', '0', '0', '0', ',3268,2873,2902,2908,');
INSERT INTO `cmf_regions` VALUES ('2909', '2902', '和静县', '4', '0', '0', '0', ',3268,2873,2902,2909,');
INSERT INTO `cmf_regions` VALUES ('2910', '2902', '和硕县', '4', '0', '0', '0', ',3268,2873,2902,2910,');
INSERT INTO `cmf_regions` VALUES ('2911', '2902', '博湖县', '4', '0', '0', '0', ',3268,2873,2902,2911,');
INSERT INTO `cmf_regions` VALUES ('2912', '2873', '博尔塔拉蒙古自治州', '3', '0', '0', '0', ',3268,2873,2912,');
INSERT INTO `cmf_regions` VALUES ('2913', '2912', '博乐市', '4', '0', '0', '0', ',3268,2873,2912,2913,');
INSERT INTO `cmf_regions` VALUES ('2914', '2912', '精河县', '4', '0', '0', '0', ',3268,2873,2912,2914,');
INSERT INTO `cmf_regions` VALUES ('2915', '2912', '温泉县', '4', '0', '0', '0', ',3268,2873,2912,2915,');
INSERT INTO `cmf_regions` VALUES ('2916', '2873', '昌吉回族自治州', '3', '0', '0', '0', ',3268,2873,2916,');
INSERT INTO `cmf_regions` VALUES ('2917', '2916', '昌吉市', '4', '0', '0', '0', ',3268,2873,2916,2917,');
INSERT INTO `cmf_regions` VALUES ('2918', '2916', '阜康市', '4', '0', '0', '0', ',3268,2873,2916,2918,');
INSERT INTO `cmf_regions` VALUES ('2919', '2916', '米泉市', '4', '0', '0', '0', ',3268,2873,2916,2919,');
INSERT INTO `cmf_regions` VALUES ('2920', '2916', '呼图壁县', '4', '0', '0', '0', ',3268,2873,2916,2920,');
INSERT INTO `cmf_regions` VALUES ('2921', '2916', '玛纳斯县', '4', '0', '0', '0', ',3268,2873,2916,2921,');
INSERT INTO `cmf_regions` VALUES ('2922', '2916', '奇台县', '4', '0', '0', '0', ',3268,2873,2916,2922,');
INSERT INTO `cmf_regions` VALUES ('2923', '2916', '吉木萨尔县', '4', '0', '0', '0', ',3268,2873,2916,2923,');
INSERT INTO `cmf_regions` VALUES ('2924', '2916', '木垒哈萨克自治县', '4', '0', '0', '0', ',3268,2873,2916,2924,');
INSERT INTO `cmf_regions` VALUES ('2925', '2873', '哈密地区', '3', '0', '0', '0', ',3268,2873,2925,');
INSERT INTO `cmf_regions` VALUES ('2926', '2925', '哈密市', '4', '0', '0', '0', ',3268,2873,2925,2926,');
INSERT INTO `cmf_regions` VALUES ('2927', '2925', '巴里坤哈萨克自治县', '4', '0', '0', '0', ',3268,2873,2925,2927,');
INSERT INTO `cmf_regions` VALUES ('2928', '2925', '伊吾县', '4', '0', '0', '0', ',3268,2873,2925,2928,');
INSERT INTO `cmf_regions` VALUES ('2929', '2873', '和田地区', '3', '0', '0', '0', ',3268,2873,2929,');
INSERT INTO `cmf_regions` VALUES ('2930', '2929', '和田市', '4', '0', '0', '0', ',3268,2873,2929,2930,');
INSERT INTO `cmf_regions` VALUES ('2931', '2929', '和田县', '4', '0', '0', '0', ',3268,2873,2929,2931,');
INSERT INTO `cmf_regions` VALUES ('2932', '2929', '墨玉县', '4', '0', '0', '0', ',3268,2873,2929,2932,');
INSERT INTO `cmf_regions` VALUES ('2933', '2929', '皮山县', '4', '0', '0', '0', ',3268,2873,2929,2933,');
INSERT INTO `cmf_regions` VALUES ('2934', '2929', '洛浦县', '4', '0', '0', '0', ',3268,2873,2929,2934,');
INSERT INTO `cmf_regions` VALUES ('2935', '2929', '策勒县', '4', '0', '0', '0', ',3268,2873,2929,2935,');
INSERT INTO `cmf_regions` VALUES ('2936', '2929', '于田县', '4', '0', '0', '0', ',3268,2873,2929,2936,');
INSERT INTO `cmf_regions` VALUES ('2937', '2929', '民丰县', '4', '0', '0', '0', ',3268,2873,2929,2937,');
INSERT INTO `cmf_regions` VALUES ('2938', '2873', '喀什地区', '3', '0', '0', '0', ',3268,2873,2938,');
INSERT INTO `cmf_regions` VALUES ('2939', '2938', '喀什市', '4', '0', '0', '0', ',3268,2873,2938,2939,');
INSERT INTO `cmf_regions` VALUES ('2940', '2938', '疏附县', '4', '0', '0', '0', ',3268,2873,2938,2940,');
INSERT INTO `cmf_regions` VALUES ('2941', '2938', '疏勒县', '4', '0', '0', '0', ',3268,2873,2938,2941,');
INSERT INTO `cmf_regions` VALUES ('2942', '2938', '英吉沙县', '4', '0', '0', '0', ',3268,2873,2938,2942,');
INSERT INTO `cmf_regions` VALUES ('2943', '2938', '泽普县', '4', '0', '0', '0', ',3268,2873,2938,2943,');
INSERT INTO `cmf_regions` VALUES ('2944', '2938', '莎车县', '4', '0', '0', '0', ',3268,2873,2938,2944,');
INSERT INTO `cmf_regions` VALUES ('2945', '2938', '叶城县', '4', '0', '0', '0', ',3268,2873,2938,2945,');
INSERT INTO `cmf_regions` VALUES ('2946', '2938', '麦盖提县', '4', '0', '0', '0', ',3268,2873,2938,2946,');
INSERT INTO `cmf_regions` VALUES ('2947', '2938', '岳普湖县', '4', '0', '0', '0', ',3268,2873,2938,2947,');
INSERT INTO `cmf_regions` VALUES ('2948', '2938', '伽师县', '4', '0', '0', '0', ',3268,2873,2938,2948,');
INSERT INTO `cmf_regions` VALUES ('2949', '2938', '巴楚县', '4', '0', '0', '0', ',3268,2873,2938,2949,');
INSERT INTO `cmf_regions` VALUES ('2950', '2938', '塔什库尔干塔吉克自治县', '4', '0', '0', '0', ',3268,2873,2938,2950,');
INSERT INTO `cmf_regions` VALUES ('2951', '2873', '克拉玛依市', '3', '0', '0', '0', ',3268,2873,2951,');
INSERT INTO `cmf_regions` VALUES ('2952', '2951', '独山子区', '4', '0', '0', '0', ',3268,2873,2951,2952,');
INSERT INTO `cmf_regions` VALUES ('2953', '2951', '克拉玛依区', '4', '0', '0', '0', ',3268,2873,2951,2953,');
INSERT INTO `cmf_regions` VALUES ('2954', '2951', '白碱滩区', '4', '0', '0', '0', ',3268,2873,2951,2954,');
INSERT INTO `cmf_regions` VALUES ('2955', '2951', '乌尔禾区', '4', '0', '0', '0', ',3268,2873,2951,2955,');
INSERT INTO `cmf_regions` VALUES ('2956', '2873', '克孜勒苏柯尔克孜自治州', '3', '0', '0', '0', ',3268,2873,2956,');
INSERT INTO `cmf_regions` VALUES ('2957', '2956', '阿图什市', '4', '0', '0', '0', ',3268,2873,2956,2957,');
INSERT INTO `cmf_regions` VALUES ('2958', '2956', '阿克陶县', '4', '0', '0', '0', ',3268,2873,2956,2958,');
INSERT INTO `cmf_regions` VALUES ('2959', '2956', '阿合奇县', '4', '0', '0', '0', ',3268,2873,2956,2959,');
INSERT INTO `cmf_regions` VALUES ('2960', '2956', '乌恰县', '4', '0', '0', '0', ',3268,2873,2956,2960,');
INSERT INTO `cmf_regions` VALUES ('2961', '2873', '石河子市', '3', '0', '0', '0', ',3268,2873,2961,');
INSERT INTO `cmf_regions` VALUES ('2962', '2873', '塔城地区', '3', '0', '0', '0', ',3268,2873,2962,');
INSERT INTO `cmf_regions` VALUES ('2963', '2962', '塔城市', '4', '0', '0', '0', ',3268,2873,2962,2963,');
INSERT INTO `cmf_regions` VALUES ('2964', '2962', '乌苏市', '4', '0', '0', '0', ',3268,2873,2962,2964,');
INSERT INTO `cmf_regions` VALUES ('2965', '2962', '额敏县', '4', '0', '0', '0', ',3268,2873,2962,2965,');
INSERT INTO `cmf_regions` VALUES ('2966', '2962', '沙湾县', '4', '0', '0', '0', ',3268,2873,2962,2966,');
INSERT INTO `cmf_regions` VALUES ('2967', '2962', '托里县', '4', '0', '0', '0', ',3268,2873,2962,2967,');
INSERT INTO `cmf_regions` VALUES ('2968', '2962', '裕民县', '4', '0', '0', '0', ',3268,2873,2962,2968,');
INSERT INTO `cmf_regions` VALUES ('2969', '2962', '和布克赛尔蒙古自治县', '4', '0', '0', '0', ',3268,2873,2962,2969,');
INSERT INTO `cmf_regions` VALUES ('2970', '2873', '图木舒克市', '3', '0', '0', '0', ',3268,2873,2970,');
INSERT INTO `cmf_regions` VALUES ('2971', '2873', '吐鲁番地区', '3', '0', '0', '0', ',3268,2873,2971,');
INSERT INTO `cmf_regions` VALUES ('2972', '2971', '吐鲁番市', '4', '0', '0', '0', ',3268,2873,2971,2972,');
INSERT INTO `cmf_regions` VALUES ('2973', '2971', '鄯善县', '4', '0', '0', '0', ',3268,2873,2971,2973,');
INSERT INTO `cmf_regions` VALUES ('2974', '2971', '托克逊县', '4', '0', '0', '0', ',3268,2873,2971,2974,');
INSERT INTO `cmf_regions` VALUES ('2975', '2873', '五家渠市', '3', '0', '0', '0', ',3268,2873,2975,');
INSERT INTO `cmf_regions` VALUES ('2976', '2873', '伊犁哈萨克自治州', '3', '0', '0', '0', ',3268,2873,2976,');
INSERT INTO `cmf_regions` VALUES ('2977', '2976', '伊宁市', '4', '0', '0', '0', ',3268,2873,2976,2977,');
INSERT INTO `cmf_regions` VALUES ('2978', '2976', '奎屯市', '4', '0', '0', '0', ',3268,2873,2976,2978,');
INSERT INTO `cmf_regions` VALUES ('2979', '2976', '伊宁县', '4', '0', '0', '0', ',3268,2873,2976,2979,');
INSERT INTO `cmf_regions` VALUES ('2980', '2976', '察布查尔锡伯自治县', '4', '0', '0', '0', ',3268,2873,2976,2980,');
INSERT INTO `cmf_regions` VALUES ('2981', '2976', '霍城县', '4', '0', '0', '0', ',3268,2873,2976,2981,');
INSERT INTO `cmf_regions` VALUES ('2982', '2976', '巩留县', '4', '0', '0', '0', ',3268,2873,2976,2982,');
INSERT INTO `cmf_regions` VALUES ('2983', '2976', '新源县', '4', '0', '0', '0', ',3268,2873,2976,2983,');
INSERT INTO `cmf_regions` VALUES ('2984', '2976', '昭苏县', '4', '0', '0', '0', ',3268,2873,2976,2984,');
INSERT INTO `cmf_regions` VALUES ('2985', '2976', '特克斯县', '4', '0', '0', '0', ',3268,2873,2976,2985,');
INSERT INTO `cmf_regions` VALUES ('2986', '2976', '尼勒克县', '4', '0', '0', '0', ',3268,2873,2976,2986,');
INSERT INTO `cmf_regions` VALUES ('2987', '3268', '云南', '2', '0', '0', '0', ',3268,2987,');
INSERT INTO `cmf_regions` VALUES ('2988', '2987', '昆明市', '3', '0', '0', '0', ',3268,2987,2988,');
INSERT INTO `cmf_regions` VALUES ('2989', '2988', '五华区', '4', '0', '0', '0', ',3268,2987,2988,2989,');
INSERT INTO `cmf_regions` VALUES ('2990', '2988', '盘龙区', '4', '0', '0', '0', ',3268,2987,2988,2990,');
INSERT INTO `cmf_regions` VALUES ('2991', '2988', '官渡区', '4', '0', '0', '0', ',3268,2987,2988,2991,');
INSERT INTO `cmf_regions` VALUES ('2992', '2988', '西山区', '4', '0', '0', '0', ',3268,2987,2988,2992,');
INSERT INTO `cmf_regions` VALUES ('2993', '2988', '东川区', '4', '0', '0', '0', ',3268,2987,2988,2993,');
INSERT INTO `cmf_regions` VALUES ('2994', '2988', '呈贡县', '4', '0', '0', '0', ',3268,2987,2988,2994,');
INSERT INTO `cmf_regions` VALUES ('2995', '2988', '晋宁县', '4', '0', '0', '0', ',3268,2987,2988,2995,');
INSERT INTO `cmf_regions` VALUES ('2996', '2988', '富民县', '4', '0', '0', '0', ',3268,2987,2988,2996,');
INSERT INTO `cmf_regions` VALUES ('2997', '2988', '宜良县', '4', '0', '0', '0', ',3268,2987,2988,2997,');
INSERT INTO `cmf_regions` VALUES ('2998', '2988', '石林彝族自治县', '4', '0', '0', '0', ',3268,2987,2988,2998,');
INSERT INTO `cmf_regions` VALUES ('2999', '2988', '嵩明县', '4', '0', '0', '0', ',3268,2987,2988,2999,');
INSERT INTO `cmf_regions` VALUES ('3000', '2988', '禄劝彝族苗族自治县', '4', '0', '0', '0', ',3268,2987,2988,3000,');
INSERT INTO `cmf_regions` VALUES ('3001', '2988', '寻甸回族彝族自治县', '4', '0', '0', '0', ',3268,2987,2988,3001,');
INSERT INTO `cmf_regions` VALUES ('3002', '2988', '安宁市', '4', '0', '0', '0', ',3268,2987,2988,3002,');
INSERT INTO `cmf_regions` VALUES ('3003', '2987', '保山市', '3', '0', '0', '0', ',3268,2987,3003,');
INSERT INTO `cmf_regions` VALUES ('3004', '3003', '隆阳区', '4', '0', '0', '0', ',3268,2987,3003,3004,');
INSERT INTO `cmf_regions` VALUES ('3005', '3003', '施甸县', '4', '0', '0', '0', ',3268,2987,3003,3005,');
INSERT INTO `cmf_regions` VALUES ('3006', '3003', '腾冲县', '4', '0', '0', '0', ',3268,2987,3003,3006,');
INSERT INTO `cmf_regions` VALUES ('3007', '3003', '龙陵县', '4', '0', '0', '0', ',3268,2987,3003,3007,');
INSERT INTO `cmf_regions` VALUES ('3008', '3003', '昌宁县', '4', '0', '0', '0', ',3268,2987,3003,3008,');
INSERT INTO `cmf_regions` VALUES ('3009', '2987', '楚雄彝族自治州', '3', '0', '0', '0', ',3268,2987,3009,');
INSERT INTO `cmf_regions` VALUES ('3010', '3009', '楚雄市', '4', '0', '0', '0', ',3268,2987,3009,3010,');
INSERT INTO `cmf_regions` VALUES ('3011', '3009', '双柏县', '4', '0', '0', '0', ',3268,2987,3009,3011,');
INSERT INTO `cmf_regions` VALUES ('3012', '3009', '牟定县', '4', '0', '0', '0', ',3268,2987,3009,3012,');
INSERT INTO `cmf_regions` VALUES ('3013', '3009', '南华县', '4', '0', '0', '0', ',3268,2987,3009,3013,');
INSERT INTO `cmf_regions` VALUES ('3014', '3009', '姚安县', '4', '0', '0', '0', ',3268,2987,3009,3014,');
INSERT INTO `cmf_regions` VALUES ('3015', '3009', '大姚县', '4', '0', '0', '0', ',3268,2987,3009,3015,');
INSERT INTO `cmf_regions` VALUES ('3016', '3009', '永仁县', '4', '0', '0', '0', ',3268,2987,3009,3016,');
INSERT INTO `cmf_regions` VALUES ('3017', '3009', '元谋县', '4', '0', '0', '0', ',3268,2987,3009,3017,');
INSERT INTO `cmf_regions` VALUES ('3018', '3009', '武定县', '4', '0', '0', '0', ',3268,2987,3009,3018,');
INSERT INTO `cmf_regions` VALUES ('3019', '3009', '禄丰县', '4', '0', '0', '0', ',3268,2987,3009,3019,');
INSERT INTO `cmf_regions` VALUES ('3020', '2987', '大理白族自治州', '3', '0', '0', '0', ',3268,2987,3020,');
INSERT INTO `cmf_regions` VALUES ('3021', '3020', '大理市', '4', '0', '0', '0', ',3268,2987,3020,3021,');
INSERT INTO `cmf_regions` VALUES ('3022', '3020', '漾濞彝族自治县', '4', '0', '0', '0', ',3268,2987,3020,3022,');
INSERT INTO `cmf_regions` VALUES ('3023', '3020', '祥云县', '4', '0', '0', '0', ',3268,2987,3020,3023,');
INSERT INTO `cmf_regions` VALUES ('3024', '3020', '宾川县', '4', '0', '0', '0', ',3268,2987,3020,3024,');
INSERT INTO `cmf_regions` VALUES ('3025', '3020', '弥渡县', '4', '0', '0', '0', ',3268,2987,3020,3025,');
INSERT INTO `cmf_regions` VALUES ('3026', '3020', '南涧彝族自治县', '4', '0', '0', '0', ',3268,2987,3020,3026,');
INSERT INTO `cmf_regions` VALUES ('3027', '3020', '巍山彝族回族自治县', '4', '0', '0', '0', ',3268,2987,3020,3027,');
INSERT INTO `cmf_regions` VALUES ('3028', '3020', '永平县', '4', '0', '0', '0', ',3268,2987,3020,3028,');
INSERT INTO `cmf_regions` VALUES ('3029', '3020', '云龙县', '4', '0', '0', '0', ',3268,2987,3020,3029,');
INSERT INTO `cmf_regions` VALUES ('3030', '3020', '洱源县', '4', '0', '0', '0', ',3268,2987,3020,3030,');
INSERT INTO `cmf_regions` VALUES ('3031', '3020', '剑川县', '4', '0', '0', '0', ',3268,2987,3020,3031,');
INSERT INTO `cmf_regions` VALUES ('3032', '3020', '鹤庆县', '4', '0', '0', '0', ',3268,2987,3020,3032,');
INSERT INTO `cmf_regions` VALUES ('3033', '2987', '德宏傣族景颇族自治州', '3', '0', '0', '0', ',3268,2987,3033,');
INSERT INTO `cmf_regions` VALUES ('3034', '3033', '瑞丽市', '4', '0', '0', '0', ',3268,2987,3033,3034,');
INSERT INTO `cmf_regions` VALUES ('3035', '3033', '潞西市', '4', '0', '0', '0', ',3268,2987,3033,3035,');
INSERT INTO `cmf_regions` VALUES ('3036', '3033', '梁河县', '4', '0', '0', '0', ',3268,2987,3033,3036,');
INSERT INTO `cmf_regions` VALUES ('3037', '3033', '盈江县', '4', '0', '0', '0', ',3268,2987,3033,3037,');
INSERT INTO `cmf_regions` VALUES ('3038', '3033', '陇川县', '4', '0', '0', '0', ',3268,2987,3033,3038,');
INSERT INTO `cmf_regions` VALUES ('3039', '2987', '迪庆藏族自治州', '3', '0', '0', '0', ',3268,2987,3039,');
INSERT INTO `cmf_regions` VALUES ('3040', '3039', '香格里拉县', '4', '0', '0', '0', ',3268,2987,3039,3040,');
INSERT INTO `cmf_regions` VALUES ('3041', '3039', '德钦县', '4', '0', '0', '0', ',3268,2987,3039,3041,');
INSERT INTO `cmf_regions` VALUES ('3042', '3039', '维西傈僳族自治县', '4', '0', '0', '0', ',3268,2987,3039,3042,');
INSERT INTO `cmf_regions` VALUES ('3043', '2987', '红河哈尼族彝族自治州', '3', '0', '0', '0', ',3268,2987,3043,');
INSERT INTO `cmf_regions` VALUES ('3044', '3043', '个旧市', '4', '0', '0', '0', ',3268,2987,3043,3044,');
INSERT INTO `cmf_regions` VALUES ('3045', '3043', '开远市', '4', '0', '0', '0', ',3268,2987,3043,3045,');
INSERT INTO `cmf_regions` VALUES ('3046', '3043', '蒙自县', '4', '0', '0', '0', ',3268,2987,3043,3046,');
INSERT INTO `cmf_regions` VALUES ('3047', '3043', '屏边苗族自治县', '4', '0', '0', '0', ',3268,2987,3043,3047,');
INSERT INTO `cmf_regions` VALUES ('3048', '3043', '建水县', '4', '0', '0', '0', ',3268,2987,3043,3048,');
INSERT INTO `cmf_regions` VALUES ('3049', '3043', '石屏县', '4', '0', '0', '0', ',3268,2987,3043,3049,');
INSERT INTO `cmf_regions` VALUES ('3050', '3043', '弥勒县', '4', '0', '0', '0', ',3268,2987,3043,3050,');
INSERT INTO `cmf_regions` VALUES ('3051', '3043', '泸西县', '4', '0', '0', '0', ',3268,2987,3043,3051,');
INSERT INTO `cmf_regions` VALUES ('3052', '3043', '元阳县', '4', '0', '0', '0', ',3268,2987,3043,3052,');
INSERT INTO `cmf_regions` VALUES ('3053', '3043', '红河县', '4', '0', '0', '0', ',3268,2987,3043,3053,');
INSERT INTO `cmf_regions` VALUES ('3054', '3043', '金平苗族瑶族傣族自治县', '4', '0', '0', '0', ',3268,2987,3043,3054,');
INSERT INTO `cmf_regions` VALUES ('3055', '3043', '绿春县', '4', '0', '0', '0', ',3268,2987,3043,3055,');
INSERT INTO `cmf_regions` VALUES ('3056', '3043', '河口瑶族自治县', '4', '0', '0', '0', ',3268,2987,3043,3056,');
INSERT INTO `cmf_regions` VALUES ('3057', '2987', '丽江市', '3', '0', '0', '0', ',3268,2987,3057,');
INSERT INTO `cmf_regions` VALUES ('3058', '3057', '古城区', '4', '0', '0', '0', ',3268,2987,3057,3058,');
INSERT INTO `cmf_regions` VALUES ('3059', '3057', '玉龙纳西族自治县', '4', '0', '0', '0', ',3268,2987,3057,3059,');
INSERT INTO `cmf_regions` VALUES ('3060', '3057', '永胜县', '4', '0', '0', '0', ',3268,2987,3057,3060,');
INSERT INTO `cmf_regions` VALUES ('3061', '3057', '华坪县', '4', '0', '0', '0', ',3268,2987,3057,3061,');
INSERT INTO `cmf_regions` VALUES ('3062', '3057', '宁蒗彝族自治县', '4', '0', '0', '0', ',3268,2987,3057,3062,');
INSERT INTO `cmf_regions` VALUES ('3063', '2987', '临沧市', '3', '0', '0', '0', ',3268,2987,3063,');
INSERT INTO `cmf_regions` VALUES ('3064', '3063', '临翔区', '4', '0', '0', '0', ',3268,2987,3063,3064,');
INSERT INTO `cmf_regions` VALUES ('3065', '3063', '凤庆县', '4', '0', '0', '0', ',3268,2987,3063,3065,');
INSERT INTO `cmf_regions` VALUES ('3066', '3063', '云县', '4', '0', '0', '0', ',3268,2987,3063,3066,');
INSERT INTO `cmf_regions` VALUES ('3067', '3063', '永德县', '4', '0', '0', '0', ',3268,2987,3063,3067,');
INSERT INTO `cmf_regions` VALUES ('3068', '3063', '镇康县', '4', '0', '0', '0', ',3268,2987,3063,3068,');
INSERT INTO `cmf_regions` VALUES ('3069', '3063', '双江拉祜族佤族布朗族傣族自治县', '4', '0', '0', '0', ',3268,2987,3063,3069,');
INSERT INTO `cmf_regions` VALUES ('3070', '3063', '耿马傣族佤族自治县', '4', '0', '0', '0', ',3268,2987,3063,3070,');
INSERT INTO `cmf_regions` VALUES ('3071', '3063', '沧源佤族自治县', '4', '0', '0', '0', ',3268,2987,3063,3071,');
INSERT INTO `cmf_regions` VALUES ('3072', '2987', '怒江傈僳族自治州', '3', '0', '0', '0', ',3268,2987,3072,');
INSERT INTO `cmf_regions` VALUES ('3073', '3072', '泸水县', '4', '0', '0', '0', ',3268,2987,3072,3073,');
INSERT INTO `cmf_regions` VALUES ('3074', '3072', '福贡县', '4', '0', '0', '0', ',3268,2987,3072,3074,');
INSERT INTO `cmf_regions` VALUES ('3075', '3072', '贡山独龙族怒族自治县', '4', '0', '0', '0', ',3268,2987,3072,3075,');
INSERT INTO `cmf_regions` VALUES ('3076', '3072', '兰坪白族普米族自治县', '4', '0', '0', '0', ',3268,2987,3072,3076,');
INSERT INTO `cmf_regions` VALUES ('3077', '2987', '曲靖市', '3', '0', '0', '0', ',3268,2987,3077,');
INSERT INTO `cmf_regions` VALUES ('3078', '3077', '麒麟区', '4', '0', '0', '0', ',3268,2987,3077,3078,');
INSERT INTO `cmf_regions` VALUES ('3079', '3077', '马龙县', '4', '0', '0', '0', ',3268,2987,3077,3079,');
INSERT INTO `cmf_regions` VALUES ('3080', '3077', '陆良县', '4', '0', '0', '0', ',3268,2987,3077,3080,');
INSERT INTO `cmf_regions` VALUES ('3081', '3077', '师宗县', '4', '0', '0', '0', ',3268,2987,3077,3081,');
INSERT INTO `cmf_regions` VALUES ('3082', '3077', '罗平县', '4', '0', '0', '0', ',3268,2987,3077,3082,');
INSERT INTO `cmf_regions` VALUES ('3083', '3077', '富源县', '4', '0', '0', '0', ',3268,2987,3077,3083,');
INSERT INTO `cmf_regions` VALUES ('3084', '3077', '会泽县', '4', '0', '0', '0', ',3268,2987,3077,3084,');
INSERT INTO `cmf_regions` VALUES ('3085', '3077', '沾益县', '4', '0', '0', '0', ',3268,2987,3077,3085,');
INSERT INTO `cmf_regions` VALUES ('3086', '3077', '宣威市', '4', '0', '0', '0', ',3268,2987,3077,3086,');
INSERT INTO `cmf_regions` VALUES ('3087', '2987', '思茅市', '3', '0', '0', '0', ',3268,2987,3087,');
INSERT INTO `cmf_regions` VALUES ('3088', '3087', '翠云区', '4', '0', '0', '0', ',3268,2987,3087,3088,');
INSERT INTO `cmf_regions` VALUES ('3089', '3087', '普洱哈尼族彝族自治县', '4', '0', '0', '0', ',3268,2987,3087,3089,');
INSERT INTO `cmf_regions` VALUES ('3090', '3087', '墨江哈尼族自治县', '4', '0', '0', '0', ',3268,2987,3087,3090,');
INSERT INTO `cmf_regions` VALUES ('3091', '3087', '景东彝族自治县', '4', '0', '0', '0', ',3268,2987,3087,3091,');
INSERT INTO `cmf_regions` VALUES ('3092', '3087', '景谷傣族彝族自治县', '4', '0', '0', '0', ',3268,2987,3087,3092,');
INSERT INTO `cmf_regions` VALUES ('3093', '3087', '镇沅彝族哈尼族拉祜族自治县', '4', '0', '0', '0', ',3268,2987,3087,3093,');
INSERT INTO `cmf_regions` VALUES ('3094', '3087', '江城哈尼族彝族自治县', '4', '0', '0', '0', ',3268,2987,3087,3094,');
INSERT INTO `cmf_regions` VALUES ('3095', '3087', '孟连傣族拉祜族佤族自治县', '4', '0', '0', '0', ',3268,2987,3087,3095,');
INSERT INTO `cmf_regions` VALUES ('3096', '3087', '澜沧拉祜族自治县', '4', '0', '0', '0', ',3268,2987,3087,3096,');
INSERT INTO `cmf_regions` VALUES ('3097', '3087', '西盟佤族自治县', '4', '0', '0', '0', ',3268,2987,3087,3097,');
INSERT INTO `cmf_regions` VALUES ('3098', '2987', '文山壮族苗族自治州', '3', '0', '0', '0', ',3268,2987,3098,');
INSERT INTO `cmf_regions` VALUES ('3099', '3098', '文山县', '4', '0', '0', '0', ',3268,2987,3098,3099,');
INSERT INTO `cmf_regions` VALUES ('3100', '3098', '砚山县', '4', '0', '0', '0', ',3268,2987,3098,3100,');
INSERT INTO `cmf_regions` VALUES ('3101', '3098', '西畴县', '4', '0', '0', '0', ',3268,2987,3098,3101,');
INSERT INTO `cmf_regions` VALUES ('3102', '3098', '麻栗坡县', '4', '0', '0', '0', ',3268,2987,3098,3102,');
INSERT INTO `cmf_regions` VALUES ('3103', '3098', '马关县', '4', '0', '0', '0', ',3268,2987,3098,3103,');
INSERT INTO `cmf_regions` VALUES ('3104', '3098', '丘北县', '4', '0', '0', '0', ',3268,2987,3098,3104,');
INSERT INTO `cmf_regions` VALUES ('3105', '3098', '广南县', '4', '0', '0', '0', ',3268,2987,3098,3105,');
INSERT INTO `cmf_regions` VALUES ('3106', '3098', '富宁县', '4', '0', '0', '0', ',3268,2987,3098,3106,');
INSERT INTO `cmf_regions` VALUES ('3107', '2987', '西双版纳傣族自治州', '3', '0', '0', '0', ',3268,2987,3107,');
INSERT INTO `cmf_regions` VALUES ('3108', '3107', '景洪市', '4', '0', '0', '0', ',3268,2987,3107,3108,');
INSERT INTO `cmf_regions` VALUES ('3109', '3107', '勐海县', '4', '0', '0', '0', ',3268,2987,3107,3109,');
INSERT INTO `cmf_regions` VALUES ('3110', '3107', '勐腊县', '4', '0', '0', '0', ',3268,2987,3107,3110,');
INSERT INTO `cmf_regions` VALUES ('3111', '2987', '玉溪市', '3', '0', '0', '0', ',3268,2987,3111,');
INSERT INTO `cmf_regions` VALUES ('3112', '3111', '红塔区', '4', '0', '0', '0', ',3268,2987,3111,3112,');
INSERT INTO `cmf_regions` VALUES ('3113', '3111', '江川县', '4', '0', '0', '0', ',3268,2987,3111,3113,');
INSERT INTO `cmf_regions` VALUES ('3114', '3111', '澄江县', '4', '0', '0', '0', ',3268,2987,3111,3114,');
INSERT INTO `cmf_regions` VALUES ('3115', '3111', '通海县', '4', '0', '0', '0', ',3268,2987,3111,3115,');
INSERT INTO `cmf_regions` VALUES ('3116', '3111', '华宁县', '4', '0', '0', '0', ',3268,2987,3111,3116,');
INSERT INTO `cmf_regions` VALUES ('3117', '3111', '易门县', '4', '0', '0', '0', ',3268,2987,3111,3117,');
INSERT INTO `cmf_regions` VALUES ('3118', '3111', '峨山彝族自治县', '4', '0', '0', '0', ',3268,2987,3111,3118,');
INSERT INTO `cmf_regions` VALUES ('3119', '3111', '新平彝族傣族自治县', '4', '0', '0', '0', ',3268,2987,3111,3119,');
INSERT INTO `cmf_regions` VALUES ('3120', '3111', '元江哈尼族彝族傣族自治县', '4', '0', '0', '0', ',3268,2987,3111,3120,');
INSERT INTO `cmf_regions` VALUES ('3121', '2987', '昭通市', '3', '0', '0', '0', ',3268,2987,3121,');
INSERT INTO `cmf_regions` VALUES ('3122', '3121', '昭阳区', '4', '0', '0', '0', ',3268,2987,3121,3122,');
INSERT INTO `cmf_regions` VALUES ('3123', '3121', '鲁甸县', '4', '0', '0', '0', ',3268,2987,3121,3123,');
INSERT INTO `cmf_regions` VALUES ('3124', '3121', '巧家县', '4', '0', '0', '0', ',3268,2987,3121,3124,');
INSERT INTO `cmf_regions` VALUES ('3125', '3121', '盐津县', '4', '0', '0', '0', ',3268,2987,3121,3125,');
INSERT INTO `cmf_regions` VALUES ('3126', '3121', '大关县', '4', '0', '0', '0', ',3268,2987,3121,3126,');
INSERT INTO `cmf_regions` VALUES ('3127', '3121', '永善县', '4', '0', '0', '0', ',3268,2987,3121,3127,');
INSERT INTO `cmf_regions` VALUES ('3128', '3121', '绥江县', '4', '0', '0', '0', ',3268,2987,3121,3128,');
INSERT INTO `cmf_regions` VALUES ('3129', '3121', '镇雄县', '4', '0', '0', '0', ',3268,2987,3121,3129,');
INSERT INTO `cmf_regions` VALUES ('3130', '3121', '彝良县', '4', '0', '0', '0', ',3268,2987,3121,3130,');
INSERT INTO `cmf_regions` VALUES ('3131', '3121', '威信县', '4', '0', '0', '0', ',3268,2987,3121,3131,');
INSERT INTO `cmf_regions` VALUES ('3132', '3121', '水富县', '4', '0', '0', '0', ',3268,2987,3121,3132,');
INSERT INTO `cmf_regions` VALUES ('3133', '3268', '浙江', '2', '0', '0', '0', ',3268,3133,');
INSERT INTO `cmf_regions` VALUES ('3134', '3133', '杭州市', '3', '0', '0', '0', ',3268,3133,3134,');
INSERT INTO `cmf_regions` VALUES ('3135', '3134', '上城区', '4', '0', '0', '0', ',3268,3133,3134,3135,');
INSERT INTO `cmf_regions` VALUES ('3136', '3134', '下城区', '4', '0', '0', '0', ',3268,3133,3134,3136,');
INSERT INTO `cmf_regions` VALUES ('3137', '3134', '江干区', '4', '0', '0', '0', ',3268,3133,3134,3137,');
INSERT INTO `cmf_regions` VALUES ('3138', '3134', '拱墅区', '4', '0', '0', '0', ',3268,3133,3134,3138,');
INSERT INTO `cmf_regions` VALUES ('3139', '3134', '西湖区', '4', '0', '0', '0', ',3268,3133,3134,3139,');
INSERT INTO `cmf_regions` VALUES ('3140', '3134', '滨江区', '4', '0', '0', '0', ',3268,3133,3134,3140,');
INSERT INTO `cmf_regions` VALUES ('3141', '3134', '萧山区', '4', '0', '0', '0', ',3268,3133,3134,3141,');
INSERT INTO `cmf_regions` VALUES ('3142', '3134', '余杭区', '4', '0', '0', '0', ',3268,3133,3134,3142,');
INSERT INTO `cmf_regions` VALUES ('3143', '3134', '桐庐县', '4', '0', '0', '0', ',3268,3133,3134,3143,');
INSERT INTO `cmf_regions` VALUES ('3144', '3134', '淳安县', '4', '0', '0', '0', ',3268,3133,3134,3144,');
INSERT INTO `cmf_regions` VALUES ('3145', '3134', '建德市', '4', '0', '0', '0', ',3268,3133,3134,3145,');
INSERT INTO `cmf_regions` VALUES ('3146', '3134', '富阳市', '4', '0', '0', '0', ',3268,3133,3134,3146,');
INSERT INTO `cmf_regions` VALUES ('3147', '3134', '临安市', '4', '0', '0', '0', ',3268,3133,3134,3147,');
INSERT INTO `cmf_regions` VALUES ('3148', '3133', '湖州市', '3', '0', '0', '0', ',3268,3133,3148,');
INSERT INTO `cmf_regions` VALUES ('3149', '3148', '吴兴区', '4', '0', '0', '0', ',3268,3133,3148,3149,');
INSERT INTO `cmf_regions` VALUES ('3150', '3148', '南浔区', '4', '0', '0', '0', ',3268,3133,3148,3150,');
INSERT INTO `cmf_regions` VALUES ('3151', '3148', '德清县', '4', '0', '0', '0', ',3268,3133,3148,3151,');
INSERT INTO `cmf_regions` VALUES ('3152', '3148', '长兴县', '4', '0', '0', '0', ',3268,3133,3148,3152,');
INSERT INTO `cmf_regions` VALUES ('3153', '3148', '安吉县', '4', '0', '0', '0', ',3268,3133,3148,3153,');
INSERT INTO `cmf_regions` VALUES ('3154', '3133', '嘉兴市', '3', '0', '0', '0', ',3268,3133,3154,');
INSERT INTO `cmf_regions` VALUES ('3155', '3154', '秀城区', '4', '0', '0', '0', ',3268,3133,3154,3155,');
INSERT INTO `cmf_regions` VALUES ('3156', '3154', '秀洲区', '4', '0', '0', '0', ',3268,3133,3154,3156,');
INSERT INTO `cmf_regions` VALUES ('3157', '3154', '嘉善县', '4', '0', '0', '0', ',3268,3133,3154,3157,');
INSERT INTO `cmf_regions` VALUES ('3158', '3154', '海盐县', '4', '0', '0', '0', ',3268,3133,3154,3158,');
INSERT INTO `cmf_regions` VALUES ('3159', '3154', '海宁市', '4', '0', '0', '0', ',3268,3133,3154,3159,');
INSERT INTO `cmf_regions` VALUES ('3160', '3154', '平湖市', '4', '0', '0', '0', ',3268,3133,3154,3160,');
INSERT INTO `cmf_regions` VALUES ('3161', '3154', '桐乡市', '4', '0', '0', '0', ',3268,3133,3154,3161,');
INSERT INTO `cmf_regions` VALUES ('3162', '3133', '金华市', '3', '0', '0', '0', ',3268,3133,3162,');
INSERT INTO `cmf_regions` VALUES ('3163', '3162', '婺城区', '4', '0', '0', '0', ',3268,3133,3162,3163,');
INSERT INTO `cmf_regions` VALUES ('3164', '3162', '金东区', '4', '0', '0', '0', ',3268,3133,3162,3164,');
INSERT INTO `cmf_regions` VALUES ('3165', '3162', '武义县', '4', '0', '0', '0', ',3268,3133,3162,3165,');
INSERT INTO `cmf_regions` VALUES ('3166', '3162', '浦江县', '4', '0', '0', '0', ',3268,3133,3162,3166,');
INSERT INTO `cmf_regions` VALUES ('3167', '3162', '磐安县', '4', '0', '0', '0', ',3268,3133,3162,3167,');
INSERT INTO `cmf_regions` VALUES ('3168', '3162', '兰溪市', '4', '0', '0', '0', ',3268,3133,3162,3168,');
INSERT INTO `cmf_regions` VALUES ('3169', '3162', '义乌市', '4', '0', '0', '0', ',3268,3133,3162,3169,');
INSERT INTO `cmf_regions` VALUES ('3170', '3162', '东阳市', '4', '0', '0', '0', ',3268,3133,3162,3170,');
INSERT INTO `cmf_regions` VALUES ('3171', '3162', '永康市', '4', '0', '0', '0', ',3268,3133,3162,3171,');
INSERT INTO `cmf_regions` VALUES ('3172', '3133', '丽水市', '3', '0', '0', '0', ',3268,3133,3172,');
INSERT INTO `cmf_regions` VALUES ('3173', '3172', '莲都区', '4', '0', '0', '0', ',3268,3133,3172,3173,');
INSERT INTO `cmf_regions` VALUES ('3174', '3172', '青田县', '4', '0', '0', '0', ',3268,3133,3172,3174,');
INSERT INTO `cmf_regions` VALUES ('3175', '3172', '缙云县', '4', '0', '0', '0', ',3268,3133,3172,3175,');
INSERT INTO `cmf_regions` VALUES ('3176', '3172', '遂昌县', '4', '0', '0', '0', ',3268,3133,3172,3176,');
INSERT INTO `cmf_regions` VALUES ('3177', '3172', '松阳县', '4', '0', '0', '0', ',3268,3133,3172,3177,');
INSERT INTO `cmf_regions` VALUES ('3178', '3172', '云和县', '4', '0', '0', '0', ',3268,3133,3172,3178,');
INSERT INTO `cmf_regions` VALUES ('3179', '3172', '庆元县', '4', '0', '0', '0', ',3268,3133,3172,3179,');
INSERT INTO `cmf_regions` VALUES ('3180', '3172', '景宁畲族自治县', '4', '0', '0', '0', ',3268,3133,3172,3180,');
INSERT INTO `cmf_regions` VALUES ('3181', '3172', '龙泉市', '4', '0', '0', '0', ',3268,3133,3172,3181,');
INSERT INTO `cmf_regions` VALUES ('3182', '3133', '宁波市', '3', '0', '0', '0', ',3268,3133,3182,');
INSERT INTO `cmf_regions` VALUES ('3183', '3182', '海曙区', '4', '0', '0', '0', ',3268,3133,3182,3183,');
INSERT INTO `cmf_regions` VALUES ('3184', '3182', '江东区', '4', '0', '0', '0', ',3268,3133,3182,3184,');
INSERT INTO `cmf_regions` VALUES ('3185', '3182', '江北区', '4', '0', '0', '0', ',3268,3133,3182,3185,');
INSERT INTO `cmf_regions` VALUES ('3186', '3182', '北仑区', '4', '0', '0', '0', ',3268,3133,3182,3186,');
INSERT INTO `cmf_regions` VALUES ('3187', '3182', '镇海区', '4', '0', '0', '0', ',3268,3133,3182,3187,');
INSERT INTO `cmf_regions` VALUES ('3188', '3182', '鄞州区', '4', '0', '0', '0', ',3268,3133,3182,3188,');
INSERT INTO `cmf_regions` VALUES ('3189', '3182', '象山县', '4', '0', '0', '0', ',3268,3133,3182,3189,');
INSERT INTO `cmf_regions` VALUES ('3190', '3182', '宁海县', '4', '0', '0', '0', ',3268,3133,3182,3190,');
INSERT INTO `cmf_regions` VALUES ('3191', '3182', '余姚市', '4', '0', '0', '0', ',3268,3133,3182,3191,');
INSERT INTO `cmf_regions` VALUES ('3192', '3182', '慈溪市', '4', '0', '0', '0', ',3268,3133,3182,3192,');
INSERT INTO `cmf_regions` VALUES ('3193', '3182', '奉化市', '4', '0', '0', '0', ',3268,3133,3182,3193,');
INSERT INTO `cmf_regions` VALUES ('3194', '3133', '衢州市', '3', '0', '0', '0', ',3268,3133,3194,');
INSERT INTO `cmf_regions` VALUES ('3195', '3194', '柯城区', '4', '0', '0', '0', ',3268,3133,3194,3195,');
INSERT INTO `cmf_regions` VALUES ('3196', '3194', '衢江区', '4', '0', '0', '0', ',3268,3133,3194,3196,');
INSERT INTO `cmf_regions` VALUES ('3197', '3194', '常山县', '4', '0', '0', '0', ',3268,3133,3194,3197,');
INSERT INTO `cmf_regions` VALUES ('3198', '3194', '开化县', '4', '0', '0', '0', ',3268,3133,3194,3198,');
INSERT INTO `cmf_regions` VALUES ('3199', '3194', '龙游县', '4', '0', '0', '0', ',3268,3133,3194,3199,');
INSERT INTO `cmf_regions` VALUES ('3200', '3194', '江山市', '4', '0', '0', '0', ',3268,3133,3194,3200,');
INSERT INTO `cmf_regions` VALUES ('3201', '3133', '绍兴市', '3', '0', '0', '0', ',3268,3133,3201,');
INSERT INTO `cmf_regions` VALUES ('3202', '3201', '越城区', '4', '0', '0', '0', ',3268,3133,3201,3202,');
INSERT INTO `cmf_regions` VALUES ('3203', '3201', '绍兴县', '4', '0', '0', '0', ',3268,3133,3201,3203,');
INSERT INTO `cmf_regions` VALUES ('3204', '3201', '新昌县', '4', '0', '0', '0', ',3268,3133,3201,3204,');
INSERT INTO `cmf_regions` VALUES ('3205', '3201', '诸暨市', '4', '0', '0', '0', ',3268,3133,3201,3205,');
INSERT INTO `cmf_regions` VALUES ('3206', '3201', '上虞市', '4', '0', '0', '0', ',3268,3133,3201,3206,');
INSERT INTO `cmf_regions` VALUES ('3207', '3201', '嵊州市', '4', '0', '0', '0', ',3268,3133,3201,3207,');
INSERT INTO `cmf_regions` VALUES ('3208', '3133', '台州市', '3', '0', '0', '0', ',3268,3133,3208,');
INSERT INTO `cmf_regions` VALUES ('3209', '3208', '椒江区', '4', '0', '0', '0', ',3268,3133,3208,3209,');
INSERT INTO `cmf_regions` VALUES ('3210', '3208', '黄岩区', '4', '0', '0', '0', ',3268,3133,3208,3210,');
INSERT INTO `cmf_regions` VALUES ('3211', '3208', '路桥区', '4', '0', '0', '0', ',3268,3133,3208,3211,');
INSERT INTO `cmf_regions` VALUES ('3212', '3208', '玉环县', '4', '0', '0', '0', ',3268,3133,3208,3212,');
INSERT INTO `cmf_regions` VALUES ('3213', '3208', '三门县', '4', '0', '0', '0', ',3268,3133,3208,3213,');
INSERT INTO `cmf_regions` VALUES ('3214', '3208', '天台县', '4', '0', '0', '0', ',3268,3133,3208,3214,');
INSERT INTO `cmf_regions` VALUES ('3215', '3208', '仙居县', '4', '0', '0', '0', ',3268,3133,3208,3215,');
INSERT INTO `cmf_regions` VALUES ('3216', '3208', '温岭市', '4', '0', '0', '0', ',3268,3133,3208,3216,');
INSERT INTO `cmf_regions` VALUES ('3217', '3208', '临海市', '4', '0', '0', '0', ',3268,3133,3208,3217,');
INSERT INTO `cmf_regions` VALUES ('3218', '3133', '温州市', '3', '0', '0', '0', ',3268,3133,3218,');
INSERT INTO `cmf_regions` VALUES ('3219', '3218', '鹿城区', '4', '0', '0', '0', ',3268,3133,3218,3219,');
INSERT INTO `cmf_regions` VALUES ('3220', '3218', '龙湾区', '4', '0', '0', '0', ',3268,3133,3218,3220,');
INSERT INTO `cmf_regions` VALUES ('3221', '3218', '瓯海区', '4', '0', '0', '0', ',3268,3133,3218,3221,');
INSERT INTO `cmf_regions` VALUES ('3222', '3218', '洞头县', '4', '0', '0', '0', ',3268,3133,3218,3222,');
INSERT INTO `cmf_regions` VALUES ('3223', '3218', '永嘉县', '4', '0', '0', '0', ',3268,3133,3218,3223,');
INSERT INTO `cmf_regions` VALUES ('3224', '3218', '平阳县', '4', '0', '0', '0', ',3268,3133,3218,3224,');
INSERT INTO `cmf_regions` VALUES ('3225', '3218', '苍南县', '4', '0', '0', '0', ',3268,3133,3218,3225,');
INSERT INTO `cmf_regions` VALUES ('3226', '3218', '文成县', '4', '0', '0', '0', ',3268,3133,3218,3226,');
INSERT INTO `cmf_regions` VALUES ('3227', '3218', '泰顺县', '4', '0', '0', '0', ',3268,3133,3218,3227,');
INSERT INTO `cmf_regions` VALUES ('3228', '3218', '瑞安市', '4', '0', '0', '0', ',3268,3133,3218,3228,');
INSERT INTO `cmf_regions` VALUES ('3229', '3218', '乐清市', '4', '0', '0', '0', ',3268,3133,3218,3229,');
INSERT INTO `cmf_regions` VALUES ('3230', '3133', '舟山市', '3', '0', '0', '0', ',3268,3133,3230,');
INSERT INTO `cmf_regions` VALUES ('3231', '3230', '定海区', '4', '0', '0', '0', ',3268,3133,3230,3231,');
INSERT INTO `cmf_regions` VALUES ('3232', '3230', '普陀区', '4', '0', '0', '0', ',3268,3133,3230,3232,');
INSERT INTO `cmf_regions` VALUES ('3233', '3230', '岱山县', '4', '0', '0', '0', ',3268,3133,3230,3233,');
INSERT INTO `cmf_regions` VALUES ('3234', '3230', '嵊泗县', '4', '0', '0', '0', ',3268,3133,3230,3234,');
INSERT INTO `cmf_regions` VALUES ('3235', '3268', '香港', '2', '0', '0', '0', ',3268,3235,');
INSERT INTO `cmf_regions` VALUES ('3236', '3235', '九龙', '3', '0', '0', '0', ',3268,3235,3236,');
INSERT INTO `cmf_regions` VALUES ('3237', '3235', '香港岛', '3', '0', '0', '0', ',3268,3235,3237,');
INSERT INTO `cmf_regions` VALUES ('3238', '3235', '新界', '3', '0', '0', '0', ',3268,3235,3238,');
INSERT INTO `cmf_regions` VALUES ('3239', '3268', '澳门', '2', '0', '0', '0', ',3268,3239,');
INSERT INTO `cmf_regions` VALUES ('3240', '3239', '澳门半岛', '3', '0', '0', '0', ',3268,3239,3240,');
INSERT INTO `cmf_regions` VALUES ('3241', '3239', '离岛', '3', '0', '0', '0', ',3268,3239,3241,');
INSERT INTO `cmf_regions` VALUES ('3242', '3268', '台湾', '2', '0', '0', '0', ',3268,3242,');
INSERT INTO `cmf_regions` VALUES ('3243', '3242', '台北市', '3', '0', '0', '0', ',3268,3242,3243,');
INSERT INTO `cmf_regions` VALUES ('3244', '3242', '高雄市', '3', '0', '0', '0', ',3268,3242,3244,');
INSERT INTO `cmf_regions` VALUES ('3245', '3242', '高雄县', '3', '0', '0', '0', ',3268,3242,3245,');
INSERT INTO `cmf_regions` VALUES ('3246', '3242', '花莲县', '3', '0', '0', '0', ',3268,3242,3246,');
INSERT INTO `cmf_regions` VALUES ('3247', '3242', '基隆市', '3', '0', '0', '0', ',3268,3242,3247,');
INSERT INTO `cmf_regions` VALUES ('3248', '3242', '嘉义市', '3', '0', '0', '0', ',3268,3242,3248,');
INSERT INTO `cmf_regions` VALUES ('3249', '3242', '嘉义县', '3', '0', '0', '0', ',3268,3242,3249,');
INSERT INTO `cmf_regions` VALUES ('3250', '3242', '金门县', '3', '0', '0', '0', ',3268,3242,3250,');
INSERT INTO `cmf_regions` VALUES ('3251', '3242', '苗栗县', '3', '0', '0', '0', ',3268,3242,3251,');
INSERT INTO `cmf_regions` VALUES ('3252', '3242', '南投县', '3', '0', '0', '0', ',3268,3242,3252,');
INSERT INTO `cmf_regions` VALUES ('3253', '3242', '澎湖县', '3', '0', '0', '0', ',3268,3242,3253,');
INSERT INTO `cmf_regions` VALUES ('3254', '3242', '屏东县', '3', '0', '0', '0', ',3268,3242,3254,');
INSERT INTO `cmf_regions` VALUES ('3255', '3242', '台北县', '3', '0', '0', '0', ',3268,3242,3255,');
INSERT INTO `cmf_regions` VALUES ('3256', '3242', '台东县', '3', '0', '0', '0', ',3268,3242,3256,');
INSERT INTO `cmf_regions` VALUES ('3257', '3242', '台南市', '3', '0', '0', '0', ',3268,3242,3257,');
INSERT INTO `cmf_regions` VALUES ('3258', '3242', '台南县', '3', '0', '0', '0', ',3268,3242,3258,');
INSERT INTO `cmf_regions` VALUES ('3259', '3242', '台中市', '3', '0', '0', '0', ',3268,3242,3259,');
INSERT INTO `cmf_regions` VALUES ('3260', '3242', '台中县', '3', '0', '0', '0', ',3268,3242,3260,');
INSERT INTO `cmf_regions` VALUES ('3261', '3242', '桃园县', '3', '0', '0', '0', ',3268,3242,3261,');
INSERT INTO `cmf_regions` VALUES ('3262', '3242', '新竹市', '3', '0', '0', '0', ',3268,3242,3262,');
INSERT INTO `cmf_regions` VALUES ('3263', '3242', '新竹县', '3', '0', '0', '0', ',3268,3242,3263,');
INSERT INTO `cmf_regions` VALUES ('3264', '3242', '宜兰县', '3', '0', '0', '0', ',3268,3242,3264,');
INSERT INTO `cmf_regions` VALUES ('3265', '3242', '云林县', '3', '0', '0', '0', ',3268,3242,3265,');
INSERT INTO `cmf_regions` VALUES ('3266', '3242', '彰化县', '3', '0', '0', '0', ',3268,3242,3266,');

-- ----------------------------
-- Table structure for cmf_role
-- ----------------------------
DROP TABLE IF EXISTS `cmf_role`;
CREATE TABLE `cmf_role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL COMMENT '角色名称',
  `pid` smallint(6) DEFAULT NULL COMMENT '父角色ID',
  `status` tinyint(1) unsigned DEFAULT NULL COMMENT '状态',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  `create_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '创建时间',
  `update_time` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '更新时间',
  `listorder` int(3) NOT NULL DEFAULT '0' COMMENT '排序字段',
  PRIMARY KEY (`id`),
  KEY `parentId` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of cmf_role
-- ----------------------------
INSERT INTO `cmf_role` VALUES ('1', '超级管理员', '0', '1', '拥有网站最高管理员权限！', '1329633709', '1329633709', '0');
INSERT INTO `cmf_role` VALUES ('2', '派送员', null, '1', '快递派送员', '1488522550', '0', '0');

-- ----------------------------
-- Table structure for cmf_role_user
-- ----------------------------
DROP TABLE IF EXISTS `cmf_role_user`;
CREATE TABLE `cmf_role_user` (
  `role_id` int(11) unsigned DEFAULT '0' COMMENT '角色 id',
  `user_id` int(11) DEFAULT '0' COMMENT '用户id',
  KEY `group_id` (`role_id`),
  KEY `user_id` (`user_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户角色对应表';

-- ----------------------------
-- Records of cmf_role_user
-- ----------------------------
INSERT INTO `cmf_role_user` VALUES ('2', '2');
INSERT INTO `cmf_role_user` VALUES ('2', '3');
INSERT INTO `cmf_role_user` VALUES ('2', '4');
INSERT INTO `cmf_role_user` VALUES ('2', '5');
INSERT INTO `cmf_role_user` VALUES ('2', '6');
INSERT INTO `cmf_role_user` VALUES ('2', '7');
INSERT INTO `cmf_role_user` VALUES ('2', '8');
INSERT INTO `cmf_role_user` VALUES ('2', '9');

-- ----------------------------
-- Table structure for cmf_route
-- ----------------------------
DROP TABLE IF EXISTS `cmf_route`;
CREATE TABLE `cmf_route` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '路由id',
  `full_url` varchar(255) DEFAULT NULL COMMENT '完整url， 如：portal/list/index?id=1',
  `url` varchar(255) DEFAULT NULL COMMENT '实际显示的url',
  `listorder` int(5) DEFAULT '0' COMMENT '排序，优先级，越小优先级越高',
  `status` tinyint(1) DEFAULT '1' COMMENT '状态，1：启用 ;0：不启用',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='url路由表';

-- ----------------------------
-- Records of cmf_route
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_seat
-- ----------------------------
DROP TABLE IF EXISTS `cmf_seat`;
CREATE TABLE `cmf_seat` (
  `seat_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `seat_detail` varchar(255) NOT NULL,
  `share` tinyint(1) NOT NULL DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  PRIMARY KEY (`seat_id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_seat
-- ----------------------------
INSERT INTO `cmf_seat` VALUES ('11', 'A1-01-01-(1)', '0', '1', '1488509234', '1488509234');
INSERT INTO `cmf_seat` VALUES ('12', 'A1-1-1-(2)', '0', '1', '1488509248', '1488764793');
INSERT INTO `cmf_seat` VALUES ('13', 'A1-01-01-(3)', '0', '1', '1488509253', '1488509253');
INSERT INTO `cmf_seat` VALUES ('14', 'A1-01-01-(4)', '0', '1', '1488509259', '1488509259');
INSERT INTO `cmf_seat` VALUES ('15', 'A1-02-01-(1)', '0', '1', '1488509265', '1488509265');
INSERT INTO `cmf_seat` VALUES ('16', 'A1-02-01-(2)', '0', '1', '1488509272', '1488509272');
INSERT INTO `cmf_seat` VALUES ('17', '111111111111111222222222223333333333', '0', '1', '1488509574', '1488509574');
INSERT INTO `cmf_seat` VALUES ('18', '111111111111111111111111111111111', '0', '1', '1488526188', '1488526188');
INSERT INTO `cmf_seat` VALUES ('19', '123123', '0', '1', '1488526360', '1488526360');
INSERT INTO `cmf_seat` VALUES ('20', 'A01-01-01', '0', '0', '1488864232', '1488864265');
INSERT INTO `cmf_seat` VALUES ('21', 'A01-01-02', '0', '0', '1488864244', '1488864244');
INSERT INTO `cmf_seat` VALUES ('22', 'A01-01-03', '0', '0', '1488864249', '1488864249');
INSERT INTO `cmf_seat` VALUES ('23', 'A01-01-04', '0', '0', '1488864252', '1488864252');
INSERT INTO `cmf_seat` VALUES ('24', 'A01-01-05', '0', '0', '1488864256', '1488864256');
INSERT INTO `cmf_seat` VALUES ('25', 'A01-02-01', '0', '0', '1488864284', '1488864284');
INSERT INTO `cmf_seat` VALUES ('26', 'A01-02-02', '0', '0', '1488864297', '1488864297');
INSERT INTO `cmf_seat` VALUES ('27', 'A01-02-03', '0', '0', '1488864302', '1488864302');
INSERT INTO `cmf_seat` VALUES ('28', 'A01-02-04', '0', '0', '1488864309', '1488864309');
INSERT INTO `cmf_seat` VALUES ('29', 'A01-02-05', '0', '0', '1488864313', '1488864313');
INSERT INTO `cmf_seat` VALUES ('30', 'A01-03-01', '0', '0', '1488864323', '1488864323');
INSERT INTO `cmf_seat` VALUES ('31', 'A01-03-02', '0', '0', '1488864327', '1488864327');
INSERT INTO `cmf_seat` VALUES ('32', 'A01-03-03', '0', '0', '1488864331', '1488864331');
INSERT INTO `cmf_seat` VALUES ('33', 'A01-03-04', '0', '0', '1488864335', '1488864335');
INSERT INTO `cmf_seat` VALUES ('34', 'A01-03-05', '0', '0', '1488864338', '1488864338');

-- ----------------------------
-- Table structure for cmf_send
-- ----------------------------
DROP TABLE IF EXISTS `cmf_send`;
CREATE TABLE `cmf_send` (
  `send_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `send_name` varchar(100) NOT NULL,
  `start_time` int(10) NOT NULL,
  `end_time` int(10) NOT NULL,
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`send_id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_send
-- ----------------------------
INSERT INTO `cmf_send` VALUES ('1', '1', '1488789551', '1488789551', '1488789574', '1488789574', '0', '1');
INSERT INTO `cmf_send` VALUES ('2', '2', '1488789610', '1488789610', '1488790250', '1488790250', '0', '1');
INSERT INTO `cmf_send` VALUES ('3', '3', '1488789619', '1488789619', '1488789627', '1488789627', '0', '1');
INSERT INTO `cmf_send` VALUES ('4', '小计划', '1488348060', '1490940060', '1488880447', '1488880447', '1', '0');

-- ----------------------------
-- Table structure for cmf_send_application_cost_center
-- ----------------------------
DROP TABLE IF EXISTS `cmf_send_application_cost_center`;
CREATE TABLE `cmf_send_application_cost_center` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `application_id` int(11) DEFAULT NULL,
  `center_id` int(11) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT '0',
  `create_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_send_application_cost_center
-- ----------------------------
INSERT INTO `cmf_send_application_cost_center` VALUES ('1', '95', '2', '0', '1487917737', '1487917737');
INSERT INTO `cmf_send_application_cost_center` VALUES ('2', '96', '2', '0', '1487917878', '1487917878');
INSERT INTO `cmf_send_application_cost_center` VALUES ('3', '97', '2', '0', '1487918017', '1487918017');
INSERT INTO `cmf_send_application_cost_center` VALUES ('4', '98', '2', '0', '1487918262', '1487918262');
INSERT INTO `cmf_send_application_cost_center` VALUES ('5', '99', '2', '0', '1488175128', '1488175128');
INSERT INTO `cmf_send_application_cost_center` VALUES ('6', '100', '2', '0', '1488175359', '1488175359');
INSERT INTO `cmf_send_application_cost_center` VALUES ('7', '101', '2', '0', '1488245270', '1488245270');
INSERT INTO `cmf_send_application_cost_center` VALUES ('8', '102', '2', '0', '1488245433', '1488245433');
INSERT INTO `cmf_send_application_cost_center` VALUES ('9', '105', '2', '0', '1488272209', '1488272209');
INSERT INTO `cmf_send_application_cost_center` VALUES ('10', '106', '2', '0', '1488272213', '1488272213');
INSERT INTO `cmf_send_application_cost_center` VALUES ('11', '111', '2', '0', '1488272918', '1488272918');
INSERT INTO `cmf_send_application_cost_center` VALUES ('12', '115', '2', '0', '1488349609', '1488349609');
INSERT INTO `cmf_send_application_cost_center` VALUES ('13', '116', '2', '0', '1488349612', '1488349612');
INSERT INTO `cmf_send_application_cost_center` VALUES ('14', '119', '2', '0', '1488350126', '1488350126');
INSERT INTO `cmf_send_application_cost_center` VALUES ('15', '119', '3', '0', '1488350126', '1488350126');
INSERT INTO `cmf_send_application_cost_center` VALUES ('16', '120', '2', '0', '1488350437', '1488350437');
INSERT INTO `cmf_send_application_cost_center` VALUES ('17', '120', '3', '0', '1488350437', '1488350437');
INSERT INTO `cmf_send_application_cost_center` VALUES ('18', '121', '1', '0', '1488421844', '1488421844');
INSERT INTO `cmf_send_application_cost_center` VALUES ('19', '122', '1', '0', '1488421921', '1488421921');
INSERT INTO `cmf_send_application_cost_center` VALUES ('20', '123', '1', '0', '1488422955', '1488422955');
INSERT INTO `cmf_send_application_cost_center` VALUES ('21', '124', '1', '0', '1488683031', '1488683031');
INSERT INTO `cmf_send_application_cost_center` VALUES ('22', '125', '1', '0', '1488683205', '1488683205');
INSERT INTO `cmf_send_application_cost_center` VALUES ('23', '126', '2', '0', '1488683306', '1488683306');
INSERT INTO `cmf_send_application_cost_center` VALUES ('24', '127', '2', '0', '1488693784', '1488693784');
INSERT INTO `cmf_send_application_cost_center` VALUES ('25', '128', '2', '0', '1488696247', '1488696247');

-- ----------------------------
-- Table structure for cmf_send_export_history
-- ----------------------------
DROP TABLE IF EXISTS `cmf_send_export_history`;
CREATE TABLE `cmf_send_export_history` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `serial_number` varchar(50) NOT NULL,
  `express_type` tinyint(1) DEFAULT NULL,
  `service_type` tinyint(1) DEFAULT NULL,
  `express_company_id` int(11) DEFAULT NULL,
  `express_company_name` varchar(100) DEFAULT NULL,
  `express_quantity` int(10) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_send_export_history
-- ----------------------------
INSERT INTO `cmf_send_export_history` VALUES ('13', 'E170306102646', '1', null, '3', null, '7', '1', '0', '0', '1488767206', '1488767206');
INSERT INTO `cmf_send_export_history` VALUES ('14', 'E170306134357', '2', null, '0', null, '4', '1', '0', '0', '1488779037', '1488779037');
INSERT INTO `cmf_send_export_history` VALUES ('15', 'E170306134846', '2', null, '3', null, '2', '1', '0', '0', '1488779326', '1488779326');

-- ----------------------------
-- Table structure for cmf_send_export_item
-- ----------------------------
DROP TABLE IF EXISTS `cmf_send_export_item`;
CREATE TABLE `cmf_send_export_item` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `export_id` int(10) DEFAULT NULL,
  `item_id` int(10) DEFAULT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_send_export_item
-- ----------------------------
INSERT INTO `cmf_send_export_item` VALUES ('43', '13', '126', '0', '1488767206', '1488767206');
INSERT INTO `cmf_send_export_item` VALUES ('44', '13', '121', '0', '1488767206', '1488767206');
INSERT INTO `cmf_send_export_item` VALUES ('45', '13', '97', '0', '1488767206', '1488767206');
INSERT INTO `cmf_send_export_item` VALUES ('46', '13', '96', '0', '1488767206', '1488767206');
INSERT INTO `cmf_send_export_item` VALUES ('47', '13', '95', '0', '1488767206', '1488767206');
INSERT INTO `cmf_send_export_item` VALUES ('48', '13', '94', '0', '1488767206', '1488767206');
INSERT INTO `cmf_send_export_item` VALUES ('49', '13', '93', '0', '1488767206', '1488767206');
INSERT INTO `cmf_send_export_item` VALUES ('50', '14', '4', '0', '1488779037', '1488779037');
INSERT INTO `cmf_send_export_item` VALUES ('51', '14', '3', '0', '1488779037', '1488779037');
INSERT INTO `cmf_send_export_item` VALUES ('52', '14', '2', '0', '1488779037', '1488779037');
INSERT INTO `cmf_send_export_item` VALUES ('53', '14', '1', '0', '1488779037', '1488779037');
INSERT INTO `cmf_send_export_item` VALUES ('54', '15', '4', '0', '1488779326', '1488779326');
INSERT INTO `cmf_send_export_item` VALUES ('55', '15', '3', '0', '1488779326', '1488779326');

-- ----------------------------
-- Table structure for cmf_send_express_application
-- ----------------------------
DROP TABLE IF EXISTS `cmf_send_express_application`;
CREATE TABLE `cmf_send_express_application` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `send_staff_id` int(20) NOT NULL,
  `express_type` tinyint(1) NOT NULL,
  `express_channel` tinyint(1) DEFAULT '0',
  `service_type` tinyint(1) DEFAULT NULL,
  `express_company_id` int(11) DEFAULT NULL,
  `express_company_name` varchar(100) DEFAULT NULL,
  `express_number` varchar(50) DEFAULT NULL,
  `express_quantity` int(10) NOT NULL,
  `sender_path` varchar(100) DEFAULT NULL,
  `receive_staff_id` int(10) DEFAULT NULL,
  `receive_name` varchar(100) NOT NULL,
  `receive_phone` varchar(11) NOT NULL,
  `receive_company` varchar(100) DEFAULT NULL,
  `receive_tel` varchar(20) DEFAULT NULL,
  `regions_country_id` int(10) DEFAULT NULL,
  `regions_province_id` int(10) DEFAULT NULL,
  `regions_city_id` int(10) DEFAULT NULL,
  `regions_area_id` int(10) DEFAULT NULL,
  `receive_zip` varchar(20) DEFAULT NULL,
  `receive_address` varchar(255) DEFAULT NULL,
  `send_comment` varchar(255) DEFAULT NULL,
  `return_comment` varchar(255) DEFAULT NULL,
  `estimated_weight` double(10,0) DEFAULT NULL,
  `estimated_expenses` double(10,0) DEFAULT NULL,
  `weight` double(10,0) DEFAULT NULL,
  `expenses` double(10,0) DEFAULT NULL,
  `number_type` tinyint(1) DEFAULT NULL,
  `package_address_id` int(10) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=129 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_send_express_application
-- ----------------------------
INSERT INTO `cmf_send_express_application` VALUES ('88', '8', '1', '0', '0', '3', null, null, '1', null, null, 'dddddd', '18608008922', null, null, null, null, null, '1', 'ddd', 'ddddddddd', null, null, '23', '24', '0', '0', '2', null, '0', '0', '1487818857', '1487818857');
INSERT INTO `cmf_send_express_application` VALUES ('89', '8', '1', '0', '0', '3', null, null, '3', null, null, 'dddddd', '18608008922', null, null, null, null, null, '1', 'ddd', 'ddddddddd', null, null, '23', '24', '11', '0', '2', null, '0', '0', '1487819644', '1487819644');
INSERT INTO `cmf_send_express_application` VALUES ('92', '10', '1', '0', '0', '3', null, null, '3', null, null, '123', '123', null, null, null, null, null, '0', '123123', '3123123', null, null, null, null, '9', '0', '2', null, '0', '0', '1487902302', '1487902302');
INSERT INTO `cmf_send_express_application` VALUES ('93', '11', '1', '0', '0', '3', null, null, '1', null, null, '132', '123', null, null, null, null, null, '0', '123123', '123123', null, null, null, null, '4', '0', '2', null, '1', '0', '1487917514', '1487917514');
INSERT INTO `cmf_send_express_application` VALUES ('94', '11', '1', '0', '0', '3', null, null, '1', null, null, '123', '312313', null, null, null, null, null, '0', '123123', '3123123123', null, null, null, null, '2', '0', '2', null, '1', '0', '1487917586', '1487917586');
INSERT INTO `cmf_send_express_application` VALUES ('95', '11', '1', '0', '0', '3', null, null, '1', null, null, '3123', '123123', null, null, null, null, null, '0', '123123', '123123', null, null, null, null, '3', '0', '2', null, '1', '0', '1487917737', '1487917737');
INSERT INTO `cmf_send_express_application` VALUES ('96', '11', '1', '0', '0', '3', null, null, '1', null, null, '132123', '12312', null, null, null, null, null, '0', '3123123', '123123123', null, null, null, null, '2', '0', '2', null, '1', '0', '1487917878', '1487917878');
INSERT INTO `cmf_send_express_application` VALUES ('97', '11', '1', '0', '0', '3', null, null, '1', null, null, '3123', '123', null, null, null, null, null, '0', '123123', '123123', null, null, null, null, '2', '0', '2', null, '1', '0', '1487918017', '1487918017');
INSERT INTO `cmf_send_express_application` VALUES ('98', '11', '1', '0', '0', '3', null, '3123123123', '2', null, null, '213', '123', null, null, null, null, null, '0', '123', '123123', null, null, null, null, '4', '0', '2', null, '0', '0', '1487918262', '1487918262');
INSERT INTO `cmf_send_express_application` VALUES ('100', '11', '3', '0', '0', '3', null, null, '1', null, '8', '', '', null, null, null, null, null, '1', '', '', null, null, '23', '24', '0', '0', '2', null, '1', '0', '1488175359', '1488175359');
INSERT INTO `cmf_send_express_application` VALUES ('101', '11', '2', '0', '0', '3', null, null, '2', null, null, '多对多', '123123', null, null, null, null, null, null, '', 'dddddddd', null, null, '0', '0', '0', '0', '2', '2', '0', '0', '1488245270', '1488245270');
INSERT INTO `cmf_send_express_application` VALUES ('102', '11', '2', '0', '0', '3', null, null, '2', null, null, '多对多', '123123', null, null, null, null, null, null, '', 'dddddddd', null, null, '0', '0', '4', '0', '2', '2', '1', '0', '1488245433', '1488245433');
INSERT INTO `cmf_send_express_application` VALUES ('111', '11', '1', '0', '0', '1', null, null, '2', null, null, '1231', '3123', null, null, null, null, null, '1', null, '', null, null, '2', '12', '0', '0', '1', null, '0', '0', '1488272918', '1488272918');
INSERT INTO `cmf_send_express_application` VALUES ('115', '11', '1', '0', '0', '0', null, null, '0', null, null, '', '', null, null, null, null, null, '0', null, '', null, null, '0', '0', null, null, '0', null, '0', '0', '1488349608', '1488349608');
INSERT INTO `cmf_send_express_application` VALUES ('116', '11', '1', '0', '0', '0', null, null, '0', null, null, '', '', null, null, null, null, null, '0', null, '', null, null, '0', '0', null, null, '0', null, '0', '0', '1488349612', '1488349612');
INSERT INTO `cmf_send_express_application` VALUES ('119', '11', '1', '0', '0', '1', null, null, '2', null, null, '2', '2', null, null, null, null, null, '1', null, '', null, null, '2', '12', null, null, '2', null, '0', '0', '1488350126', '1488350126');
INSERT INTO `cmf_send_express_application` VALUES ('120', '11', '1', '0', '0', '1', null, null, '3', null, null, '123', '123', null, null, null, null, null, '1', null, '', null, null, '2', '12', null, null, '2', null, '0', '0', '1488350437', '1488350437');
INSERT INTO `cmf_send_express_application` VALUES ('121', '0', '1', '0', '1', '3', null, '3123123', '1', null, null, '3123', '12312', null, null, null, null, null, '0', '3123', '123123', null, null, null, null, '2', '0', '2', null, '1', '0', '1488421844', '1488421844');
INSERT INTO `cmf_send_express_application` VALUES ('122', '0', '1', '0', '1', '1', null, '3123123', '1', null, null, '123', '123', null, null, null, null, null, '0', '123', '123', null, null, null, null, '2', '0', '2', null, '1', '0', '1488421921', '1488421921');
INSERT INTO `cmf_send_express_application` VALUES ('123', '0', '1', '0', '1', '1', null, '123', '1', null, null, '123', '123', null, null, null, null, null, '0', '123123', '123', null, null, null, null, '2', '0', '2', null, '1', '0', '1488422955', '1488422955');
INSERT INTO `cmf_send_express_application` VALUES ('126', '11', '1', '1', '1', '3', null, '3123123123', '1', null, null, '测试收件人', '18608008922', null, null, null, null, null, '0', '123123', '123123123', null, null, null, null, '2', '0', '2', null, '1', '0', '1488683306', '1488683306');
INSERT INTO `cmf_send_express_application` VALUES ('127', '11', '2', '0', '1', '3', null, null, '2', null, null, '多对多', '123123', null, null, null, null, null, null, '', 'dddddddd', null, null, '0', '0', null, null, '2', '2', '1', '0', '1488693784', '1488693784');
INSERT INTO `cmf_send_express_application` VALUES ('128', '11', '2', '0', '1', '3', null, null, '2', null, null, '多对多', '123123', null, null, null, null, null, null, '', 'dddddddd', null, null, '0', '0', null, null, '2', '2', '1', '0', '1488696247', '1488696247');

-- ----------------------------
-- Table structure for cmf_send_express_item
-- ----------------------------
DROP TABLE IF EXISTS `cmf_send_express_item`;
CREATE TABLE `cmf_send_express_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `application_id` int(20) NOT NULL,
  `express_number` varchar(50) DEFAULT NULL,
  `serial_number` varchar(50) NOT NULL,
  `day_number` int(20) DEFAULT NULL,
  `express_company_id` int(11) DEFAULT NULL,
  `express_company_name` varchar(100) DEFAULT NULL,
  `express_type` tinyint(1) DEFAULT NULL,
  `send_staff_id` int(20) DEFAULT NULL,
  `weight` double(10,0) DEFAULT NULL,
  `expenses` float(10,0) DEFAULT NULL,
  `user_id` int(20) DEFAULT NULL,
  `package_address_id` int(10) DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  `app_number` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_send_express_item
-- ----------------------------
INSERT INTO `cmf_send_express_item` VALUES ('67', '88', null, 'DHL2170223000001', '1', '3', null, '1', '8', null, null, '0', null, '-1', '0', '1487818857', '1487818857', '1');
INSERT INTO `cmf_send_express_item` VALUES ('68', '89', null, 'DHL2170223000002', '2', '3', null, '1', '8', '2', '0', '1', null, '-1', '0', '1487819644', '1487819644', '1');
INSERT INTO `cmf_send_express_item` VALUES ('69', '89', null, 'DHL2170223000002', '2', '3', null, '1', '8', '4', '0', '1', null, '-1', '0', '1487819644', '1487819644', '2');
INSERT INTO `cmf_send_express_item` VALUES ('70', '89', null, 'DHL2170223000002', '2', '3', null, '1', '8', '5', '0', '1', null, '-1', '0', '1487819644', '1487819644', '3');
INSERT INTO `cmf_send_express_item` VALUES ('74', '92', null, 'DHL2170224000001', '1', '3', null, '1', '10', '2', '0', '1', null, '-1', '0', '1487902302', '1487902302', '1');
INSERT INTO `cmf_send_express_item` VALUES ('75', '92', null, 'DHL2170224000001', '1', '3', null, '1', '10', '3', '0', '1', null, '-1', '0', '1487902302', '1487902302', '2');
INSERT INTO `cmf_send_express_item` VALUES ('76', '92', null, 'DHL2170224000001', '1', '3', null, '1', '10', '4', '0', '1', null, '-1', '0', '1487902302', '1487902302', '3');
INSERT INTO `cmf_send_express_item` VALUES ('77', '93', null, 'DHL2170224000002', '2', '3', null, '1', '11', '4', '0', '1', null, '0', '0', '1487917514', '1487917514', '1');
INSERT INTO `cmf_send_express_item` VALUES ('78', '94', null, 'DHL2170224000003', '3', '3', null, '1', '11', '2', '0', '1', null, '0', '0', '1487917586', '1487917586', '1');
INSERT INTO `cmf_send_express_item` VALUES ('79', '95', null, 'DHL2170224000004', '4', '3', null, '1', '11', '3', '0', '1', null, '0', '0', '1487917737', '1487917737', '1');
INSERT INTO `cmf_send_express_item` VALUES ('80', '96', null, 'DHL2170224000005', '5', '3', null, '1', '11', '2', '0', '1', null, '0', '0', '1487917878', '1487917878', '1');
INSERT INTO `cmf_send_express_item` VALUES ('81', '97', null, 'DHL2170224000006', '6', '3', null, '1', '11', '2', '0', '1', null, '0', '0', '1487918017', '1487918017', '1');
INSERT INTO `cmf_send_express_item` VALUES ('82', '98', '3123123123', 'DHL2170224000007', '7', '3', null, '1', '11', '2', '0', '1', null, '-1', '0', '1487918262', '1487918262', '1');
INSERT INTO `cmf_send_express_item` VALUES ('83', '98', '3123123123', 'DHL2170224000007', '7', '3', null, '1', '11', '2', '0', '1', null, '-1', '0', '1487918262', '1487918262', '2');
INSERT INTO `cmf_send_express_item` VALUES ('85', '100', null, 'DHL2170227000001', '1', '3', null, '3', '11', '0', '0', '1', null, '0', '0', '1488175359', '1488175359', '1');
INSERT INTO `cmf_send_express_item` VALUES ('86', '101', null, 'DHL2170228000001', '1', '3', null, '2', '11', null, null, '0', '2', '-1', '0', '1488245270', '1488245270', '1');
INSERT INTO `cmf_send_express_item` VALUES ('87', '101', null, 'DHL2170228000001', '1', '3', null, '2', '11', null, null, '0', '2', '-1', '0', '1488245270', '1488245270', '2');
INSERT INTO `cmf_send_express_item` VALUES ('88', '102', null, 'DHL2170228000002', '2', '3', null, '2', '11', '2', '0', '1', '2', '1', '0', '1488245433', '1488245433', '1');
INSERT INTO `cmf_send_express_item` VALUES ('89', '102', null, 'DHL2170228000002', '2', '3', null, '2', '11', '2', '0', '1', '2', '1', '0', '1488245433', '1488245433', '2');
INSERT INTO `cmf_send_express_item` VALUES ('90', '111', null, '12313123', null, '1', null, '1', '11', null, null, null, null, '-1', '0', '1488272918', '1488272918', '1');
INSERT INTO `cmf_send_express_item` VALUES ('91', '111', null, '76867867867', null, '1', null, '1', '11', null, null, null, null, '-1', '0', '1488272918', '1488272918', '2');
INSERT INTO `cmf_send_express_item` VALUES ('92', '119', null, 'DHL2170301000001', '1', '1', null, '1', '11', null, null, null, null, '-1', '0', '1488350126', '1488350126', '1');
INSERT INTO `cmf_send_express_item` VALUES ('93', '119', null, 'DHL2170301000001', '1', '1', null, '1', '11', null, null, null, null, '-1', '0', '1488350126', '1488350126', '2');
INSERT INTO `cmf_send_express_item` VALUES ('94', '120', null, 'DHL2170301000002', '2', '1', null, '1', '11', null, null, null, null, '-1', '0', '1488350437', '1488350437', '1');
INSERT INTO `cmf_send_express_item` VALUES ('95', '120', null, 'DHL2170301000002', '2', '1', null, '1', '11', null, null, null, null, '-1', '0', '1488350437', '1488350437', '2');
INSERT INTO `cmf_send_express_item` VALUES ('96', '120', null, 'DHL2170301000002', '2', '1', null, '1', '11', null, null, null, null, '-1', '0', '1488350437', '1488350437', '3');
INSERT INTO `cmf_send_express_item` VALUES ('97', '121', '3123123', 'DHL2170302000001', '1', '3', null, '1', '0', '2', '0', '1', null, '0', '0', '1488421844', '1488421844', '1');
INSERT INTO `cmf_send_express_item` VALUES ('98', '122', '3123123', 'DHL2170302000002', '2', '1', null, '1', '0', '2', '0', '1', null, '0', '0', '1488421921', '1488421921', '1');
INSERT INTO `cmf_send_express_item` VALUES ('99', '123', '123', 'DHL2170302000003', '3', '1', null, '1', '0', '2', '0', '1', null, '0', '0', '1488422955', '1488422955', '1');
INSERT INTO `cmf_send_express_item` VALUES ('102', '126', '3123123123', 'DHL2170305000001', '1', '3', null, '1', '11', '2', '0', '1', null, '0', '0', '1488683306', '1488683306', '1');
INSERT INTO `cmf_send_express_item` VALUES ('103', '127', null, 'DHL2170305000002', '2', '3', null, '2', '11', '2', null, '1', '2', '1', '0', '1488693784', '1488693784', '1');
INSERT INTO `cmf_send_express_item` VALUES ('104', '127', null, 'DHL2170305000002', '2', '3', null, '2', '11', '2', null, '1', '2', '1', '0', '1488693784', '1488693784', '2');
INSERT INTO `cmf_send_express_item` VALUES ('105', '128', null, 'DHL2170305000003', '3', '3', null, '2', '11', '3', null, '1', '2', '1', '0', '1488696247', '1488696247', '1');
INSERT INTO `cmf_send_express_item` VALUES ('106', '128', null, 'DHL2170305000003', '3', '3', null, '2', '11', '4', null, '1', '2', '1', '0', '1488696247', '1488696247', '2');

-- ----------------------------
-- Table structure for cmf_send_express_package
-- ----------------------------
DROP TABLE IF EXISTS `cmf_send_express_package`;
CREATE TABLE `cmf_send_express_package` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `express_number` varchar(50) DEFAULT NULL,
  `express_company_id` int(11) DEFAULT NULL,
  `express_company_name` varchar(50) DEFAULT NULL,
  `weight` double(10,0) DEFAULT NULL,
  `expenses` double(10,0) DEFAULT NULL,
  `express_quantity` int(10) DEFAULT '0',
  `package_address_id` int(11) DEFAULT NULL,
  `package_address` varchar(100) DEFAULT NULL,
  `user_id` int(20) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_send_express_package
-- ----------------------------
INSERT INTO `cmf_send_express_package` VALUES ('1', '123123123', '1', 'test', '4', '12', '2', '2', null, '1', '0', '0', '1488441674', '1488441674');
INSERT INTO `cmf_send_express_package` VALUES ('2', '', '0', null, '0', '0', '2', '0', null, '1', '0', '0', '1488535090', '1488535090');
INSERT INTO `cmf_send_express_package` VALUES ('3', '111111111111111', '3', '圆通', '4', '12', '2', '2', null, '1', '0', '0', '1488696183', '1488696183');
INSERT INTO `cmf_send_express_package` VALUES ('4', '1223131323123', '3', '圆通', '7', '12', '2', '2', null, '1', '0', '0', '1488696302', '1488696302');

-- ----------------------------
-- Table structure for cmf_send_express_package_item
-- ----------------------------
DROP TABLE IF EXISTS `cmf_send_express_package_item`;
CREATE TABLE `cmf_send_express_package_item` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `package_id` int(10) NOT NULL,
  `item_id` int(10) NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  `create_time` int(10) DEFAULT NULL,
  `update_time` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_send_express_package_item
-- ----------------------------
INSERT INTO `cmf_send_express_package_item` VALUES ('3', '1', '88', '0', '0', '1488441674', '1488441674');
INSERT INTO `cmf_send_express_package_item` VALUES ('4', '1', '89', '0', '0', '1488441674', '1488441674');
INSERT INTO `cmf_send_express_package_item` VALUES ('5', '2', '0', '0', '0', '1488535090', '1488535090');
INSERT INTO `cmf_send_express_package_item` VALUES ('6', '3', '103', '0', '0', '1488696183', '1488696183');
INSERT INTO `cmf_send_express_package_item` VALUES ('7', '3', '104', '0', '0', '1488696183', '1488696183');
INSERT INTO `cmf_send_express_package_item` VALUES ('8', '4', '105', '0', '0', '1488696302', '1488696302');
INSERT INTO `cmf_send_express_package_item` VALUES ('9', '4', '106', '0', '0', '1488696302', '1488696302');

-- ----------------------------
-- Table structure for cmf_send_way
-- ----------------------------
DROP TABLE IF EXISTS `cmf_send_way`;
CREATE TABLE `cmf_send_way` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `send_id` int(11) NOT NULL,
  `way_id` int(11) NOT NULL,
  `way_name` varchar(100) NOT NULL,
  `sender_id` int(11) NOT NULL,
  `sender` varchar(100) NOT NULL,
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_send_way
-- ----------------------------
INSERT INTO `cmf_send_way` VALUES ('12', '4', '8', 'A01-01', '0', 'admin', '1488880447', '1488880447', '0');
INSERT INTO `cmf_send_way` VALUES ('13', '4', '9', 'A01-02', '0', 'admin', '1488880447', '1488880447', '0');
INSERT INTO `cmf_send_way` VALUES ('14', '4', '10', 'A01-03', '0', 'admin', '1488880447', '1488880447', '0');

-- ----------------------------
-- Table structure for cmf_slide
-- ----------------------------
DROP TABLE IF EXISTS `cmf_slide`;
CREATE TABLE `cmf_slide` (
  `slide_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slide_cid` int(11) NOT NULL COMMENT '幻灯片分类 id',
  `slide_name` varchar(255) NOT NULL COMMENT '幻灯片名称',
  `slide_pic` varchar(255) DEFAULT NULL COMMENT '幻灯片图片',
  `slide_url` varchar(255) DEFAULT NULL COMMENT '幻灯片链接',
  `slide_des` varchar(255) DEFAULT NULL COMMENT '幻灯片描述',
  `slide_content` text COMMENT '幻灯片内容',
  `slide_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  `listorder` int(10) DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`slide_id`),
  KEY `slide_cid` (`slide_cid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='幻灯片表';

-- ----------------------------
-- Records of cmf_slide
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_slide_cat
-- ----------------------------
DROP TABLE IF EXISTS `cmf_slide_cat`;
CREATE TABLE `cmf_slide_cat` (
  `cid` int(11) NOT NULL AUTO_INCREMENT,
  `cat_name` varchar(255) NOT NULL COMMENT '幻灯片分类',
  `cat_idname` varchar(255) NOT NULL COMMENT '幻灯片分类标识',
  `cat_remark` text COMMENT '分类备注',
  `cat_status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1显示，0不显示',
  PRIMARY KEY (`cid`),
  KEY `cat_idname` (`cat_idname`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='幻灯片分类表';

-- ----------------------------
-- Records of cmf_slide_cat
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_staff
-- ----------------------------
DROP TABLE IF EXISTS `cmf_staff`;
CREATE TABLE `cmf_staff` (
  `staff_id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '员工主键id',
  `zn_name` varchar(100) NOT NULL COMMENT '中文名',
  `en_name` varchar(100) NOT NULL COMMENT '英文名',
  `alias` varchar(100) DEFAULT NULL COMMENT '别名',
  `job_number` varchar(30) DEFAULT NULL COMMENT '工号',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机号',
  `extension_no` varchar(20) DEFAULT NULL COMMENT '分机号',
  `email` varchar(100) NOT NULL COMMENT '邮箱',
  `seat_id` int(11) unsigned NOT NULL,
  `seat_detail` varchar(255) NOT NULL,
  `receiving_demand` tinyint(1) NOT NULL DEFAULT '0' COMMENT '收件需求：0派送，1自取',
  `department_id` int(11) DEFAULT NULL COMMENT '部门id',
  `department_name` varchar(100) NOT NULL,
  `turnover_status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '离职状态：1离职，0在职',
  `disabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '逻辑删除：1（TRUE）， 0（FALSE）',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  `password` varchar(64) NOT NULL DEFAULT '',
  `avatar` varchar(255) DEFAULT NULL,
  `sex` smallint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`staff_id`)
) ENGINE=MyISAM AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_staff
-- ----------------------------
INSERT INTO `cmf_staff` VALUES ('8', '我的名字', 'face', '你的名字', '', '18912480002', '18912480002', 'fvbdrt@qq.com', '3', 'D1-1-1-3', '0', '0', '', '0', '1', '1487732281', '1488508555', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('9', '他的名字', 'name', '', '', '18912480001', '18912480001', 'noinoi@qq.com', '2', 'D1-1-1-2', '0', '0', '', '0', '1', '1487732437', '1488507323', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('10', '你的名字', 'face', '', '', '18912480000', '18912480000', 'cwe@qq.com', '1', 'D1-1-1-11', '0', '3', '行政部', '0', '1', '1487735304', '1488507311', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('11', '悦悦', 'yueyue', '', '', '18912370001', '', '222001@qq.com', '21', 'A01-01-02', '0', '12', '研发部', '0', '0', '1488680554', '1488866815', '###1003bcfef15cb7e2c331964fb1e35b34', null, '0');
INSERT INTO `cmf_staff` VALUES ('12', '乐乐', 'lele', '', '', '18912370002', '', '222002@qq.com', '20', 'A01-01-01', '0', '13', '测试部', '0', '0', '1488680585', '1488866828', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('13', '糊糊', 'huhu', '', '', '18912370003', '', '222003@qq.com', '22', 'A01-01-03', '0', '12', '研发部', '0', '0', '1488680627', '1488866840', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('14', '圆圆', 'yuanyuan', '', '', '18912370004', '', '222004@qq.com', '23', 'A01-01-04', '0', '12', '研发部', '0', '0', '1488680656', '1488866854', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('15', '咕咕', 'gugu', '', '', '18912370005', '', '222005@qq.com', '24', 'A01-01-05', '0', '12', '研发部', '0', '0', '1488680708', '1488866875', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('16', '酷酷', 'kuku', '', '', '18912370006', '', '222006@qq.com', '25', 'A01-02-01', '0', '12', '研发部', '0', '0', '1488680737', '1488866887', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('17', '拂拂', 'fufu', '', '', '18912370007', '', '222007@qq.com', '26', 'A01-02-02', '0', '13', '测试部', '0', '0', '1488680765', '1488866901', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('18', '发发', 'fafa', '', '', '18912370008', '', '222008@qq.com', '27', 'A01-02-03', '0', '13', '测试部', '0', '0', '1488680794', '1488866913', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('19', '嘟嘟', 'dudu', '', '', '18912370009', '', '222009@qq.com', '28', 'A01-02-04', '0', '13', '测试部', '0', '0', '1488680822', '1488866949', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('20', '馥馥', 'fufu', '', '', '18912370010', '', '222010@qq.com', '29', 'A01-02-05', '0', '13', '测试部', '0', '0', '1488680852', '1488866937', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('21', '杜杜', 'dudu', '', '', '18912370011', '', '222011@qq.com', '30', 'A01-03-01', '0', '14', '人事部', '0', '0', '1488680880', '1488866969', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('22', '素素', 'susu', '', '', '18912370012', '', '222012@qq.com', '31', 'A01-03-02', '0', '14', '人事部', '0', '0', '1488680908', '1488867016', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('23', '瑟瑟', 'sese', '', '', '18912370013', '', '222013@qq.com', '32', 'A01-03-03', '0', '14', '人事部', '0', '0', '1488680946', '1488867034', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('24', '粗粗', 'cucu', '', '', '18912370014', '', '222014@qq.com', '24', 'A01-03-04', '0', '14', '人事部', '0', '1', '1488680974', '1488683589', '', null, '0');
INSERT INTO `cmf_staff` VALUES ('25', '我我', 'wowo', '', '', '18912370015', '', '222015@qq.com', '25', 'A01-03-05', '0', '14', '人事部', '0', '1', '1488681006', '1488683641', '', null, '0');

-- ----------------------------
-- Table structure for cmf_staff_costcenters
-- ----------------------------
DROP TABLE IF EXISTS `cmf_staff_costcenters`;
CREATE TABLE `cmf_staff_costcenters` (
  `staffcenter_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `staff_id` int(11) NOT NULL,
  `center_id` int(11) NOT NULL,
  `staffcenter_default` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`staffcenter_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_staff_costcenters
-- ----------------------------
INSERT INTO `cmf_staff_costcenters` VALUES ('1', '6', '2', '1');
INSERT INTO `cmf_staff_costcenters` VALUES ('2', '6', '1', '0');

-- ----------------------------
-- Table structure for cmf_terms
-- ----------------------------
DROP TABLE IF EXISTS `cmf_terms`;
CREATE TABLE `cmf_terms` (
  `term_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '分类id',
  `name` varchar(200) DEFAULT NULL COMMENT '分类名称',
  `slug` varchar(200) DEFAULT '',
  `taxonomy` varchar(32) DEFAULT NULL COMMENT '分类类型',
  `description` longtext COMMENT '分类描述',
  `parent` bigint(20) unsigned DEFAULT '0' COMMENT '分类父id',
  `count` bigint(20) DEFAULT '0' COMMENT '分类文章数',
  `path` varchar(500) DEFAULT NULL COMMENT '分类层级关系路径',
  `seo_title` varchar(500) DEFAULT NULL,
  `seo_keywords` varchar(500) DEFAULT NULL,
  `seo_description` varchar(500) DEFAULT NULL,
  `list_tpl` varchar(50) DEFAULT NULL COMMENT '分类列表模板',
  `one_tpl` varchar(50) DEFAULT NULL COMMENT '分类文章页模板',
  `listorder` int(5) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`term_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Portal 文章分类表';

-- ----------------------------
-- Records of cmf_terms
-- ----------------------------
INSERT INTO `cmf_terms` VALUES ('1', '列表演示', '', 'article', '', '0', '0', '0-1', '', '', '', 'list', 'article', '0', '1');
INSERT INTO `cmf_terms` VALUES ('2', '瀑布流', '', 'article', '', '0', '0', '0-2', '', '', '', 'list_masonry', 'article', '0', '1');

-- ----------------------------
-- Table structure for cmf_term_relationships
-- ----------------------------
DROP TABLE IF EXISTS `cmf_term_relationships`;
CREATE TABLE `cmf_term_relationships` (
  `tid` bigint(20) NOT NULL AUTO_INCREMENT,
  `object_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT 'posts表里文章id',
  `term_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '分类id',
  `listorder` int(10) NOT NULL DEFAULT '0' COMMENT '排序',
  `status` int(2) NOT NULL DEFAULT '1' COMMENT '状态，1发布，0不发布',
  PRIMARY KEY (`tid`),
  KEY `term_taxonomy_id` (`term_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='Portal 文章分类对应表';

-- ----------------------------
-- Records of cmf_term_relationships
-- ----------------------------
INSERT INTO `cmf_term_relationships` VALUES ('1', '1', '2', '0', '1');

-- ----------------------------
-- Table structure for cmf_test
-- ----------------------------
DROP TABLE IF EXISTS `cmf_test`;
CREATE TABLE `cmf_test` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL,
  `D_start` varchar(10) DEFAULT NULL,
  `D_end` varchar(10) DEFAULT NULL,
  `F_start` varchar(10) DEFAULT NULL,
  `F_end` varchar(10) DEFAULT NULL,
  `A_start` varchar(10) DEFAULT NULL,
  `A_end` varchar(10) DEFAULT NULL,
  `S_start` varchar(10) DEFAULT NULL,
  `S_end` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_test
-- ----------------------------
INSERT INTO `cmf_test` VALUES ('1', '路径一', '1', '3', '3', '2', '4', '3', '18', '34');
INSERT INTO `cmf_test` VALUES ('2', '路径二', '4', '4', '4', '4', '4', '4', '18', '30');
INSERT INTO `cmf_test` VALUES ('3', '路径三', '5', '5', '5', '5', '3', '6', '12', '6');

-- ----------------------------
-- Table structure for cmf_users
-- ----------------------------
DROP TABLE IF EXISTS `cmf_users`;
CREATE TABLE `cmf_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '' COMMENT '用户名',
  `user_pass` varchar(64) NOT NULL DEFAULT '' COMMENT '登录密码；sp_password加密',
  `user_nicename` varchar(50) NOT NULL DEFAULT '' COMMENT '用户美名',
  `user_email` varchar(100) NOT NULL DEFAULT '' COMMENT '登录邮箱',
  `user_url` varchar(100) NOT NULL DEFAULT '' COMMENT '用户个人网站',
  `avatar` varchar(255) DEFAULT NULL COMMENT '用户头像，相对于upload/avatar目录',
  `sex` smallint(1) DEFAULT '0' COMMENT '性别；0：保密，1：男；2：女',
  `birthday` date DEFAULT '2000-01-01' COMMENT '生日',
  `signature` varchar(255) DEFAULT NULL COMMENT '个性签名',
  `last_login_ip` varchar(16) DEFAULT NULL COMMENT '最后登录ip',
  `last_login_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '最后登录时间',
  `create_time` datetime NOT NULL DEFAULT '2000-01-01 00:00:00' COMMENT '注册时间',
  `user_activation_key` varchar(60) NOT NULL DEFAULT '' COMMENT '激活码',
  `user_status` int(11) NOT NULL DEFAULT '1' COMMENT '用户状态 0：禁用； 1：正常 ；2：未验证',
  `score` int(11) NOT NULL DEFAULT '0' COMMENT '用户积分',
  `user_type` smallint(1) DEFAULT '1' COMMENT '用户类型，1:admin ;2:会员',
  `coin` int(11) NOT NULL DEFAULT '0' COMMENT '金币',
  `mobile` varchar(20) NOT NULL DEFAULT '' COMMENT '手机号',
  PRIMARY KEY (`id`),
  KEY `user_login_key` (`user_login`),
  KEY `user_nicename` (`user_nicename`)
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of cmf_users
-- ----------------------------
INSERT INTO `cmf_users` VALUES ('1', 'admin', '###1dbff7af36a0ef6c2d1a575c696bd1de', 'admin', '1074026609@qq.com', '', null, '0', '2000-01-01', null, '127.0.0.1', '2017-03-08 11:16:14', '2017-01-18 09:39:04', '', '1', '0', '1', '0', '');
INSERT INTO `cmf_users` VALUES ('2', 'delivery1', '###1dbff7af36a0ef6c2d1a575c696bd1de', '', 'delivery1@demo.com', '', null, '0', '2000-01-01', null, null, '2000-01-01 00:00:00', '2017-03-03 14:41:26', '', '1', '0', '1', '0', '');
INSERT INTO `cmf_users` VALUES ('3', 'delivery2', '###1dbff7af36a0ef6c2d1a575c696bd1de', '', 'delivery2@demo.com', '', null, '0', '2000-01-01', null, null, '2000-01-01 00:00:00', '2017-03-03 14:41:50', '', '1', '0', '1', '0', '');
INSERT INTO `cmf_users` VALUES ('4', 'delivery3', '###1dbff7af36a0ef6c2d1a575c696bd1de', '', 'delivery3@demo.com', '', null, '0', '2000-01-01', null, null, '2000-01-01 00:00:00', '2017-03-03 14:42:12', '', '1', '0', '1', '0', '');
INSERT INTO `cmf_users` VALUES ('5', '派送员1', '###48d300cdd65b587f06eb2f2a670fb806', '', '999001@qq.com', '', null, '0', '2000-01-01', null, null, '2000-01-01 00:00:00', '2017-03-05 10:13:47', '', '1', '0', '1', '0', '');
INSERT INTO `cmf_users` VALUES ('6', '派送员2', '###48d300cdd65b587f06eb2f2a670fb806', '', '999002@qq.com', '', null, '0', '2000-01-01', null, null, '2000-01-01 00:00:00', '2017-03-05 10:14:03', '', '1', '0', '1', '0', '');
INSERT INTO `cmf_users` VALUES ('7', '派送员3', '###48d300cdd65b587f06eb2f2a670fb806', '', '999003@qq.com', '', null, '0', '2000-01-01', null, null, '2000-01-01 00:00:00', '2017-03-05 10:14:22', '', '1', '0', '1', '0', '');
INSERT INTO `cmf_users` VALUES ('8', '派送员4', '###48d300cdd65b587f06eb2f2a670fb806', '', '999004@qq.com', '', null, '0', '2000-01-01', null, null, '2000-01-01 00:00:00', '2017-03-05 10:14:37', '', '1', '0', '1', '0', '');
INSERT INTO `cmf_users` VALUES ('9', '派送员5', '###48d300cdd65b587f06eb2f2a670fb806', '', '999005@qq.com', '', null, '0', '2000-01-01', null, null, '2000-01-01 00:00:00', '2017-03-05 10:14:50', '', '1', '0', '1', '0', '');

-- ----------------------------
-- Table structure for cmf_user_favorites
-- ----------------------------
DROP TABLE IF EXISTS `cmf_user_favorites`;
CREATE TABLE `cmf_user_favorites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) DEFAULT NULL COMMENT '用户 id',
  `title` varchar(255) DEFAULT NULL COMMENT '收藏内容的标题',
  `url` varchar(255) DEFAULT NULL COMMENT '收藏内容的原文地址，不带域名',
  `description` varchar(500) DEFAULT NULL COMMENT '收藏内容的描述',
  `table` varchar(50) DEFAULT NULL COMMENT '收藏实体以前所在表，不带前缀',
  `object_id` int(11) DEFAULT NULL COMMENT '收藏内容原来的主键id',
  `createtime` int(11) DEFAULT NULL COMMENT '收藏时间',
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='用户收藏表';

-- ----------------------------
-- Records of cmf_user_favorites
-- ----------------------------

-- ----------------------------
-- Table structure for cmf_way
-- ----------------------------
DROP TABLE IF EXISTS `cmf_way`;
CREATE TABLE `cmf_way` (
  `way_id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `way_name` varchar(100) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '0' COMMENT '启用路径（默认不启用）',
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`way_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_way
-- ----------------------------
INSERT INTO `cmf_way` VALUES ('1', '1(测试删除座位号后查看)', '1', '1488789413', '1488789413', '1');
INSERT INTO `cmf_way` VALUES ('2', '2（测试启用）', '0', '1488789289', '1488789289', '1');
INSERT INTO `cmf_way` VALUES ('3', '3', '0', '1488789302', '1488789302', '1');
INSERT INTO `cmf_way` VALUES ('4', '4（测试启用后删除）', '1', '1488789331', '1488789331', '1');
INSERT INTO `cmf_way` VALUES ('5', '4', '1', '1488789513', '1488789513', '1');
INSERT INTO `cmf_way` VALUES ('6', '5', '1', '1488789521', '1488789521', '1');
INSERT INTO `cmf_way` VALUES ('7', '6', '1', '1488789530', '1488789530', '1');
INSERT INTO `cmf_way` VALUES ('8', 'A01-01', '1', '1488864365', '1488864365', '0');
INSERT INTO `cmf_way` VALUES ('9', 'A01-02', '1', '1488864382', '1488864382', '0');
INSERT INTO `cmf_way` VALUES ('10', 'A01-03', '0', '1488864402', '1488864402', '1');
INSERT INTO `cmf_way` VALUES ('11', 'A01-03', '1', '1488865537', '1488865537', '0');
INSERT INTO `cmf_way` VALUES ('12', 'a', '0', '1488878502', '1488878502', '1');

-- ----------------------------
-- Table structure for cmf_way_seat
-- ----------------------------
DROP TABLE IF EXISTS `cmf_way_seat`;
CREATE TABLE `cmf_way_seat` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `way_id` int(11) NOT NULL,
  `seat_id` int(11) NOT NULL,
  `create_time` int(10) NOT NULL,
  `update_time` int(10) NOT NULL,
  `disabled` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=43 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of cmf_way_seat
-- ----------------------------
INSERT INTO `cmf_way_seat` VALUES ('14', '8', '20', '1488864365', '1488864365', '0');
INSERT INTO `cmf_way_seat` VALUES ('15', '8', '21', '1488864365', '1488864365', '0');
INSERT INTO `cmf_way_seat` VALUES ('16', '8', '22', '1488864365', '1488864365', '0');
INSERT INTO `cmf_way_seat` VALUES ('17', '8', '23', '1488864365', '1488864365', '0');
INSERT INTO `cmf_way_seat` VALUES ('18', '8', '24', '1488864365', '1488864365', '0');
INSERT INTO `cmf_way_seat` VALUES ('19', '9', '25', '1488864382', '1488864382', '0');
INSERT INTO `cmf_way_seat` VALUES ('20', '9', '26', '1488864382', '1488864382', '0');
INSERT INTO `cmf_way_seat` VALUES ('21', '9', '27', '1488864382', '1488864382', '0');
INSERT INTO `cmf_way_seat` VALUES ('22', '9', '28', '1488864382', '1488864382', '0');
INSERT INTO `cmf_way_seat` VALUES ('23', '9', '29', '1488864382', '1488864382', '0');
INSERT INTO `cmf_way_seat` VALUES ('24', '1', '30', '1488864402', '1488864402', '0');
INSERT INTO `cmf_way_seat` VALUES ('25', '1', '31', '1488864402', '1488864402', '0');
INSERT INTO `cmf_way_seat` VALUES ('26', '1', '32', '1488864402', '1488864402', '0');
INSERT INTO `cmf_way_seat` VALUES ('27', '1', '33', '1488864402', '1488864402', '0');
INSERT INTO `cmf_way_seat` VALUES ('28', '1', '34', '1488864402', '1488864402', '0');
INSERT INTO `cmf_way_seat` VALUES ('29', '1', '30', '1488864455', '1488864455', '0');
INSERT INTO `cmf_way_seat` VALUES ('30', '1', '31', '1488864455', '1488864455', '0');
INSERT INTO `cmf_way_seat` VALUES ('31', '1', '32', '1488864455', '1488864455', '0');
INSERT INTO `cmf_way_seat` VALUES ('32', '1', '33', '1488864455', '1488864455', '0');
INSERT INTO `cmf_way_seat` VALUES ('33', '1', '34', '1488864455', '1488864455', '0');
INSERT INTO `cmf_way_seat` VALUES ('34', '11', '30', '1488865537', '1488865537', '0');
INSERT INTO `cmf_way_seat` VALUES ('35', '11', '31', '1488865537', '1488865537', '0');
INSERT INTO `cmf_way_seat` VALUES ('36', '11', '32', '1488865537', '1488865537', '0');
INSERT INTO `cmf_way_seat` VALUES ('37', '11', '33', '1488865537', '1488865537', '0');
INSERT INTO `cmf_way_seat` VALUES ('38', '11', '34', '1488865537', '1488865537', '0');
INSERT INTO `cmf_way_seat` VALUES ('39', '1', '20', '1488878502', '1488878502', '0');
INSERT INTO `cmf_way_seat` VALUES ('40', '1', '21', '1488878502', '1488878502', '0');
INSERT INTO `cmf_way_seat` VALUES ('41', '1', '22', '1488878502', '1488878502', '0');
INSERT INTO `cmf_way_seat` VALUES ('42', '1', '23', '1488878502', '1488878502', '0');
