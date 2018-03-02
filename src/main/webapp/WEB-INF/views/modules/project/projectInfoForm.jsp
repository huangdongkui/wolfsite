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
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>		
		<div class="control-group">
			<label class="control-label">项目名称：</label>
			<div class="controls">
				<form:input path="projectName" htmlEscape="false" maxlength="45" class="input-xlarge required"/>
				<span class="help-inline"><font color="red">*</font> </span>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目类型：</label>
			<div class="controls">
				<form:input path="projectType" htmlEscape="false" maxlength="45" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">项目来源：</label>
			<div class="controls">
				<form:input path="projectSource" htmlEscape="false" maxlength="45" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预算金额：</label>
			<div class="controls">
				<form:input path="budgetAmount" htmlEscape="false" maxlength="45" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">是否投标：</label>
			<div class="controls">
				<form:input path="needBid" htmlEscape="false" maxlength="3" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">预计开始日期：</label>
			<div class="controls">
				<input name="planBeginDatetime" type="text" readonly="readonly" maxlength="20" class="input-medium Wdate "
					value="<fmt:formatDate value="${projectInfo.planBeginDatetime}" pattern="yyyy-MM-dd HH:mm:ss"/>"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">委托方名称：</label>
			<div class="controls">
				<form:input path="clientName" htmlEscape="false" maxlength="45" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">委托方需求简述：</label>
			<div class="controls">
				<form:input path="clientRequestDesc" htmlEscape="false" maxlength="45" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">招投标信息：</label>
			<div class="controls">
				<form:input path="bidInfo" htmlEscape="false" maxlength="45" class="input-xlarge "/>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4" maxlength="255" class="input-xxlarge "/>
			</div>
		</div>


		
			<div class="form-actions">
		
				<input id="btnSubmit" class="btn btn-primary" type="submit" value="提交申请" onclick="$('#flag').val('yes')"/>&nbsp;
				<c:if test="${not empty projectInfo.id}">
					<input id="btnSubmit2" class="btn btn-inverse" type="submit" value="销毁申请" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
		
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<c:if test="${not empty projectInfo.id}">
			<act:histoicFlow procInsId="${projectInfo.act.procInsId}" />
		</c:if>
	</form:form>
</body>
</html>