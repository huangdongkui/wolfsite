/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.test.dao;

import com.fanhua.wolfsite.common.persistence.CrudDao;
import com.fanhua.wolfsite.common.persistence.annotation.MyBatisDao;
import com.fanhua.wolfsite.modules.test.entity.Test;

/**
 * 测试DAO接口
 * @author fanhua
 * @version 2013-10-17
 */
@MyBatisDao
public interface TestDao extends CrudDao<Test> {
	
}
