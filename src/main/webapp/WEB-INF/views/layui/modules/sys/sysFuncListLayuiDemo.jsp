<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>功能按钮管理</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<meta http-equiv="X-UA-Compatible" content="ie=edge">
<link rel="stylesheet"
	href="${ctxStatic}/BeginnerAdmin/plugins/layui/css/layui.css?v=2.1"
	media="all">
<link rel="stylesheet" type="text/css"
	href="http://cdn.bootcss.com/font-awesome/4.6.0/css/font-awesome.min.css">
<link rel="stylesheet" href="${ctxStatic}/bootstrap/bootstrap.min.css"
	media="all">
<link rel="stylesheet"
	href="${ctxStatic}/bootstrap-table/bootstrap-table.min.css" media="all">
<link rel="stylesheet" href="${ctxStatic}/common/style.css?v=4.0"
	media="all">

</head>
<body class="layui-main">

	<form class="layui-form layui-form-pane" action="">


		<blockquote class="layui-elem-quote layui-text">

			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">用户名</label>
					<div class="layui-input-block">
						<input type="text" name="date" id="date1" autocomplete="off"
							class="layui-input" lay-key="2">
					</div>
				</div>

				<div class="layui-inline">
					<label class="layui-form-label">性别</label>
					<div class="layui-input-inline">
						<select name="quiz1">
							<option value="">请选择性别</option>
							<option value="男" selected="">男</option>
							<option value="女">女</option>
						</select>
					</div>

				</div>

				<div class="layui-inline">

					<button class="layui-btn layui-btn-normal">
						<i class="fa fa-search"></i> 搜索
					</button>
				</div>
			</div>
		</blockquote>
	</form>
	<div style="height: fit-content;">
		<div id=toolbar role="group">
			<button type="button" class="btn btn-primary" onclick="add()">
				<i class="fa fa-plus" aria-hidden="true"></i>添加
			</button>
			<button type="button" class="btn btn-danger" onclick="batchRemove()">
				<i class="fa fa-trash" aria-hidden="true"></i>删除
			</button>
		</div>
		<table id="exampleTable" data-mobile-responsive="true">
		</table>
	</div>




	<script src="${ctxStatic}/jquery/jquery.min.js?v=2.1.4"></script>
	<script src="${ctxStatic}/BeginnerAdmin/plugins/layui/layui.js"></script>
	<script src="${ctxStatic}/BeginnerAdmin/plugins/layui/lay/modules/layui.js"></script>
	<script src="${ctxStatic}/bootstrap-table/bootstrap-table.min.js"></script>
	<script
		src="${ctxStatic}/bootstrap-table/bootstrap-table-mobile.min.js"></script>
	<script
		src="${ctxStatic}/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>

	<script type="text/javascript">
		var prefix='${ctx}/sys/sysFunc';
		$(function() {

			$('#exampleTable')
					.bootstrapTable(
							{
								method : 'get', // 服务器数据的请求方式 get or post
								url : '${ctx}/sys/sysFunc/listPage', // 服务器数据的加载地址
								striped : true, // 设置为true会有隔行变色效果
								dataType : "json", // 服务器返回的数据类型
								pagination : true, // 设置为true会在底部显示分页条
								// queryParamsType : "limit",
								// //设置为limit则会发送符合RESTFull格式的参数
								singleSelect : false, // 设置为true将禁止多选
								iconSize : 'outline',
								toolbar : '#toolbar',
								// contentType : "application/x-www-form-urlencoded",
								// //发送到服务器的数据编码类型
								pageSize : 10, // 如果设置了分页，每页数据条数
								pageNumber : 1, // 如果设置了分布，首页页码
								search : false, // 是否显示搜索框
								//showColumns : true, // 是否显示内容下拉框（选择显示的列）
								sidePagination : "client", // 设置在哪里进行分页，可选值为"client" 或者
								// "server"
								// queryParams : queryParams,
								// //请求服务器数据时，你可以通过重写参数的方式添加一些额外的参数，例如 toolbar 中的参数 如果
								// queryParamsType = 'limit' ,返回参数必须包含
								// limit, offset, search, sort, order 否则, 需要包含:
								// pageSize, pageNumber, searchText, sortName,
								// sortOrder.
								// 返回false将会终止请求
								columns : [
										{ // 列配置项
											// 数据类型，详细参数配置参见文档http://bootstrap-table.wenzhixin.net.cn/zh-cn/documentation/
											checkbox : true
										// 列表中显示复选框
										},
										{
											field : 'id', // 列字段名
											title : 'ID' // 列标题
										},
										{
											field : 'funcName',
											title : '功能名称'
										},
										{
											field : 'funcJsmethod',
											title : 'JS方法名'
										},
										{
											field : 'showType',
											title : '显示位置'
										},
										{
                                        field : 'icon',
                                        title : '图标'
                                    },
                                    {
                                        field : 'createByName',
                                        title : '创建人'
                                    },

										{
											title : '操作',
											field : 'id',
											align : 'center',
											formatter : function(value, row,
													index) {
												var e = '<a class="btn btn-primary btn-sm" href="#" mce_href="#" title="编辑" onclick="edit(\''
														+ row.id
														+ '\')"><i class="fa fa-edit"></i></a> ';
												var d = '<a class="btn btn-warning btn-sm" href="#" title="删除"  mce_href="#" onclick="remove(\''
														+ row.id
														+ '\')"><i class="fa fa-remove"></i></a> ';
												return e + d;
											}
										} ]
							});
		});

        function remove(id) {
            layer.confirm('确定要删除选中的记录？', {
                btn : [ '确定', '取消' ]
            }, function() {
                $.ajax({
                    url : prefix + "/remove",
                    type : "get",
                    data : {
                        'id' : id
                    },
                    success : function(r) {
                        if (r.code === 0) {
                            layer.msg("删除成功");
                            reLoad();
                        } else {
                            layer.msg(r.msg);
                        }
                    }
                });
            })

        }
        function reLoad() {
            $('#exampleTable').bootstrapTable('refresh');
        }
		layui.use([ 'form' ], function() {
			var form = layui.form
		});

        function add() {
            // iframe层
            layer.open({
                type : 2,
                title : '添加按钮',
                maxmin : true,
                shadeClose : false, // 点击遮罩关闭层
                area : [ '800px', '520px' ],
                content : prefix + '/formLayuiDemo' // iframe的url
            });
        }
        function edit(id) {
            layer.open({
                type : 2,
                title : '编辑',
                maxmin : true,
                shadeClose : false, // 点击遮罩关闭层
                area : [ '800px', '520px' ],
                content : prefix + '/formLayuiDemo?id=' + id // iframe的url
            });
        }
	</script>
</body>
</html>