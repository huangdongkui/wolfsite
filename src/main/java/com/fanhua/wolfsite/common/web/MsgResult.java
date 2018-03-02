package com.fanhua.wolfsite.common.web;
/**
 * 返回实体
 * @author Administrator
 *
 */
public class MsgResult {
	private String mscode;
	private String mstext;
	private Object results;
	public String getMscode() {
		return mscode;
	}
	public void setMscode(String mscode) {
		this.mscode = mscode;
	}
	public Object getResults() {
		return results;
	}
	public void setResults(Object results) {
		this.results = results;
	}
	public String getMstext() {
		return mstext;
	}
	public void setMstext(String mstext) {
		this.mstext = mstext;
	}
	

}
