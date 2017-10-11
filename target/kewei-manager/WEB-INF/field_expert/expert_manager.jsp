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
	<link href="/kewei-manager/js/bootstrap/css/select2.min.css" rel="stylesheet" />
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
	<style>
.demo {display: inline-block;*display: inline;*zoom: 1;width: 30em;height: 90px;line-height: 20px;font-size: 12px;overflow: hidden;-ms-text-overflow: ellipsis;text-overflow: ellipsis;white-space: nowrap;}
/* .demo:hover {height: auto; word-break:break-all; white-space: pre-wrap;  text-decoration: none;} */
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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 专家数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon" >技术领域</div>
      <select id="sel_menu1" class="form-control" ">   
      				<option></option>
				    <c:forEach var="obj" items="${list_field}" varStatus="i">
				          <option value="${obj}">${obj}</option>
				     		</c:forEach>
				 	  </select>
				 	  </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-primary" style="margin-left:10px;" onclick="window.open('/kewei-manager/goto_expert_content_manager/edit_expert_by_id/0/.do')"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br><br>
<br style="clear:both;">
 <h1 id="notice">请选择技术领域</h1>
          <div class="table-responsive">
            <table id="expertTable" class="table  table-bordered" style="font-size: 85%;display: none">
              <thead>
                <tr >
                  <th style="text-align:center;">编号 </th>
				  <th ><input id="allBox" type="checkbox"></th>
				  <th style="text-align:center;">标题</th>
				  <th style=" text-align:center;">专家</th>
				  <th style="text-align:center;">专家简介</th>
                  <th style="text-align:center;">发布时间</th>
                  <th style="text-align:center;">关键词</th>
                  <th style="text-align:center;" width="70px">操作</th>
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
    <script src="/kewei-manager/js/jquery/jquery-3.0.0.js"></script>
    <script src="/kewei-manager/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="/kewei-manager/js/layer/layer.js"></script>
	<script src="/kewei-manager/js/jquery/jquery.pagination.js"></script>
	<script src="/kewei-manager/js/jquery/jquery-form.min.js"></script>
	<script src="/kewei-manager/js/bootstrap/js/select2.js"></script>
        <script type="text/javascript">
        $("#sel_menu1").select2({
        	placeholder:"请选择技术领域"
        });
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
            
            $("#allBox").click(function(){
            	// 获取全选框的选中状态
            	//var flg = this.checked;
            	var that = this;
            	// 将每一个用户复选框的状态和全选框保持一致
            	//$.each(集合，回调方法);
            	$("#expertTable tbody :checkbox").each(function(i, checkbox){
            		checkbox.checked = that.checked;
            	});
            	
            });
            
            $("#queryBtn").click(function(){
            	 var oMenuIcon = $("#sel_menu1").select2();
            	if ( oMenuIcon.val() == "" ) {
            		layer.msg("查询条件不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
            			querytext.focus();
            		});
            	} else {
            		$("#notice").hide();
            		document.getElementById('expertTable').style.display='';
            		pageQuery(0);
            	}
            });
            
            var loadingIndex = -1;
            var pagesize = 10;
            var pageIndex = 0;
            function pageQuery( pageIndex ) {
            	var dataObj = {"pageno" : pageIndex+1,"pagesize" : pagesize,"fieldName":$("#sel_menu1").select2().val()+""};
            	$.ajax({
            		url : "/kewei-manager/goto_expert_content_manager/expert/pageQuery.do",
            		type : "POST",
            		data : dataObj,
            		beforeSend : function() {
            			loadingIndex = layer.load(2, {time: 10*1000});
            		},
            		success : function( r ) {
            			layer.close(loadingIndex);
            			if ( r.success ) {
            				// 专家渲染
            				var pageObj = r.page;
            				// 循环遍历
            				var expert = "";
            				$.each(pageObj.datas, function(index, expertDto){
            					// 相同类型的引号不能嵌套使用
	            	            expert += '<tr>';
	          	                expert += '  <td style="text-align:center;">'+(index+1)+'</td>';
	          					expert += '  <td><input type="checkbox" value="'+expertDto.id+'"></td>';
	          	                expert += '  <td style="text-align:center;">'+expertDto.title+'</td>';
	          	                expert += '  <td style="text-align:center;" >'+expertDto.name+'</td>';
	          	                /* expert += '  <td style="text-align:center;">'+expertDto.authorAffiliation+'</td>'; */
	          	                expert += '  <td style="text-align:center;">'+expertDto.summary+'</td>';
	          	                expert += '  <td style="text-align:center;">'+expertDto.pbdate+'</td>';
	          	                expert += '  <td style="text-align:center;">'+expertDto.keyword+'</td>';
	          	                expert += '  <td style="text-align:center;">';
	          	              	expert += '      <a type="button" title="编辑" onclick="window.open(\'/kewei-manager/goto_expert_content_manager/edit_expert_by_id/'+expertDto.id+'/'+$("#sel_menu1").select2().val()+'.do\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></a>';	
	          					expert += '	  <a type="button" title="删除" onclick="deleteexpert('+expertDto.id+')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></a>';
	          					/* expert += '	  <button type="button" onclick="DownloadArticle('+expertDto.id+')" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-download-alt  "></i></button>'; */
	          					expert += '  </td>';
	          	                expert += '</tr>';
            				});
            				// 设置纯文本内容
            				//$("#expertTable tbody").text(expert);
            				// 设置HTML标签内容
            				$("#expertTable tbody").html(expert);
            				
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
            
            function deleteexpert(id) {
    			layer.confirm("删除专家，是否继续",  {icon: 3, title:'提示'}, function(cindex){
    				
    				$.ajax({
    					url : "/kewei-manager/goto_expert_content_manager/delete_expert_by_id.do",
    					type : "POST",
    					data : {
    						id : id
    					},
    					success : function( r ) {
    				if ( r.success ) {
    				    		layer.msg("专家删除成功", {time:1000, icon:6, shift:6}, function(){
    				    			pageQuery(0);
    				    		});
    						} else {
    				    		layer.msg("专家删除失败", {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }
           /*  function deleteexperts() {
            	var selBox = $("#expertTable tbody :checked");
            	var len = selBox.length;
            	if ( len == 0 ) {
            		layer.msg("请选择需要删除的专家", {time:1000, icon:5, shift:6});
            		return;
            	}
    			layer.confirm("删除选择的专家，是否继续",  {icon: 3, title:'提示'}, function(cindex){
    				
    				var dataObj = {};
    				$.each(selBox, function(i, n){
    					dataObj["ids["+i+"]"] = n.value;
    				});
    				
    				$.ajax({
    					url : "delete_experts_by_ids.do",
    					type : "POST",
    					data : dataObj,
    					success : function( r ) {
    						if ( r.success ) {
    				    		layer.msg("专家删除成功", {time:1000, icon:6, shift:6}, function(){
    				    			pageQuery(0);
    				    		});
    						} else {
    				    		layer.msg("专家删除失败", {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }  */       
            </script>
  </body>
</html>
