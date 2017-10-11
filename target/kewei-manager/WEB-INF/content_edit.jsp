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
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
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
							<li class="list-group-item" >
								<span><i class="glyphicon glyphicon-book"></i> 菜单管理 </span>  
								<ul id="menu_tree" class="ztree" style="margin-top:5px;border: 1px solid #617775;overflow-y: scroll;height: auto;width: auto;"></ul>
							</li>
				</ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-9 col-md-offset-3 main">
				<ol class="breadcrumb">
				  <li class="active">修改</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"></div></div>
			  <div class="panel-body">
			  <form action="/kewei-manager/updateContent.do" method="post" id="contentForm" role="form">
				  <input type="hidden" id="id" name="id" value="${content.id}">
				  <div class="form-group">
					<label for="contents">内容</label>
					<script id="contents" type="text/plain" style="width:auto!important;height:100%;">
                      ${content.contents}
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
	<script type="text/javascript" src="/kewei-manager/ztree/jquery.ztree.all-3.5.min.js"></script>
	<script type="text/javascript" charset="utf-8" src="/kewei-manager/ueditor/ueditor.config.js"></script>
    <script type="text/javascript" charset="utf-8" src="/kewei-manager/ueditor/ueditor.all.min.js"> </script>
	 <script type="text/javascript" charset="utf-8" src="/kewei-manager/ueditor/lang/zh-cn/zh-cn.js"></script>
        <script type="text/javascript">
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
				        onDrop: onDrop  
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
						s += '<a class="btn btn-info dropdown-toggle btn-xs" style="margin-left:10px;padding-top:0px;" href="/kewei-manager/goto_menu_manager/edit_content/' +treeNode.name+"/"+treeNode.jsdid+"/"+ treeNode.id +'.do" title="编辑页面" onfocus="this.blur();" >&nbsp;&nbsp;<i class="fa fa-fw fa-edit rbg "></i></a>';
					s += '</span>';
					aObj.after(s);
				    var btn = $("#addBtn_"+treeNode.id);
				    var ebtn= $("#"+"editBtn_"+treeNode.id+treeNode.name);
				    //绑定添加事件，并定义添加操作  
				    var zTree = $.fn.zTree.getZTreeObj("menu_tree");  
				    if (btn) btn.bind("click", function(){  
				        //将新节点添加到数据库中
				        var name='新菜单'; 
				        $.post('/kewei-manager/goto_menu_manager/menu_add/'+treeNode.id+'/'+name+'/'+$("#sel_menu2").select2().val()+'.do',function (data) {  
				            var newID = data; //获取新添加的节点Id  
				            zTree.addNodes(treeNode, {id:newID, fid:treeNode.id, name:name}); //页面上添加节点  
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
			        url:"/kewei-manager/goto_menu_manager/menu/menuQuery2/"+${content.jsdid}+".do",
			    	autoParam:["id", "name=n", "level=lv"]
			    	
			    }
		};
		function onDrop(event, treeId, treeNodes, targetNode, moveType, isCopy) {  
			 $.post('/kewei-manager/goto_menu_manager/edit_menu_by_id/'+treeNodes[0].id+'/'+targetNode.id+'/'+treeNodes[0].name+'/'+$("#sel_menu2").select2().val()+'.do');
    		    return true; 
		}  
		$.fn.zTree.init($("#menu_tree"), setting);
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
	       var menuid=${content.menuid};
	       var jsdid=${content.jsdid};
	       var menuname='${content.menuname}';
	    	var dataObj = {"menuid" : menuid,"contents":contents,"jsdid":jsdid,"menuname":menuname};
	    	$.ajax({
	            type: "post",
	            url: "/kewei-manager/goto_menu_manager/updateContent.do",
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
