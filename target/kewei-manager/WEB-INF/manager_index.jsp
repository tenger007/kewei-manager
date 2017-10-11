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

	<link rel="stylesheet" href="/kewei-manager/js/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/kewei-manager/css/font-awesome.min.css">
	<link rel="stylesheet" href="/kewei-manager/css/main.css">
	<link rel="stylesheet" href="/kewei-manager/css/pagination.css">
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
            <div class="col-xs-6 col-sm-3 placeholder">
              <a href="/kewei-manager/goto_article_manager.htm" class="glyphicon glyphicon-book" style="font-size:100px;"></a>
              <br><br><br>
              <h3>预判模块文章管理</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
              <a href="/kewei-manager/goto_jsd_manager.htm" class="glyphicon glyphicon-tag" style="font-size:100px;"></a>
              <br><br><br>
              <h3>预判及跟踪技术点管理</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="/kewei-manager/goto_menu_manager.htm" class="glyphicon glyphicon-list-alt" style="font-size:100px;"></a>
             <br><br><br>
              <h3>跟踪模块菜单管理</h3>
            </div>
            <div class="col-xs-6 col-sm-3 placeholder">
            <a href="/kewei-manager/goto_expert_content_manager.htm" class="glyphicon glyphicon-bookmark" style="font-size:100px;"></a>
             <br><br><br>
              <h3>重点领域专家页面管理</h3>
            </div>
          </div>
        </div>
      </div>
    </div>
  <div id="myModal" class="modal fade bs-modal-lg" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header bg-primary">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                <h4 class="modal-title">Excel导入</h4>
            </div>
            <div class="modal-body">
                <form action="import_excel.htm" id="fileImport" method="post"  enctype="multipart/form-data" >
                        <input id="file_upload" name="file" type="file" accept="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" >                    
                        <button type="button" class="btn btn-primary" id="btnUpload" >上传</button>
                        <button type="button" class="btn btn-default" id="btnCancelUpload" >取消</button>

                        <div id="fileQueue" class="fileQueue"></div>
                        <br />                    
                        <div id="div_files"></div>
                        <br />  
                        <div class="modal-footer">
               				<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
            			</div>                  
                </form>
            </div>
        </div>
    </div>
</div> 
     <script src="/kewei-manager/js/jquery/jquery-3.0.0.js"></script>
    <script src="/kewei-manager/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="/kewei-manager/script/docs.min.js"></script>
	<script src="/kewei-manager/js/layer/layer.js"></script>
	<script src="/kewei-manager/js/jquery/jquery.pagination.js"></script>
	<script src="/kewei-manager/js/jquery/jquery-form.min.js"></script>
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
            		layer.msg("文件不能为空", {time:1500, icon:5, shift:6}, function(){
            			file_upload.focus();
            		});
            	}
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
    	    	    		layer.msg("文件上传失败，请检查后上传", {time:3000, icon:5, shift:6});
    	    			}
    	    		}
    	    	});
            });   
            
        </script>
  </body>
</html>
