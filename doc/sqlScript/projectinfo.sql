CREATE TABLE `project_info` (
  `id` varchar(36) COLLATE utf8_bin NOT NULL,
  `project_name` varchar(45) CHARACTER SET utf8 NOT NULL COMMENT '项目名称',
  `project_type` varchar(45) CHARACTER SET utf8 DEFAULT NULL COMMENT '项目类型',
  `project_source` varchar(45) CHARACTER SET utf8 DEFAULT NULL COMMENT '项目来源',
  `budget_amount` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '预算金额',
  `need_bid` char(3) COLLATE utf8_bin DEFAULT NULL COMMENT '是否投标',
  `plan_begin_datetime` date DEFAULT NULL COMMENT '预计开始日期',
  `client_name` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '委托方名称',
  `client_request_desc` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '委托方需求简述',
  `bid_info` varchar(45) COLLATE utf8_bin DEFAULT NULL COMMENT '招投标信息',
  `create_by` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '创建者',
  `create_date` datetime NOT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8 NOT NULL COMMENT '更新者',
  `update_date` datetime NOT NULL COMMENT '更新时间',
  `remarks` varchar(255) CHARACTER SET utf8 DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) CHARACTER SET utf8 NOT NULL DEFAULT '0' COMMENT '删除标记',
  `PROC_INS_ID` varchar(64) CHARACTER SET utf8 DEFAULT NULL COMMENT '流程实例ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='项目信息表';