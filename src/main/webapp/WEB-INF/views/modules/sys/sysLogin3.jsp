<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="org.apache.shiro.web.filter.authc.FormAuthenticationFilter" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>${fns:getConfig('productName')} 登录</title>

    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <meta name="apple-mobile-web-app-status-bar-style" content="black">
    <meta name="apple-mobile-web-app-capable" content="yes">
    <meta name="format-detection" content="telephone=no">

    <link href="${ctxStatic}/layui/css/layui.css" rel="stylesheet" media="all"/>
    <link href="${ctxStatic}/common/login.css" rel="stylesheet" media="all"/>

    <script type="text/javascript">
        $(document).ready(function () {
            $("#loginForm").validate({
                rules: {
                    validateCode: {remote: "${pageContext.request.contextPath}/servlet/validateCodeServlet"}
                },
                messages: {
                    username: {required: "请填写用户名."}, password: {required: "请填写密码."},
                    validateCode: {remote: "验证码不正确.", required: "请填写验证码."}
                },
                errorLabelContainer: "#messageBox",
                errorPlacement: function (error, element) {
                    error.appendTo($("#loginError").parent());
                }
            });
        });
        // 如果在框架或在对话框中，则弹出提示并跳转到首页
        if (self.frameElement && self.frameElement.tagName == "IFRAME" || $('#left').length > 0 || $('.jbox').length > 0) {
            alert('未登录或登录超时。请重新登录，谢谢！');
            top.location = "${ctx}";
        }
    </script>
</head>
<body>

<div class="header">
    <c:if test="${not empty message}">
    <div id="messageBox" class="alert alert-error">
            <button data-dismiss="alert" class="close">×</button>
        <label id="loginError" class="error">${message}</label>
    </div>
    </c:if>
</div>

<div class="login">
    <h1 class="form-signin-heading">${fns:getConfig('productName')}</h1>
    <form id="loginForm" class="layui-form" action="${ctx}/login" method="post">

        <div class="layui-form-item">
            <input class="layui-input" name="username" placeholder="用户名" lay-verify="required" value="${username}"
                   type="text" autocomplete="off">
        </div>

        <div class="layui-form-item">
            <input class="layui-input" name="password" placeholder="密码" lay-verify="required" type="password"
                   autocomplete="off">
        </div>

        <c:if test="${isValidateCodeLogin}">
            <div class="validateCode">
                <label class="input-label mid" for="validateCode">验证码</label>
                <sys:validateCode name="validateCode" inputCssStyle="margin-bottom:0;"/>
            </div>
        </c:if>
        <button class="layui-btn login_btn" lay-submit="" lay-filter="login">登录</button>


    </form>

</div>

<script src="${ctxStatic}/flash/zoom.min.js" type="text/javascript"></script>
</body>
</html>