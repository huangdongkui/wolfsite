/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.oa.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fanhua.wolfsite.common.config.Global;
import com.fanhua.wolfsite.common.persistence.Page;
import com.fanhua.wolfsite.common.web.BaseController;
import com.fanhua.wolfsite.common.utils.StringUtils;
import com.fanhua.wolfsite.modules.oa.entity.BusiTools;
import com.fanhua.wolfsite.modules.oa.service.BusiToolsService;

/**
 * 工具申请Controller
 * @author wolfhuang
 * @version 2017-12-15
 */
@Controller
@RequestMapping(value = "${adminPath}/oa/busiTools")
public class BusiToolsController extends BaseController {

	@Autowired
	private BusiToolsService busiToolsService;
	
	@ModelAttribute
	public BusiTools get(@RequestParam(required=false) String id) {
		BusiTools entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = busiToolsService.get(id);
		}
		if (entity == null){
			entity = new BusiTools();
		}
		return entity;
	}
	
	//@RequiresPermissions("oa:busiTools:view")
	@RequestMapping(value = {"list", ""})
	public String list(BusiTools busiTools, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<BusiTools> page = busiToolsService.findPage(new Page<BusiTools>(request, response), busiTools); 
		model.addAttribute("page", page);
		return "modules/oa/busiToolsList";
	}

	//@RequiresPermissions("oa:busiTools:view")
	@RequestMapping(value = "form")
	public String form(BusiTools busiTools, Model model) {
		model.addAttribute("busiTools", busiTools);
		return "modules/oa/busiToolsForm";
	}

	//@RequiresPermissions("oa:busiTools:edit")
	@RequestMapping(value = "save")
	public String save(BusiTools busiTools, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, busiTools)){
			return form(busiTools, model);
		}
		busiToolsService.save(busiTools);
		addMessage(redirectAttributes, "保存工具成功");
		return "redirect:"+Global.getAdminPath()+"/oa/busiTools";
	}
	
	@RequestMapping(value = "saveOnly")
	@ResponseBody
	public void saveOnly(BusiTools busiTools, Model model, RedirectAttributes redirectAttributes,HttpServletResponse response) {
		
		if (!beanValidator(model, busiTools)){
			renderString(response, model);
		}
		
		busiToolsService.save(busiTools);
		renderString(response, busiTools);
	}
	
	//@RequiresPermissions("oa:busiTools:edit")
	@RequestMapping(value = "delete")
	public String delete(BusiTools busiTools, RedirectAttributes redirectAttributes) {
		busiToolsService.delete(busiTools);
		addMessage(redirectAttributes, "删除工具成功");
		return "redirect:"+Global.getAdminPath()+"/oa/busiTools/?repage";
	}

}