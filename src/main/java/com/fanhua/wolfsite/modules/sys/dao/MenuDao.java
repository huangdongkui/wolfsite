/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.sys.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.fanhua.wolfsite.common.persistence.CrudDao;
import com.fanhua.wolfsite.common.persistence.annotation.MyBatisDao;
import com.fanhua.wolfsite.modules.sys.entity.Menu;

/**
 * 菜单DAO接口
 * @author fanhua
 * @version 2014-05-16
 */
@MyBatisDao
public interface MenuDao extends CrudDao<Menu> {

	public List<Menu> findByParentIdsLike(Menu menu);

	public List<Menu> findByUserId(Menu menu);
	
	public int updateParentIds(Menu menu);
	
	public int updateSort(Menu menu);
	
	public List<Menu> findByParentId(Menu menu);
	
	public List<Menu> findByParentIdWithPermit(@Param("parentId") String parentId,@Param("userId") String userId);
}
