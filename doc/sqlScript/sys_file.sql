CREATE TABLE `sys_file` (
  `id` varchar(36) CHARACTER SET utf8 NOT NULL COMMENT '主键',
  `file_name` varchar(200) CHARACTER SET utf8 DEFAULT NULL COMMENT '文件名',
  `file_path` varchar(1000) CHARACTER SET utf8 DEFAULT NULL COMMENT '路径',
  `file_size` int(11) DEFAULT NULL COMMENT '大小',
  `file_type` varchar(20) CHARACTER SET utf8 DEFAULT NULL COMMENT '文件扩展名',
  `bussiness_id` varchar(45) CHARACTER SET utf8 DEFAULT NULL COMMENT '业务表单主键',
  `create_by` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '删除标记',
  `bussnissType` varchar(45) CHARACTER SET utf8 DEFAULT NULL COMMENT '业务类别',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='文件表';
