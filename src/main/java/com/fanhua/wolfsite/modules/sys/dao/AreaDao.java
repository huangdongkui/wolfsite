/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.sys.dao;

import com.fanhua.wolfsite.common.persistence.TreeDao;
import com.fanhua.wolfsite.common.persistence.annotation.MyBatisDao;
import com.fanhua.wolfsite.modules.sys.entity.Area;

/**
 * 区域DAO接口
 * @author fanhua
 * @version 2014-05-16
 */
@MyBatisDao
public interface AreaDao extends TreeDao<Area> {
	
}
