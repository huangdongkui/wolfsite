
var layer;
layui.use('layer', function () {
    layer = layui.layer;

});

var WTable = (function (window) {
    var WTable = function () {
    }

    WTable.WBootstrapTable = function (p_config) {

        var obj = {

            baseConfig: {
                method: 'get', // 服务器数据的请求方式 get or post
                url: "", // 服务器数据的加载地址
                striped: true, // 设置为true会有隔行变色效果
                dataType: "json", // 服务器返回的数据类型
                pagination: true, // 设置为true会在底部显示分页条
                showRefresh: true,
                // idField:"id",
                // queryParamsType : "limit",
                // //设置为limit则会发送符合RESTFull格式的参数
                singleSelect: false, // 设置为true将禁止多选
                iconSize: 'outline',
                toolbar: '#toolbar',
                // contentType : "application/x-www-form-urlencoded",
                // //发送到服务器的数据编码类型
                pageSize: 10, // 如果设置了分页，每页数据条数
                pageNumber: 1, // 如果设置了分布，首页页码
                search: false, // 是否显示搜索框
                //showColumns : true, // 是否显示内容下拉框（选择显示的列）
                sidePagination: "server", // 设置在哪里进行分页，可选值为"client" 或者
                // "server"
                queryParams: function (params) {
                    var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                        limit: params.limit,   //页面大小
                        offset: params.offset,  //页码
                        order: params.order,
                        sort: params.sort
                    };
                    return temp;
                },
                elementId: ""
                // //请求服务器数据时，你可以通过重写参数的方式添加一些额外的参数，例如 toolbar 中的参数 如果
                // queryParamsType = 'limit' ,返回参数必须包含
                // limit, offset, search, sort, order 否则, 需要包含:
                // pageSize, pageNumber, searchText, sortName,
                // sortOrder.
                // 返回false将会终止请求

            },
            //bootstrapTable对象
            _bootstrapTable: {},

            add: function () {
                // iframe层
                layer.open({
                    type: 2,
                    title: '添加按钮',
                    maxmin: true,
                    shadeClose: false, // 点击遮罩关闭层
                    area: ['800px', '520px'],
                    content: this.baseConfig.addUrl // iframe的url
                });
            },

            baseEdit: function (data) { //修改

            	var params = Object.keys(data).map(i => `${i}=${data[i]}`).join('&');
            	
                layer.open({
                    type: 2,
                    title: '编辑',
                    maxmin: true,
                    shadeClose: false, // 点击遮罩关闭层
                    area: ['800px', '520px'],
                    content: this.baseConfig.editUrl + '?' + params.toString() // iframe的url
                });
            },

            //删除
            baseRemove: function (data) {

            	var params = Object.keys(data).map(i => `${i}=${data[i]}`).join('&');
            
            	
                layer.confirm('确定要删除选中的记录？', {
                    btn: ['确定', '取消']
                }, function () {
                    $.ajax({
                        url: obj.baseConfig.deleteUrl+'?' + params.toString(),
                        type: "DELETE",
                        async:false,
                        success: function (r) {
                            if (r.code === 0) {
                                layer.msg("删除成功");
                                obj._bootstrapTable.bootstrapTable('refresh');
                            } else {
                                layer.msg(r.msg);
                            }
                        }
                    });

                });

            },
            reload:function(option){
            	if(option){
            		  this._bootstrapTable.bootstrapTable("refreshOptions",option);	
            	}
               
                this._bootstrapTable.bootstrapTable('refresh');
            }

        }


        $.extend(obj.baseConfig, p_config);
        obj._bootstrapTable = $(obj.baseConfig.elementId).bootstrapTable(obj.baseConfig);

        return obj;
    };

    return WTable;
})();


//获取字典标签
function getDictLabel(data, value, defaultValue) {
    for (var i = 0; i < data.length; i++) {
        var row = data[i];
        if (row.value == value) {
            return row.label;
        }
    }
    return defaultValue;
}

//根据权限加载按钮
function initButton(parentId) {
  $.get(ctx+"/sys/menu/menuListByParentId",{parentId:parentId},function (r) {
    for (var i = 0; i < r.length; i++) {
    if(r[i].icon){alert(r[i].icon)}
    var btn='<button type="button" class="btn btn-primary" onclick="add()">'
    +'<i class="icon-#icon#" aria-hidden="true"></i>#btnName#</button>';
    $("#toolbar").append($(btn.replace("#btnName#",r[i].name).replace("#icon#",r[i].icon)));
    }

    }); 
}
