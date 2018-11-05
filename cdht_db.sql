/*
Navicat MySQL Data Transfer

Source Server         : dev_local_host
Source Server Version : 80013
Source Host           : 192.168.56.101:3306
Source Database       : cdht_db

Target Server Type    : MYSQL
Target Server Version : 80013
File Encoding         : 65001

Date: 2018-11-05 18:18:10
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for admin_messages
-- ----------------------------
DROP TABLE IF EXISTS `admin_messages`;
CREATE TABLE `admin_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '发给哪个管理员的消息,0为所有管理员',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '哪个用户发的消息，对应 app 用户表',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `type` enum('SY','FK') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SY',
  `content` varchar(2000) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `status` enum('U','R') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'U' COMMENT '消息状态',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admin_messages_status_index` (`status`),
  KEY `admin_messages_type_index` (`type`),
  KEY `admin_messages_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_messages
-- ----------------------------

-- ----------------------------
-- Table structure for admin_users
-- ----------------------------
DROP TABLE IF EXISTS `admin_users`;
CREATE TABLE `admin_users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `enable` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '启用状态：F禁用，T启用',
  `is_admin` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '是否可登录后台：F否，是',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '一句话描述',
  `head_image` int(11) NOT NULL DEFAULT '0' COMMENT '头像',
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `admin_users_email_unique` (`email`),
  KEY `admin_users_head_image_index` (`head_image`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of admin_users
-- ----------------------------

-- ----------------------------
-- Table structure for advertisement_positions
-- ----------------------------
DROP TABLE IF EXISTS `advertisement_positions`;
CREATE TABLE `advertisement_positions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '广告位名称',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '广告位描述',
  `type` enum('default','model','spa') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'default' COMMENT '广告位类型:默认、跳转到模型、单页面',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of advertisement_positions
-- ----------------------------

-- ----------------------------
-- Table structure for advertisements
-- ----------------------------
DROP TABLE IF EXISTS `advertisements`;
CREATE TABLE `advertisements` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '广告标题',
  `cover_image` int(11) NOT NULL DEFAULT '0' COMMENT '广告封面图片',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '广告内容:json_encode([raw:xxx,html:xxx])',
  `weight` int(11) NOT NULL DEFAULT '20' COMMENT '权重',
  `advertisement_positions_id` int(11) NOT NULL DEFAULT '0' COMMENT '所属广告位',
  `link_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '跳转 url:为空则不跳转',
  `model_column_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'json_encode([model=>article,column=>slug,value=markdown-language)',
  `start_at` timestamp NULL DEFAULT NULL,
  `end_at` timestamp NULL DEFAULT NULL,
  `enable` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '启用状态：F禁用，T启用',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `advertisements_cover_image_index` (`cover_image`),
  KEY `advertisements_advertisement_positions_id_index` (`advertisement_positions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of advertisements
-- ----------------------------

-- ----------------------------
-- Table structure for alipay_notifies
-- ----------------------------
DROP TABLE IF EXISTS `alipay_notifies`;
CREATE TABLE `alipay_notifies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'undefined' COMMENT '订单类型:一般写表名称:users,取return_param下的第一个值',
  `notify_time` timestamp NULL DEFAULT NULL COMMENT '交易创建时间',
  `notify_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '通知类型',
  `notify_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '通知id',
  `app_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '支付宝分配给开发者的应用Id',
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '支付宝交易凭证号',
  `order_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '服务器订单号',
  `out_biz_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户业务号',
  `trade_state` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '交易状态',
  `amount` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT '本次交易支付的订单金额，单位为人民币（元）',
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '订单标题',
  `body` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商品描述',
  `refund_fee` decimal(9,2) NOT NULL DEFAULT '0.00' COMMENT '退款通知中，返回总退款金额，单位为元，支持两位小数',
  `trade_create_time` timestamp NULL DEFAULT NULL COMMENT '交易创建时间',
  `pay_time` timestamp NULL DEFAULT NULL COMMENT '交易付款时间',
  `trade_close_time` timestamp NULL DEFAULT NULL COMMENT '交易结束时间',
  `channel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '支付渠道',
  `return_param` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '参数：多个以_param_分隔',
  `other` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'json 信息',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `alipay_notifies_order_no_index` (`order_no`),
  KEY `alipay_notifies_transaction_id_index` (`transaction_id`),
  KEY `alipay_notifies_amount_index` (`amount`),
  KEY `alipay_notifies_trade_state_index` (`trade_state`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of alipay_notifies
-- ----------------------------

-- ----------------------------
-- Table structure for api_messages
-- ----------------------------
DROP TABLE IF EXISTS `api_messages`;
CREATE TABLE `api_messages` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL DEFAULT '0' COMMENT '哪个管理员发的消息',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '发给哪个用户的消息,0为所有管理员',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `content` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '跳转url',
  `status` enum('U','R') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'U' COMMENT '消息状态',
  `type` enum('SY') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'SY',
  `is_alert_at_home` enum('F','T') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '是否在首页弹出提示框，已读后就不再弹出',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `api_messages_status_index` (`status`),
  KEY `api_messages_type_index` (`type`),
  KEY `api_messages_user_id_index` (`user_id`),
  KEY `api_messages_is_alert_at_home_index` (`is_alert_at_home`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of api_messages
-- ----------------------------

-- ----------------------------
-- Table structure for app_versions
-- ----------------------------
DROP TABLE IF EXISTS `app_versions`;
CREATE TABLE `app_versions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `port` enum('A') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'A' COMMENT '留置有多个 app 的情况',
  `system` enum('ANDROID','IOS','ALL') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'ANDROID',
  `version_sn` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1.0.0',
  `version_intro` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `package` int(11) NOT NULL DEFAULT '0' COMMENT '对应的包',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `app_versions_system_index` (`system`),
  KEY `app_versions_version_sn_index` (`version_sn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of app_versions
-- ----------------------------

-- ----------------------------
-- Table structure for areas
-- ----------------------------
DROP TABLE IF EXISTS `areas`;
CREATE TABLE `areas` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `areaid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `area` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `cityid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `areas_cityid_index` (`cityid`),
  KEY `areas_area_index` (`area`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of areas
-- ----------------------------

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '文章标题',
  `slug` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'slug',
  `keywords` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '关键词,以英文逗号隔开',
  `descriptions` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `cover_image` int(11) NOT NULL DEFAULT '0' COMMENT '封面图片',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '内容',
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '作者 id',
  `category_id` int(11) NOT NULL DEFAULT '0' COMMENT '分类 id',
  `view_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '查看数量',
  `vote_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '点赞数量',
  `comment_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '评论数量',
  `collection_count` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '收藏数量',
  `enable` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '启用状态：F禁用，T启用',
  `recommend` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '是否推荐到首页',
  `top` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '是否置顶',
  `weight` int(11) NOT NULL DEFAULT '20' COMMENT '权重',
  `access_type` enum('PUB','PRI','PWD') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'PUB' COMMENT '访问权限类型：公开、私密、密码访问',
  `access_value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '访问权限值：PUB->不公开的用户ids,PRI->公开的用户ids,PWD->访问密码',
  `created_year` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '创建年：2018',
  `created_month` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '01',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `articles_weight_index` (`weight`),
  KEY `articles_category_id_index` (`category_id`),
  KEY `articles_user_id_index` (`user_id`),
  KEY `articles_created_year_index` (`created_year`),
  KEY `articles_created_month_index` (`created_month`),
  KEY `articles_access_type_index` (`access_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of articles
-- ----------------------------

-- ----------------------------
-- Table structure for attachments
-- ----------------------------
DROP TABLE IF EXISTS `attachments`;
CREATE TABLE `attachments` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0' COMMENT '上传用户 id',
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '附件上传者 ip',
  `original_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '原始名称',
  `mime_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'mime 类型',
  `size` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '0' COMMENT '大小/kb',
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'tmp' COMMENT '类型',
  `storage_position` enum('oss','local','api_local','api_oss') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'local' COMMENT '存储位置',
  `domain` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '域名地址,https://jiayouhaoshi.com',
  `storage_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '附件相对 storage 目录,app/public/images/avatars',
  `link_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '附件相对网站根目录,访问路径：storage/images/avatars',
  `storage_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '存储名称',
  `enable` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'T' COMMENT '启用状态：F禁用，T启用',
  `use_status` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '使用状态：F临时图片，T使用中',
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '附件备注',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attachments_user_id_index` (`user_id`),
  KEY `attachments_use_status_index` (`use_status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of attachments
-- ----------------------------

-- ----------------------------
-- Table structure for carousels
-- ----------------------------
DROP TABLE IF EXISTS `carousels`;
CREATE TABLE `carousels` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cover_image` int(11) NOT NULL DEFAULT '0',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `weight` int(11) NOT NULL DEFAULT '10',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of carousels
-- ----------------------------

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '分类名称',
  `cover_image` int(11) NOT NULL DEFAULT '0' COMMENT '封面图片',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '描述',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_cover_image_index` (`cover_image`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of categories
-- ----------------------------

-- ----------------------------
-- Table structure for cities
-- ----------------------------
DROP TABLE IF EXISTS `cities`;
CREATE TABLE `cities` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `cityid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `provinceid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `cities_provinceid_index` (`provinceid`),
  KEY `cities_city_index` (`city`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of cities
-- ----------------------------

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------

-- ----------------------------
-- Table structure for ip_filters
-- ----------------------------
DROP TABLE IF EXISTS `ip_filters`;
CREATE TABLE `ip_filters` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `type` enum('white','black') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'white' COMMENT '类型',
  `ip` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `ip_filters_ip_unique` (`ip`),
  KEY `ip_filters_type_index` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of ip_filters
-- ----------------------------

-- ----------------------------
-- Table structure for logs
-- ----------------------------
DROP TABLE IF EXISTS `logs`;
CREATE TABLE `logs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `type` enum('C','U','R','D','L','O') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'O' COMMENT '日志所属操作类型:模型 CURD 操作,后台登录,其它操作',
  `table_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '表名：articles',
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'IP',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '日志内容,json_encode([data=>insert into ... ,message=>添加数据)',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `logs_user_id_index` (`user_id`),
  KEY `logs_type_index` (`type`),
  KEY `logs_table_name_index` (`table_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of logs
-- ----------------------------

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of migrations
-- ----------------------------
INSERT INTO `migrations` VALUES ('1', '2014_10_12_100000_create_password_resets_table', '1');
INSERT INTO `migrations` VALUES ('2', '2016_06_01_000001_create_oauth_auth_codes_table', '1');
INSERT INTO `migrations` VALUES ('3', '2016_06_01_000002_create_oauth_access_tokens_table', '1');
INSERT INTO `migrations` VALUES ('4', '2016_06_01_000003_create_oauth_refresh_tokens_table', '1');
INSERT INTO `migrations` VALUES ('5', '2016_06_01_000004_create_oauth_clients_table', '1');
INSERT INTO `migrations` VALUES ('6', '2016_06_01_000005_create_oauth_personal_access_clients_table', '1');
INSERT INTO `migrations` VALUES ('7', '2018_06_19_100726_create_permission_tables', '1');
INSERT INTO `migrations` VALUES ('8', '2018_06_19_104740_seed_roles_and_permissions_data', '1');
INSERT INTO `migrations` VALUES ('9', '2018_06_25_044857_oauth_access_token_providers', '1');
INSERT INTO `migrations` VALUES ('10', '2018_06_28_155337_create_failed_jobs_table', '1');
INSERT INTO `migrations` VALUES ('11', '2018_07_07_112147_create_users_table', '1');
INSERT INTO `migrations` VALUES ('12', '2018_07_07_123102_create_admin_users_table', '1');
INSERT INTO `migrations` VALUES ('13', '2018_07_07_123220_create_attachments_table', '1');
INSERT INTO `migrations` VALUES ('14', '2018_07_07_124609_add_description_to_roles_table', '1');
INSERT INTO `migrations` VALUES ('15', '2018_07_07_124746_add_description_to_permissions_table', '1');
INSERT INTO `migrations` VALUES ('16', '2018_07_07_124856_create_advertisement_positions_table', '1');
INSERT INTO `migrations` VALUES ('17', '2018_07_07_125225_create_advertisements_table', '1');
INSERT INTO `migrations` VALUES ('18', '2018_07_07_130107_create_categories_table', '1');
INSERT INTO `migrations` VALUES ('19', '2018_07_07_130328_create_tags_table', '1');
INSERT INTO `migrations` VALUES ('20', '2018_07_07_130428_create_model_has_tags_table', '1');
INSERT INTO `migrations` VALUES ('21', '2018_07_07_134918_create_articles_table', '1');
INSERT INTO `migrations` VALUES ('22', '2018_07_07_141918_create_logs_table', '1');
INSERT INTO `migrations` VALUES ('23', '2018_07_07_142556_create_ip_filters_table', '1');
INSERT INTO `migrations` VALUES ('24', '2018_07_17_090002_add_phone_to_users_table', '1');
INSERT INTO `migrations` VALUES ('25', '2018_07_31_142658_create_smses_table', '1');
INSERT INTO `migrations` VALUES ('26', '2018_08_23_114057_create_provinces_table', '1');
INSERT INTO `migrations` VALUES ('27', '2018_08_23_114113_create_cities_table', '1');
INSERT INTO `migrations` VALUES ('28', '2018_08_23_114153_create_areas_table', '1');
INSERT INTO `migrations` VALUES ('29', '2018_08_25_114220_create_alipay_notifies_table', '1');
INSERT INTO `migrations` VALUES ('30', '2018_08_25_114241_create_weixinpay_notifies_table', '1');
INSERT INTO `migrations` VALUES ('31', '2018_08_27_101831_create_pay_notify_raws_table', '1');
INSERT INTO `migrations` VALUES ('32', '2018_08_29_185221_create_system_versions_table', '1');
INSERT INTO `migrations` VALUES ('33', '2018_08_31_192337_create_system_configs_table', '1');
INSERT INTO `migrations` VALUES ('34', '2018_09_25_144618_create_admin_messages_table', '1');
INSERT INTO `migrations` VALUES ('35', '2018_09_25_144632_create_api_messages_table', '1');
INSERT INTO `migrations` VALUES ('36', '2018_09_27_180209_create_carousels_table', '1');
INSERT INTO `migrations` VALUES ('37', '2018_09_28_103501_create_mobile_connect_user_lists_table', '1');
INSERT INTO `migrations` VALUES ('38', '2018_10_02_093825_create_app_versions_table', '1');

-- ----------------------------
-- Table structure for mobile_connect_user_lists
-- ----------------------------
DROP TABLE IF EXISTS `mobile_connect_user_lists`;
CREATE TABLE `mobile_connect_user_lists` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL DEFAULT '0',
  `register_id` int(11) NOT NULL DEFAULT '0' COMMENT '大于0表示已经注册过了',
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `last_invited_at` int(11) NOT NULL DEFAULT '0' COMMENT '最近一次邀请时间,时间戳',
  `first_alpha` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户姓名的拼音的第一个字母，用于筛选',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mobile_connect_user_lists_user_id_index` (`user_id`),
  KEY `mobile_connect_user_lists_register_id_index` (`register_id`),
  KEY `mobile_connect_user_lists_phone_index` (`phone`),
  KEY `mobile_connect_user_lists_first_alpha_index` (`first_alpha`),
  KEY `mobile_connect_user_lists_last_invited_at_index` (`last_invited_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of mobile_connect_user_lists
-- ----------------------------

-- ----------------------------
-- Table structure for model_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `model_id` int(10) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of model_has_permissions
-- ----------------------------

-- ----------------------------
-- Table structure for model_has_roles
-- ----------------------------
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` int(10) unsigned NOT NULL,
  `model_id` int(10) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  KEY `model_has_roles_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of model_has_roles
-- ----------------------------
INSERT INTO `model_has_roles` VALUES ('1', '1', 'App\\Models\\User');

-- ----------------------------
-- Table structure for model_has_tags
-- ----------------------------
DROP TABLE IF EXISTS `model_has_tags`;
CREATE TABLE `model_has_tags` (
  `tag_id` int(10) unsigned NOT NULL,
  `model_id` int(10) unsigned NOT NULL,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`tag_id`,`model_type`,`model_id`),
  KEY `model_has_tags_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_tags_tag_id_foreign` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of model_has_tags
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_access_token_providers
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_token_providers`;
CREATE TABLE `oauth_access_token_providers` (
  `oauth_access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `provider` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`oauth_access_token_id`),
  CONSTRAINT `oauth_access_token_providers_oauth_access_token_id_foreign` FOREIGN KEY (`oauth_access_token_id`) REFERENCES `oauth_access_tokens` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_access_token_providers
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `client_id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_access_tokens
-- ----------------------------
INSERT INTO `oauth_access_tokens` VALUES ('0152bc50223ee5841ba0c43f273d3f513752db1cfd7afbea199396a8a423b7e2715a134feb93e98c', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:07:35', '2018-11-05 13:07:35', '2018-11-08 13:07:35');
INSERT INTO `oauth_access_tokens` VALUES ('324a27da4500bfaf16192e3844c576dac2b4bb1d8dbc59d773494ea5ee59a085dc247aac243a2a5e', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:29:36', '2018-11-05 13:29:36', '2018-11-08 13:29:35');
INSERT INTO `oauth_access_tokens` VALUES ('37b4ab7b2d302f01229175d6c78f5d61b9db96158fa5fcda4ed432a3988d55e04e77402c3c96e428', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:39:16', '2018-11-05 13:39:16', '2018-11-08 13:39:16');
INSERT INTO `oauth_access_tokens` VALUES ('44d8334e79b5ec91e0b847c1b40c076a4ab668bde8903687bd4616e3daf9dea5b0456cf14f4970ba', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:34:28', '2018-11-05 13:34:28', '2018-11-08 13:34:28');
INSERT INTO `oauth_access_tokens` VALUES ('4fb7eee178397af11f0966b2397c64753932438d8c2fea0191d19d1f4b890a9346f38bba16b6d61b', '1', '2', null, '[\"*\"]', '0', '2018-11-05 17:02:33', '2018-11-05 17:02:33', '2018-11-08 17:02:33');
INSERT INTO `oauth_access_tokens` VALUES ('5bdb9ccfed65ad8389a056876b72ff251f28d6c2025902a31135805365f962860f1b2332deed16ee', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:01:36', '2018-11-05 13:01:36', '2018-11-08 13:01:35');
INSERT INTO `oauth_access_tokens` VALUES ('61e6aadd4e96feda602135a7c89fc1fdb35e518656ed8fcb0e7a77ec12d4b2b590712d51f1cff46c', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:49:48', '2018-11-05 13:49:48', '2018-11-08 13:49:48');
INSERT INTO `oauth_access_tokens` VALUES ('64f83a2df6f00cae89af5b23b41fc86307fd13da9f21be8c24e38ced4cb0f4829c0f8ed4af683715', '6', '2', null, '[\"*\"]', '0', '2018-11-05 14:16:01', '2018-11-05 14:16:01', '2018-11-08 14:16:01');
INSERT INTO `oauth_access_tokens` VALUES ('7f6b924c74ad401a435cb10c6758bc5c9545a587f760a09552983da0c3d7378e3c662132d07b408e', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:12:57', '2018-11-05 13:12:57', '2018-11-08 13:12:57');
INSERT INTO `oauth_access_tokens` VALUES ('85b4c90d53f6848c75eea00b10f31b2113ef047748b527b9176c1225edef975f5447ff58c4600e01', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:34:15', '2018-11-05 13:34:15', '2018-11-08 13:34:15');
INSERT INTO `oauth_access_tokens` VALUES ('9f8f9d087a2c2348e408156772615ad564f4f2a372dc02132fae756a99a129f68c9e1b30e5090c2a', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:01:11', '2018-11-05 13:01:11', '2018-11-08 13:01:10');
INSERT INTO `oauth_access_tokens` VALUES ('dfe248084135b2460013a6be4fbdde30d4d4702727279bf5647c7c36f8d99e9f73af0a1b9931b9a0', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:15:29', '2018-11-05 13:15:29', '2018-11-08 13:15:29');
INSERT INTO `oauth_access_tokens` VALUES ('e538040bb0d0f1d368dc66539365ecdc2a82762a5ac65855cac95fb1698bff862a254cd69fa719e9', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:13:45', '2018-11-05 13:13:45', '2018-11-08 13:13:45');
INSERT INTO `oauth_access_tokens` VALUES ('f65049ad504db31be45f146f52bfb547691eccf746f603e41a67d3812151792c6841b738495a0b23', '1', '2', null, '[\"*\"]', '0', '2018-11-05 13:13:22', '2018-11-05 13:13:22', '2018-11-08 13:13:22');

-- ----------------------------
-- Table structure for oauth_auth_codes
-- ----------------------------
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `client_id` int(11) NOT NULL,
  `scopes` text COLLATE utf8mb4_unicode_ci,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_auth_codes
-- ----------------------------

-- ----------------------------
-- Table structure for oauth_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `redirect` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_clients
-- ----------------------------
INSERT INTO `oauth_clients` VALUES ('1', null, 'Lucms Personal Access Client', 'cmkZMzp1JB1x1cjEGKPhTNnlJmMYTQyAu80ryDq4', 'http://localhost', '1', '0', '0', '2018-11-05 10:50:18', '2018-11-05 10:50:18');
INSERT INTO `oauth_clients` VALUES ('2', null, 'Lucms Password Grant Client', 'YXlfDVRPWqCDD01i78Obncb6Sq5YWlNr6jkjcSoH', 'http://localhost', '0', '1', '0', '2018-11-05 10:50:18', '2018-11-05 10:50:18');

-- ----------------------------
-- Table structure for oauth_personal_access_clients
-- ----------------------------
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_personal_access_clients_client_id_index` (`client_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_personal_access_clients
-- ----------------------------
INSERT INTO `oauth_personal_access_clients` VALUES ('1', '1', '2018-11-05 10:50:18', '2018-11-05 10:50:18');

-- ----------------------------
-- Table structure for oauth_refresh_tokens
-- ----------------------------
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `access_token_id` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of oauth_refresh_tokens
-- ----------------------------
INSERT INTO `oauth_refresh_tokens` VALUES ('095dfa4a31145119cfa60987395e43dd426fbb762ca84f34f850baf123d627dde13a16ff278e2a6d', '44d8334e79b5ec91e0b847c1b40c076a4ab668bde8903687bd4616e3daf9dea5b0456cf14f4970ba', '0', '2018-11-08 13:34:28');
INSERT INTO `oauth_refresh_tokens` VALUES ('33bdfcb4a416979d878d3e7efb42c8deea3e85b3f870f79df73a552ef7f1e50fbf530677c68d5604', '37b4ab7b2d302f01229175d6c78f5d61b9db96158fa5fcda4ed432a3988d55e04e77402c3c96e428', '0', '2018-11-08 13:39:16');
INSERT INTO `oauth_refresh_tokens` VALUES ('34234b2b902de0cc9e58fd92137a5c9a618cb034a851e295e318722f9424db8d327cc3ecdf74caea', '5bdb9ccfed65ad8389a056876b72ff251f28d6c2025902a31135805365f962860f1b2332deed16ee', '0', '2018-11-08 13:01:35');
INSERT INTO `oauth_refresh_tokens` VALUES ('3aabb9caf7a913d59898aeac360331d18c0d102e3b582da96ddba0c61f378ba77263417611c4e5b3', 'e538040bb0d0f1d368dc66539365ecdc2a82762a5ac65855cac95fb1698bff862a254cd69fa719e9', '0', '2018-11-08 13:13:45');
INSERT INTO `oauth_refresh_tokens` VALUES ('4b75ff87ad82c0fea10f21ce510daa22f0dd22eee074d7c614fb7ee9afdf81e519b80e2a44174746', '324a27da4500bfaf16192e3844c576dac2b4bb1d8dbc59d773494ea5ee59a085dc247aac243a2a5e', '0', '2018-11-08 13:29:36');
INSERT INTO `oauth_refresh_tokens` VALUES ('5da00023200096867b13c2ccaf901e7bbf4cdcb9f54b88508fabd1359ec35cb3b952385921637633', '7f6b924c74ad401a435cb10c6758bc5c9545a587f760a09552983da0c3d7378e3c662132d07b408e', '0', '2018-11-08 13:12:57');
INSERT INTO `oauth_refresh_tokens` VALUES ('60a8d165567b8faf58a8d54560160500ab6ec2f9744fe3a813935972f7c04e3186374bd00a1fa84a', '85b4c90d53f6848c75eea00b10f31b2113ef047748b527b9176c1225edef975f5447ff58c4600e01', '0', '2018-11-08 13:34:15');
INSERT INTO `oauth_refresh_tokens` VALUES ('6d29046340d8a4664011499e7bd129ce6274818eea1c19ffe33190f29402531446fe7d29b371db09', '4fb7eee178397af11f0966b2397c64753932438d8c2fea0191d19d1f4b890a9346f38bba16b6d61b', '0', '2018-11-08 17:02:33');
INSERT INTO `oauth_refresh_tokens` VALUES ('977ca8368c01f23f3589e42bff05eac75c0d063e91c50b4d8179bc2ee26af00a3f782987347a6f10', 'dfe248084135b2460013a6be4fbdde30d4d4702727279bf5647c7c36f8d99e9f73af0a1b9931b9a0', '0', '2018-11-08 13:15:29');
INSERT INTO `oauth_refresh_tokens` VALUES ('986bd102f81e9cc021cd63aef383845f2e61befbf89da49838f14d5d104a2739b0e061af1ff4832c', '64f83a2df6f00cae89af5b23b41fc86307fd13da9f21be8c24e38ced4cb0f4829c0f8ed4af683715', '0', '2018-11-08 14:16:01');
INSERT INTO `oauth_refresh_tokens` VALUES ('b4757ed912deeb8a08ea350a54bf33ab53a04582d474bfd89a71312eaed2d353230de0a704f7ae89', '61e6aadd4e96feda602135a7c89fc1fdb35e518656ed8fcb0e7a77ec12d4b2b590712d51f1cff46c', '0', '2018-11-08 13:49:48');
INSERT INTO `oauth_refresh_tokens` VALUES ('cdf6934d67a68f17d072473db428ca289e2cb6fde75ab9644ed07136971ae4811de19cf42a4f611b', '0152bc50223ee5841ba0c43f273d3f513752db1cfd7afbea199396a8a423b7e2715a134feb93e98c', '0', '2018-11-08 13:07:35');
INSERT INTO `oauth_refresh_tokens` VALUES ('cf89409d54a7ba824faa76079e8f77e9d156c27b061c96f2fe5eba110eed4e1721b6838ffa6e2abd', 'f65049ad504db31be45f146f52bfb547691eccf746f603e41a67d3812151792c6841b738495a0b23', '0', '2018-11-08 13:13:22');
INSERT INTO `oauth_refresh_tokens` VALUES ('d14f888cf0439eb6f58506066e62e83c399fced59d05455c1d128245e83fc76a218cf54d33b29107', '9f8f9d087a2c2348e408156772615ad564f4f2a372dc02132fae756a99a129f68c9e1b30e5090c2a', '0', '2018-11-08 13:01:10');

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of password_resets
-- ----------------------------

-- ----------------------------
-- Table structure for pay_notify_raws
-- ----------------------------
DROP TABLE IF EXISTS `pay_notify_raws`;
CREATE TABLE `pay_notify_raws` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `model_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'undefined' COMMENT '订单类型:一般写表名称:users',
  `raw` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of pay_notify_raws
-- ----------------------------

-- ----------------------------
-- Table structure for permissions
-- ----------------------------
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of permissions
-- ----------------------------
INSERT INTO `permissions` VALUES ('1', 'manage_contents', 'web', '2018-11-05 10:49:33', '2018-11-05 10:49:33', '');
INSERT INTO `permissions` VALUES ('2', 'manage_users', 'web', '2018-11-05 10:49:33', '2018-11-05 10:49:33', '');
INSERT INTO `permissions` VALUES ('3', 'edit_settings', 'web', '2018-11-05 10:49:33', '2018-11-05 10:49:33', '');

-- ----------------------------
-- Table structure for provinces
-- ----------------------------
DROP TABLE IF EXISTS `provinces`;
CREATE TABLE `provinces` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `provinceid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `province` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `provinces_provinceid_index` (`provinceid`),
  KEY `provinces_province_index` (`province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of provinces
-- ----------------------------

-- ----------------------------
-- Table structure for role_has_permissions
-- ----------------------------
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` int(10) unsigned NOT NULL,
  `role_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of role_has_permissions
-- ----------------------------
INSERT INTO `role_has_permissions` VALUES ('1', '1');
INSERT INTO `role_has_permissions` VALUES ('2', '1');
INSERT INTO `role_has_permissions` VALUES ('3', '1');
INSERT INTO `role_has_permissions` VALUES ('1', '2');

-- ----------------------------
-- Table structure for roles
-- ----------------------------
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `guard_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '说明',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of roles
-- ----------------------------
INSERT INTO `roles` VALUES ('1', 'Founder', 'web', '2018-11-05 10:49:33', '2018-11-05 10:49:33', '');
INSERT INTO `roles` VALUES ('2', 'Maintainer', 'web', '2018-11-05 10:49:33', '2018-11-05 10:49:33', '');

-- ----------------------------
-- Table structure for sms
-- ----------------------------
DROP TABLE IF EXISTS `sms`;
CREATE TABLE `sms` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'O',
  `code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ip` varchar(45) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_phone_index` (`phone`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of sms
-- ----------------------------

-- ----------------------------
-- Table structure for system_configs
-- ----------------------------
DROP TABLE IF EXISTS `system_configs`;
CREATE TABLE `system_configs` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `flag` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置英文标识',
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置标题',
  `system_config_group` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'basic' COMMENT '配置分组',
  `value` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置值',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '配置描述',
  `weight` int(11) NOT NULL DEFAULT '10',
  `enable` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'T',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `system_configs_system_config_group_index` (`system_config_group`),
  KEY `system_configs_enable_index` (`enable`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of system_configs
-- ----------------------------
INSERT INTO `system_configs` VALUES ('1', 'test', '测试配置项', 'test_group', '20000', '测试配置项', '10', 'T', '2018-11-05 10:49:47', '2018-11-05 10:49:47');

-- ----------------------------
-- Table structure for system_versions
-- ----------------------------
DROP TABLE IF EXISTS `system_versions`;
CREATE TABLE `system_versions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `version` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '1.0.0',
  `content` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `download_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of system_versions
-- ----------------------------

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '名称',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of tags
-- ----------------------------

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `enable` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '启用状态：F禁用，T启用',
  `is_admin` enum('T','F') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'F' COMMENT '是否可登录后台：F否，是',
  `description` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '一句话描述',
  `head_image` int(11) NOT NULL DEFAULT '0' COMMENT '头像',
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `last_login_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `phone` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '手机号',
  `weixin_openid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `mini_openid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '小程序 openid',
  `weixin_unionid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `weixin_session_key` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `weixin_head_image_path` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信头像路径',
  `country` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `province` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `city` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
  KEY `users_head_image_index` (`head_image`),
  KEY `users_phone_index` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES ('1', 'ucer', 'dev@lucms.com', '$2y$10$Kw2S8M/57wORHkxbpjChSu.5cJy7njR3gCNEIUHpap.S9QK4rwEWW', 'T', 'T', 'Ut est asperiores laborum commodi et odio itaque.', '0', 'WbdIUtFdTU', '2018-11-05 17:02:30', '2018-11-05 10:49:47', '2018-11-05 17:02:30', '', '', '', '', '', '', '', '', '');
INSERT INTO `users` VALUES ('6', 'test', 'test@email.com', '$2y$10$cn3uLHA1iKpjET/OVWJc/eyJcXUo4adC.VFaLdIEEEEFqhkiazKJm', 'T', 'T', '', '0', '', '2018-11-05 14:16:00', '2018-11-05 14:14:35', '2018-11-05 14:16:00', '', '', '', '', '', '', '', '', '');

-- ----------------------------
-- Table structure for weixinpay_notifies
-- ----------------------------
DROP TABLE IF EXISTS `weixinpay_notifies`;
CREATE TABLE `weixinpay_notifies` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `appid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信开放平台审核通过的应用APPID',
  `mch_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信支付分配的商户号',
  `device_info` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信支付分配的终端设备号，',
  `result_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'SUCCESS/FAIL',
  `err_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '错误返回的信息描述',
  `err_code_des` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '错误返回的信息描述',
  `openid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '用户在商户appid下的唯一标识',
  `trade_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT 'APP',
  `bank_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '银行类型，采用字符串类型的银行标识',
  `total_fee` int(11) NOT NULL DEFAULT '0' COMMENT '订单总金额，单位为分',
  `transaction_id` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '微信支付订单号',
  `out_trade_no` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商户系统内部订单号',
  `attach` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '' COMMENT '商家数据包，原样返回',
  `time_end` timestamp NULL DEFAULT NULL COMMENT '支付完成时间',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ----------------------------
-- Records of weixinpay_notifies
-- ----------------------------
