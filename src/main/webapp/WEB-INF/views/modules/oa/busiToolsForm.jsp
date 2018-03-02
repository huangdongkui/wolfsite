<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<html>
<head>
<title>工具管理</title>
<meta name="decorator" content="default" />
<script src="/wolfsite/static/common/workflow.js" type="text/javascript"></script>

<script type="text/javascript">


	$(document).ready(function() {
				//$("#name").focus();
				$("#inputForm").validate(
								{
									submitHandler : function(form) {
										//loading('正在提交，请稍等...');
										form.submit();

										//parent.setTabActive();

									},
									errorContainer : "#messageBox",
									errorPlacement : function(error, element) {
										$("#messageBox").text("输入有误，请先更正。");
										if (element.is(":checkbox")
												|| element.is(":radio")
												|| element.parent().is(".input-append")) {
											error.appendTo(element.parent()
													.parent());
										} else {
											error.insertAfter(element);

										}
									}
								});

				
				workflow.config.taskid = '${busiTools.act.taskId}';
				workflow.config.ctx='${ctx}';
				workflow.config.taskDefKey = '${busiTools.act.taskDefKey}';
				workflow.config.status='<%= request.getParameter("act.status")%>';
				workflow.config.saveOnlyAction='/oa/busiTools/saveOnly';
				workflow.config.procDefKey='process_tool';
				workflow.config.businessTable='busi_tools';
				
				workflow.init();
				
				//initFlowAuditOrView(taskDefKey);//初始华页面
				//initButtun(taskDefKey);//初始按钮

				//$(".flowbtn").click(clickButtun);
			});

<%-- 	function clickButtun() {
		var btnVal = $(this).val();
		
		if (btnVal === '提交') {//申请提交
			submitWorkFlow();
		} else {//审批

			if (!taskid) {
				alertx("任务ID不能为空");
				return;
			}

			if (btnVal === '同意' || btnVal === '完成') {
				complete(taskid, [ {
					key : 'pass',
					value : 1,
					type : 'I'
				} ]);
			} else if (btnVal === '驳回') {
				complete(taskid, [ {
					key : 'pass',
					value : 0,
					type : 'I'
				} ]);
			} else if (btnVal === '重新提交') {
				reSubmitWorkFlow();
			} else if (btnVal === '销毁') {
				complete(taskid, [ {
					key : 'pass',
					value : 0,
					type : 'I'
				} ]);
			}

		}
	}
	/* 流程申请 */
	function submitWorkFlow() {
		var url = ctx+"/oa/busiTools/saveOnly";
		var postData = $("#inputForm").serializeArray();
		$.post(url, postData, function(obj) {
			if (obj.id) {
				callStartFlow('process_tool', 'busi_tools', obj.id,
						obj.toolName);
			}

		});
	}
	
	//重新申请
	function reSubmitWorkFlow(){
		var url = ctx+"/oa/busiTools/saveOnly";
		var postData = $("#inputForm").serializeArray();
		$.post(url, postData, function(obj) {
			if (obj.id) {	
				complete(taskid, [ {
					key : 'pass',
					value : 1,
					type : 'I'
				},{key : 'title',
					value : obj.toolName,
					type : 'S'} ]);
				
			}

		});
	}

	//路由审批碳或查看页面
	function initFlowAuditOrView(taskDefKey) {

		if (taskDefKey.indexOf('audit') != -1) {
			$(":input").each(function myfunction(o) {
				var typestr = $(this).attr("type");

				if (typestr == "text") {
					$(this).replaceWith($(this).val());
				} else if (typestr == undefined) {
					if ($(this).html().indexOf("textarea")) {
						$(this).replaceWith($(this).val());
					}
				}

			});

			$("span > font").remove();

		}

	}

	/* 控制按钮显示 */
	function initButtun(taskDefKey) {
		$(".flowbtn").hide();

		var status='<%= request.getParameter("act.status")%>';
		if(status==='finish'){
			return;
		}
		$(".flowbtn").each(function() {
			var btnVal = $(this).val();
			/* 审批 */
			if (taskDefKey.indexOf('audit') != -1) {
				if (btnVal === "同意"||btnVal==="驳回") {
					$(this).show();
				}
			} else if (taskDefKey.indexOf('modify') != -1) {/* 修改 */

				if (btnVal === "重新提交" || btnVal === "销毁" || btnVal === "保存") {
					$(this).show();
				}

			} else if (taskDefKey.indexOf('end') != -1) {/* 结束 */
				if (btnVal === "完成") {
					$(this).show();
				}

			} else {
				if (btnVal == "提交" || btnVal == "保存") {
					$(this).show();
				}
			}

		});

	}

	/* 调用提交流程请求 */
	function callStartFlow(p_procDefKey, p_businessTable, p_businessId, p_title) {
		var url = ctx+"/act/task/startFlow";
		$.post(url,{
							procDefKey : p_procDefKey,
							businessTable : p_businessTable,
							businessId : p_businessId,
							title : p_title
						},
						function(obj) {
							if (obj === "true") {
								alertx("流程提交成功！");
								top.$.fn.jerichoTab.closeCurrentTab();
								var a = $('<a href="'+ctx+'/act/task/myApply"  target="mainFrame" jerichotabindex="2">我的申请</a>');
								parent.addTab(a);
								//parent.addTabPage('我的申请', '${ctx}/a/act/task/myApply',true,'');
							} else {
								alertx("流程提交失败！:" + obj);
							}
						});
	}

	/**
	 * 完成任务
	 * @param {Object} taskId
	 */
	function complete(taskId, variables) {
		// 转换JSON为字符串
		var keys = "", values = "", types = "";
		if (variables) {
			$.each(variables, function(idx) {
				if (keys != "") {
					keys += ",";
					values += ",";
					types += ",";
				}
				keys += this.key;
				values += this.value;
				types += this.type;
			});
		}
		// 发送任务完成请求
		$.post('${ctx}/act/task/complete/', {
			taskId : taskId,
			"vars.keys" : keys,
			"vars.values" : values,
			"vars.types" : types
		}, function(data) {
			//top.$.jBox.tip('任务完成');
			alertx('任务完成');
			//location = '${pageContext.request.contextPath}' + data;
			location.reload();
		});
	} --%>
</script>

</head>
<body>

	<form:form id="inputForm" modelAttribute="busiTools"
		action="${ctx}/oa/busiTools/save" method="post"
		class="form-horizontal">
		<form:hidden path="id" />
		<sys:message content="${message}" />
		<div class="control-group">
			<label class="control-label">工具名：</label>
			<div class="controls">
				<form:input path="toolName" htmlEscape="false" maxlength="100"
					class="input-xlarge required" />
				<span class="help-inline"><font color="red">*</font> </span>
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

			<input id="btnFinish" class="btn btn-primary flowbtn" type="button"
				value="完成" /> <input id="btnSubmit" class="btn btn-primary flowbtn"
				type="button" value="提交" /> <input id="btnReSubmit"
				class="btn btn-primary flowbtn" type="button" value="重新提交" /> <input
				id="btnDestroy" class="btn btn-primary flowbtn" type="button"
				value="销毁" /> <input id="btnSave" class="btn btn-primary flowbtn"
				type="submit" value="保存" /> <input id="btnYes"
				class="btn btn-primary flowbtn" type="button" value="同意" />&nbsp; <input
				id="btnNo" class="btn btn-inverse flowbtn" type="button" value="驳回" />&nbsp;

			<input id="btnCancel" class="btn" type="button" value="返 回"
				onclick="history.go(-1)" />
		</div>


		<act:histoicFlow procInsId="${busiTools.act.procInsId}" />
	</form:form>
</body>
</html>