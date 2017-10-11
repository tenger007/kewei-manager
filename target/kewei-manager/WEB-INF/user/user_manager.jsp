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
	<link rel="stylesheet" href="/kewei-manager/css/pagination.css">
	<link rel="stylesheet" href="/kewei-manager/ztree/zTreeStyle.css" type="text/css">
	<link href="/kewei-manager/js/bootstrap/css/select2.min.css" rel="stylesheet" />
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
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
			<ul style="width: auto" class="list-group">
							<%@include file="/WEB-INF/common/common.jsp"%>
				</ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-9 col-md-offset-3 main">
        <div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>第三方列表
				<button type="button" style="margin-left: 20px" class="btn btn-primary" data-toggle="modal" data-target="#myModal" >
				<i class="glyphicon glyphicon-plus"></i> 新增</button>
				</h3>
			  </div>
     	  <div class="panel-body">
          <div class="table-responsive">
            <table id="menuTable" class="table  table-bordered">
              <thead>
                <tr >
                  <th style="text-align:center;" width="50">编号</th>
				  <th style="text-align:center;">登陆账号</th>
				  <th style="text-align:center;">用户名称</th>
                  <th style="text-align:center;" width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
            </table>
          </div>
			  </div>
			  </div>
			  </div>
      </div>
    </div>
    <div class="modal fade bs-modal-lg" id="myModal"  tabindex="1"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
	  <div class="modal-dialog modal-lg">
		<div class="modal-content">
		  <div class="modal-header bg-primary">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">用户信息</h4>
		  </div>
		  <div class="modal-body">
		  <div class="mpdal-title-container">
				 <input id="cm-modal-id"  style="display:none;"></input>
				 <div class="input-group">
				   <div class="input-group-addon" >用户名称</div>
					<input type="text" class="form-control" id="cm-modal-name" style="width:100%;"  >
				  </div>
				  <br>
				 <div class="input-group">
				   <div class="input-group-addon" >登录账号</div>
					<input type="text" class="form-control" id="cm-modal-loginname" style="width:100%;" >
				  </div>
				  <br>
				 <div class="input-group">
				   <div class="input-group-addon" >登录密码</div>
					<input type="text" class="form-control" id="cm-modal-password" style="width:100%;" >
				  </div>
				   <br>
				 </div>
		  </div>
		  <div class="modal-footer">
				  <button  type="button" onclick="addUser()" class="btn btn-success"><i class="glyphicon glyphicon-share-alt"></i>新增</button>
		  </div>
		</div>
	  </div>
	</div>
    <div class="modal fade bs-modal-lg" id="Modal"  tabindex="1"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
	  <div class="modal-dialog modal-lg">
		<div class="modal-content">
		  <div class="modal-header bg-primary">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">更改密码</h4>
		  </div>
		  <div class="modal-body">
		  <div class="mpdal-title-container">
				 <input id="cm-modal2-id"  style="display:none;"></input>
				 <div class="input-group">
				   <div class="input-group-addon" >用户名称</div>
					<input type="text" class="form-control" id="cm-modal2-name" style="width:100%;" readonly >
				  </div>
				  <br>
				 <div class="input-group">
				   <div class="input-group-addon" >登录账号</div>
					<input type="text" class="form-control" id="cm-modal2-loginname" style="width:100%;" readonly>
				  </div>
				  <br>
				 <div class="input-group">
				   <div class="input-group-addon" >修改密码</div>
					<input type="text" class="form-control" id="cm-modal2-password" placeholder="请输入新密码" style="width:100%;" >
				  </div>
				   <br>
				 </div>
		  </div>
		  <div class="modal-footer">
				  <button  type="button" onclick="edit_User()" class="btn btn-success"><i class="glyphicon glyphicon-share-alt"></i>修改</button>
		  </div>
		</div>
	  </div>
	</div>
    <script src="/kewei-manager/js/jquery/jquery-3.0.0.js"></script>
    <script src="/kewei-manager/js/jquery/jquery-form.min.js"></script>
    <script src="/kewei-manager/js/bootstrap/js/bootstrap.min.js"></script>
    <script src="/kewei-manager/js/jquery/jquery.pagination.js"></script>
	<script src="/kewei-manager/js/layer/layer.js"></script>
	<script type="text/javascript" src="/kewei-manager/ztree/jquery.ztree.all-3.5.min.js"></script>
	<script src="/kewei-manager/js/bootstrap/js/select2.js"></script>
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
		    pageQuery();
        });
        
        function addUser(){
        	var name=$("#cm-modal-name").val();
        	var loginname=$("#cm-modal-loginname").val();
        	var password=$("#cm-modal-password").val();
        	$.ajax({
					url : "/kewei-manager/goto_user_manager/addUser.do",
					type : "POST",
					data : {
						name : name,loginname:loginname,password:password
					},
					success : function( r ) {
						if ( r.success ) {
				    		layer.msg("用户增加成功", {time:1000, icon:6, shift:6}, function(){
				    			window.location.reload();
				    		});
						} else {
				    		layer.msg("用户增加失败，请确定用户名不重复", {time:1000, icon:5, shift:6});
						}
					}
				});
        }
        function edit_User(){
        	var name=$("#cm-modal2-name").val();
        	var password=$("#cm-modal2-password").val();
        	$.ajax({
					url : "/kewei-manager/goto_user_manager/editUser.do",
					type : "POST",
					data : {
						name : name,password:password
					},
					success : function( r ) {
						if ( r.success ) {
				    		layer.msg("密码修改成功", {time:1000, icon:6, shift:6}, function(){
				    			window.location.reload();
				    		});
						} else {
				    		layer.msg("密码修改失败，请确定用户名不重复", {time:1000, icon:5, shift:6});
						}
					}
				});
        }
        
        function editUser(id,name,loginname){
        	 $('#Modal').on('show.bs.modal', function () {
        		 $.fn.modal.Constructor.prototype.enforceFocus = function () { };
            	 var modal = $(this)
            	 modal.find('#cm-modal2-id').val(id);
            	 modal.find('#cm-modal2-name').val(name);
            	 modal.find('#cm-modal2-loginname').val(loginname);
            	});
        }

        function deleteUser(id, name) {
 			layer.confirm("删除用户："+name+"，是否继续?",  {icon: 3, title:'提示'}, function(cindex){
 				$.ajax({
 					url : "/kewei-manager/goto_user_manager/delete_user_by_id.do",
 					type : "POST",
 					data : {
 						id : id
 					},
 					success : function( r ) {
 						if ( r.success ) {
 				    		layer.msg("用户删除成功", {time:1000, icon:6, shift:6}, function(){
 				    			window.location.reload();
 				    		});
 						} else {
 				    		layer.msg("用户删除失败", {time:1000, icon:5, shift:6});
 						}
 					}
 				});
 				
 			    layer.close(cindex);
 			}, function(cindex){
 			    layer.close(cindex);
 			});
 		} 
         
        var loadingIndex = -1;
        function pageQuery() {
        	$.ajax({
        		url : "/kewei-manager/goto_user_manager/user/userQuery.do",
        		type : "POST",
        		beforeSend : function() {
        			loadingIndex = layer.load(2, {time: 10*1000});
        		},
        		success : function( r ) {
        			layer.close(loadingIndex);
        			if ( r.success ) {
        				// 页面渲染
        				var users = r.users;
        				// 循环遍历
        				var content = "";
        				$.each(users, function(index,users){
        					// 相同类型的引号不能嵌套使用
            	            content += '<tr>';
          	                content += '  <td style="text-align:center;">'+(index+1)+'</td>';
          					content += '  <td style="text-align:center;">'+users.loginname+'</td>';
          	                content += '  <td style="text-align:center;">'+users.name+'</td>';
          	              content += '  <td style="text-align:center;">';
        					content += '      <button type="button" title="修改密码" data-toggle="modal" data-target="#Modal" onclick="editUser('+users.id+', \''+users.name+'\', \''+users.loginname+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
        					content += '	  <button type="button" title="删除用户" onclick="deleteUser('+users.id+', \''+users.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
          	             /*  content += '      <button type="button" title="同意申请" onclick="agreeApply('+applys.id+', \''+applys.jsdname+'\''+', \''+applys.jsdid+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-ok"></i></button>';	
          					content += '	  <button type="button" title="不同意申请" onclick="disagree('+applys.id+', \''+applys.jsdname+'\')" data-toggle="modal" data-target="#myModal" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>'; */
          					content += '  </td>';
          	                content += '</tr>';
        				});
        				// 设置纯文本内容
        				//$("#menuTable tbody").text(content);
        				// 设置HTML标签内容
        				$("#menuTable tbody").html(content);
        			} 
        		}
        	});
        }
        
        </script>
  </body>
</html>
