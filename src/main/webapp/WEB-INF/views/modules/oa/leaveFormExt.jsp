<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>请假管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    form.submit();
                },
                errorContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    $("#messageBox").text("输入有误，请先更正。");
                    if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                        error.appendTo(element.parent().parent());
                    } else {
                        error.insertAfter(element);
                    }
                }
            });
            
            
            
            $("#btnSubmit").click(function(){
            	   var url = "${ctx}/oa/leave/saveOnly";
            	   var postData=$("#inputForm").serializeArray();
            	   $.post(url,postData,function(obj){
            		   submitWorkflow('leave','oa_leave',obj.id,obj.reason);
            	});
            	
            });
        });

        
        function submitWorkflow(p_procDefKey,p_businessTable,p_businessId,p_title) {
            var url = "${ctx}/act/task/startFlow";
            $.post(url, {
                procDefKey: p_procDefKey,
                businessTable: p_businessTable,
                businessId: p_businessId,
                title: p_title
            }, function (obj) {
                if (obj === "true") {
                    alert("流程提交成功！");
                   // alertx(result.mstext);
                } else {
                    alert("流程提交失败！");
                }
            });
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/oa/leave/">待办任务</a></li>
    <li><a href="${ctx}/oa/leave/list">所有任务</a></li>
    <shiro:hasPermission name="oa:leave:edit">
        <li class="active"><a href="${ctx}/oa/leave/form">请假申请</a></li>
    </shiro:hasPermission>
</ul>
<form:form id="inputForm" modelAttribute="leave" action="${ctx}/oa/leave/saveOnly" method="post" class="form-horizontal">
    <form:hidden path="id"/>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">请假类型：</label>
        <div class="controls">
            <form:select path="leaveType">
                <form:options items="${fns:getDictList('oa_leave_type')}" itemLabel="label" itemValue="value"
                              htmlEscape="false"/>
            </form:select>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">开始时间：</label>
        <div class="controls">
				<input id="startTime" name="startTime" type="text"
					readonly="readonly" maxlength="20" class="Wdate required"
					onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});"
					value="${fns:formatDateTime(leave.startTime) }" />

			</div>
    </div>
    <div class="control-group">
        <label class="control-label">结束时间：</label>
        <div class="controls">
            <input id="endTime" name="endTime" type="text" readonly="readonly" maxlength="20" class="Wdate required"
                   onclick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss',isShowClear:false});" value="${fns:formatDateTime(leave.endTime) }"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">请假原因：</label>
        <div class="controls">
            <form:textarea path="reason" class="required" rows="5" maxlength="20"/>
        </div>
    </div>
    <div class="form-actions">
        <input id="btnSubmit" class="btn btn-primary" type="button" value="提 交"
               />
        <input id="btnSave" class="btn btn-primary" type="submit" value="保 存"/>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>
