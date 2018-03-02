<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
	<title>工具管理</title>
	<meta name="decorator" content="default"/>
	<script type="text/javascript">
		$(document).ready(function() {
			
		});
		function page(n,s){
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
        	return false;
        }
	 
	</script>
</head>
<body>

	<form:form id="searchForm" modelAttribute="busiTools" action="${ctx}/oa/busiTools/" method="post" class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
		<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
		<ul class="ul-form">
			<li><label>工具名：</label>
				<form:input path="toolName" htmlEscape="false" maxlength="100" class="input-medium"/>
			</li>
			<li class="btns"><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></li>
			<li class="btns">
		<%-- 	<a onclick="parent.addTabPage('添加工具', '${ctx}/oa/busiTools/form')" class="btn btn-primary" href="javascript:(0);"  target="mainFrame" jerichotabindex="2">
			添加</a> --%>
				<a class="btn btn-primary" href="${ctx}/oa/busiTools/form" >
			添加</a>
			</li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}"/>
	<table id="contentTable" class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>工具名</th>
				<th>创建者</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="oa:busiTools:edit"><th>操作</th></shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
		<c:forEach items="${page.list}" var="busiTools">
			<tr>
				<td><a onclick="parent.addTabPage('工具查看', '${ctx}/oa/busiTools/form?id=${busiTools.id}')" href="javascript:(0);"  target="mainFrame" jerichotabindex="2">
					${busiTools.toolName}
				</a>
			
				</td>
				<td>
					${busiTools.createBy.id}
				</td>
				<td>
					<fmt:formatDate value="${busiTools.updateDate}" pattern="yyyy-MM-dd HH:mm:ss"/>
				</td>
				<td>
					${busiTools.remarks}
				</td>
				<shiro:hasPermission name="oa:busiTools:edit"><td>
    				<a href="${ctx}/oa/busiTools/form?id=${busiTools.id}">修改</a>
					<a href="${ctx}/oa/busiTools/delete?id=${busiTools.id}" onclick="return confirmx('确认要删除该工具吗？', this.href)">删除</a>
				</td></shiro:hasPermission>
			</tr>
		</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>