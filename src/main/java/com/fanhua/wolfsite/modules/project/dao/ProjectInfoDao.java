/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.project.dao;

import com.fanhua.wolfsite.common.persistence.CrudDao;
import com.fanhua.wolfsite.common.persistence.annotation.MyBatisDao;
import com.fanhua.wolfsite.modules.project.entity.ProjectInfo;

/**
 * 项目信息DAO接口
 * @author wolfhuang
 * @version 2017-11-25
 */
@MyBatisDao
public interface ProjectInfoDao extends CrudDao<ProjectInfo> {
	
}