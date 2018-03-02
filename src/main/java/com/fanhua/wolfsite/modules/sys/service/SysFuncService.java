/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fanhua.wolfsite.common.persistence.Page;
import com.fanhua.wolfsite.common.service.CrudService;
import com.fanhua.wolfsite.modules.sys.entity.SysFunc;
import com.fanhua.wolfsite.modules.sys.dao.SysFuncDao;

/**
 * 功能按钮Service
 * @author huangdk
 * @version 2017-08-19
 */
@Service
@Transactional(readOnly = true)
public class SysFuncService extends CrudService<SysFuncDao, SysFunc> {

	public SysFunc get(String id) {
		return super.get(id);
	}
	
	public List<SysFunc> findList(SysFunc sysFunc) {
		return super.findList(sysFunc);
	}
	
	public Page<SysFunc> findPage(Page<SysFunc> page, SysFunc sysFunc) {
		return super.findPage(page, sysFunc);
	}
	
	@Transactional(readOnly = false)
	public void save(SysFunc sysFunc) {
		super.save(sysFunc);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysFunc sysFunc) {
		super.delete(sysFunc);
	}

	
}