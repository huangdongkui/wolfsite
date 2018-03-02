<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>功能按钮管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {
		//$("#name").focus();
		$("#inputForm").validate({
			submitHandler : function(form) {
				//loading('正在提交，请稍等...');
				//form.submit();
				save();
			}
		});

	});

	function save() {	
		$.ajax({
			cache : true,
			type : "POST",
			url : "${ctx}/sys/sysFunc",
			data : $('#inputForm').serialize(), // 你的formid
			async : false,
			error : function(request) {
				parent.layer.alert("网络超时");
			},
			success : function(data) {
				if (data.code == 0) {

					window.parent.reload();
					
					window.parent.layer.msg("操作成功");
					
					var index = window.parent.layer.getFrameIndex(window.name);
					window.parent.layer.close(index);

				} else {
					parent.layer.alert(data.msg);
				}

			}
		});

	}
</script>
</head>
<body>

	<form:form id="inputForm" modelAttribute="sysFunc" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">功能名称：</label>
			<div class="controls">
				<form:input path="funcName" htmlEscape="false" maxlength="100"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">JS方法名：</label>
			<div class="controls">
				<form:input path="funcJsmethod" htmlEscape="false" maxlength="100"
					class="input-xlarge " />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">显示位置：</label>
			<div class="controls">
				<form:select path="showType" class="input-xlarge ">
					<form:option value="" label="" />
					<form:options items="${fns:getDictList('showtype')}"
						itemLabel="label" itemValue="value" htmlEscape="false" />
				</form:select>
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">图标：</label>
			<%--<div class="controls">--%>
			<%--<form:input path="icon" htmlEscape="false" maxlength="100" class="input-xlarge "/>--%>
			<%----%>
			<%--</div>--%>
			<div class="controls">
				<sys:iconselect id="icon" name="icon" value="${sysFunc.icon}" />
			</div>
		</div>
		<div class="control-group">
			<label class="control-label">备注信息：</label>
			<div class="controls">
				<form:textarea path="remarks" htmlEscape="false" rows="4"
					maxlength="255" class="input-xxlarge " />
			</div>
		</div>
		<div class="form-actions">
			<shiro:hasPermission name="sys:sysFunc:edit">
				<input id="btnSubmit" class="btn btn-primary" type="submit"
					value="保 存" />&nbsp;</shiro:hasPermission>

		</div>

	</form:form>
</body>
</html>