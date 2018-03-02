
package com.fanhua.wolfsite.modules.sys.entity;

import java.util.Date;

import org.hibernate.validator.constraints.Length;

import com.fanhua.wolfsite.common.persistence.DataEntity;

/**
 * 公共文件表Entity
 * @author wolfhuang
 * @version 2017-11-05
 */
public class SysFile extends DataEntity<SysFile> {
	
	private static final long serialVersionUID = 1L;
	private String fileName;		// 文件名
	private String filePath;		// 路径
	private String fileSize;		// 大小
	private String fileType;		// 文件扩展名
	private String bussinessId;		// 业务表单主键
	private String uploadName;
	private String bussnissType;    //文件业务类型

	public String getUploadName(){
		return createBy.getName();
	}

	
	public SysFile() {
		super();
	}

	public SysFile(String id){
		super(id);
	}

	
	@Length(min=0, max=200, message="文件名长度必须介于 0 和 200 之间")
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
	
	@Length(min=0, max=1000, message="路径长度必须介于 0 和 1000 之间")
	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	
	@Length(min=0, max=11, message="大小长度必须介于 0 和 11 之间")
	public String getFileSize() {
		return fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}
	
	@Length(min=0, max=20, message="类型长度必须介于 0 和 20 之间")
	public String getFileType() {
		return fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}
	
	@Length(min=0, max=45, message="业务表单主键长度必须介于 0 和 45 之间")
	public String getBussinessId() {
		return bussinessId;
	}

	public void setBussinessId(String bussinessId) {
		this.bussinessId = bussinessId;
	}


	public String getBussnissType() {
		return bussnissType;
	}


	public void setBussnissType(String bessnissType) {
		this.bussnissType = bessnissType;
	}
	
}