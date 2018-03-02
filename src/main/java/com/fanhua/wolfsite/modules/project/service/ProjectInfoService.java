/**
 * Copyright &copy; 2012-2016 <a href="https://github.com/fanhua/wolfsite">wolfsite</a> All rights reserved.
 */
package com.fanhua.wolfsite.modules.project.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.fanhua.wolfsite.common.persistence.Page;
import com.fanhua.wolfsite.common.service.CrudService;
import com.fanhua.wolfsite.common.utils.StringUtils;
import com.fanhua.wolfsite.modules.project.entity.ProjectInfo;
import com.google.common.collect.Maps;
import com.fanhua.wolfsite.modules.act.service.ActTaskService;
import com.fanhua.wolfsite.modules.act.utils.ActUtils;
import com.fanhua.wolfsite.modules.project.dao.ProjectInfoDao;

/**
 * 项目信息Service
 * 
 * @author wolfhuang
 * @version 2017-11-25
 */
@Service
@Transactional(readOnly = true)
public class ProjectInfoService extends CrudService<ProjectInfoDao, ProjectInfo> {
	@Autowired
	private ActTaskService actTaskService;

	public ProjectInfo get(String id) {
		return super.get(id);
	}

	public List<ProjectInfo> findList(ProjectInfo projectInfo) {
		return super.findList(projectInfo);
	}

	public Page<ProjectInfo> findPage(Page<ProjectInfo> page, ProjectInfo projectInfo) {
		return super.findPage(page, projectInfo);
	}

	@Transactional(readOnly = false)
	public void save(ProjectInfo projectInfo) {

		// 申请发起
		if (StringUtils.isBlank(projectInfo.getId())) {
			projectInfo.preInsert();
			dao.insert(projectInfo);

			// 启动流程
			actTaskService.startProcess(ActUtils.PD_ProjectApply[0], ActUtils.PD_ProjectApply[1], projectInfo.getId(),
					projectInfo.getProjectName());

		}

		// 重新编辑申请
		else {
			projectInfo.preUpdate();
			dao.update(projectInfo);

			projectInfo.getAct().setComment(("yes".equals(projectInfo.getAct().getFlag()) ? "[重申] " : "[销毁] ")
					+ projectInfo.getAct().getComment());

			// 完成流程任务
			Map<String, Object> vars = Maps.newHashMap();
			vars.put("pass", "yes".equals(projectInfo.getAct().getFlag()) ? "1" : "0");
			actTaskService.complete(projectInfo.getAct().getTaskId(), projectInfo.getAct().getProcInsId(),
					projectInfo.getAct().getComment(), projectInfo.getProjectName(), vars);
		}

		super.save(projectInfo);
	}

	@Transactional(readOnly = false)
	public void delete(ProjectInfo projectInfo) {
		super.delete(projectInfo);
	}

	/**
	 * 审核审批保存
	 * 
	 * @param testAudit
	 */
	@Transactional(readOnly = false)
	public void auditSave(ProjectInfo projectInfo) {

		// 设置意见
		projectInfo.getAct().setComment(
				("yes".equals(projectInfo.getAct().getFlag()) ? "[同意] " : "[驳回] ") + projectInfo.getAct().getComment());

		projectInfo.preUpdate();

		// 对不同环节的业务逻辑进行操作
		String taskDefKey = projectInfo.getAct().getTaskDefKey();

		// 审核环节
		if ("audit".equals(taskDefKey)) {

		} else if ("audit2".equals(taskDefKey)) {
			// testAudit.setHrText(testAudit.getAct().getComment());

		} else if ("audit3".equals(taskDefKey)) {
			// testAudit.setLeadText(testAudit.getAct().getComment());

		} else if ("audit4".equals(taskDefKey)) {
			// testAudit.setMainLeadText(testAudit.getAct().getComment());

		} else if ("apply_end".equals(taskDefKey)) {

		}

		// 未知环节，直接返回
		else {
			return;
		}

		// 提交流程任务
		Map<String, Object> vars = Maps.newHashMap();
		vars.put("pass", "yes".equals(projectInfo.getAct().getFlag()) ? "1" : "0");
		actTaskService.complete(projectInfo.getAct().getTaskId(), projectInfo.getAct().getProcInsId(),
				projectInfo.getAct().getComment(), vars);

		// vars.put("var_test", "yes_no_test2");
		// actTaskService.getProcessEngine().getTaskService().addComment(testAudit.getAct().getTaskId(),
		// testAudit.getAct().getProcInsId(), testAudit.getAct().getComment());
		// actTaskService.jumpTask(testAudit.getAct().getProcInsId(),
		// testAudit.getAct().getTaskId(), "audit2", vars);
	}
}