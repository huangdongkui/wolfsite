<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>菜单管理</title>
    <meta name="decorator" content="default"/>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#name").focus();
            $("#inputForm").validate({
                submitHandler: function (form) {
                    loading('正在提交，请稍等...');
                    $("#permissionSelect").removeAttr("name");
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
        });

        function funChange() {
            $("#permission").val($("#permissionSelect :selected").val());

            $("#hname").val($("#permissionSelect :selected").text());
        }
    </script>
</head>
<body>
<ul class="nav nav-tabs">
    <li><a href="${ctx}/sys/menu/">菜单列表</a></li>
    <%--<li class="active">--%>

    <%--<a href="${ctx}/sys/menu/form?id=${menu.id}&parent.id=${menu.parent.id}">菜单<shiro:hasPermission--%>
    <%--name="sys:menu:edit">${not empty menu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission--%>
    <%--name="sys:menu:edit">查看</shiro:lacksPermission></a></li>--%>

    <li class="active">

        <c:choose>
        <c:when test="${menu.isButton== '1'}">

            <a href="${ctx}/sys/menu/form?id=${menu.id}&parent.id=${menu.parent.id}">按键<shiro:hasPermission
                    name="sys:menu:edit">${not empty menu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
                    name="sys:menu:edit">查看</shiro:lacksPermission></a>

        </c:when>
        <c:otherwise>
        <a href="${ctx}/sys/menu/form?id=${menu.id}&parent.id=${menu.parent.id}">菜单<shiro:hasPermission
                name="sys:menu:edit">${not empty menu.id?'修改':'添加'}</shiro:hasPermission><shiro:lacksPermission
                name="sys:menu:edit">查看</shiro:lacksPermission></a></li>

    </c:otherwise>
    </c:choose>
    </li>
</ul>
<br/>
<form:form id="inputForm" modelAttribute="menu" action="${ctx}/sys/menu/save" method="post" class="form-horizontal">
    <form:hidden path="id"/>

    <form:hidden path="isButton" id="isButton"></form:hidden>
    <sys:message content="${message}"/>
    <div class="control-group">
        <label class="control-label">上级菜单:</label>
        <div class="controls">
            <sys:treeselect id="menu" name="parent.id" value="${menu.parent.id}" labelName="parent.name"
                            labelValue="${menu.parent.name}" disabled="disabled"
                            title="菜单" url="/sys/menu/treeData" extId="${menu.id}" cssClass="required"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">名称:</label>
        <div class="controls">

            <c:choose>
                <c:when test="${menu.isButton eq '1'}">

                    <form:select path="permission" id="permissionSelect" class="input-medium" onchange="funChange()">
                        <form:option value="" label="选择"></form:option>
                        <form:options items="${sysFuncList}" itemLabel="funcName" itemValue="funcJsmethod"
                                      htmlEscape="false"/>
                    </form:select>
                    <form:hidden path="name" id="hname"></form:hidden>
                </c:when>
                <c:otherwise>

                    <form:input path="name" htmlEscape="false" maxlength="50" class="required input-xlarge"/>
                    <span class="help-inline"><font color="red">*</font> </span>

                </c:otherwise>
            </c:choose>


        </div>
    </div>
    <div class="control-group">
        <label class="control-label">权限标识或JS方法名:</label>
        <div class="controls">
            <form:input path="permission" htmlEscape="false" maxlength="100" class="input-xxlarge"/>
            <span class="help-inline">控制器中定义的权限标识，如：@RequiresPermissions("权限标识") 或是JS方法</span>
        </div>
    </div>
    <c:if test="${menu.isButton!= '1'}">
        <div class="control-group">
            <label class="control-label">链接:</label>
            <div class="controls">
                <form:input path="href" htmlEscape="false" maxlength="2000" class="input-xxlarge"/>
                <span class="help-inline">点击菜单跳转的页面</span>
            </div>
        </div>

        <div class="control-group">
            <label class="control-label">目标:</label>
            <div class="controls">
                <form:input path="target" htmlEscape="false" maxlength="10" class="input-small"/>
                <span class="help-inline">链接地址打开的目标窗口，默认：mainFrame</span>
            </div>
        </div>


    </c:if>
    <div class="control-group">
        <label class="control-label">图标:</label>
        <div class="controls">
            <sys:iconselect id="icon" name="icon" value="${menu.icon}"/>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">排序:</label>
        <div class="controls">
            <form:input path="sort" htmlEscape="false" maxlength="50" class="required digits input-small"/>
            <span class="help-inline">排列顺序，升序。</span>
        </div>
    </div>
    <div class="control-group">
        <label class="control-label">可见:</label>
        <div class="controls">
            <form:radiobuttons path="isShow" items="${fns:getDictList('show_hide')}" itemLabel="label" itemValue="value"
                               htmlEscape="false" class="required"/>
            <span class="help-inline">该菜单或操作是否显示到系统菜单中</span>
        </div>
    </div>


    <div class="control-group">
        <label class="control-label">备注:</label>
        <div class="controls">
            <form:textarea path="remarks" htmlEscape="false" rows="3" maxlength="200" class="input-xxlarge"/>
        </div>
    </div>
    <div class="form-actions">
        <shiro:hasPermission name="sys:menu:edit"><input id="btnSubmit" class="btn btn-primary" type="submit"
                                                         value="保 存"/>&nbsp;</shiro:hasPermission>
        <input id="btnCancel" class="btn" type="button" value="返 回" onclick="history.go(-1)"/>
    </div>
</form:form>
</body>
</html>