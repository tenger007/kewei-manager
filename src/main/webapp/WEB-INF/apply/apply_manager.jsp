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
	.tree-closed {
	    height : 40px;
	}
	.tree-expanded {
	    height : auto;
	    
	}
	#imessages{
		width:100%;
	}
	#sel_menu1{
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
			<ul style="width: auto" class="list-group">
							<%@include file="/WEB-INF/common/common.jsp"%>
				</ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-9 col-md-offset-3 main">
        <div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>技术点添加跟踪申请列表
				</h3>
			  </div>
     	  <div class="panel-body">
	<form class="form-inline" role="form" style="float:left;">
	  <div class="form-group has-feedback">
	    <div class="input-group">
	      <div class="input-group-addon">查询条件</div>
	      <input id="querytext" class="form-control has-success"  type="text" placeholder="请输入技术点">
	    </div>
	  </div>
	</form>
	<button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i>查询</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table id="menuTable" class="table  table-bordered">
              <thead>
                <tr >
                  <th style="text-align:center;" width="50">编号</th>
                   <th ><input id="allBox" type="checkbox"></th>
				  <th style="text-align:center;">技术领域 </th>
				  <th style="text-align:center;">技术点</th>
                  <th style="text-align:center;">技术点描述</th>
                  <th style="text-align:center;">申请人</th>
                  <th style="text-align:center;">申请单位</th>
                  <th style="text-align:center;">联系方式</th>
                  <th style="text-align:center;">申请时间</th>
                  <th style="text-align:center;" width="20%">操作</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="10" align="center">
				        <div id="Pagination" class="pagination">
					 	 </div>
					 </td>
				 </tr>

			  </tfoot>
			  <button type="button" class="btn btn-danger" style="margin-left: 80%"  onclick="disupdates()"><i class=" glyphicon glyphicon-cog"></i>反馈</button>
			  <button id="returnBack" type="button" style="display: none;" data-toggle="modal" data-target="#Modal" ></button>
			  <a href="${APP_PATH}/goto_apply_manager/apply_all_manager.htm" style="margin-left: 2%">消息记录<span class="caret"></span></a>
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
			<h4 class="modal-title" id="myModalLabel">详细信息</h4>
		  </div>
		  <div class="modal-body">
		  <div class="mpdal-title-container">
				 <input id="cm-modal-id"  style="display:none;"></input>
				 <input id="cm-modal-status"  style="display:none;"></input>
				 <input id="cm-modal-jsdid"  style="display:none;"></input>
				 <div class="input-group">
				   <div class="input-group-addon" >技术领域名称</div>
					<input type="text" class="form-control" id="cm-modal-fieldname" style="width:100%;" readonly >
				  </div>
				  <br>
				 <div class="input-group">
				   <div class="input-group-addon" >技术点名称</div>
					<input type="text" class="form-control" id="cm-modal-jsdname" style="width:100%;" readonly >
				  </div>
				  <br>
				 <div class="input-group">
				   <div class="input-group-addon" >技术点描述</div>
					<input type="text" class="form-control" id="cm-modal-content" style="width:100%;" readonly>
				  </div>
				   <br>
				 <div class="input-group">
				   <div class="input-group-addon" >申请人、单位、联系方式</div>
					<input type="text" class="form-control" id="cm-modal-user" style="width:100%;" readonly>
				  </div>
				  <br>
				 </div>
				 <div class="modal-description-container">
				 <div class="modal-description-bar">技术点菜单 
				 </div>
				 <div class="modal-description-content">
				 <div class="zTreeDemoBackground left">
				 <ul style="border: 1px solid #617775;overflow-y: scroll;height: 500px;">
				 <ul id="menu_tree" class="ztree">
				 </ul>
				 <button id="menu_complete" type="button" class="btn btn-warning" style="margin-left:85%;" onclick="agree_menu()"><i class="glyphicon glyphicon-ok"></i>菜单完成</button>
				  <h2 id="notice">跟踪技术点已经添加显示,未反馈</h2>
				  <h2 id="notice2">申请信息已经反馈，正在处理</h2>
				  <h2 id="notice3">申请信息已经完成</h2>
				  <h2 id="notice4">该技术点尚未确定是否添加</h2>
				 </ul>
				 </div>
				 </div>
				 </div>
		  </div>
		  <div class="modal-footer" id="updateapply">
				  <button  type="button" onclick="update()" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i>同意添加</button>
		  </div>
		</div>
	  </div>
	</div>
	  <div class="modal fade bs-modal-lg" id="Modal"  tabindex="1"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
	  <div class="modal-dialog modal-lg">
		<div class="modal-content">
		  <div class="modal-header bg-primary">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">申请反馈</h4>
		  </div>
		  <div class="modal-body">
		  <div class="mpdal-title-container">
				 <input id="cm-modal2-id"  style="display:none;"></input>
				 <div class="input-group">
				   <div class="input-group-addon" >邮件标题</div>
					<input type="text" id="completeTitle"name="title" class="form-control has-success"  style="width:90%;" value="科委大数据平台" name="authorAffiliation" placeholder="请输入完成信息">
				  </div>
				  <br>
				 <div class="input-group">
				   <div class="input-group-addon" >邮件主题</div>
					<input type="text" id="completeSubject"name="subject" class="form-control has-success"  style="width:90%;" value="申请反馈信息" name="authorAffiliation" placeholder="请输入完成信息">
				  </div>
				  <br>
				 <div class="input-group">
				   <div class="input-group-addon" >邮件正文</div>
                   <textarea id="imessages" class="form-control" placeholder="请输入反馈信息">
                   </textarea>
                    </div>
		  </div>
		  <div class="modal-footer">
				  <button  type="button" onclick="sendEmail()" class="btn btn-success"><i class="glyphicon glyphicon-share-alt"></i>推送</button>
		  </div>
		</div>
	  </div>
	</div>
	</div>
	<div class="modal fade bs-modal-lg" id="User_permission"  tabindex="1"  role="dialog" aria-labelledby="myModalLabel" aria-hidden="false">
	  <div class="modal-dialog modal-lg">
		<div class="modal-content">
		  <div class="modal-header bg-primary">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="user_permission_Label"></h4>
		  </div>
		  <div class="modal-body">
		  <div class="mpdal-title-container">
				 <input id="cm-modal3-id"  style="display:none;"></input>
				 <input id="cm-modal4-id"  style="display:none;"></input>
				 <form class="form-inline" role="form" style="float:left;">
  		 <div class="form-group has-feedback">
   			 <div class="input-group">
    		 <div class="input-group-addon" >第三方</div>
      				<select id="sel_menu1" class="form-control" >
      				<option></option>
				    <c:forEach var="obj" items="${users}" varStatus="i">
				          <option value="${obj}">${obj}</option>
				     		</c:forEach>
				 	  </select>
				 	  </div>
  		 </div>
  			</form>
  			<br><br>
 <br style="clear:both;">
  <div class="zTreeDemoBackground left">
 <ul style="border: 1px solid #617775;overflow-y: scroll;height: 500px;">
 <ul id="menu_tree2" class="ztree" >
 </ul>
 <button onclick="goto_others()"  type="button" style="margin-left:85%;" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i>分配</button>
 </ul>
 </div>
				 </div>
		  </div>
		  <div class="modal-footer">
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
        var dataObj = {};
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
		    
		    pageQuery(0);
        });
        function  give_permission(name,fieldname){
      	  $('#User_permission').on('show.bs.modal', function () {
       		 $('#user_permission_Label').html("分配技术点："+name); 
       		 var modal = $(this)
        	 modal.find('#cm-modal3-id').val(name);
        	 modal.find('#cm-modal4-id').val(fieldname);
           	});
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
			        url:"${APP_PATH}/goto_menu_manager/menu/menuQuery/"+name+".do",
			    	autoParam:["id", "name=n", "level=lv"]
			    }
		};
		$.fn.zTree.init($("#menu_tree2"), setting);
		 function onCheck(e,treeId,treeNode){
	            var treeObj=$.fn.zTree.getZTreeObj("menu_tree2");
	            nodes=treeObj.getCheckedNodes(true);
	            for(var i=0;i<nodes.length;i++){
	            ids+=nodes[i].id+",";
	            }
	          //获取选中节点的值
	            }
        }
        function goto_others(){
      		 var username = $('#sel_menu1').select2().val();
      		 var jsdname = $("#cm-modal3-id").val();
      		 var fieldname = $("#cm-modal4-id").val();
      		 if(username==""){
      			layer.msg("请先选择第三方", {time:1000, icon:6, shift:6});
      			return;
      		 }
      		 else{
      			layer.confirm("是否分配所选菜单?",  {icon: 3, title:'提示'}, function(cindex){
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
       				    			var treeObj=$.fn.zTree.getZTreeObj("menu_tree2");
       				    		 nodes=treeObj.getCheckedNodes(true);
       				            for(var i=0;i<nodes.length;i++){
       				            	$("#"+nodes[i].tId+"_span").append("<i  style='color:red;'>"+$('#sel_menu1').select2().val()+"</i>"); 
       				            }
       				    		});
       						} else {
       				    		layer.msg("分配失败", {time:1000, icon:5, shift:6});
       						}
      	        		}
      	           });
      			}, function(cindex){
     			    layer.close(cindex);
     			});
      		 }
          }
        
         function editApply(id,status,jsdid,jsdname,fieldname,describe,applicant,applicantUnit,tel){
        	 $("#disagreeimessage").hide();
        	 $("#agreeimessage").hide();
        	 if(status==3){
        		 $("#updateapply").hide();
        		 $("#notice").show();
        		 $("#notice2").hide();
        		 $("#notice3").hide();
        		 $("#notice4").hide();
        		 $("#menu_complete").hide();
        	 }
        	 if(status==0){
        		 $("#updateapply").show(); 
        		 $("#notice").hide();
        		 $("#notice2").hide();
        		 $("#notice3").hide();
        		 $("#notice4").show();
        		 $("#menu_complete").show();
        	 }
        			 // 树形组件的异步读取数据
		        		var setting = {
		        				edit: {
		        					drag: {  
		        						isCopy: false,
		        						isMove: false
		        				    },  
		        					enable: true,
		        					showRemoveBtn: false,
		        		            showRenameBtn: true
		        					},
		        					callback: {  
		        						beforeRename:  beforeRename  ,
		        				        onRename:onRename,
		        				    }  ,
		        				    check:{
		        				    	  enable: false  //设置是否显示checkbox复选框
		        				    	  },
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
		    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" id="addBtn_' + treeNode.id + '" title="增加菜单" onfocus="this.blur();" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg"></i></a>';	
		    						}else{
		    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" id="addBtn_' + treeNode.id + '" title="增加菜单" onfocus="this.blur();" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg"></i></a>';
		    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteNode('+treeNode.id+', \''+treeNode.name+'\')" title="删除菜单">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg"></i></a>';
		    						}
		    						s += '</span>';
		    						aObj.after(s);
		    					    var btn = $("#addBtn_"+treeNode.id);
		    					    //绑定添加事件，并定义添加操作  
		    					    var zTree = $.fn.zTree.getZTreeObj("menu_tree");  
		    					    if (btn) btn.bind("click", function(){  
		    					        //将新节点添加到数据库中
		    					        var name2='新菜单'; 
		    					        $.post('${APP_PATH}/goto_apply_manager/menu_add/'+treeNode.id+'/'+name2+'/'+id+'.do',function (data) {  
		    					            var newID = data; //获取新添加的节点Id  
		    					            zTree.addNodes(treeNode, {id:newID,jsdid:treeNode.jsdid, fid:treeNode.id, name:name2}); //页面上添加节点  
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
		       			        url:"${APP_PATH}/goto_apply_manager/query_temp_menu/"+id+".do",
		       			    	autoParam:["id", "name=n", "level=lv"]
		       			    	
		       			    }
		        		};
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
		        		   $.post('${APP_PATH}/goto_apply_manager/edit_menu_by_id/'+treeNode.id+'/'+treeNode.name+'.do'); 
		        			return true;
		        		}
		        		
        	 $('#myModal').on('show.bs.modal', function () {
        		 $.fn.modal.Constructor.prototype.enforceFocus = function () { };
            	 var modal = $(this)
            	 modal.find('#cm-modal-id').val(id);
            	 modal.find('#cm-modal-status').val(status);
            	 modal.find('#cm-modal-jsdid').val(jsdid);
            	 modal.find('#cm-modal-jsdname').val(jsdname);
            	 modal.find('#cm-modal-fieldname').val(fieldname);
            	 modal.find('#cm-modal-content').val(describe);
            	 modal.find('#cm-modal-user').val(applicant+","+applicantUnit+","+tel);
            	});
        } 
         
         function deleteNode(id, name) {
 			layer.confirm("删除"+name+"，是否继续?",  {icon: 3, title:'提示'}, function(cindex){
 				$.ajax({
 					url : "${APP_PATH}/goto_apply_manager/delete_menu_by_id.do",
 					type : "POST",
 					data : {
 						id : id
 					},
 					success : function( r ) {
 						if ( r.success ) {
 				    		layer.msg("菜单删除成功", {time:1000, icon:6, shift:6}, function(){
 				  				var treeObj = $.fn.zTree.getZTreeObj("menu_tree");
 				  				treeObj.reAsyncChildNodes(null, "refresh");
 				    		});
 						} else {
 				    		layer.msg("菜单删除失败", {time:1000, icon:5, shift:6});
 						}
 					}
 				});
 				
 			    layer.close(cindex);
 			}, function(cindex){
 			    layer.close(cindex);
 			});
 		} 
         
         function agree_menu(){
        	 var treeObj = $.fn.zTree.getZTreeObj("menu_tree");
        	 ids = "Y";
         	var nodes =treeObj.transformToArray(treeObj.getNodes());
             var jsdid = $('#cm-modal-jsdid').val();  
             var jsdname = $("#cm-modal-jsdname").val();
             var fieldname = $("#cm-modal-fieldname").val();
        	 var menunames="";
             var menuids = "";
             var menufids = "";
             for(var i=0;i<nodes.length;i++){
 	         menunames+=nodes[i].name + ",";
 	         menuids+=nodes[i].id+",";
 	         menufids+=nodes[i].fid+",";
 	            }
             layer.confirm("技术点："+jsdname+"菜单完成，是否添加到数据库",  {icon: 3, title:'提示'}, function(cindex){
                  $.ajax({  
                      type: "post",  
                      url: "${APP_PATH}/goto_apply_manager/agree_menu.do",  
                      data : {
      					jsdid:jsdid,jsdname:jsdname,fieldname:fieldname,menunames:menunames,menuids:menuids,menufids:menufids
      				},
      				success : function( r ) {
      					if ( r.success ) {
      			    		layer.msg("操作成功", {time:1000, icon:6, shift:6}, function(){
      			    		});
      					} else {
      			    		layer.msg("操作失败，请联系管理员", {time:1000, icon:5, shift:6});
      					}
      				}
                  }); 
                  layer.close(cindex);
      		}, function(cindex){
      		    layer.close(cindex);
      		});
         }
      //提交更改  
        function update() {
    	  if(ids!="Y"){
    		  layer.confirm("请先完成菜单", {icon:3, title:"提示"});
    	  }
    	  else{
    		  var id = $('#cm-modal-id').val(); 
    		  var jsdname = $("#cm-modal-jsdname").val();
    		  $.ajax({  
                  type: "post",  
                  url: "${APP_PATH}/goto_apply_manager/agreeApply.do",  
                  data : {
  					id : id,jsdname:jsdname
  				},
  				success : function( r ) {
  					if ( r.success ) {
  			    		layer.msg("操作成功", {time:1000, icon:6, shift:6}, function(){
  			    			window.location.reload()
  			    		});
  					} else {
  			    		layer.msg("操作失败，请联系管理员", {time:1000, icon:5, shift:6});
  					}
  				}
              });
    	  }
        }  
        function disupdates(){
             	var selBox = $("#menuTable tbody :checked");
             	var len = selBox.length;
             	if ( len == 0 ) {
             		layer.msg("请选择需要反馈的申请信息", {time:1000, icon:5, shift:6});
             		return;
             	}
             	else{
             		 $("#returnBack").click();
     				$.each(selBox, function(i, n){
     					dataObj["ids["+i+"]"] = n.value;
     					dataObj["emails["+i+"]"] = n.name;
     					dataObj["statuss["+i+"]"] = n.className;
     				}); 
             	}
        }
        function sendEmail(){
        	dataObj["imessages"] =$("#imessages").val();
        	dataObj["title"] =$("#completeTitle").val();
        	dataObj["subject"] =$("#completeSubject").val();
        	 $.ajax({  
                 type: "post",  
                 url: "${APP_PATH}/goto_apply_manager/sendEmail.do",  
                 data :dataObj ,
 				success : function( r ) {
 					if ( r.success ) {
 			    		layer.msg("推送成功", {time:1000, icon:6, shift:6}, function(){
 			    			window.location.reload()
 			    			dataObj="";
 			    		});
 					} else {
 			    		layer.msg("推送失败，请联系管理员", {time:1000, icon:5, shift:6});
 					}
 				}
             });
        }
        $("#btnCancelUpload").click(function(){
	    	 document.getElementById("fileImport").reset(); 
	    });
        $("#send_excel").click(function(){
        	layer.msg("请到首页导入Excel", {time:1500, icon:5, shift:6}, function(){
    		});
        })
        $("#queryBtn").click(function(){
        	var querytext = $("#querytext");
        	if ( querytext.val() == "" ) {
        		layer.msg("查询条件不能为空，请输入技术点名称", {time:2000, icon:5, shift:6}, function(){
        			querytext.focus();
        		});
        	} else {
        		pageQuery(0);
        	}
        });
        var loadingIndex = -1;
        var pagesize = 8;
        function pageQuery( pageIndex ) {
        	var dataObj = {"pageno" : pageIndex+1,"pagesize" : pagesize};
        	var querytext = $("#querytext");
        	if ( querytext.val() != "" ) {
        		dataObj["querytext"] = querytext.val();
        	}
        	
        	$.ajax({
        		url : "${APP_PATH}/goto_apply_manager/apply/page_new_Query.do",
        		type : "POST",
        		data : dataObj,
        		beforeSend : function() {
        			loadingIndex = layer.load(2, {time: 1*1000});
        		},
        		success : function( r ) {
        			layer.close(loadingIndex);
        			if ( r.success ) {
        				// 页面渲染
        				var pageObj = r.page;
        				// 循环遍历
        				var content = "";
        				$.each(pageObj.datas, function(index, applys){
        					// 相同类型的引号不能嵌套使用
            	            content += '<tr>';
          	                content += '  <td style="text-align:center;">'+(index+1)+'</td>';
          	                content += '  <td><input type="checkbox" value="'+applys.id+'" class="'+applys.status+'" name="'+applys.tel+'"></td>';
          					content += '  <td style="text-align:center;">'+applys.fieldname+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.jsdname+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.jsd_describe+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.applicant+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.applicant_unit+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.tel+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.apply_time+'</td>';
          	                content += '  <td style="text-align:center;">';
          	              content += '     <a type="button" title="详细信息"  data-toggle="modal" data-target="#myModal" onclick="editApply('+applys.id+', '+applys.status+', '+applys.jsdid+', \''+applys.jsdname+'\', \''+applys.fieldname+'\', \''+applys.jsd_describe+'\', \''+applys.applicant+'\', \''+applys.applicant_unit+'\', \''+applys.tel+'\')"  ><i class="glyphicon glyphicon-transfer"></i></a>';
          	              content += '     <i title="已完成" id="'+"ok"+applys.status+'"  class=" glyphicon glyphicon-ok" ></i>';
          	              content += '     <i title="已添加" id="'+"on"+applys.status+'" class=" glyphicon glyphicon-edit" ></i>';
          	              content += '     <i title="已反馈" id="'+"no"+applys.status+'" class="glyphicon glyphicon-remove" name = "'+applys.status+'"></i>';
          	            content += '      <a type="button" id="'+"user_permission"+applys.status+'" title="分配技术点" data-toggle="modal" data-target="#User_permission" onclick="give_permission(\''+applys.jsdname+'\', \''+applys.fieldname+ '\')" ><i class=" glyphicon glyphicon-check"></i></a>';
          	             /*  content += '      <button type="button" title="同意申请" onclick="agreeApply('+applys.id+', \''+applys.jsdname+'\''+', \''+applys.jsdid+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-ok"></i></button>';	
          					content += '	  <button type="button" title="不同意申请" onclick="disagree('+applys.id+', \''+applys.jsdname+'\')" data-toggle="modal" data-target="#myModal" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>'; */
          					content += '  </td>';
          	                content += '</tr>';
        				});
        				// 设置纯文本内容
        				//$("#menuTable tbody").text(content);
        				// 设置HTML标签内容
        				$("#menuTable tbody").html(content);
        				$("[id='ok0']").hide();//将所有未同意的申请信息id隐藏
        				$("[id='ok2']").hide();
        				$("[id='ok3']").hide();
        				$("[id='on1']").hide();//将所有不在进行中的申请信息id隐藏
        				$("[id='on2']").hide();
        				$("[id='on0']").hide();
        				$("[id='no1']").hide();//将所有同意和进行中的申请信息id隐藏
        				$("[id='no0']").hide();
        				$("[id='no3']").hide();
        				$("[id='user_permission1']").hide();
        				$("[id='user_permission0']").hide();
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
        			} else {
        	    		layer.msg("分页查询失败", {time:1000, icon:5, shift:6});
        			}
        		}
        	});
        }
        $("#allBox").click(function(){
        	// 获取全选框的选中状态
        	//var flg = this.checked;
        	var that = this;
        	// 将每一个用户复选框的状态和全选框保持一致
        	//$.each(集合，回调方法);
        	$("#menuTable tbody :checkbox").each(function(i, checkbox){
        		checkbox.checked = that.checked;
        	});
        	
        });
        </script>
  </body>
</html>
