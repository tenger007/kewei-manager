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
	<link rel="stylesheet" href="${APP_PATH}/static/css/pagination.css">
	<link rel="stylesheet" href="${APP_PATH}/static/ztree/zTreeStyle.css" type="text/css">
	<link href="${APP_PATH}/static/js/bootstrap/css/select2.min.css" rel="stylesheet" />
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	body {
font: normal 150% Helvetica, Arial, sans-serif;
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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>消息列表
				</h3>
			  </div>
     	  <div class="panel-body">
          <div class="table-responsive">
            <table id="menuTable" class="table  table-bordered">
              <thead>
                <tr >
                  <th style="text-align:center;" width="50">编号</th>
				  <th style="text-align:center;">服务方</th>
				  <th style="text-align:center;">消息内容</th>
				  <th style="text-align:center;">发送时间</th>
                  <!-- <th style="text-align:center;" width="100">操作</th> -->
                </tr>
              </thead>
              <tbody>
              </tbody>
                <tfoot>
			     <tr >
				     <td colspan="12" align="center">
				        <div id="Pagination" class="pagination">
					 	 </div>
					 </td>
				 </tr>
			  </tfoot>
			   <a href="${APP_PATH}/goto_menu_manager/other_all_imessage.htm" style="margin-left: 90%">消息记录<span class="caret"></span></a>
            </table>
          </div>
			  </div>
			  </div>
			  </div>
      </div>
    </div>
    <script src="${APP_PATH}/static/js/jquery/jquery-3.0.0.js"></script>
    <script src="${APP_PATH}/static/js/jquery/jquery-form.min.js"></script>
    <script src="${APP_PATH}/static/js/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/static/js/jquery/jquery.pagination.js"></script>
	<script src="${APP_PATH}/static/js/layer/layer.js"></script>
	<script type="text/javascript" src="${APP_PATH}/static/ztree/jquery.ztree.all-3.5.min.js"></script>
	<script src="${APP_PATH}/static/js/bootstrap/js/select2.js"></script>
        <script type="text/javascript">
        var ids="";
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
        
        function goto_others(){
   		 var username = $('#user_permission_Label').html();
   		 var jsdname = $('#sel_menu2').select2().val();
   		 var fieldname = $('#sel_menu1').select2().val();
   			 $.ajax({
   	        	   url : "${APP_PATH}/goto_apply_manager/addApply.do",
   	        		type : "POST",
   	        		data : {username:username,jsdname:jsdname,fieldname:fieldname,id:ids},
   	        		beforeSend : function() {
   	        			loadingIndex = layer.load(2, {time: 1000});
   	        		},
   	        		success:function(r){
   	        			if ( r.success ) {
    				    		layer.msg("分配成功", {time:1000, icon:6, shift:6}, function(){
    				    		});
    						} else {
    				    		layer.msg("分配失败", {time:1000, icon:5, shift:6});
    						}
   	        		}
   	           });
       }
        
        $("#send_excel").click(function(){
        	layer.msg("请到首页导入Excel", {time:1500, icon:5, shift:6}, function(){
    		});
        })
        
        $("#queryBtn").click(function(){
        	var oMenuIcon = $("#sel_menu2").select2();
        	if ( oMenuIcon.val() == null ) {
        		layer.msg("查询条件不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
        		});
        	}
        	else {
        		$("#notice").hide();
        		// 树形组件的异步读取数据
        		var setting = {
        				edit: {
        					drag: {  
        						isCopy: false,
        						isMove: true
        				    },  
        					enable: true,
        					showRemoveBtn: false,
        		            showRenameBtn: false
        					},
        					callback: {  
        						onCheck:onCheck
        				    }  ,
        				    check:{
      				    	  enable: true  //设置是否显示checkbox复选框
      				    	  },
    				view: {
    					selectedMulti: false,
    					addDiyDom: function(treeId, treeNode){
    						var icoObj = $("#" + treeNode.tId + "_ico");
    						if ( treeNode.icon ) {
    							icoObj.removeClass("button ico_docu ico_open").addClass("fa fa-fw " + "fa-sitemap").css("background","");
    						}
    					},
    					removeHoverDom: function(treeId, treeNode){
    						$("#btnGroup"+treeNode.tId).remove();
    					}
    				},
       			    async: {
       			        enable: true,
       			        url:"${APP_PATH}/goto_menu_manager/menu/menuQuery/"+$("#sel_menu2").select2().val()+".do",
       			    	autoParam:["id", "name=n", "level=lv"]
       			    }
        		};
        		$.fn.zTree.init($("#menu_tree"), setting);
        		 function onCheck(e,treeId,treeNode){
     	            var treeObj=$.fn.zTree.getZTreeObj("menu_tree");
     	            nodes=treeObj.getCheckedNodes(true);
     	            for(var i=0;i<nodes.length;i++){
     	            ids+=nodes[i].id+",";
     	            }
     	          //获取选中节点的值
     	            }
        	}
       });
        
        function fieldChange(){
            var fieldName = $("#sel_menu1").select2().val();
            document.getElementById("sel_menu2").length=0;
            $.ajax({
	            type: "post",
	            url: "${APP_PATH}/goto_menu_manager/queryGenZongnoshowJsdName.do",
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
        
        function addUser(){
        	var name=$("#cm-modal-name").val();
        	var loginname=$("#cm-modal-loginname").val();
        	var password=$("#cm-modal-password").val();
        	$.ajax({
					url : "${APP_PATH}/goto_user_manager/addUser.do",
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
					url : "${APP_PATH}/goto_user_manager/editUser.do",
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
        
      function  give_permission(id,name){
    	  $('#user_permission').on('show.bs.modal', function () {
     		 $.fn.modal.Constructor.prototype.enforceFocus = function () { };
     		 $('#user_permission_Label').html(name); 
     		var modal = $(this)
       	 	modal.find('#cm-modal3-id').val(id);
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
 					url : "${APP_PATH}/goto_user_manager/delete_user_by_id.do",
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
        var pagesize = 8;
        var pageIndex = 0;
        function pageQuery() {
        	var dataObj = {"pageno" : pageIndex+1,"pagesize" : pagesize,"username":'${loginUser.name}'};
        	$.ajax({
        		url : "${APP_PATH}/goto_menu_manager/user_other_imessageQuery.do",
        		type : "POST",
        		data : dataObj,
        		beforeSend : function() {
        			loadingIndex = layer.load(2, {time: 10*1000});
        		},
        		success : function( r ) {
        			layer.close(loadingIndex);
        			if ( r.success ) {
        				var pageObj = r.page;
        				// 页面渲染
        				//var user_imessages = r.user_imessages;
        				// 循环遍历
        				var content = "";
        				$.each(pageObj.datas, function(index,user_imessages){
        					// 相同类型的引号不能嵌套使用
            	            content += '<tr>';
          	                content += '  <td style="text-align:center;">'+(index+1)+'</td>';
          					content += '  <td style="text-align:center;">'+user_imessages.loginname+'</td>';
          	                content += '  <td style="text-align:left;">'+user_imessages.imessage+'</td>';
          	                content += '  <td style="text-align:center;">'+user_imessages.sendtime+'</td>';
          	              /* content += '  <td style="text-align:center;">';
        					content += '      <button type="button"  title="修改密码" data-toggle="modal" data-target="#Modal" onclick="editUser('+users.id+', \''+users.name+'\', \''+users.loginname+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
        					content += '      <button type="button" id="'+'user_permission'+users.id+'" title="分配技术点" data-toggle="modal" data-target="#user_permission" onclick="give_permission('+users.id+', \''+users.name+'\')" class="btn btn-warning btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
        					content += '	  <button type="button" id="'+'delete_user'+users.id+'" title="删除用户" onclick="deleteUser('+users.id+', \''+users.name+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>'; */
          	             /*  content += '      <button type="button" title="同意申请" onclick="agreeApply('+applys.id+', \''+applys.jsdname+'\''+', \''+applys.jsdid+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-ok"></i></button>';	
          					content += '	  <button type="button" title="不同意申请" onclick="disagree('+applys.id+', \''+applys.jsdname+'\')" data-toggle="modal" data-target="#myModal" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>'; */
          					//content += '  </td>';
          	                content += '</tr>';
        				});
        				// 设置纯文本内容
        				//$("#menuTable tbody").text(content);
        				// 设置HTML标签内容
        				$("#menuTable tbody").html(content);
        				$("[id='user_permission1']").hide();//将所有未同意的申请信息id隐藏
        				$("[id='delete_user1']").hide();
        				// 分页查询会在初始化后默认查询第一页的数据
        				// 由于实现方式不一样，所以需要注释掉插件中的查询第一页的方法（L158）
        				$("#Pagination").pagination(pageObj.totalsize, {
        					num_edge_entries: 2, //边缘页数
        					num_display_entries: 3, //主体页数
        					current_page: pageIndex,// 当前页码索引
        					callback: pageQuery,
        					prev_text:"上一页",
        					next_text:"下一页",
        					items_per_page:pagesize //每页显示数据条数
        				});
        			} 
        		}
        	});
        }
        
        </script>
  </body>
</html>
