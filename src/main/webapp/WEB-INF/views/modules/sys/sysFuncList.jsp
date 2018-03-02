<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>功能按钮管理</title>
    <meta name="decorator" content="default"/>

    <%@ include file="/WEB-INF/views/include/listInclude.jsp" %>
</head>
<body>

<form:form id="searchForm" action="${ctx}/sys/sysFunc/" method="post" class="breadcrumb form-search">

    <ul class="ul-form">
        <li><label>功能名称：</label>
            <input id="funcName" name="func_name" type="text" maxlength="100" class="input-medium"/>
        </li>
        <li><label>JS方法名：</label>
            <input id="funcJsmethod" name="func_jsmethod" type="text" maxlength="100" class="input-medium"/>
        </li>
        <li class="btns">
            <button id="btnSearch" type="button" class="btn btn-primary">
                <i class="icon-search" aria-hidden="true"></i>查询
            </button>
        </li>
        <li class="clearfix"></li>
    </ul>
</form:form>

<div style="height: fit-content;">
    <div id="toolbar" role="group">
        <button type="button" class="btn btn-primary" onclick="add()">
            <i class="icon-plus" aria-hidden="true"></i>添加
        </button>
    </div>
    <table id="exampleTable" data-mobile-responsive="true" class="table-bordered table-condensed">
    </table>

</div>


<script type="text/javascript">

    var prefix = ctx + '/sys/sysFunc';
    var WTable1;
    //字典
    var dict = {};
    dict["showtype"] =${fns:getDictListJson("showtype")};

    $(function () {
        //根据权限加载按钮
        //initButton('${param.menuid}');

        //构造bootstrap table的请求参数
        function queryParams(params) {
            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                limit: params.limit,   //页面大小
                offset: params.offset,  //页码
                order: params.order,
                sort: params.sort,
                searchParams: $("#searchForm").serialize()
            };
            return temp;
        }

        $("#btnSearch").click(function () {
            WTable1.reload({queryParams: queryParams});
        });

        var columns = [
            {
                field: 'func_name',
                title: '功能名称'
            },
            {
                field: 'func_jsmethod',
                title: 'JS方法名'
            },
            {
                field: 'show_type',
                title: '显示位置',
                formatter: function (value, row, index) {
                    return getDictLabel(dict["showtype"], value, '未知', true);
                }
            },
            {
                field: 'icon',
                title: '图标'
            },
            {
                field: 'create_by_name',
                title: '创建人'
            },

            {
                title: '操作',
                field: 'id',
                align: 'center',
                formatter: function (value, row,
                                     index) {
                    var e = '<a  href="#" title="编辑" onclick="edit(\'' + row.id + '\')">编辑</a> ';
                    var d = '<a  href="#" title="删除"  mce_href="#" onclick="remove(\'' + row.id + '\')">删除</i></a> ';
                    return e + d;
                }
            }];

        WTable1 = WTable.WBootstrapTable({
            elementId: "#exampleTable",
            deleteUrl: prefix,
            addUrl: prefix,
            editUrl: prefix,
            url: prefix + '/lists',
            columns: columns
        });
    });

    function add() {
        WTable1.add();
    }
    function edit(id) {
        WTable1.baseEdit({id: id});
    }
    function remove(id) {
        WTable1.baseRemove({id: id});
    }
    function reload() {
        WTable1.reload();
    }
</script>
</body>
</html>