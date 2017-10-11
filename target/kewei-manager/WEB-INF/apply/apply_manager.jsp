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
				  <th style="text-align:center;">技术属性名称</th>
				  <th style="text-align:center;">技术点名称</th>
                  <th style="text-align:center;">技术点描述</th>
                  <th style="text-align:center;">申请人</th>
                  <th style="text-align:center;">申请单位</th>
                  <th style="text-align:center;">联系方式</th>
                  <th style="text-align:center;" width="100">操作</th>
                </tr>
              </thead>
              <tbody>
              </tbody>
			  <tfoot>
			     <tr >
				     <td colspan="8" align="center">
				        <div id="Pagination" class="pagination">
					 	 </div>
					 </td>
				 </tr>

			  </tfoot>
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
				  <select id="sel_menu1" style="margin-left:50px;width: 50%;z-index: 99999!important;">   
				    <c:forEach var="obj" items="${users}" varStatus="i">
				          <option value="${obj}" style="width: 50%;z-index: 99999!important;">${obj}</option>
				     		</c:forEach>
				 </select> 
				 <button type="button" class="btn btn-danger" style="margin-left:20px;" onclick="agree_menu()"><i class="glyphicon glyphicon-ok"></i>技术点菜单完成</button>
				 <button type="button" class="btn btn-primary" style="margin-left:10px;" onclick="goto_others()"><i class="glyphicon glyphicon-plus"></i>分配给第三方</button>
				 </div>
				 <div class="modal-description-content">
				 <div class="zTreeDemoBackground left">
				 <ul id="menu_tree" class="ztree" style="border: 1px solid #617775;overflow-y: scroll;height: 500px;"></ul>
				 </div>
				 </div>
				 </div>
		  </div>
		  <div class="modal-footer">
				  <button  type="button" onclick="update()" class="btn btn-success"><i class="glyphicon glyphicon-share-alt"></i>同意</button>
				  <button id="resetBtn"  type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i>不同意</button>
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
        
         function editApply(id,jsdid,jsdname,fieldname,describe,applicant,applicantUnit,tel){
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
		        						onCheck:onCheck,
		        						beforeRename:  beforeRename  ,
		        				        onRename:onRename,
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
		    					addHoverDom: function(treeId, treeNode){
		    						var aObj = $("#" + treeNode.tId + "_a"); 
		    						if (treeNode.editNameFlag || $("#btnGroup"+treeNode.tId).length>0) return;
		    						var s = '<span id="btnGroup'+treeNode.tId+'">';
		    						if( treeNode.level == 0){
		    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" id="addBtn_' + treeNode.id + '" title="增加菜单" onfocus="this.blur();" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';	
		    						}else{
		    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" id="addBtn_' + treeNode.id + '" title="增加菜单" onfocus="this.blur();" >&nbsp;&nbsp;<i class="fa fa-fw fa-plus rbg "></i></a>';
		    							s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" onclick="deleteNode('+treeNode.id+', \''+treeNode.name+'\')" title="删除菜单">&nbsp;&nbsp;<i class="fa fa-fw fa-times rbg "></i></a>';
		    						}
		    						s += '</span>';
		    						aObj.after(s);
		    					    var btn = $("#addBtn_"+treeNode.id);
		    					    //绑定添加事件，并定义添加操作  
		    					    var zTree = $.fn.zTree.getZTreeObj("menu_tree");  
		    					    if (btn) btn.bind("click", function(){  
		    					        //将新节点添加到数据库中
		    					        var name2='新菜单'; 
		    					        $.post('/kewei-manager/goto_apply_manager/menu_add/'+treeNode.id+'/'+name2+'/'+0+'.do',function (data) {  
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
		       			        url:"/kewei-manager/goto_apply_manager/query_temp_menu/"+0+".do",
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
		        		   $.post('/kewei-manager/goto_apply_manager/edit_menu_by_id/'+treeNode.id+'/'+treeNode.name+'.do'); 
		        			return true;
		        		}
		        		
		        		 function onCheck(e,treeId,treeNode){
		        	            var treeObj=$.fn.zTree.getZTreeObj("menu_tree");
		        	            nodes=treeObj.getCheckedNodes(true);
		        	            for(var i=0;i<nodes.length;i++){
		        	            ids+=nodes[i].id+",";
		        	            }
		        	          //获取选中节点的值
		        	            }
        	 
        	 $('#myModal').on('show.bs.modal', function () {
        		 $.fn.modal.Constructor.prototype.enforceFocus = function () { };
            	 var modal = $(this)
            	 modal.find('#cm-modal-id').val(id);
            	 modal.find('#cm-modal-jsdid').val(jsdid);
            	 modal.find('#cm-modal-jsdname').val(jsdname);
            	 modal.find('#cm-modal-fieldname').val(fieldname);
            	 modal.find('#cm-modal-content').val(describe);
            	 modal.find('#cm-modal-user').val(applicant+","+applicantUnit+","+tel);
            	});
        } 
         function goto_others(){
        		 var user = $("#sel_menu1").select2();
        		 alert(user.val());
        		 if(user.val()==""){
            		 layer.msg("请先选择第三方再分配", {time:1500, icon:5, shift:6}, function(){
    	        			return false;
    	        		});
            	 }
        		 else{
        			 $.ajax({
	    	        	   url : "/kewei-manager/goto_apply_manager/addApply.do",
	    	        		type : "POST",
	    	        		data : {user:user.val(),name:$("#cm-modal-jsdname").val(),id:ids,jsdid:$('#cm-modal-jsdid').val()},
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
	        }
         
         function deleteNode(id, name) {
 			layer.confirm("删除"+name+"，是否继续?",  {icon: 3, title:'提示'}, function(cindex){
 				$.ajax({
 					url : "/kewei-manager/goto_apply_manager/delete_menu_by_id.do",
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
         
         function agree_menu(){
        	 var treeObj = $.fn.zTree.getZTreeObj("menu_tree");
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
                      url: "/kewei-manager/goto_apply_manager/agree_menu.do",  
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
            var id = $('#cm-modal-id').val();  
            var jsdname = $("#cm-modal-jsdname").val();
       layer.confirm("添加技术点："+jsdname+"到跟踪，是否同意",  {icon: 3, title:'提示'}, function(cindex){
    	   $('#myModal').modal('hide');  
            $.ajax({  
                type: "post",  
                url: "/kewei-manager/goto_apply_manager/agreeApply.do",  
                data : {
					id : id
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
            layer.close(cindex);
		}, function(cindex){
		    layer.close(cindex);
		});
        }  
        
    /*     
     function agreeApply(id,name,jsdid) {
    	 layer.confirm("同意将技术点："+name+"添加到跟踪，是否继续",  {icon: 3, title:'提示'}, function(cindex){
				
				$.ajax({
					url : "agreeApplyById.do",
					type : "POST",
					data : {
						id : id,jsdid:jsdid,name:name
					},
					success : function( r ) {
						if ( r.success ) {
				    		layer.msg("操作成功", {time:1000, icon:6, shift:6}, function(){
				    			document.location.reload()
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
         */
        
   /*   function editApply(id) {
				$.ajax({
					url : "editApplyById.do",
					type : "POST",
					data : {
						id : id
					},
					success : function( r ) {
					}
				});
	}
        */ 
        $("#queryBtn").click(function(){
        	var querytext = $("#querytext");
        	if ( querytext.val() == "" ) {
        		layer.msg("查询条件不能为空，请输入技术点名称", {time:1000, icon:5, shift:6}, function(){
        			querytext.focus();
        		});
        	} else {
        		pageQuery(0);
        	}
        });
        var loadingIndex = -1;
        var pagesize = 5;
        function pageQuery( pageIndex ) {
        	var dataObj = {"pageno" : pageIndex+1,"pagesize" : pagesize};
        	var querytext = $("#querytext");
        	if ( querytext.val() != "" ) {
        		dataObj["querytext"] = querytext.val();
        	}
        	
        	$.ajax({
        		url : "/kewei-manager/goto_apply_manager/apply/pageQuery.do",
        		type : "POST",
        		data : dataObj,
        		beforeSend : function() {
        			loadingIndex = layer.load(2, {time: 10*1000});
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
          					content += '  <td style="text-align:center;">'+applys.fieldname+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.jsdname+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.jsd_describe+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.applicant+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.applicant_unit+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.tel+'</td>';
          	                content += '  <td style="text-align:center;">';
          	              content += '      <a type="button" title="详细信息" data-toggle="modal" data-target="#myModal" onclick="editApply('+applys.id+', '+applys.jsdid+', \''+applys.jsdname+'\', \''+applys.fieldname+'\', \''+applys.jsd_describe+'\', \''+applys.applicant+'\', \''+applys.applicant_unit+'\', \''+applys.tel+'\')"  class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-edit"></i></a>';
          	             /*  content += '      <button type="button" title="同意申请" onclick="agreeApply('+applys.id+', \''+applys.jsdname+'\''+', \''+applys.jsdid+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-ok"></i></button>';	
          					content += '	  <button type="button" title="不同意申请" onclick="disagree('+applys.id+', \''+applys.jsdname+'\')" data-toggle="modal" data-target="#myModal" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>'; */
          					content += '  </td>';
          	                content += '</tr>';
        				});
        				// 设置纯文本内容
        				//$("#menuTable tbody").text(content);
        				// 设置HTML标签内容
        				$("#menuTable tbody").html(content);
        				
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
        
        </script>
  </body>
</html>
