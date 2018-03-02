/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.oa.dao;

import com.fanhua.wolfsite.common.persistence.CrudDao;
import com.fanhua.wolfsite.common.persistence.annotation.MyBatisDao;
import com.fanhua.wolfsite.modules.oa.entity.BusiTools;

/**
 * 工具申请DAO接口
 * @author wolfhuang
 * @version 2017-12-15
 */
@MyBatisDao
public interface BusiToolsDao extends CrudDao<BusiTools> {
	
}