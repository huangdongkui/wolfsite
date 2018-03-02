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

	<form:form id="inputForm" modelAttribute="projectInfo" action="${ctx}/project/projectInfo/saveAudit" method="post" class="form-horizontal">

		<form:hidden path="id"/>
		<form:hidden path="act.taskId"/>
		<form:hidden path="act.taskName"/>
		<form:hidden path="act.taskDefKey"/>
		<form:hidden path="act.procInsId"/>
		<form:hidden path="act.procDefId"/>
		<form:hidden id="flag" path="act.flag"/>
		<sys:message content="${message}"/>
		<fieldset>
			<legend>${projectInfo.act.taskName}</legend>
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
		<div class="control-group">
			<label class="control-label">我的意见：</label>
			<div class="controls">
					<form:textarea path="act.comment" class="required" rows="5" maxlength="20" cssStyle="width:500px"/>
			</div>
		</div>
		</fieldset>

	<div class="form-actions">
		
				<c:if test="${projectInfo.act.taskDefKey eq 'audit'}">
					<input id="btnSubmit" class="btn btn-primary" type="submit" value="同 意" onclick="$('#flag').val('yes')"/>&nbsp;
					<input id="btnSubmit" class="btn btn-inverse" type="submit" value="驳 回" onclick="$('#flag').val('no')"/>&nbsp;
				</c:if>
			
			<input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
		</div>
		<act:histoicFlow procInsId="${projectInfo.act.procInsId}"/>
	</form:form>
</body>
</html>