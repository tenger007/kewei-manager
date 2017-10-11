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
	<link rel="stylesheet" href="/kewei-manager/js/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/kewei-manager/css/font-awesome.min.css">
	<link rel="stylesheet" href="/kewei-manager/css/main.css">
	<link rel="stylesheet" href="/kewei-manager/ztree/zTreeStyle.css" type="text/css">
	 <link rel="stylesheet" href="/kewei-manager/ueditor/themes/default/css/ueditor.css" type="text/css">
	 <link href="js/bootstrap/css/select2.min.css" rel="stylesheet" />
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>重点领域专家页面</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <select id="sel_menu2" class="form-control" style="width:500px;">
      <option></option>
 			<c:forEach var="obj" items="${list_field}" varStatus="i">
            <option value="${obj}">${obj}</option>
       		</c:forEach>
 	  </select>
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<br><br>
<br style="clear:both;">
 <h1 id="notice">请选择技术领域</h1>
           <form style="display:none"  action="/kewei-manager/updateContent.do" method="post" id="contentForm" role="form">
				  <div class="form-group">
					<label for="contents" id="field"> </label>
					<script id="contents" type="text/plain" style="width:auto!important;height:100%;">
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
    <script src="/kewei-manager/js/jquery/jquery-3.0.0.js"></script>
    <script src="/kewei-manager/js/jquery/jquery-form.min.js"></script>
    <script src="/kewei-manager/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="/kewei-manager/js/layer/layer.js"></script>
	<script src="js/bootstrap/js/select2.js"></script>
	<script type="text/javascript" src="/kewei-manager/ztree/jquery.ztree.all-3.5.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="/kewei-manager/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/kewei-manager/ueditor/ueditor.all.min.js"> </script>
	 <script type="text/javascript" charset="utf-8" src="/kewei-manager/ueditor/lang/zh-cn/zh-cn.js"></script>
        <script type="text/javascript">
        $(function () {
		    $(".list-group-item").click(function(){
			    if ( $(this).find("ul") ) {
					$(this).toggleClass("tree-expanded");
					if ( $(this).hasClass("tree-expanded") ) {
						$("ul", this).hide("fast");
					} else {
						$("ul", this).show("fast");
					}
				}
			});
		    
        });
        function Query(fieldname) {
        	$.ajax({
        		url:"expertcontent/Query.do",
        		type:"POST",
        		data:{"fieldname":fieldname},
        		success:function(r){
        			if(r.success){
        				var contents = r.contents;
        				UE.getEditor('contents').setContent(contents);
        			}
        			else {
        	    		layer.msg("分页查询失败", {time:1000, icon:5, shift:6});
        			}
        		}
        	})
		}
        $("#queryBtn").click(function(){
       	 var oMenuIcon = $("#sel_menu2").select2();
        	if ( oMenuIcon.val() == "" ) {
        		layer.msg("查询条件不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
        		});
        	} else {
        		$("#notice").hide();
        		document.getElementById('contentForm').style.display='';
        		document.getElementById('field').innerHTML =oMenuIcon.val()+'专家页面' ;
        		Query(oMenuIcon.val());
        	}
        });
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
	       var fieldname=$("#sel_menu2").select2().val();
	    	var dataObj = {"fieldname" : fieldname,"contents":contents};
	    	$.ajax({
	            type: "post",
	            url: "expertcontent/update.do",
                data: dataObj,
	            success: function(r){
	            	layer.msg("页面更新成功", {time:1000, icon:6, shift:6}, function(){
		    		});
	            }
	        });
	    	});
        </script>
  </body>
</html>
