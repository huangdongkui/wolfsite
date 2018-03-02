/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.gen.dao;

import com.fanhua.wolfsite.common.persistence.CrudDao;
import com.fanhua.wolfsite.common.persistence.annotation.MyBatisDao;
import com.fanhua.wolfsite.modules.gen.entity.GenTableColumn;

/**
 * 业务表字段DAO接口
 * @author fanhua
 * @version 2013-10-15
 */
@MyBatisDao
public interface GenTableColumnDao extends CrudDao<GenTableColumn> {
	
	public void deleteByGenTableId(String genTableId);
}
