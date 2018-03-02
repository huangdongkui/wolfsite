/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.oa.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fanhua.wolfsite.common.persistence.Page;
import com.fanhua.wolfsite.common.service.CrudService;
import com.fanhua.wolfsite.modules.oa.entity.BusiTools;
import com.fanhua.wolfsite.modules.oa.dao.BusiToolsDao;

/**
 * 工具申请Service
 * @author wolfhuang
 * @version 2017-12-15
 */
@Service
@Transactional(readOnly = true)
public class BusiToolsService extends CrudService<BusiToolsDao, BusiTools> {

	public BusiTools get(String id) {
		return super.get(id);
	}
	
	public List<BusiTools> findList(BusiTools busiTools) {
		return super.findList(busiTools);
	}
	
	public Page<BusiTools> findPage(Page<BusiTools> page, BusiTools busiTools) {
		return super.findPage(page, busiTools);
	}
	
	@Transactional(readOnly = false)
	public void save(BusiTools busiTools) {
		super.save(busiTools);
	}
	
	@Transactional(readOnly = false)
	public void delete(BusiTools busiTools) {
		super.delete(busiTools);
	}
	
}