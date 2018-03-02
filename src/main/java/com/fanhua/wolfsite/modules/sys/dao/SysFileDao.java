
package com.fanhua.wolfsite.modules.sys.dao;

import com.fanhua.wolfsite.common.persistence.CrudDao;
import com.fanhua.wolfsite.common.persistence.annotation.MyBatisDao;
import com.fanhua.wolfsite.modules.sys.entity.SysFile;

/**
 * 公共文件表DAO接口
 * @author wolfhuang
 * @version 2017-11-05
 */
@MyBatisDao
public interface SysFileDao extends CrudDao<SysFile> {
	
}