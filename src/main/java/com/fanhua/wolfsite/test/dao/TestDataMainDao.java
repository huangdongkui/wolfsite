/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.test.dao;

import com.fanhua.wolfsite.common.persistence.CrudDao;
import com.fanhua.wolfsite.common.persistence.annotation.MyBatisDao;
import com.fanhua.wolfsite.test.entity.TestDataMain;

/**
 * 主子表生成DAO接口
 * @author fanhua
 * @version 2015-04-06
 */
@MyBatisDao
public interface TestDataMainDao extends CrudDao<TestDataMain> {
	
}