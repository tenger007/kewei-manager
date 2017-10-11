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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 技术点数据列表
				<button onclick="edit_score()" type="button" class="btn btn-success"><i class="glyphicon glyphicon-pencil"></i>一键评分</button>
				</h3>
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
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deletejsds()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.open('${APP_PATH}/goto_jsd_manager/edit_jsd_by_id/0.do')"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br><br>
<br style="clear:both;">
 <h1 id="notice">请选择技术领域</h1>
          <div class="table-responsive" id="table">
            <table id="jsdTable" class="table  table-bordered" style="font-size:85%">
              <thead>
                <tr >
                   <th style="text-align:center;" width="50">编号</th>
				  <th width="30"><input id="allBox" type="checkbox"></th>
				  <th style="text-align:center;">技术领域</th>
				  <th style="text-align:center;">技术点</th>
				  <th style="text-align:center;">平均发布年</th>
                  <th style="text-align:center;">机构得分</th>
                  <th style="text-align:center;">杂志得分</th>
                  <th style="text-align:center;">数据得分</th>
                  <th style="text-align:center;">专家得分</th>
                  <th style="text-align:center;">综合评分
                  <a id="descScore" href="#" title="由高到低"><i class="glyphicon glyphicon-arrow-up"></i></a>
                  <a id="escScore" href="#" title="由低到高"><i class="glyphicon glyphicon-arrow-down"></i></a>
                  </th>
                  <th style="text-align:center;">操作</th>
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
            </table>
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
        $("#send_excel").click(function(){
        	layer.msg("请到首页导入Excel", {time:1500, icon:5, shift:6}, function(){
    		});
        })
       function uploadBtn(){
            $("#jsdFile").click();
        };
        $("#jsdFile").change(function(event){
             var loadingIndex = -1;
 	    	$("#uploadForm").ajaxSubmit({
 	    		beforeSubmit : function() {
 	    			loadingIndex = layer.load(2, {time: 10*1000});
 	    		},
 	    		success : function( r ) {
 	    			layer.close(loadingIndex);
 	    			if ( r.success ) {
 	    				layer.msg("图片上传成功", {time:1000, icon:6}, function(){
 	    				    $("#uploadForm")[0].reset();
 	    				});
 	    			} else {
 	    	    		layer.msg("图片上传失败", {time:1000, icon:5, shift:6});
 	    			}
 	    		}
 	    	});
         });
            $(function(){
            	$("#sel_menu2").select2({
            		 placeholder: "请选择技术领域",
            		 });
            });
            $("#allBox").click(function(){
            	// 获取全选框的选中状态
            	//var flg = this.checked;
            	var that = this;
            	// 将每一个用户复选框的状态和全选框保持一致
            	//$.each(集合，回调方法);
            	$("#jsdTable tbody :checkbox").each(function(i, checkbox){
            		checkbox.checked = that.checked;
            	});
            	
            });
            $("#descScore").click(function(){
            	order = "order by score desc";
            	pageQuery(0);
            });
            $("#escScore").click(function(){
            	order = "order by score";
            	pageQuery(0);
            });
            $("#queryBtn").click(function(){
            	 var oMenuIcon = $("#sel_menu2").select2();
             	if ( oMenuIcon.val() == "" ) {
             		layer.msg("查询条件不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
             		});
             	} else {
             		$("#notice").hide();
             		pageQuery(0);
             	}
             });
            var loadingIndex = -1;
            var pagesize = 15;
            var pageIndex = 0;
            var order = "";
            function pageQuery( pageIndex) {
            	var dataObj = {"pageno" : pageIndex+1,"order":order,"pagesize" : pagesize,"fieldName":$("#sel_menu2").select2().val()+""};
            	$.ajax({
            		url : "${APP_PATH}/goto_jsd_manager/jsd/pageQuery.do",
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
            				var jsd = "";
            				$.each(pageObj.datas, function(index, jsdDto){
            					// 相同类型的引号不能嵌套使用
	            	            jsd += '<tr>';
	          	                jsd += '  <td style="text-align:center;">'+(index+1)+'</td>';
	          					jsd += '  <td><input type="checkbox" value="'+jsdDto.id+'"></td>';
	          	                jsd += '  <td style="text-align:center;">'+jsdDto.fieldName+'</td>';
	          	                jsd += '  <td style="text-align:center;">'+jsdDto.jsdName+'</td>';
	          	                jsd += '  <td style="text-align:center;">'+jsdDto.year+'</td>';
	          	                jsd += '  <td style="text-align:center;">'+jsdDto.scoreJigou+'</td>';
	          	                jsd += '  <td style="text-align:center;">'+jsdDto.scoreZazhi+'</td>';
	          	                jsd += '  <td style="text-align:center;">'+jsdDto.scoreDb+'</td>';
	          	                jsd += '  <td style="text-align:center;">'+jsdDto.scoreExpert+'</td>';
	          	              	jsd += '  <td style="text-align:center;">'+jsdDto.score+'</td>';
	          	                jsd += '  <td style="text-align:center;">';
	          	              	jsd += '      <a type="button" title="编辑" onclick="window.open(\'${APP_PATH}/goto_jsd_manager/edit_jsd_by_id/'+jsdDto.id+'.do\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></a>';	
	          					jsd += '	  <a type="button" title="删除" onclick="deletejsd('+jsdDto.id+')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></a>';
	          					jsd += '  </td>';
	          	                jsd += '</tr>';
            				});
            				// 设置纯文本内容
            				//$("#jsdTable tbody").text(jsd);
            				// 设置HTML标签内容
            				$("#jsdTable tbody").html(jsd);
            				
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
            
            function deletejsd(id) {
    			layer.confirm("删除技术点，是否继续",  {icon: 3, title:'提示'}, function(cindex){
    				
    				$.ajax({
    					url : "${APP_PATH}/goto_jsd_manager/delete_jsd_by_id.do",
    					type : "POST",
    					data : {
    						id : id
    					},
    					success : function( r ) {
    						if ( r.success ) {
    				    		layer.msg("技术点删除成功", {time:1000, icon:6, shift:6}, function(){
    				    			pageQuery(0);
    				    		});
    						} else {
    				    		layer.msg("技术点删除失败", {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }
            
           function edit_score(){
        	   $.ajax({
					url : "${APP_PATH}/goto_jsd_manager/edit_score.do",
					type : "POST",
					success : function( r ) {
						if ( r.success ) {
				    		layer.msg("技术点评分成功", {time:1000, icon:6, shift:6}, function(){
				    			pageQuery(0);
				    		});
						} else {
				    		layer.msg("技术点评分失败", {time:1000, icon:5, shift:6}),function(){
				    			pageQuery(0);
				    		};
						}
					}
				});
           }
            
            function deletejsds() {
            	var selBox = $("#jsdTable tbody :checked");
            	var len = selBox.length;
            	if ( len == 0 ) {
            		layer.msg("请选择需要删除的技术点", {time:1000, icon:5, shift:6});
            		return;
            	}
    			layer.confirm("删除选择的技术点，是否继续",  {icon: 3, title:'提示'}, function(cindex){
    				
    				var dataObj = {};
    				$.each(selBox, function(i, n){
    					dataObj["ids["+i+"]"] = n.value;
    				});
    				
    				$.ajax({
    					url : "${APP_PATH}/goto_jsd_manager/delete_jsds_by_ids.do",
    					type : "POST",
    					data : dataObj,
    					success : function( r ) {
    						if ( r.success ) {
    				    		layer.msg("技术点删除成功", {time:1000, icon:6, shift:6}, function(){
    				    			pageQuery(0);
    				    		});
    						} else {
    				    		layer.msg("技术点删除失败", {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }        </script>
  </body>
</html>
