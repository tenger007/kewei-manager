<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${APP_PATH}/static/js/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/static/css/main.css">
	<link href="${APP_PATH}/static/js/bootstrap/css/select2.min.css" rel="stylesheet" />
	 <link rel="stylesheet" href="${APP_PATH}/ueditor/themes/default/css/ueditor.css" type="text/css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	.tree-closed {
	    height : 40px;
	}
	.tree-expanded {
	    height : auto;
	    
	}
	.edui-editor{
		z-index:0!important;
	}
	body {
font: normal 130% Helvetica, Arial, sans-serif;
}
	</style>
  </head>
  
  <body>
   <%@include file="/WEB-INF/common/userinfo.jsp"%>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-3 sidebar">
			<ul style="width: auto" class="list-group">
							<%@include file="/WEB-INF/common/common.jsp"%>
				</ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-9 col-md-offset-3 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>重点领域专家编辑</h3>
			  </div>
			  <div class="panel-body">
           <form style="display:"   method="post" id="contentForm" role="form">
           <input type="hidden" id="id" name="id" value="${expert.id}">
           <input type="hidden" id="fieldid" name="id" value="${expert.fieldid}">
           <div class="input-group">
				  <div class="input-group-addon" >技术领域</div>
					<select id="sel_menu2" name="field" class="form-control" style="width:820px;">
					<option value="${field }">${field }</option>
				    <c:forEach var="obj" items="${fields}" varStatus="i">
		            <option value="${obj}" >${obj}</option>
		       		</c:forEach>
				 	  </select>
				  </div>
				  <br>
           <div class="input-group">
				  <div class="input-group-addon" >标题</div>
					<input type="text" class="form-control " style="width:800px;"  id="title"  value="${expert.title }" name="title" placeholder="请输入文章标题">
				  </div>
				  <br>
				   <div class="input-group">
				   <div class="input-group-addon" >专家</div>
					<input type="text" class="form-control" id="name" style="width:830px;" value="${expert.name }" name="author" placeholder="请输入专家">
				  </div>
				  <br>
				  <div class="input-group">
				   <div class="input-group-addon" >专家简介</div>
					<input type="text" class="form-control" id="summary" style="width:800px;" value="${expert.summary }" name="authorAffiliation" placeholder="请输入专家简介">
				  </div>
				  <br>
				   <div class="input-group">
				  <div class="input-group-addon" >分布时间</div>
				  <input type="date" style="width:280px;" class="form-control" id="pbdate"  value="${expert.pbdate }" name="pbdate" placeholder="请输入发布时间">
				  <div class="input-group-addon">关键词</div>
					<input type="text" style="width:280px;" class="form-control" id="keyword" name="issue" value="${expert.keyword}" placeholder="请输入关键词">
				  </div>
				  <div class="form-group">
					<label for="contents" id="field"> </label>
					<script id="contents" type="text/plain" style="width:auto!important;height:100%;">
					${expert.content}
					</script>
				  </div>
				  <button id="enable" type="button" class="btn btn-warning" onclick="setEnabled()"><i class="glyphicon glyphicon-wrench"></i> 编辑</button>
                  <button type="button" class="btn btn-danger" onclick="setDisabled()"><i class="glyphicon glyphicon-floppy-save"></i> 保存</button>
                  <button id="updateBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-cloud-upload"></i> 提交</button>
				  </form>
			  </div>
			</div>
        </div>
      </div>
    </div>
    <script src="${APP_PATH}/static/js/jquery/jquery-3.0.0.js"></script>
    <script src="${APP_PATH}/static/js/jquery/jquery-form.min.js"></script>
    <script src="${APP_PATH}/static/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/static/js/layer/layer.js"></script>
	<script src="${APP_PATH}/static/js/bootstrap/js/select2.js"></script>
	<script type="text/javascript" charset="utf-8" src="${APP_PATH}/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="${APP_PATH}/ueditor/ueditor.all.min.js"> </script>
	 <script type="text/javascript" charset="utf-8" src="${APP_PATH}/ueditor/lang/zh-cn/zh-cn.js"></script>
        <script type="text/javascript">
        $(function () {
		    $(".list-group-item").click(function(){
			    if ( $(this).find("ul") ) {
					$(this).toggleClass("tree-closed");
					if ( $(this).hasClass("tree-closed") ) {
						$("ul", this).hide("fast");
					} else {
						$("ul", this).show("fast");
					}
				}
			});
		    
        });
        $("#send_excel").click(function(){
        	layer.msg("请到首页导入Excel", {time:1500, icon:5, shift:6}, function(){
    		});
        })
        function setDisabled() {
            UE.getEditor('contents').setDisabled('fullscreen');
        }
        function setEnabled() {
            UE.getEditor('contents').setEnabled();
        } 
        var ue = UE.getEditor('contents');
        
	    var loadingIndex = -1;
	    $("#updateBtn").click(function(){
	       var contents=UE.getEditor('contents').getContent();
	       var id=$("#id").val();
	       if(id==""){
	    	   id=0;
	       }
	    	var title = $("#title").val(); 
	    	var name = $("#name").val(); 
	    	var fieldname = $("#sel_menu2").select2().val();
	    	var summary = $("#summary").val(); 
	    	var pbdate = $("#pbdate").val(); 
	    	var keyword = $("#keyword").val(); 
	    	$.ajax({
	            type: "post",
	            url: "${APP_PATH}/goto_expert_content_manager/expertcontent/update.do",
	            data: {"id":id,"title":title,"name":name,
                	"summary":summary,"pbdate":pbdate,
                	"keyword":keyword,"contents":contents,"fieldname":fieldname},
	            success: function(r){
	            	layer.msg("页面更新成功", {time:1000, icon:6, shift:6}, function(){
		    		});
	            }
	        });
	    	});
        </script>
  </body>
</html>
