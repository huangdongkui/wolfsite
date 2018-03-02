<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>项目信息管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			//$("#name").focus();
			$("#inputForm").validate({
				submitHandler: function(form){
					loading('正在提交，请稍等...');
					form.submit();
				},
				errorContainer: "#messageBox",
				errorPlacement: function(error, element) {
					$("#messageBox").text("输入有误，请先更正。");
					if (element.is(":checkbox")||element.is(":radio")||element.parent().is(".input-append")){
						error.appendTo(element.parent().parent());
					} else {
						error.insertAfter(element);
					}
				}
			});
		});
	</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li><a href="${ctx}/project/projectInfo/">项目信息列表</a></li>
		<li class="active"><a href="${ctx}/project/projectInfo/form?id=${projectInfo.id}">项目信息<shiro:hasPermission name="project:projectInfo:edit">${not empty projectInfo.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission name="project:projectInfo:edit">查看</shiro:lacksPermission></a></li>
	</ul><br/>
	<form:form id="inputForm" modelAttribute="projectInfo" action="${ctx}/project/projectInfo/save" method="post" class="form-horizontal">
		<form:hidden path="id"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">项目名称：</label>
			<div class="controls">
				
				${projectInfo.projectName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目类型：</label>
			<div class="controls">
				${projectInfo.projectType}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目来源：</label>
			<div class="controls">
				${projectInfo.projectSource}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预算金额：</label>
			<div class="controls">
					${projectInfo.budgetAmount}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否投标：</label>
			<div class="controls">
					${projectInfo.needBid}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预计开始日期：</label>
			<div class="controls">					
					${projectInfo.planBeginDatetime}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">委托方名称：</label>
			<div class="controls">
					${projectInfo.clientName}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">委托方需求简述：</label>
			<div class="controls">
					${projectInfo.clientRequestDesc}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">招投标信息：</label>
			<div class="controls">
						${projectInfo.bidInfo}
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
					${projectInfo.remarks}
			</div>
		</div>

		<act:histoicFlow procInsId="${projectInfo.act.procInsId}" />
		<div class="form-actions">
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
	</form:form>
</body>
</html>