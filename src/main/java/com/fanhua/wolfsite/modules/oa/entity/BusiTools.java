/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.oa.entity;

import org.hibernate.validator.constraints.Length;

import com.fanhua.wolfsite.common.persistence.ActEntity;
import com.fanhua.wolfsite.common.persistence.DataEntity;

/**
 * 工具申请Entity
 * @author wolfhuang
 * @version 2017-12-15
 */
public class BusiTools extends ActEntity<BusiTools> {
	
	private static final long serialVersionUID = 1L;
	private String toolName;		// 工具名
	private String procInsId;		// 流程实例ID
	
	public BusiTools() {
		super();
	}

	public BusiTools(String id){
		super(id);
	}

	@Length(min=1, max=100, message="工具名长度必须介于 1 和 100 之间")
	public String getToolName() {
		return toolName;
	}

	public void setToolName(String toolName) {
		this.toolName = toolName;
	}
	
	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
	public String getProcInsId() {
		return procInsId;
	}

	public void setProcInsId(String procInsId) {
		this.procInsId = procInsId;
	}
	
}