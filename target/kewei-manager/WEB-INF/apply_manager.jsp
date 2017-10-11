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
	<link rel="stylesheet" href="css/pagination.css">
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
				  <th width="30"><input id="allBox" type="checkbox"></th>
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
    <div class="modal fade bs-modal-lg" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog modal-lg">
		<div class="modal-content">
		  <div class="modal-header bg-primary">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">不同意将技术点添加到跟踪</h4>
		  </div>
		  <div class="modal-body">
				  <div class="form-group">
					<label for="fid">推送信息</label>
					<input type="text" class="form-control" id="imessage" name="imessage" placeholder="请输入异常原因">
					<input type="hidden" id="id" name="id" >
					<input type="hidden" id="jsdname" name="jsdname" >
				  </div>
		  </div>
		  <div class="modal-footer">
				  <button  type="button" onclick="update()" class="btn btn-success"><i class="glyphicon glyphicon-share-alt"></i> 推送</button>
				  <button id="resetBtn"  type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
		  </div>
		  
		</div>
	  </div>
	</div>
    <script src="/kewei-manager/js/jquery/jquery-3.0.0.js"></script>
    <script src="/kewei-manager/js/jquery/jquery-form.min.js"></script>
    <script src="/kewei-manager/js/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/jquery/jquery.pagination.js"></script>
	<script src="/kewei-manager/js/layer/layer.js"></script>
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
		    
		    pageQuery(0);
        });
        
        function disagree(id,name){
        	$("#id").val(id);
        	$("#jsdname").val(name);
        }
        
      //提交更改  
        function update() {  
        	var imessage = $('#imessage').val();  
            var id = $('#id').val();  
            var name = $("#jsdname").val();
       layer.confirm("不添加技术点："+name+"到跟踪，是否继续",  {icon: 3, title:'提示'}, function(cindex){
    	   $('#myModal').modal('hide');  
            $.ajax({  
                type: "post",  
                url: "disagreeApply.do",  
                data : {
					id : id,imessage:imessage
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
        		url : "apply/pageQuery.do",
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
          					content += '  <td><input type="checkbox" value="'+applys.id+'"></td>';
          	                content += '  <td style="text-align:center;">'+applys.jsdname+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.jsd_describe+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.applicant+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.applicant_unit+'</td>';
          	                content += '  <td style="text-align:center;">'+applys.tel+'</td>';
          	                content += '  <td style="text-align:center;">';
          	              content += '      <button type="button" title="同意申请" onclick="agreeApply('+applys.id+', \''+applys.jsdname+'\''+', \''+applys.jsdid+'\')" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-ok"></i></button>';	
          					content += '	  <button type="button" title="不同意申请" onclick="disagree('+applys.id+', \''+applys.jsdname+'\')" data-toggle="modal" data-target="#myModal" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
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
