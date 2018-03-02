
package com.fanhua.wolfsite.modules.sys.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fanhua.wolfsite.common.persistence.Page;
import com.fanhua.wolfsite.common.service.CrudService;
import com.fanhua.wolfsite.modules.sys.entity.SysFile;
import com.fanhua.wolfsite.modules.sys.dao.SysFileDao;

/**
 * 公共文件表Service
 * @author wolfhuang
 * @version 2017-11-05
 */
@Service
@Transactional(readOnly = true)
public class SysFileService extends CrudService<SysFileDao, SysFile> {

	public SysFile get(String id) {
		return super.get(id);
	}
	
	public List<SysFile> findList(SysFile sysFile) {
		return super.findList(sysFile);
	}
	
	public Page<SysFile> findPage(Page<SysFile> page, SysFile sysFile) {
		return super.findPage(page, sysFile);
	}
	
	@Transactional(readOnly = false)
	public void save(SysFile sysFile) {
		super.save(sysFile);
	}
	
	@Transactional(readOnly = false)
	public void delete(SysFile sysFile) {
		super.delete(sysFile);
	}
	
}