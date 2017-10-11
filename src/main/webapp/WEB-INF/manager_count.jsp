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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i>服务分配统计
				</h3>
			  </div>
     	  <div class="panel-body">
	<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon" >查询条件</div>
      <select id="sel_menu1" class="form-control"  onchange="fieldChange()">   
      				<option></option>
				          <option value="技术领域">技术领域</option>
				          <option value="跟踪技术点">跟踪技术点</option>
				          <option value="服务方">服务方</option>
				 	  </select>
				 	  </div>
				 	  <div class="input-group">
				 	  <div class="input-group-addon">查询内容</div>
				    <select id="sel_menu2" class="form-control" style="width:300px;">
				    <option></option>
				 	  </select>
				 	</div>  
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<br>
<h1 id="notice">请选择查询条件</h1>
 <hr style="clear:both;">
          <div class="table-responsive">
            <table id="menuTable" class="table  table-bordered">
              <thead>
                <tr >
                  <th style="text-align:center;" width="50">编号</th>
				  <th style="text-align:center;">技术领域 </th>
				  <th style="text-align:center;">跟踪技术点</th>
                  <th style="text-align:center;">分配服务方</th>
                  <th style="text-align:center;">分配信息</th>
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
        });
        
        function fieldChange(){
            var fieldName = $("#sel_menu1").select2().val();
            document.getElementById("sel_menu2").length=0;
            if(fieldName=="技术领域"){
            $.ajax({
	            type: "post",
	            url: "${APP_PATH}/goto_jsd_manager/queryField.do",
                success : function( r ) {
        				var jsdName = r.list_jsdName;
        				// 循环遍历
        				$.each(jsdName, function(index,jsdName){
        					$("#sel_menu2").append("<option value='"+jsdName+"'>"+jsdName+"</option>");
        				});
                }
	        });
            }
            if(fieldName=="服务方"){
            $.ajax({
	            type: "post",
	            url: "${APP_PATH}/goto_jsd_manager/queryUser.do",
                success : function( r ) {
        				var jsdName = r.list_jsdName;
        				// 循环遍历
        				$.each(jsdName, function(index,jsdName){
        					$("#sel_menu2").append("<option value='"+jsdName+"'>"+jsdName+"</option>");
        				});
                }
	        });
            }
            if(fieldName=="跟踪技术点"){
            $.ajax({
	            type: "post",
	            url: "${APP_PATH}/goto_jsd_manager/queryJsd.do",
                success : function( r ) {
        				var jsdName = r.list_jsdName;
        				// 循环遍历
        				$.each(jsdName, function(index,jsdName){
        					$("#sel_menu2").append("<option value='"+jsdName+"'>"+jsdName+"</option>");
        				});
                }
	        });
            }
           }
        $("#send_excel").click(function(){
        	layer.msg("请到首页导入Excel", {time:1500, icon:5, shift:6}, function(){
    		});
        })
        
        $("#queryBtn").click(function(){
        	 var oMenuIcon = $("#sel_menu2").select2();
         	if ( oMenuIcon.val() == "" ) {
         		layer.msg("查询内容不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
         		});
         	} else {
         		$("#notice").hide();
         		pageQuery(0);
         	}
        });
        
        var loadingIndex = -1;
        var pagesize = 5;
        function pageQuery( pageIndex ) {
        	var dataObj = {"pageno" : pageIndex+1,"pagesize" : pagesize};
        	var querytext=$("#sel_menu2").select2();
        	if ( querytext.val() != "" ) {
        		dataObj["querytext"] =$("#sel_menu2").select2().val();
        		dataObj["querytext2"] =$("#sel_menu1").select2().val();
        	}
        	
        	$.ajax({
        		url : "${APP_PATH}/goto_count_manager/user_menuQuery.do",
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
          	                content += '  <td style="text-align:center;">'+applys.username+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.menuname+'</td>';
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
        	    		layer.msg("该技术点未分配", {time:1000, icon:5, shift:6});
        			}
        		}
        	});
        }
        
        </script>
  </body>
</html>
