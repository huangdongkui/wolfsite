function rootclick(o) {

	//非叶子节点
	var hasChildrenLi = '<li class=""><a onclick="nodeclick(this)" data-href=".menu3-#id#" href="javascript:void(0);" target="mainFrame"><i class="icon-circle-arrow-right"></i>&nbsp;#menuName#</a>'
			+ '</li>';

	//叶子节点
	var liLastnode = '<li style="display: list-item;"><a onclick="addTab($(this))" href="#href#" target="mainFrame"><i class="icon-user"></i>&nbsp;#menuName#</a></li>';

	var id = $(o).attr("href");
	
	var len = $(id + ' > .accordion-inner').children().length;
	if (len == 0) {

		$.get(ctx+'/sys/menu/menuListByParentId', {
			parentId : id.split('-').pop()
		}, function(o) {

			var listr = '<ul class="nav nav-list">';

			for (var i = 0; i < o.length; i++) {
				if(o[i].href){

				listr += liLastnode.replace("#menuName#", o[i].name).replace("#href#", '/wolfsite/a'+o[i].href);
					}
				else{
					
					
				listr += hasChildrenLi.replace("#menuName#", o[i].name).replace(
							"#id#", o[i].id);
				}
			}

			listr += '</ul>';

			$(id + ' > .accordion-inner').append(listr);

		});

	}
}



function nodeclick(obj) {

	//非叶子节点
	var hasChildrenLi = '<li class=""><a onclick="nodeclick(this)" data-href=".menu3-#id#" href="javascript:void(0);" target="mainFrame"><i class="icon-circle-arrow-right"></i>&nbsp;#menuName#</a>'
			+ '</li>';
	
	var id = $(obj).attr("data-href");

	//叶子节点
	var liLastnode = '<li class="'+ id+ '" style="display: list-item;"><a onclick="addTab($(this))" href="#href#" target="mainFrame"><i class="icon-user"></i>&nbsp;#menuName#</a></li>';

	var len = $(obj).next().length;
	if (len == 0) {

		$.get(ctx+'/sys/menu/menuListByParentId', {
			parentId : id.split('-').pop()
		}, function(o) {

			var listr = '<ul class="nav nav-list">';

			for (var i = 0; i < o.length; i++) {
				if(o[i].href){
					listr += liLastnode.replace("#menuName#", o[i].name).replace("#href#", '/wolfsite/a'+o[i].href+'?menuid='+o[i].id);
				}
				else{
					listr += hasChildrenLi.replace("#menuName#", o[i].name).replace(
							"#id#", o[i].id);
				}
				
			}

			listr += '</ul>';

			$(obj).parent().append(listr);

		});

	} else {

		$(obj).next().toggle();
	}
}


$(document).ready(
		function() {
			var menuId = "#menu-1";
			$.get(ctx+"/sys/menu/tree?parentId=1", function(data) {
				if (data.indexOf("id=\"loginForm\"") != -1) {
					alert('未登录或登录超时。请重新登录，谢谢！');
					top.location = "${ctx}";
					return false;
				}

				$("#left .accordion").hide();
				$("#left").append(data);

				// 链接去掉虚框
				$(menuId + " a").bind("focus", function() {
					if (this.blur) {
						this.blur()
					}
					;
				});

				// 二级标题
				$(menuId + " .accordion-heading a").click(
						function() {
							$(menuId + " .accordion-toggle i").removeClass(
									'icon-chevron-down').addClass(
									'icon-chevron-right');
							if (!$($(this).attr('data-href')).hasClass('in')) {
								$(this).children("i").removeClass(
										'icon-chevron-right').addClass(
										'icon-chevron-down');
							}
						});
				// 二级内容
				$(menuId + " .accordion-body a").click(function() {
					$(menuId + " li").removeClass("active");
					$(menuId + " li i").removeClass("icon-white");
					$(this).parent().addClass("active");
					$(this).children("i").addClass("icon-white");
				});

				// 默认选中第一个菜单
				// $(menuId + " .accordion-body a:first i").click();
				// $(menuId + " .accordion-body li:first li:first a:first
				// i").click();
			});
		});
