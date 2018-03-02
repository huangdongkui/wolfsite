/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.sys.dao;

import com.fanhua.wolfsite.common.persistence.CrudDao;
import com.fanhua.wolfsite.common.persistence.annotation.MyBatisDao;
import com.fanhua.wolfsite.modules.sys.entity.SysFunc;

/**
 * 功能按钮DAO接口
 * @author huangdk
 * @version 2017-08-19
 */
@MyBatisDao
public interface SysFuncDao extends CrudDao<SysFunc> {
	
}