/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.common.persistence;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.ResultType;
import org.apache.ibatis.annotations.Select;
import org.codehaus.groovy.util.ListHashMap;

/**
 * DAO支持类实现
 * 
 * @author fanhua
 * @version 2014-05-16
 */
public interface BaseDao {
	@Select("CALL `sp_pager`(#{p_table_name}, #{p_fields}, #{p_page_size}, #{p_page_no},#{p_order_string}, #{p_where_string});")
	public List<HashMap> listPage(HashMap hashMap);
}