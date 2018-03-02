/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.sys.entity;

import org.hibernate.validator.constraints.Length;

import com.fanhua.wolfsite.common.persistence.DataEntity;

/**
 * 功能按钮Entity
 * @author huangdk
 * @version 2017-08-19
 */
public class SysFunc extends DataEntity<SysFunc> {

	private static final long serialVersionUID = 1L;
	private String funcName;		// 功能名称
	private String funcJsmethod;		// JS方法名
	private String showType;		// 显示位置
	private String icon;		// 图标
	
	public SysFunc() {
		super();
	}

	public SysFunc(String id){
		super(id);
	}

	@Length(min=0, max=100, message="功能名称长度必须介于 0 和 100 之间")
	public String getFuncName() {
		return funcName;
	}

	public void setFuncName(String funcName) {
		this.funcName = funcName;
	}
	
	@Length(min=0, max=100, message="JS方法名长度必须介于 0 和 100 之间")
	public String getFuncJsmethod() {
		return funcJsmethod;
	}

	public void setFuncJsmethod(String funcJsmethod) {
		this.funcJsmethod = funcJsmethod;
	}
	
	@Length(min=0, max=11, message="显示位置长度必须介于 0 和 11 之间")
	public String getShowType() {
		return showType;
	}

	public void setShowType(String showType) {
		this.showType = showType;
	}
	
	@Length(min=0, max=100, message="图标长度必须介于 0 和 100 之间")
	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}
	
}