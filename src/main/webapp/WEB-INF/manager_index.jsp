<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0, minimum-scale=0.5, maximum-scale=2.0, user-scalable=yes">
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="${APP_PATH}/static/js/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/static/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/static/css/main.css">
	<link rel="stylesheet" href="${APP_PATH}/static/css/pagination.css">
	<link href="${APP_PATH}/static/js/bootstrap/css/select2.min.css" rel="stylesheet" />
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
	#sel_menu1{
		display:block!important;
	}
	#sel_menu2{
		display:block!important;
	}
	.select2 {
		display: none!important;
	}
	body {
font: normal 150% Helvetica, Arial, sans-serif;
}
	</style>
  </head>

  <body>
<%@include file="/WEB-INF/common/userinfo.jsp"%>
    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-3 sidebar">
        <ul style="height:auto;width:auto;" class="list-group">
        <%@include file="/WEB-INF/common/common.jsp"%>
				</ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-9 col-md-offset-3 main" >
          <h1 class="page-header">控制面板</h1>
          <div class="row placeholders">
          <c:if test="${loginUser.name=='Admin'}">
           <div class="col-xs-6 col-sm-3 placeholder">
              <a href="${APP_PATH}/goto_jsd_manager.htm" class="glyphicon glyphicon-tag" style="font-size:100px;"></a>
              <br><br><br>
              <h3>技术点管理</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <a href="${APP_PATH}/goto_article_manager.htm" class="glyphicon glyphicon-book" style="font-size:100px;"></a>
              <br><br><br>
              <h3>前言预判文章管理</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="${APP_PATH}/goto_menu_manager.htm" class="glyphicon glyphicon-list-alt" style="font-size:100px;"></a>
             <br><br><br>
              <h3>专题跟踪菜单管理</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="${APP_PATH}/goto_expert_content_manager.htm" class="glyphicon glyphicon-user" style="font-size:100px;"></a>
             <br><br><br>
              <h3>重点领域专家页面</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="${APP_PATH}/goto_apply_manager.htm" class="glyphicon glyphicon-envelope" style="font-size:100px;"></a>
             <br><br><br>
              <h3>申请信息</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="${APP_PATH}/goto_user_manager.htm" class="glyphicon glyphicon-move" style="font-size:100px;"></a>
             <br><br><br>
              <h3>第三方管理</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="${APP_PATH}/goto_count_manager.htm" class="glyphicon glyphicon-th-list" style="font-size:100px;"></a>
             <br><br><br>
              <h3>服务分配统计</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="${APP_PATH}/goto_user_manager/user_imessage.htm" id="imessageHref" class="glyphicon glyphicon-comment" style="font-size:100px;"></a>
             <br><br><br>
              <h3>消息管理</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="${APP_PATH}/DownloadExcel.htm" class="glyphicon glyphicon-arrow-down" style="font-size:100px;"></a>
             <br><br><br>
              <h3>数据导入模板下载</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="#" data-toggle="modal" data-target="#excelModal" class="glyphicon glyphicon-arrow-up" style="font-size:100px;"></a>
             <br><br><br>
              <h3>批量导入</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="${APP_PATH}/test.htm"  class="glyphicon glyphicon-arrow-up" style="font-size:100px;"></a>
             <br><br><br>
              <h3>test</h3>
            </div>
          </c:if>
          <c:if test="${loginUser.name!='Admin'}">
          <div class="col-xs-6 col-sm-3 placeholder">
            <a href="${APP_PATH}/goto_menu_manager.htm" class="glyphicon glyphicon-list-alt" style="font-size:100px;"></a>
             <br><br><br>
              <h3>专题跟踪菜单管理</h3>
            </div>
          </c:if>
          </div>
        </div>
      </div>
    </div>
  <div id="excelModal" class="modal fade bs-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">批量导入</h4>
            </div>
            <div class="modal-body">
                <ul class="nav nav-tabs" role="tablist">
                <li role="presentation" class="active"><a href="#importExcel" aria-controls="home" role="tab" data-toggle="tab" aria-expanded="false">导入Excel</a></li>
                <li role="presentation" class=""><a href="#importExpertImg" aria-controls="profile" role="tab" data-toggle="tab" aria-expanded="true">导入前言预判文章附件</a></li>
                <li role="presentation" class=""><a href="#importDownloader" aria-controls="profile" role="tab" data-toggle="tab" aria-expanded="true">导入下载器邮箱数据及专家照片</a></li>
               <!--  <li role="presentation" class=""><a href="#importEmail" aria-controls="profile" role="tab" data-toggle="tab" aria-expanded="true">导入邮箱数据</a></li> -->
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="importExcel">
                <br />
                <form action="import_excel.htm" id="fileImport" method="post"  enctype="multipart/form-data" >
                <input id="file_upload" name="file" type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" >   
                <br />                  
                        <button type="button" class="btn btn-primary" id="btnUpload" >上传</button>
                        <button type="button" class="btn btn-default" id="btnCancelUpload" >取消</button>
                        <div id="fileQueue" class="fileQueue"></div>
                        <br />                    
                        <div id="div_files"></div>
                        <br />  
                        </form>
                </div>
                <div role="tabpanel" class="tab-pane" id="importExpertImg">
                <br />
                <form action="import_articles.htm" id="articleImports" method="post"  enctype="multipart/form-data" >
                <input id="article_uploads" multiple="multiple" name="updateArticles" type="file" accept="image/png,image/gif,image/jpg,image/jpeg,application/pdf" >   
                <br />                  
                        <button type="button" class="btn btn-primary" id="btnUploadss" >上传</button>
                        <button type="button" class="btn btn-default" id="btnCancelUploadss" >取消</button>
                        <div id="fileQueue" class="fileQueue"></div>
                        <br />                    
                        <div id="div_files"></div>
                        <br />  
                </form>
                </div>
                <div role="tabpanel" class="tab-pane" id="importDownloader">
     <div class="form-inline" role="form" style="float:left;">
  		 <div class="form-group has-feedback">
   			 <div class="input-group">
    		 <div class="input-group-addon" >技术领域</div>
      				<select id="sel_menu1" class="form-control"  onchange="fieldChange()" style="width:200px;">
      				<option></option>
				    <c:forEach var="obj" items="${list_field}" varStatus="i">
				          <option value="${obj}">${obj}</option>
				     		</c:forEach>
				 	  </select>
				 	  </div>
				 	  <div class="input-group">
				 	  <div class="input-group-addon">技术点</div>
				    <select id="sel_menu2" class="form-control" style="width:400px;">
				 	  </select>
				 	</div>  
  		 </div>
  		 &nbsp;&nbsp;&nbsp;&nbsp;
  			<button id="queryBtn"  type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
  			</div>
  		<br><br>
 <h1 id="notice">请选择技术点</h1>
 <div id="Inotice" style="display: none">
<h1>导入下载器数据</h1>
  <div class="input-group">
					<div class="input-group-addon" >频道Id</div>
					<input type="text" class="form-control" style="width:700px;" id="channelId"  value="" name="channelId" placeholder="请输入频道Id">
					<button id="editDownloader"  type="button" class="btn btn-danger"><i class="glyphicon glyphicon-ok"></i>提交</button>
					</div>
					<br>
  <div class="input-group">
					<div class="input-group-addon" >文章总数</div>
					<input type="text" class="form-control" style="width:800px;" id="articleCounts"  value="" name="articleCounts"readonly>
					</div>
					<br><br>
  <div class="input-group">
					<div class="input-group-addon" >上次添加文章数</div>
					<input type="text" class="form-control" style="width:758px;" id="articleCount"  value="" name="articleCount" readonly>
					</div>
					<br><br>
  <div class="input-group">
					<div class="input-group-addon" >更新时间</div>
					<input type="text" class="form-control" style="width:800px;" id="updatetime"  value="" name="updatetime" readonly>
					</div>
					  <form action="import_documents.htm" id="fileImports" method="post"  enctype="multipart/form-data" >
					  <h1>上传专家照片</h1>
                <input id="file_uploads" multiple="multiple" name="updateFiles" type="file" accept="image/png,image/gif,image/jpg,image/jpeg,application/pdf" >   
                <input id="file_jsd" name="jsdName" style="display:none">
                <br />                  
                        <button type="button" class="btn btn-primary" id="btnUploads" >上传</button>
                        <button type="button" class="btn btn-default" id="btnCancelUploads" >取消</button>
                        <div id="fileQueue" class="fileQueue"></div>
                        <br />                    
                        <div id="div_files"></div>
                        <br />  
                </form>
 </div>
				 	  </div>
                <div role="tabpanel" class="tab-pane" id="importEmail">
                <h1 id="notice">请选择技术点</h1>
                </div>
            </div>
            </div>
        </div>
    </div>
</div> 
     <script src="${APP_PATH}/static/js/jquery/jquery-3.0.0.js"></script>
    <script src="${APP_PATH}/static/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/static/js/layer/layer.js"></script>
	<script src="${APP_PATH}/static/js/jquery/jquery.pagination.js"></script>
	<script src="${APP_PATH}/static/js/jquery/jquery-form.min.js"></script>
	<script src="${APP_PATH}/static/js/bootstrap/js/select2.js"></script>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
					}
				});
            });
            $("#btnCancelUpload").click(function(){
		    	 document.getElementById("fileImport").reset(); 
		    });
            $("#btnUpload").click(function(){
            	var file = $("#file_upload");
            	if(file.val()==""){
            		layer.msg("文件不能为空,请选择文件", {time:1500, icon:5, shift:6}, function(){
            		});
            	}
            	else{  
            		var loadingIndex = -1;
    	    	$("#fileImport").ajaxSubmit({
    	    		beforeSubmit : function() {
    	    			loadingIndex = layer.load(2, {time: 1*1000});
    	    		},
    	    		success : function( r ) {
    	    			layer.close(loadingIndex);
    	    			if ( r.success) {
    	    				layer.msg("文件上传成功并导入数据库", {time:1500, icon:6, shift:6});
    	    				
    	    			} else {
    	    	    		layer.msg("文件上传失败，请检查文件后上传", {time:2000, icon:5, shift:6});
    	    			}
    	    		}
    	    	});
            	}
            });  
            $("#btnCancelUploads").click(function(){
		    	 document.getElementById("fileImports").reset(); 
		    });
            $("#btnUploads").click(function(){
            	var files = $("#file_uploads");
            	if(files.val()==""){
            		layer.msg("文件不能为空,请选择文件", {time:1500, icon:5, shift:6}, function(){
            		});
            	}
            	else{ 
            		$("#file_jsd").val($("#sel_menu2").select2().val());
            		var loadingIndex = -1;
    	    	$("#fileImports").ajaxSubmit({
    	    		beforeSubmit : function() {
    	    			loadingIndex = layer.load(2, {time: 1*1000});
    	    		},
    	    		success : function( r ) {
    	    			layer.close(loadingIndex);
    	    			if ( r.success) {
    	    				layer.msg("文件上传成功并导入数据库", {time:1500, icon:6, shift:6});
    	    				
    	    			} else {
    	    	    		layer.msg("文件上传失败，请检查文件后上传", {time:2000, icon:5, shift:6});
    	    			}
    	    		}
    	    	});
            	}
            });   
            $("#btnCancelUploadss").click(function(){
		    	 document.getElementById("articleImports").reset(); 
		    });
           $("#btnUploadss").click(function(){
           	var files = $("#article_uploads");
           	if(files.val()==""){
           		layer.msg("文件不能为空,请选择文件", {time:1500, icon:5, shift:6}, function(){
           		});
           	}
           	else{ 
           		var loadingIndex = -1;
   	    	$("#articleImports").ajaxSubmit({
   	    		beforeSubmit : function() {
   	    			loadingIndex = layer.load(2, {time: 1*1000});
   	    		},
   	    		success : function( r ) {
   	    			layer.close(loadingIndex);
   	    			if ( r.success) {
   	    				layer.msg("文件上传成功并导入数据库", {time:1500, icon:6, shift:6});
   	    			} else {
   	    	    		layer.msg("文件上传失败，请检查文件后上传", {time:2000, icon:5, shift:6});
   	    			}
   	    		}
   	    	});
           	}
           });
            function fieldChange(){
                var fieldName = $("#sel_menu1").select2().val();
                document.getElementById("sel_menu2").length=0;
                $.ajax({
    	            type: "post",
    	            url: "${APP_PATH}/goto_menu_manager/queryGenZongJsdName.do",
                    data: {"fieldName":fieldName},
                    success : function( r ) {
            				var jsdName = r.list_jsdName;
            				// 循环遍历
            				$.each(jsdName, function(index,jsdName){
            					$("#sel_menu2").append("<option value='"+jsdName+"'>"+jsdName+"</option>");
            				});
                    }
    	        });
               };
            $("#queryBtn").click(function(){
            	var oMenuIcon = $("#sel_menu2").select2();
            	if ( oMenuIcon.val() == null ) {
            		layer.msg("查询条件不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
            		});
            	}
            	else {
               		$("#notice").hide();
               		$("#Inotice").show();
               		pageQuery();
            	}
            });
            
            function pageQuery( pageIndex ) {
            	var dataObj = {"jsdName":$("#sel_menu2").select2().val()+""};
            	$.ajax({
            		url : "${APP_PATH}/goto_jsd_manager/get_jsdDownloader_channel.do",
            		type : "POST",
            		data : dataObj,
            		beforeSend : function() {
            			loadingIndex = layer.load(2, {time: 10*1000});
            		},
            		success : function( r ) {
            			layer.close(loadingIndex);
            			if ( r.success ) {
            				var downloader_channel = r.downloader_channel;
            				if(downloader_channel!=null){
            					var channelId = downloader_channel.channel_id;
                				var updatetime = downloader_channel.updatetime;
                				var size = downloader_channel.size;
                				var this_size = downloader_channel.this_size;
                				$("#channelId").val(channelId);
                				$("#articleCounts").val(size);
                				$("#articleCount").val(this_size);
                				$("#updatetime").val(updatetime);
            				}
            				else{
            					$("#channelId").val("");
                				$("#articleCounts").val("");
                				$("#articleCount").val("");
                				$("#updatetime").val("");
            				}
            			}
            		}
            			})
            }
            $("#editDownloader").click(function(){
            	var oMenuIcon = $("#sel_menu2").select2().val();
            	var channelId=$("#channelId").val();
            	var reg = /^\d+([,，]\d+)*$/;
            	if(!reg.test(channelId)){
    				//格式不正确
    				alert("请输入数字加逗号的格式文本（末尾不加逗号）");
    				//取消默认行为
    				return false;
    			}
          	   layer.confirm("确定修改技术点："+oMenuIcon+"的下载频道？",  {icon: 3, title:'提示'}, function(cindex){
          		   $.ajax({
     					url : "${APP_PATH}/goto_jsd_manager/set_jsdDownloader_channel.do",
     					type : "POST",
     					data : {
     						name : oMenuIcon,
     						channelId:channelId
     					},
     					success : function( r ) {
     						if ( r.success ) {
     							layer.msg("修改成功", {time:1000, icon:6, shift:6});
     							pageQuery();
     						} else {
     				    		layer.msg("修改失败,请联系管理员", {time:1000, icon:5, shift:6});
     						}
     					}
     				});
          		   layer.close(cindex); 
          	   });
            });
        </script>
  </body>
</html>
