/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.project.entity;

import org.hibernate.validator.constraints.Length;
import java.util.Date;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fanhua.wolfsite.common.persistence.ActEntity;
import com.fanhua.wolfsite.common.persistence.DataEntity;

/**
 * 项目信息Entity
 * @author wolfhuang
 * @version 2017-11-25
 */
public class ProjectInfo extends ActEntity<ProjectInfo> {
	
	private static final long serialVersionUID = 1L;
	private String projectName;		// 项目名称
	private String projectType;		// 项目类型
	private String projectSource;		// 项目来源
	private String budgetAmount;		// 预算金额
	private String needBid;		// 是否投标
	private Date planBeginDatetime;		// 预计开始日期
	private String clientName;		// 委托方名称
	private String clientRequestDesc;		// 委托方需求简述
	private String bidInfo;		// 招投标信息
	//private String procInsId;		// 流程实例ID
	
	public ProjectInfo() {
		super();
	}

	public ProjectInfo(String id){
		super(id);
	}

	@Length(min=1, max=45, message="项目名称长度必须介于 1 和 45 之间")
	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}
	
	@Length(min=0, max=45, message="项目类型长度必须介于 0 和 45 之间")
	public String getProjectType() {
		return projectType;
	}

	public void setProjectType(String projectType) {
		this.projectType = projectType;
	}
	
	@Length(min=0, max=45, message="项目来源长度必须介于 0 和 45 之间")
	public String getProjectSource() {
		return projectSource;
	}

	public void setProjectSource(String projectSource) {
		this.projectSource = projectSource;
	}
	
	@Length(min=0, max=45, message="预算金额长度必须介于 0 和 45 之间")
	public String getBudgetAmount() {
		return budgetAmount;
	}

	public void setBudgetAmount(String budgetAmount) {
		this.budgetAmount = budgetAmount;
	}
	
	@Length(min=0, max=3, message="是否投标长度必须介于 0 和 3 之间")
	public String getNeedBid() {
		return needBid;
	}

	public void setNeedBid(String needBid) {
		this.needBid = needBid;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getPlanBeginDatetime() {
		return planBeginDatetime;
	}

	public void setPlanBeginDatetime(Date planBeginDatetime) {
		this.planBeginDatetime = planBeginDatetime;
	}
	
	@Length(min=0, max=45, message="委托方名称长度必须介于 0 和 45 之间")
	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	
	@Length(min=0, max=45, message="委托方需求简述长度必须介于 0 和 45 之间")
	public String getClientRequestDesc() {
		return clientRequestDesc;
	}

	public void setClientRequestDesc(String clientRequestDesc) {
		this.clientRequestDesc = clientRequestDesc;
	}
	
	@Length(min=0, max=45, message="招投标信息长度必须介于 0 和 45 之间")
	public String getBidInfo() {
		return bidInfo;
	}

	public void setBidInfo(String bidInfo) {
		this.bidInfo = bidInfo;
	}
	
//	@Length(min=0, max=64, message="流程实例ID长度必须介于 0 和 64 之间")
//	public String getProcInsId() {
//		return procInsId;
//	}
//
//	public void setProcInsId(String procInsId) {
//		this.procInsId = procInsId;
//	}
	
}