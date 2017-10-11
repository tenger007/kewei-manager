<%@page import="kewei.manager.bean.MenuDto"%>
<%@page pageEncoding="utf-8"%>
<%@ page import="java.net.URLEncoder"%>
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
    <link href="/kewei-manager/js/bootstrap/css/select2.min.css" rel="stylesheet" />
	<link rel="stylesheet" href="/kewei-manager/ztree/zTreeStyle.css" type="text/css">
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
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
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
			<ul style="padding-left:0px;" class="list-group">
							<%@include file="/WEB-INF/common/common.jsp"%>
				</ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-9 col-md-offset-3 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 菜单数据列表
				</h3>
			  </div>
			  <div class="panel-body">
  <form class="form-inline" role="form" style="float:left;">
   <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon" >技术领域</div>
      <select id="sel_menu1" class="form-control"  onchange="fieldChange()" >
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
  <button id="queryBtn"  type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
  </form>
<br><br>
 <br style="clear:both;">
 <div class="zTreeDemoBackground left">
 <h1 id="notice">请选择技术点</h1>
 <ul id="menu_tree" class="ztree" style="border: 1px solid #617775;overflow-y: scroll;height: 500px;"></ul>
 </div>
			</div>
        </div>
      </div>
    </div>
    </div>
    <script src="/kewei-manager/js/jquery/jquery-3.0.0.js"></script>
    <script src="/kewei-manager/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="/kewei-manager/js/layer/layer.js"></script>
	<script src="/kewei-manager/js/jquery/jquery.pagination.js"></script>
	<script src="/kewei-manager/js/jquery/jquery-form.min.js"></script>
	<script src="/kewei-manager/js/bootstrap/js/select2.js"></script>
	<script type="text/javascript" src="/kewei-manager/ztree/jquery.ztree.all-3.5.min.js"></script>
	
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
        function fieldChange(){
            var fieldName = $("#sel_menu1").select2().val();
            document.getElementById("sel_menu2").length=0;
            $.ajax({
	            type: "post",
	            url: "/kewei-manager/goto_menu_manager/queryGenZongJsdName.do",
                data: {"fieldName":fieldName},
                success : function( r ) {
        				var jsdName = r.list_jsdName;
        				// 循环遍历
        				$.each(jsdName, function(index,jsdName){
        					$("#sel_menu2").append("<option value='"+jsdName+"'>"+jsdName+"</option>");
        				});
                }
	        });
           }
       /*  $("#queryGenZong").click(function(){
        	var fieldName = $("#sel_menu1").select2().val();
            document.getElementById("sel_menu2").length=0;
            $.ajax({
	            type: "post",
	            url: "/kewei-manager/queryGenZongJsdName.do",
                data: {"fieldName":fieldName},
                success : function( r ) {
        				var jsdName = r.list_jsdName;
        				// 循环遍历
        				$.each(jsdName, function(index,jsdName){
        					$("#sel_menu2").append("<option value='"+jsdName+"'>"+jsdName+"</option>");
        				});
                }
	        });
        }); */
            $("#queryBtn").click(function(){
            	 var oMenuIcon = $("#sel_menu2").select2();
            	if ( oMenuIcon.val() == "" ) {
            		layer.msg("查询条件不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
            		});
            	} else {
            		pageQuery(oMenuIcon.val());
            	}
            });
            function pageQuery( name ) {
            	$.ajax({
            		url : "/kewei-manager/goto_menu_manager/menu/pageQuery.do",
            		type : "POST",
            		data :{name:name+""} , 
            		success : function( r ) {
						if ( r.success ) {
				    		layer.msg("菜单查询成功", {time:500, icon:6, shift:6}, function(){
				    			$("#notice").hide();
				    			var url="";
		       			    	if (${UserId}==1) {
									url="/kewei-manager/goto_menu_manager/menu/menuQuery/"+$("#sel_menu2").select2().val()+".do";
								}
		       			    	else{
		       			    		url="/kewei-manager/goto_menu_manager/menu/menuQuery/"+$("#sel_menu2").select2().val()+"/"+"${loginUser.name}" +".do";
		       			    	}
				    			 // 树形组件的异步读取数据
				        		var setting = {
				        				edit: {
				        					drag: {  
				        						isCopy: false,
				        						isMove: true
				        				    },  
				        					enable: true,
				        					showRemoveBtn: false,
				        		            showRenameBtn: true
				        					},
				        					callback: {  
				        				        beforeRename:  beforeRename  ,
				        				        onRename:onRename,
				        				       
				        				    }  ,
				    				view: {
				    					selectedMulti: false,
				    					addDiyDom: function(treeId, treeNode){
				    						var icoObj = $("#" + treeNode.tId + "_ico");
				    						if ( treeNode.icon ) {
				    							icoObj.removeClass("button ico_docu ico_open").addClass("fa fa-fw " + "fa-sitemap").css("background","");
				    						}
				    					},
				    					addHoverDom: function(treeId, treeNode){
				    						var aObj = $("#" + treeNode.tId + "_a"); 
				    						if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
				    						var s = '<span id="btnGroup'+treeNode.tId+'">';
				    						if( treeNode.level == 0){
				    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" id="addBtn_' + treeNode.id + '" title="增加菜单" onfocus="this.blur();" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';	
				    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick=window.open("/kewei-manager/goto_menu_manager/edit_content/' +treeNode.name+"/"+treeNode.jsdid+"/"+ treeNode.id +'.do") title="编辑页面" onfocus="this.blur();" >&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
				    						}else{
				    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" id="addBtn_' + treeNode.id + '" title="增加菜单" onfocus="this.blur();" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
				    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick=window.open("/kewei-manager/goto_menu_manager/edit_content/' +treeNode.name+"/"+treeNode.jsdid+"/"+ treeNode.id +'.do") title="编辑页面" onfocus="this.blur();" >&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
				    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteNode('+treeNode.id+', \''+treeNode.name+'\')" title="删除菜单">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
				    						}
				    						s += '</span>';
				    						aObj.after(s);
				    					    var btn = $("#addBtn_"+treeNode.id);
				    					    var ebtn= $("#"+"editBtn_"+treeNode.id+treeNode.name);
				    					    //绑定添加事件，并定义添加操作  
				    					    var zTree = $.fn.zTree.getZTreeObj("menu_tree");  
				    					    if (btn) btn.bind("click", function(){  
				    					        //将新节点添加到数据库中
				    					        var name='新菜单'; 
				    					        $.post('/kewei-manager/goto_menu_manager/menu_add/'+treeNode.id+'/'+name+'/'+treeNode.jsdid+'.do',function (data) {  
				    					            var newID = data; //获取新添加的节点Id  
				    					            zTree.addNodes(treeNode, {id:newID,jsdid:treeNode.jsdid, fid:treeNode.id, name:name}); //页面上添加节点  
				    					            var node = zTree.getNodeByParam("id", newID, null); //根据新的id找到新添加的节点  
				    					            zTree.selectNode(node); //让新添加的节点处于选中状态  
				    					            return true;
				    					        });  
				    					    }); 

				    					},
				    					removeHoverDom: function(treeId, treeNode){
				    						$("#btnGroup"+treeNode.tId).remove();
				    					}
				    				},
				       			    async: {
				       			        enable: true,
				       			        url:url,
				       			    	autoParam:["id", "name=n", "level=lv"]
				       			    	
				       			    }
				        		};
				        		/* function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {  
				        			 $.post('edit_menu_by_id/'+treeNodes[0].id+'/'+targetNode.id+'/'+treeNodes[0].name+'/'+treeNodes[0].jsdid+'.do');
					        		    return true; 
				        		} */  
				        		$.fn.zTree.init($("#menu_tree"), setting);
				        		function beforeRename(treeId, treeNode, newName, isCancel) {  
				        		    if (newName.length == 0) {  
				        		    	layer.msg("菜单名称不能为空", {time:1000, icon:5, shift:6});
				        		        return false;  
				        		    }  
				        		    return true;  
				        		} 
				        		function onRename(e,treeId, treeNode, isCancel){
				        			//需要对名字做判定的，可以来这里写~~  
				        		    $.post('/kewei-manager/goto_menu_manager/edit_menu_by_id/'+treeNode.id+'/'+treeNode.name+'/'+treeNode.fid+'/'+treeNode.jsdid+'.do'); 
				        			return true;
				        		}
				    		});
						} else {
				    		layer.msg("菜单查询失败", {time:1000, icon:5, shift:6});
						}
					}
            	});
            }
        
    		function deleteNode(id, name) {
    			layer.confirm("删除"+name+"，是否继续?",  {icon: 3, title:'提示'}, function(cindex){
    				
    				$.ajax({
    					url : "/kewei-manager/goto_menu_manager/delete_menu_by_id.do",
    					type : "POST",
    					data : {
    						id : id
    					},
    					success : function( r ) {
    						if ( r.success ) {
    				    		layer.msg("数据删除成功", {time:1000, icon:6, shift:6}, function(){
    				  				var treeObj = $.fn.zTree.getZTreeObj("menu_tree");
    				  				treeObj.reAsyncChildNodes(null, "refresh");
    				    		});
    						} else {
    				    		layer.msg("数据删除失败", {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
    		} 
        </script>
  </body>
</html>
