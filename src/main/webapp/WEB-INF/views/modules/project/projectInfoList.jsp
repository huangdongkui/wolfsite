<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>项目信息管理</title>
<meta name="decorator" content="default" />
<script type="text/javascript">
	$(document).ready(function() {

	});
	function page(n, s) {
		$("#pageNo").val(n);
		$("#pageSize").val(s);
		$("#searchForm").submit();
		return false;
	}
</script>
</head>
<body>
	<ul class="nav nav-tabs">
		<li class="active"><a href="${ctx}/project/projectInfo/">项目信息列表</a></li>
		<li><a href="${ctx}/project/projectInfo/form">项目信息申请</a></li>
	</ul>
	<form:form id="searchForm" modelAttribute="projectInfo"
		action="${ctx}/project/projectInfo/" method="post"
		class="breadcrumb form-search">
		<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
		<input id="pageSize" name="pageSize" type="hidden"
			value="${page.pageSize}" />
		<ul class="ul-form">
			<li class="btns"><input id="btnSubmit" class="btn btn-primary"
				type="submit" value="查询" /></li>
			<li class="clearfix"></li>
		</ul>
	</form:form>
	<sys:message content="${message}" />
	<table id="contentTable"
		class="table table-striped table-bordered table-condensed">
		<thead>
			<tr>
				<th>项目名称</th>
				<th>项目类型</th>
				<th>创建者</th>
				<th>创建时间</th>
				<th>更新时间</th>
				<th>备注信息</th>
				<shiro:hasPermission name="project:projectInfo:edit">
					<th>操作</th>
				</shiro:hasPermission>
			</tr>
		</thead>
		<tbody>
			<c:forEach items="${page.list}" var="projectInfo">
				<tr>
					<td><a
						href="${ctx}/project/projectInfo/form?id=${projectInfo.id}">
							${projectInfo.projectName} </a></td>
					<td>${projectInfo.projectType}</td>
					<td>${projectInfo.createBy.id}</td>
					<td><fmt:formatDate value="${projectInfo.createDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td><fmt:formatDate value="${projectInfo.updateDate}"
							pattern="yyyy-MM-dd HH:mm:ss" /></td>
					<td>${projectInfo.remarks}</td>
					<td><a
						href="${ctx}/project/projectInfo/form?id=${projectInfo.id}">修改</a>
						<a href="${ctx}/project/projectInfo/delete?id=${projectInfo.id}"
						onclick="return confirmx('确认要删除该项目信息吗？', this.href)">删除</a></td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div class="pagination">${page}</div>
</body>
</html>