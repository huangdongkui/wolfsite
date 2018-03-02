/**
 * 流程公共方法
 */
var workflow = {

	config : {
		taskid : '',
		taskDefKey : '',
		ctx : '',
		saveOnlyAction : '',
		status : '',// finish todo
		procDefKey : '',
		businessTable : ''
	},

	init : function() {

		// 验证工作流必填参数
		if (workflow.config.status != '') {
			debugger;
			for ( var i in this.config) {
				if (this.config[i] === '') {
					alertx(i + "不能为空");
					$(".flowbtn").hide();
					return;
				}

			}
		}
		
		this.initFlowAuditOrView(this.config.taskDefKey);// 初始华页面
		this.initButtun(this.config.taskDefKey);// 初始按钮

	},
	// 路由审批碳或查看页面
	initFlowAuditOrView : function(taskDefKey) {

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

	},
	/* 控制按钮显示 */
	initButtun : function(taskDefKey) {
		$(".flowbtn").hide();
		$(".flowbtn").click(this.clickButtun);
		if (workflow.config.status === 'finish') {
			return;
		}

		$(".flowbtn").each(function() {
			var btnVal = $(this).val();
			/* 审批 */
			if (taskDefKey.indexOf('audit') != -1) {
				if (btnVal === "同意" || btnVal === "驳回") {
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

	},
	clickButtun : function() {
		var taskid = workflow.config.taskid;

		var btnVal = $(this).val();

		if (btnVal === '提交') {// 申请提交
			workflow.submitWorkFlow();
		} else {// 审批

			if (!taskid) {
				alertx("任务ID不能为空");
				return;
			}

			if (btnVal === '同意' || btnVal === '完成') {
				workflow.complete(taskid, [ {
					key : 'pass',
					value : 1,
					type : 'I'
				} ]);
			} else if (btnVal === '驳回') {
				workflow.complete(taskid, [ {
					key : 'pass',
					value : 0,
					type : 'I'
				} ]);
			} else if (btnVal === '重新提交') {
				workflow.reSubmitWorkFlow();
			} else if (btnVal === '销毁') {
				workflow.complete(taskid, [ {
					key : 'pass',
					value : 0,
					type : 'I'
				} ]);
			}

		}
	},
	/* 调用提交流程请求 */
	callStartFlow : function(p_procDefKey, p_businessTable, p_businessId,
			p_title) {
		var url = workflow.config.ctx + "/act/task/startFlow";
		$
				.post(
						url,
						{
							procDefKey : p_procDefKey,
							businessTable : p_businessTable,
							businessId : p_businessId,
							title : p_title
						},
						function(obj) {
							if (obj === "true") {
								alertx("流程提交成功！");
								top.$.fn.jerichoTab.closeCurrentTab();
								var a = $('<a href="'
										+ workflow.config.ctx
										+ '/act/task/myApply"  target="mainFrame" jerichotabindex="2">我的申请</a>');
								parent.addTab(a);
							} else {
								alertx("流程提交失败！:" + obj);
							}
						});
	},
	/**
	 * 完成任务
	 * 
	 * @param {Object}
	 *            taskId
	 */
	complete : function(taskId, variables) {
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
		$.post(workflow.config.ctx + '/act/task/complete/', {
			taskId : taskId,
			"vars.keys" : keys,
			"vars.values" : values,
			"vars.types" : types
		}, function(data) {
			// top.$.jBox.tip('任务完成');
			alertx('任务完成');
			// location = '${pageContext.request.contextPath}' + data;
			location.reload();
		});
	},
	// 重新申请
	reSubmitWorkFlow : function() {
		var url = workflow.config.ctx + workflow.config.saveOnlyAction;
		var postData = $("#inputForm").serializeArray();
		$.post(url, postData, function(obj) {
			if (obj.id) {
				workflow.complete(workflow.config.taskid, [ {
					key : 'pass',
					value : 1,
					type : 'I'
				}, {
					key : 'title',
					value : obj.toolName,
					type : 'S'
				} ]);

			}

		});
	},
	/* 流程申请 */
	submitWorkFlow : function() {
		var url = workflow.config.ctx + workflow.config.saveOnlyAction;
		var postData = $("#inputForm").serializeArray();
		$.post(url, postData, function(obj) {
			if (obj.id) {
				workflow.callStartFlow(workflow.config.procDefKey,
						workflow.config.businessTable, obj.id, obj.toolName);
			}

		});
	}

};