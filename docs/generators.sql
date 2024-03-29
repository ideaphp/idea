CREATE DATABASE IF NOT EXISTS `generators`;

USE `generators`;

/*
单行文本（text）
多行文本（textarea）
密码（password）
隐藏文本（hidden）
HTML文本（ckeditor）
时间控件（datetime）
上传文件（file）
单选下拉框（select）
单选选项卡（radio）
开关选项卡（switch）
多选选项卡（checkbox）
提交按钮（submit）
重置按钮（reset）
普通按钮（button）
*/

DROP TABLE IF EXISTS `generators`;
CREATE TABLE `generators` (
  `generator_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `generator_name` varchar(100) NOT NULL DEFAULT '' COMMENT '生成代码名',
  `tbl_name` varchar(100) NOT NULL DEFAULT '' COMMENT '表名',
  `tbl_profile` enum('y','n') NOT NULL DEFAULT 'n' COMMENT '是否生成扩展表',
  `tbl_engine` enum('MyISAM','InnoDB') NOT NULL DEFAULT 'InnoDB' COMMENT '表引擎',
  `tbl_charset` enum('utf8','gbk','gb2312') NOT NULL DEFAULT 'utf8' COMMENT '表编码',
  `tbl_comment` varchar(200) NOT NULL DEFAULT '' COMMENT '表描述',
  `app_name` varchar(100) NOT NULL DEFAULT '' COMMENT '应用名',
  `mod_name` varchar(100) NOT NULL DEFAULT '' COMMENT '模块名',
  `ctrl_name` varchar(100) NOT NULL DEFAULT '' COMMENT '控制器名，默认和表名相同',
  `act_index_name` varchar(100) NOT NULL DEFAULT 'index' COMMENT '行动名-数据列表',
  `act_view_name` varchar(100) NOT NULL DEFAULT 'view' COMMENT '行动名-数据详情',
  `act_create_name` varchar(100) NOT NULL DEFAULT 'create' COMMENT '行动名-新增数据',
  `act_modify_name` varchar(100) NOT NULL DEFAULT 'modify' COMMENT '行动名-更新数据',
  `act_remove_name` varchar(100) NOT NULL DEFAULT 'remove' COMMENT '行动名-删除数据',
  `description` text COMMENT '描述',
  `creator_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '创建人ID',
  `dt_created` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '创建时间',
  `modifier_id` bigint(20) unsigned NOT NULL DEFAULT '0' COMMENT '上次更新人ID',
  `dt_modified` datetime NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '上次更新时间',
  `trash` enum('y','n') NOT NULL DEFAULT 'n' COMMENT '是否删除',
  PRIMARY KEY (`generator_id`),
  KEY `generator_name` (`generator_name`),
  KEY `tbl_name` (`tbl_name`),
  KEY `tbl_profile` (`tbl_profile`),
  KEY `tbl_engine` (`tbl_engine`),
  KEY `tbl_charset` (`tbl_charset`),
  KEY `app_mod_ctrl` (`app_name`,`mod_name`,`ctrl_name`),
  KEY `creator_id` (`creator_id`),
  KEY `trash` (`trash`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='生成代码表';

DROP TABLE IF EXISTS `generator_field_groups`;
CREATE TABLE `generator_field_groups` (
  `group_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_name` varchar(100) NOT NULL DEFAULT '' COMMENT '组名',
  `generator_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '生成代码ID',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  `description` text COMMENT '描述',
  PRIMARY KEY (`group_id`),
  KEY `group_name` (`group_name`),
  KEY `generator_id` (`generator_id`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表单字段组表';

DROP TABLE IF EXISTS `generator_field_types`;
CREATE TABLE `generator_field_types` (
  `type_id` smallint(5) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `type_name` varchar(100) NOT NULL DEFAULT '' COMMENT '类型名，单行文本、多行文本、密码、开关选项卡、提交按钮等',
  `form_type` varchar(100) NOT NULL DEFAULT '' COMMENT '表单类型名，HTML：text、password、button、radio等；用户自定义：ckeditor、datetime等',
  `field_type` varchar(100) NOT NULL DEFAULT '' COMMENT '表字段类型，INT、VARCHAR、CHAR、TEXT等',
  `category` enum('text','option','button') NOT NULL DEFAULT 'text' COMMENT '所属分类，text：文本类、option：选项类、button：按钮类',
  PRIMARY KEY (`type_id`),
  KEY `group_name` (`type_name`),
  KEY `category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表单字段类型表';

DROP TABLE IF EXISTS `generator_fields`;
CREATE TABLE `generator_fields` (
  `field_id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `field_name` varchar(100) NOT NULL DEFAULT '' COMMENT '字段名',
  `field_pid` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '父ID',
  `group_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '组ID',
  `label` varchar(100) NOT NULL DEFAULT '' COMMENT '表头和表单显示名',
  `type_id` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '表单字段类型ID',
  `field_length` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '表字段长度',
  `form_prompt` varchar(200) NOT NULL DEFAULT '' COMMENT '表单提示',
  `required` enum('y','n') NOT NULL DEFAULT 'n' COMMENT '是否必填',
  `search` enum('y','n') NOT NULL DEFAULT 'n' COMMENT '是否用于查询',
  `form_disabled` enum('y','n') NOT NULL DEFAULT 'n' COMMENT '字段内容是否可以编辑',
  `index_show` enum('y','n') NOT NULL DEFAULT 'n' COMMENT '是否在列表中展示',
  `index_sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '列表中排序',
  `form_create_show` enum('y','n') NOT NULL DEFAULT 'n' COMMENT '是否在新增表单中展示',
  `form_create_sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '在新增表单中排序',
  `form_modify_show` enum('y','n') NOT NULL DEFAULT 'n' COMMENT '是否在更新表单中展示',
  `form_modify_sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '在更新表单中排序',
  PRIMARY KEY (`field_id`),
  KEY `field_name` (`field_name`),
  KEY `group_id` (`group_id`),
  KEY `type_id` (`type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表单字段表';

DROP TABLE IF EXISTS `generator_field_validators`;
CREATE TABLE `generator_field_validators` (
  `validator_id` bigint(20) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `validator_name` varchar(100) NOT NULL DEFAULT '' COMMENT '验证类名',
  `field_id` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '表单字段ID',
  `options` varchar(100) NOT NULL DEFAULT '' COMMENT '验证时对比值，可以是布尔类型、整型、字符型、数组序列化',
  `option_category` enum('boolean','integer','string','array') NOT NULL DEFAULT 'boolean' COMMENT '验证时对比值分类',
  `message` varchar(100) NOT NULL DEFAULT '' COMMENT '出错提示消息',
  `sort` smallint(5) unsigned NOT NULL DEFAULT '0' COMMENT '排序',
  PRIMARY KEY (`validator_id`),
  KEY `validator_name` (`validator_name`),
  KEY `field_id` (`field_id`),
  KEY `sort` (`sort`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='表单字段验证表';
