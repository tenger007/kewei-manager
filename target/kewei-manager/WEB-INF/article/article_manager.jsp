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
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 文章数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon" >技术领域</div>
      <select id="sel_menu1" class="form-control"  onchange="fieldChange()">   
      				<option></option>
				    <c:forEach var="obj" items="${list_field}" varStatus="i">
				          <option value="${obj}">${obj}</option>
				     		</c:forEach>
				 	  </select>
				 	  </div>
				 	  <div class="input-group">
				 	  <div class="input-group-addon">技术点</div>
				    <select id="sel_menu2" class="form-control" style="width:300px;">
				    <option></option>
				 	  </select>
				 	</div>  
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" style="float:right;margin-left:10px;" onclick="deletearticles()"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;"onclick="window.open('/kewei-manager/goto_article_manager/edit_article_by_id/0.do')"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br><br>
<br style="clear:both;">
 <h1 id="notice">请选择技术点</h1>
          <div class="table-responsive">
            <table id="articleTable" class="table  table-bordered" style="font-size: 85%">
              <thead>
                <tr >
                  <th style="text-align:center;">编号 </th>
				  <th ><input id="allBox" type="checkbox"></th>
				  <th style="text-align:center;">文章标题</th>
				  <th style=" text-align:center;">作者</th>
				<!--   <th style=" text-align:center;" width= "90">作者机构</th> -->
				  <th style="text-align:center;">来源</th>
                  <th style="text-align:center;">发布时间</th>
                  <th style="text-align:center;">相关/预测</th>
                  <th style="text-align:center;">类型</th>
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
         function fieldChange(){
            var fieldName = $("#sel_menu1").select2().val();
            document.getElementById("sel_menu2").length=0;
            $.ajax({
	            type: "post",
	            url: "/kewei-manager/goto_jsd_manager/queryJsdName.do",
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
            	$("#articleTable tbody :checkbox").each(function(i, checkbox){
            		checkbox.checked = that.checked;
            	});
            	
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
            var pagesize = 8;
            var pageIndex = 0;
            function pageQuery( pageIndex ) {
            	var dataObj = {"pageno" : pageIndex+1,"pagesize" : pagesize,"jsdName":$("#sel_menu2").select2().val()+""};
            	$.ajax({
            		url : "/kewei-manager/goto_article_manager/article/pageQuery.do",
            		type : "POST",
            		data : dataObj,
            		beforeSend : function() {
            			loadingIndex = layer.load(2, {time: 10*1000});
            		},
            		success : function( r ) {
            			layer.close(loadingIndex);
            			if ( r.success ) {
            				// 文章渲染
            				var pageObj = r.page;
            				// 循环遍历
            				var article = "";
            				$.each(pageObj.datas, function(index, articleDto){
            					// 相同类型的引号不能嵌套使用
	            	            article += '<tr>';
	          	                article += '  <td style="text-align:center;">'+(index+1)+'</td>';
	          					article += '  <td><input type="checkbox" value="'+articleDto.id+'"></td>';
	          	                article += '  <td style="text-align:center;">'+articleDto.title+'</td>';
	          	                article += '  <td style="text-align:center;" class="demo">'+articleDto.author+'</td>';
	          	                /* article += '  <td style="text-align:center;">'+articleDto.authorAffiliation+'</td>'; */
	          	                article += '  <td style="text-align:center;">'+articleDto.sourceName+'</td>';
	          	                article += '  <td style="text-align:center;">'+articleDto.pbdate+'</td>';
	          	                article += '  <td style="text-align:center;">'+(articleDto.isforecast==1?'相关':'预测')+'</td>';
	          	                article += '  <td style="text-align:center;">'+(articleDto.type==1?'文献':articleDto.type==0?'报告':'数据库')+'</td>';
	          	                article += '  <td style="text-align:center;">';
	          	              	article += '      <a type="button" title="编辑" onclick="window.open(\'/kewei-manager/goto_article_manager/edit_article_by_id/'+articleDto.id+'.do\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></a>';	
	          					article += '	  <a type="button" title="删除" onclick="deletearticle('+articleDto.id+')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></a>';
	          					/* article += '	  <button type="button" onclick="DownloadArticle('+articleDto.id+')" class="btn btn-success btn-xs"><i class="glyphicon glyphicon-download-alt  "></i></button>'; */
	          					article += '  </td>';
	          	                article += '</tr>';
            				});
            				// 设置纯文本内容
            				//$("#articleTable tbody").text(article);
            				// 设置HTML标签内容
            				$("#articleTable tbody").html(article);
            				
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
            
            function deletearticle(id) {
    			layer.confirm("删除文章，是否继续",  {icon: 3, title:'提示'}, function(cindex){
    				
    				$.ajax({
    					url : "/kewei-manager/goto_article_manager/delete_article_by_id.do",
    					type : "POST",
    					data : {
    						id : id
    					},
    					success : function( r ) {
    				if ( r.success ) {
    				    		layer.msg("文章删除成功", {time:1000, icon:6, shift:6}, function(){
    				    			pageQuery(0);
    				    		});
    						} else {
    				    		layer.msg("文章删除失败", {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            }
            /* function DownloadArticle(id) {
    			layer.confirm("下载文章，是否继续",  {icon: 3, title:'提示'}, function(cindex){
    				
    				$.ajax({
    					url : "DownloadArticle.do",
    					type : "POST",
    					data : {
    						id : id
    					},
    					success : function( r ) {
    						if ( r.success ) {
    				    		layer.msg("文章下载成功", {time:1000, icon:6, shift:6}, function(){
    				    			pageQuery(0);
    				    		});
    						} else {
    				    		layer.msg("文章下载失败，请上传", {time:1000, icon:5, shift:6});
    						}
    					}
    				});
    				
    			    layer.close(cindex);
    			}, function(cindex){
    			    layer.close(cindex);
    			});
            } */
            
            function deletearticles() {
            	var selBox = $("#articleTable tbody :checked");
            	var len = selBox.length;
            	if ( len == 0 ) {
            		layer.msg("请选择需要删除的文章", {time:1000, icon:5, shift:6});
            		return;
            	}
    			layer.confirm("删除选择的文章，是否继续",  {icon: 3, title:'提示'}, function(cindex){
    				
    				var dataObj = {};
    				$.each(selBox, function(i, n){
    					dataObj["ids["+i+"]"] = n.value;
    				});
    				
    				$.ajax({
    					url : "/goto_article_manager/delete_articles_by_ids.do",
    					type : "POST",
    					data : dataObj,
    					success : function( r ) {
    						if ( r.success ) {
    				    		layer.msg("文章删除成功", {time:1000, icon:6, shift:6}, function(){
    				    			pageQuery(0);
    				    		});
    						} else {
    				    		layer.msg("文章删除失败", {time:1000, icon:5, shift:6});
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
