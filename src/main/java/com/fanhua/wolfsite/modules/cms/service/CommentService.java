/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.cms.service;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fanhua.wolfsite.common.persistence.Page;
import com.fanhua.wolfsite.common.service.CrudService;
import com.fanhua.wolfsite.modules.cms.dao.CommentDao;
import com.fanhua.wolfsite.modules.cms.entity.Comment;

/**
 * 评论Service
 * @author fanhua
 * @version 2013-01-15
 */
@Service
@Transactional(readOnly = true)
public class CommentService extends CrudService<CommentDao, Comment> {

	public Page<Comment> findPage(Page<Comment> page, Comment comment) {
//		DetachedCriteria dc = commentDao.createDetachedCriteria();
//		if (StringUtils.isNotBlank(comment.getContentId())){
//			dc.add(Restrictions.eq("contentId", comment.getContentId()));
//		}
//		if (StringUtils.isNotEmpty(comment.getTitle())){
//			dc.add(Restrictions.like("title", "%"+comment.getTitle()+"%"));
//		}
//		dc.add(Restrictions.eq(Comment.FIELD_DEL_FLAG, comment.getDelFlag()));
//		dc.addOrder(Order.desc("id"));
//		return commentDao.find(page, dc);
		comment.getSqlMap().put("dsf", dataScopeFilter(comment.getCurrentUser(), "o", "u"));
		
		return super.findPage(page, comment);
	}
	
	@Transactional(readOnly = false)
	public void delete(Comment entity, Boolean isRe) {
		super.delete(entity);
	}
}
