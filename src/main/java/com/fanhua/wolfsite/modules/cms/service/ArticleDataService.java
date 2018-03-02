/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.cms.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fanhua.wolfsite.common.service.CrudService;
import com.fanhua.wolfsite.modules.cms.dao.ArticleDataDao;
import com.fanhua.wolfsite.modules.cms.entity.ArticleData;

/**
 * 站点Service
 * @author fanhua
 * @version 2013-01-15
 */
@Service
@Transactional(readOnly = true)
public class ArticleDataService extends CrudService<ArticleDataDao, ArticleData> {

}
