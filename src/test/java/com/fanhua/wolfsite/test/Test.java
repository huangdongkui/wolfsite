package com.fanhua.wolfsite.test;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;

import com.fanhua.wolfsite.common.persistence.PageResult;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.defaults.DefaultSqlSessionFactory;
import org.codehaus.groovy.util.ListHashMap;
import org.junit.Assert;
import org.junit.runner.RunWith;
import org.mybatis.spring.SqlSessionUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.fanhua.wolfsite.modules.sys.service.SysFuncService;

@RunWith(SpringJUnit4ClassRunner.class)    
@ContextConfiguration(locations = {"classpath:spring-context.xml"})    
@Transactional 
public class Test {
	  
	@Autowired    
    private SysFuncService sysFuncService;
	@Autowired
	private SqlSessionFactory sqlSessionFactory;

	public static void main(String[] args) {
		System.out.println(genWhere("a=&b="));
	}

	/**
	 * 生成where
	 * @param searchParams
	 * @return
	 */
	private static String genWhere(String searchParams) {
		try {
			searchParams=java.net.URLDecoder.decode(searchParams,"utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		StringBuilder sb=new StringBuilder();
		List<String> list=new ArrayList<>();
		String[] split = searchParams.split("&");
		for (String s : split) {
			if(!s.trim().endsWith("=")){
				list.add(s);
			}
		}
		if(list.size()==0){
			return "1=1";
		}
		return String.join(" and ",list);
	}

	@org.junit.Test
	public void testBase(){

		HashMap hashMap=new HashMap();
		hashMap.put("p_table_name","sys_user");
		hashMap.put("p_fields","*");
		hashMap.put("p_page_size",10);
		hashMap.put("p_page_no",1);
		hashMap.put("p_order_string","create_date");
		hashMap.put("p_where_string","1=1");

		List<HashMap> fn= sysFuncService.listPage(hashMap);

		//List fn= sysFuncService.listPage("select * from sys_user","*",10,1,"create_date","1=1");
	
		
		//System.out.println(hashMap);

	    Assert.assertEquals(10,10);
	}
	@org.junit.Test
	public void tesmybatis(){
		HashMap hs=new HashMap();
		hs.put("DEL_FLAG_NORMAL",0);
		List o = SqlSessionUtils.getSqlSession(sqlSessionFactory).selectList("com.fanhua.wolfsite.modules.sys.dao.SysFuncDao.findAllList",hs);
		Assert.assertEquals(7,o.size());
		//SqlSessionFactory d=new DefaultSqlSessionFactory();

	}
}
