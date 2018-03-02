CREATE TABLE `sys_func` (
	`id` VARCHAR(64) NOT NULL COMMENT '编号' COLLATE 'utf8_bin',
	`func_name` VARCHAR(100) NULL DEFAULT NULL COMMENT '功能名称' COLLATE 'utf8_bin',
	`func_jsmethod` VARCHAR(100) NULL DEFAULT NULL COMMENT 'JS方法名' COLLATE 'utf8_bin',
	`show_type` INT(11) NULL DEFAULT NULL COMMENT '显示位置',
	`icon` VARCHAR(100) NULL DEFAULT NULL COMMENT '图标' COLLATE 'utf8_bin',
	`create_by` VARCHAR(64) NOT NULL COMMENT '创建者' COLLATE 'utf8_bin',
	`create_date` DATETIME NOT NULL COMMENT '创建时间',
	`update_by` VARCHAR(64) NOT NULL COMMENT '更新者' COLLATE 'utf8_bin',
	`update_date` DATETIME NOT NULL COMMENT '更新时间',
	`remarks` VARCHAR(255) NULL DEFAULT NULL COMMENT '备注信息' COLLATE 'utf8_bin',
	`del_flag` CHAR(1) NOT NULL DEFAULT '0' COMMENT '删除标记' COLLATE 'utf8_bin',
	PRIMARY KEY (`id`),
	INDEX `sys_func_del_flag` (`del_flag`)
)
COMMENT='功能表'
COLLATE='utf8_bin'
ENGINE=InnoDB
;
