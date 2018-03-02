<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>${fns:getConfig('productName')}</title>
    <link rel="stylesheet" href="${ctxStatic}/BeginnerAdmin/plugins/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="http://www.jq22.com/jquery/font-awesome.4.6.0.css">
    <link rel="stylesheet" href="${ctxStatic}/BeginnerAdmin/build/css/app.css" media="all">
     <link href="${ctxStatic}/BeginnerAdmin/layuiExt.css" rel="stylesheet" />
</head>

<body>
    <div class="layui-layout layui-layout-admin kit-layout-admin">
        <div class="layui-header">
            <div class="layui-logo">${fns:getConfig('productName')}</div>
            <div class="layui-logo kit-logo-mobile">K</div>
          
            <ul class="layui-nav layui-layout-right kit-nav">
                <li class="layui-nav-item">
                    <a href="javascript:;">
                        <img src="http://m.zhengjinfan.cn/images/0.jpg" class="layui-nav-img">${fns:getUser().name}
                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="javascript:;">基本资料</a></dd>
                        <dd><a href="javascript:;">安全设置</a></dd>
                    </dl>
                </li>
                <li class="layui-nav-item"><a href="${ctx}/logout" title="注销">
                    <i class="fa fa-sign-out" aria-hidden="true"></i> 注销 <a>
                </li>
            </ul>
        </div>

        <div class="layui-side layui-bg-black kit-side">
            <div class="layui-side-scroll">
                <div class="kit-side-fold"><i class="fa fa-navicon" aria-hidden="true"></i></div>
                <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
                <ul class="layui-nav layui-nav-tree" id="ulmenu" lay-filter="kitNavbar" kit-navbar>

                </ul>
            </div>
        </div>
        <div class="layui-body" id="container">
            <!-- 内容主体区域 -->
            <div style="padding: 15px;">主体内容加载中,请稍等...</div>
        </div>

        <div class="layui-footer">
            <!-- 底部固定区域 -->
            2017 &copy;${wolf}
         hdk

        </div>
    </div>

    <script src="${ctxStatic}/BeginnerAdmin/plugins/layui/layui.js"></script>
 <script src="${ctxStatic}/jquery/jquery-1.9.1.js"></script>

    <script src="${ctxStatic}/BeginnerAdmin/menuExt.js"></script>
    <script>
        var message;
        var ctx='${ctx}';
        layui.config({
            base: '${ctxStatic}/BeginnerAdmin/build/js/'
        }).use(['app', 'message','navbar'], function() {
            var app = layui.app,
                $ = layui.jquery,
                layer = layui.layer,
                navbar = layui.navbar;
            //将message设置为全局以便子页面调用
            message = layui.message;
            //主入口
            app.set({
                type: 'iframe'
            }).init();
            appGlobal=app;
            //initMenu(getMenus("1"),app);
            initMenu(getMenus("1"));
        });
        

    </script>
</body>

</html>