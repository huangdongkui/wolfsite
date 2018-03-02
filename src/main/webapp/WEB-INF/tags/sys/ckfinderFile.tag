<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/include/taglib.jsp"%>
<%@ attribute name="input" type="java.lang.String" required="true" description="输入框"%>
<%@ attribute name="type" type="java.lang.String" required="true" description="files、images、flash、thumb"%>
<%@ attribute name="uploadPath" type="java.lang.String" required="true" description="打开文件管理的上传路径"%>
<%@ attribute name="selectMultiple" type="java.lang.Boolean" required="false" description="是否允许多选"%>
<%@ attribute name="readonly" type="java.lang.Boolean" required="false" description="是否查看模式"%>
<%@ attribute name="maxWidth" type="java.lang.String" required="false" description="最大宽度"%>
<%@ attribute name="maxHeight" type="java.lang.String" required="false" description="最大高度"%>
<%@ attribute name="bussinessId" type="java.lang.String" required="true" description="业务ID"%>
<div id="${input}Preview">
<table id="${input}treeTable" class="table table-striped table-bordered table-condensed">
<thead><tr><th>文件名</th><th>文件类型</th><th>文件大小</th><th>上传时间</th><th>上传者</th><th>操作</th></tr></thead><tbody></tbody></table>
</div>

<c:if test="${!readonly}">

       <select id="${input}bFileType" class="input-slarge" Width="400">
        <option value="">
            文件类型
        </option>
          	<c:forEach items="${fns:getDictList('filetype')}" var="dict">
						<option value="${dict.value}">${dict.label}</option>
					</c:forEach>
    </select>
    &nbsp;
<a href="javascript:" onclick="${input}FinderOpen();" class="btn">${selectMultiple?'添加':'选择'}</a></c:if>
<script type="text/javascript">
	function ${input}FinderOpen(){
		if($("#${input}bFileType").select2("data").id===""){
			alertx("请选择文件类型");
			return;
		}
		//<c:if test="${type eq 'thumb'}"><c:set var="ctype" value="images"/></c:if><c:if test="${type ne 'thumb'}"><c:set var="ctype" value="${type}"/></c:if>
		var date = new Date(), year = date.getFullYear(), month = (date.getMonth()+1)>9?date.getMonth()+1:"0"+(date.getMonth()+1);
		var url = "${ctxStatic}/ckfinder/ckfinder.html?type=${ctype}&start=${ctype}:${uploadPath}/"+year+"/"+month+
			"/&action=js&func=${input}SelectAction&thumbFunc=${input}ThumbSelectAction&cb=${input}Callback&dts=${type eq 'thumb'?'1':'0'}&sm=${selectMultiple?1:0}";
	
			windowOpen(url,"文件管理",1000,700);
		//top.$.jBox("iframe:"+url+"&pwMf=1", {title: "文件管理", width: 1000, height: 500, buttons:{'关闭': true}});
	}
	
	function ${input}SelectAction(fileUrl, data, allFiles){
		var tempSelectFiles=[];
		var url="", files=ckfinderAPI.getSelectedFiles();
		for(var i=0; i<files.length; i++){//<c:if test="${type eq 'thumb'}">
			url += files[i].getThumbnailUrl();//</c:if><c:if test="${type ne 'thumb'}">
			url += files[i].getUrl();//</c:if>
			if (i<files.length-1) url+="|";
			
			tempSelectFiles.push({selectUrl:files[i].getUrl(),filesize:files[i].size,filetype:files[i].ext,filename:files[i].name,bessnissType:$("#bFileType").val()});
		}//<c:if test="${selectMultiple}">
		
		$("#${input}").val($("#${input}").val()+($("#${input}").val(url)==""?url:"|"+url));//</c:if><c:if test="${!selectMultiple}">
		$("#${input}").val(url);//</c:if>
		updateFileToDB(tempSelectFiles);

	}
	function ${input}ThumbSelectAction(fileUrl, data, allFiles){
		var url="", files=ckfinderAPI.getSelectedFiles();
		for(var i=0; i<files.length; i++){
			url += files[i].getThumbnailUrl();
			if (i<files.length-1) url+="|";
		}//<c:if test="${selectMultiple}">
		$("#${input}").val($("#${input}").val()+($("#${input}").val(url)==""?url:"|"+url));//</c:if><c:if test="${!selectMultiple}">
		$("#${input}").val(url);//</c:if>
		//${input}Preview();
		//top.$.jBox.close();
	}
	function ${input}Callback(api){
		ckfinderAPI = api;
	}
	function Del(id){
		confirmx('确认要删除此文件吗',function(){
			hrefCall(id)
		});	
		
	}

	function hrefCall(id){
		var url='${ctx}/sys/file/delete';
		$.get(url,{id:id},function(e){
			${input}Preview();
		});
	}
	function ${input}DelAll(){
		//$("#${input}").val("");
		//${input}Preview();
	}
	var _tr='<tr><td><a href="{地址}">{文件名}</a></td><td>{文件业务类型}</td><td>{大小}</td><td>{日期}</td><td>{上传人}</td><td><a href="javascript:" onclick="Del(\'{id}\');">删除</a></td></tr>';
	function ${input}Preview(){
		
		var url='${ctx}/sys/file/list';
    	var trStr='';
        $.get(url,{bussinessId:'${bussinessId}'},function(list){
        	$("#${input}treeTable").children("tbody").children().remove()
        	var trhtml='';
        	for (var i=0; i<list.length; i++){

				trhtml+=_tr.replace(/{文件名}/g,list[i].fileName)
				.replace("{文件业务类型}",list[i].bussnissType)
				.replace("{大小}",list[i].fileSize)
				.replace("{日期}",list[i].createDate)
				.replace("{上传人}",list[i].uploadName)
				.replace("{地址}",list[i].filePath)
				.replace("{id}",list[i].id);
        	}
        	
        	$("#${input}treeTable").append(trhtml);
		});
        
	}
	
	${input}Preview();
	
	function updateFileToDB(tempSelectFiles)
	{	
		var url='${ctx}/sys/file/upload/';
		for (var i=0; i<tempSelectFiles.length; i++){
			
			$.post(url,{pkUid:'',filePath:tempSelectFiles[i].selectUrl,fileName:tempSelectFiles[i].filename,fileSize:tempSelectFiles[i].filesize,fileType:tempSelectFiles[i].ext,bussnissType:$("#${input}bFileType").select2("data").id,bussinessId:'${bussinessId}'},function(result){

				if(result.mscode==="1"){
					
					var tr='';
					tr+=_tr.replace("{文件名}",result.results.fileName)
					.replace("{文件业务类型}",$("#${input}bFileType").select2("data").text)
					.replace("{大小}",result.results.fileSize)
					.replace("{日期}",result.results.createDate)
					.replace("{上传人}",result.results.uploadName);
					$("#${input}treeTable").append(tr);
				}
				
					
				alertx(result.mstext);
			});
		}
		
	}
</script>