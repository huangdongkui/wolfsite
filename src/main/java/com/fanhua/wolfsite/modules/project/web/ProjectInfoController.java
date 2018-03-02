/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.project.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fanhua.wolfsite.common.config.Global;
import com.fanhua.wolfsite.common.persistence.Page;
import com.fanhua.wolfsite.common.web.BaseController;
import com.fanhua.wolfsite.common.utils.StringUtils;
import com.fanhua.wolfsite.modules.oa.entity.TestAudit;
import com.fanhua.wolfsite.modules.project.entity.ProjectInfo;
import com.fanhua.wolfsite.modules.project.service.ProjectInfoService;

/**
 * 项目信息Controller
 * @author wolfhuang
 * @version 2017-11-25
 */
@Controller
@RequestMapping(value = "${adminPath}/project/projectInfo")
public class ProjectInfoController extends BaseController {

	@Autowired
	private ProjectInfoService projectInfoService;
	
	@ModelAttribute
	public ProjectInfo get(@RequestParam(required=false) String id) {
		ProjectInfo entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = projectInfoService.get(id);
		}
		if (entity == null){
			entity = new ProjectInfo();
		}
		return entity;
	}
	
//	@RequiresPermissions("project:projectInfo:view")
	@RequestMapping(value = {"list", ""})
	public String list(ProjectInfo projectInfo, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<ProjectInfo> page = projectInfoService.findPage(new Page<ProjectInfo>(request, response), projectInfo); 
		model.addAttribute("page", page);
		return "modules/project/projectInfoList";
	}

//	@RequiresPermissions("project:projectInfo:view")
	@RequestMapping(value = "form")
	public String form(ProjectInfo projectInfo, Model model) {
		
	String view = "projectInfoForm";
		
		// 查看审批申请单
		if (StringUtils.isNotBlank(projectInfo.getId())){//.getAct().getProcInsId())){

			// 环节编号
			String taskDefKey = projectInfo.getAct().getTaskDefKey();
			
			// 查看工单
			if(projectInfo.getAct().isFinishTask()){
				view = "projectInfoView";
			}
			// 审核环节
			else if ("audit".equals(taskDefKey)){
				view = "projectInfoAudit";
//				String formKey = "/oa/testAudit";
//				return "redirect:" + ActUtils.getFormUrl(formKey, testAudit.getAct());
			}
			
		}

		model.addAttribute("projectInfo", projectInfo);
		return "modules/project/" + view;
		
		//model.addAttribute("projectInfo", projectInfo);
		//return "modules/project/projectInfoForm";
	}

	//@RequiresPermissions("project:projectInfo:edit")
	@RequestMapping(value = "save")
	public String save(ProjectInfo projectInfo, Model model, RedirectAttributes redirectAttributes) {
		if (!beanValidator(model, projectInfo)){
			return form(projectInfo, model);
		}
		projectInfoService.save(projectInfo);
		addMessage(redirectAttributes, "保存项目信息成功");
		return "redirect:"+Global.getAdminPath()+"/project/projectInfo/?repage";
	}
	
	/**
	 * 工单执行（完成任务）
	 * @param projectInfo
	 * @param model
	 * @return
	 */

	@RequestMapping(value = "saveAudit")
	public String saveAudit(ProjectInfo projectInfo, Model model) {
		if (StringUtils.isBlank(projectInfo.getAct().getFlag())
				|| StringUtils.isBlank(projectInfo.getAct().getComment())){
			addMessage(model, "请填写审核意见。");
			return form(projectInfo, model);
		}
		projectInfoService.auditSave(projectInfo);
		return "redirect:" + adminPath + "/act/task/historic/";
	}
	
	//@RequiresPermissions("project:projectInfo:edit")
	@RequestMapping(value = "delete")
	public String delete(ProjectInfo projectInfo, RedirectAttributes redirectAttributes) {
		projectInfoService.delete(projectInfo);
		addMessage(redirectAttributes, "删除项目信息成功");
		return "redirect:"+Global.getAdminPath()+"/project/projectInfo/?repage";
	}

}