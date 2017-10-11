<%@page import="kewei.manager.bean.MenuDto"%>
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
	<link rel="stylesheet" href="${APP_PATH}/static/css/doc.min.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
         <div><a class="navbar-brand" style="font-size:32px;" href="#">科创中心大数据后台管理平台</a></div>
        </div>
      </div>
    </nav>

    <div class="container-fluid">
      <div class="row">
        <div class="col-sm-3 col-md-2 sidebar">
			<ul style="padding-left:0px;" class="list-group">
							<li class="list-group-item tree-closed" >
								<a href="${APP_PATH}/index.do"><i class="glyphicon glyphicon-home"></i> 首页</a> 
							</li>
							<li class="list-group-item tree-closed">
								<span><i class="glyphicon glyphicon glyphicon-tasks"></i> 数据管理 </span> 
								<ul style="margin-top:10px;display:none;">
										<li style="height:30px;">
											<a href="${APP_PATH}/goto_article_manager.do"><i class="glyphicon glyphicon-minus-sign"></i> 文章管理</a> 
										</li>
										<li style="height:30px;">
											<a href="${APP_PATH}/goto_jsd_manager.do"><i class="glyphicon glyphicon-minus-sign"></i> 技术点管理</a> 
										</li>
										
										<li style="height:30px;">
											<a href="${APP_PATH}/goto_menu_manager.do"><i class="glyphicon glyphicon-minus-sign"></i> 菜单管理</a> 
										</li>
										<li style="height:30px;">
											<a href="${APP_PATH}/goto_content_manager.do"><i class="glyphicon glyphicon-minus-sign"></i> 页面管理</a> 
										</li>
								</ul>
							</li>
				</ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="${APP_PATH}/goto_menu_manager.do">菜单数据列表</a></li>
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"></div></div>
			  <div class="panel-body">
				<form action="${APP_PATH}/updateMenu.do" method="post" id="menuForm" role="form">
				  <input type="hidden" id="id" name="id" value="${menuDto.id}">
				  <div class="form-group">
					<label for="exampleInputEmail1">父菜单名称</label>
					<input type="text" class="form-control" id="floginacct" value="${menuDto.fMenuName}" name="fMenuName" placeholder="请输入父菜单">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">技术点名称</label>
					<input type="text" class="form-control" id="jsdName" value="${menuDto.jsdName}" name="jsdName" placeholder="请输入技术点">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">菜单等级</label>
					<input type="text" class="form-control" id="level" value="${menuDto.level}" name="level" placeholder="请输入菜单等级">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">菜单名称</label>
					<input type="text" class="form-control" id="menuName" value="${menuDto.menuName}" name="menuName" placeholder="请输入菜单">
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">是否是最后一级</label>
					<input type="radio" value="1" name="isend" id="isend" ${menuDto.isend=="1" ? "checked='checked'" : ""} />是
					<input type="radio" value="0" name="isend" id="isend" ${menuDto.isend=="0" ? "checked='checked'" : ""} />否
				  </div>
				  <div class="form-group">
					<label for="exampleInputEmail1">是否有子菜单</label>
					<input type="radio" value="1" name="hasson" id="hasson" ${menuDto.hasson=="1" ? "checked='checked'" : ""} />是
					<input type="radio" value="0" name="hasson" id="hasson" ${menuDto.hasson=="0" ? "checked='checked'" : ""} />否
				  </div>
				  <button id="updateBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 修改</button>
				  <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
    <script src="${APP_PATH}/static/js/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/static/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/static/script/docs.min.js"></script>
	<script src="${APP_PATH}/static/js/layer/layer.js"></script>
	<script src="${APP_PATH}/static/js/jquery/jquery-form.min.js"></script>
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
        
        $("#resetBtn").click(function(){
        	document.getElementById("menuForm").reset(); 
        });
	    var loadingIndex = -1;
	    $("#updateBtn").click(function(){
	    	var jsdName = $("#jsdName");
	    	var menuName = $("#menuName");
	    	var level = $("#level");
	    	var isend = $("#isend");
	    	var hasson = $("#hasson");
	    	if ( isend.val() == "" ) {
	    		layer.msg("是否是最后一级不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	        		isend.focus();
	    		});
	    		return;
	    	}
	    	if ( hasson.val() == "" ) {
	    		layer.msg("是否有子菜单不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	        		hasson.focus();
	    		});
	    		return;
	    	}
	    	if ( level.val() == "" ) {
	    		layer.msg("菜单等级不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	        		level.focus();
	    		});
	    		return;
	    	}
	    	if ( menuName.val() == "" ) {
	    		layer.msg("菜单名称不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	        		menuName.focus();
	    		});
	    		return;
	    	}
	    	if ( jsdName.val() == "" ) {
	    		layer.msg("技术点不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	        		jsdName.focus();
	    		});
	    		return;
	    	}
	    	
	    	$("#menuForm").ajaxSubmit({
	    		beforeSubmit : function() {
	    			loadingIndex = layer.load(2, {time: 10*1000});
	    		},
	    		success : function( r ) {
	    			layer.close(loadingIndex);
	    			if ( r.success ) {
	    				layer.msg("修改菜单成功", {time:1000, icon:6, shift:6});
	    			} else {
	    	    		layer.msg("修改菜单失败", {time:1000, icon:5, shift:6});
	    			}
	    		}
	    	});
	    });
        </script>
  </body>
</html>
