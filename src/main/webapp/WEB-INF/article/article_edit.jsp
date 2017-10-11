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
	<link href="${APP_PATH}/static/js/bootstrap/css/select2.min.css" rel="stylesheet" />
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	body {
font: normal 150% Helvetica, Arial, sans-serif;
}
	</style>
	<style>
.demo {display: inline-block;*display: inline;*zoom: 1;width: 10em;height: 80px;line-height: 20px;font-size: 12px;overflow: hidden;-ms-text-overflow: ellipsis;text-overflow: ellipsis;white-space: nowrap;}
.demo:hover {height: auto; word-break:break-all; white-space: pre-wrap;  text-decoration: none;}
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
        <c:if test="${!empty articleDto}">
				<ol class="breadcrumb">
				  <li class="active">修改</li>
				  <li>附件地址：${articleDto.pdf }&nbsp; &nbsp;&nbsp; &nbsp;<button type="button" id="uploadBtn" class="btn btn-primary" ><i class="glyphicon glyphicon-open"></i> 上传文章</button></li>
				</ol>
				</c:if>
			<div class="panel panel-default">
              <div class="panel-heading">文章数据
              </div>
			  <div class="panel-body">
				<form  enctype="multipart/form-data" class="form-inline" role="form" style="float:left;" id="articleForm">
				  <input type="hidden" id="id" name="id" value="${articleDto.id}">
				  <div class="input-group">
				  <div class="input-group-addon" >文章标题</div>
					<input type="text" class="form-control " style="width:800px;"  id="title"  value="${articleDto.title }" name="title" placeholder="请输入文章标题">
				  </div>
				  <br><hr>
				   <div class="input-group">
				   <div class="input-group-addon" >作者</div>
					<input type="text" class="form-control" id="author" style="width:830px;" value="${articleDto.author }" name="author" placeholder="请输入作者">
				  </div>
				  <br><hr>
				  <div class="input-group">
				   <div class="input-group-addon" >作者机构</div>
					<input type="text" class="form-control" id="authorAffiliation" style="width:800px;" value="${articleDto.authorAffiliation }" name="authorAffiliation" placeholder="请输入作者">
				  </div>
				  <br><hr>
				  <div class="input-group">
				  <div class="input-group-addon" >来源</div>
					<select id="sel_menu1" name="sourceName" class="form-control" style="width:830px;">
					<option value="${articleDto.sourceName }">${articleDto.sourceName }</option>
					<c:forEach var="obj" items="${sourceNames}" varStatus="i">
		            <option value="${obj}" >${obj}</option>
		       		</c:forEach>
				 	  </select>
				  </div>
				  <br><hr>
				   <div class="input-group">
				  <div class="input-group-addon" >技术点</div>
					<select id="sel_menu2" name="jsds" multiple="multiple" class="form-control" style="width:820px;">
				    <c:forEach var="obj" items="${jsdNames}" varStatus="i">
		            <option value="${obj}" selected="selected">${obj}</option>
		       		</c:forEach>
		       		<c:forEach var="objs" items="${jsdNamess }" varStatus="i">
		       		<option value="${objs }">${objs}</option>
		       		</c:forEach>
				 	  </select>
				  </div>
				  <br><hr>
				  <div class="input-group">
				  <div class="input-group-addon" >分布时间</div>
					<input type="date" style="width:280px;" class="form-control" id="pbdate"  value="${articleDto.pbdate }" name="pbdate" placeholder="请输入发布时间">
					<div class="input-group-addon">期</div>
					<input type="text" style="width:200px;" class="form-control" id="issue" name="issue" value="${articleDto.issue}" placeholder="请输入期刊号">
					<div class="input-group-addon">卷</div>
					<input type="text" style="width:200px;" class="form-control" id="volume" name="volume" value="${articleDto.issue}" placeholder="请输入期刊号">
				  </div>
				  <br><hr>
				  <div class="form-group">
					<label for="type">文章类型</label>
					报告<input type="radio" class="form-control" value="0" name="type" id="type0" ${articleDto.type=="0" ? "checked='checked'" : ""} />
					文献<input type="radio" class="form-control" value="1" name="type" id="type1" ${articleDto.type=="1" ? "checked='checked'" : ""} />
					数据库<input type="radio" class="form-control" value="2" name="type" id="type2" ${articleDto.type=="2" ? "checked='checked'" : ""} />
				  </div>
				  &nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
				   <div class="form-group">
					<label for="isforecast">技术点相关/预测</label>
					相关<input type="radio" class="form-control" value="1" name="isforecast" id="isforecast0" ${articleDto.isforecast=="1" ? "checked='checked'" : ""} />
					预测<input type="radio" class="form-control" value="0" name="isforecast" id="isforecast1" ${articleDto.isforecast=="0" ? "checked='checked'" : ""} />
				  </div>
				  <br><hr>
				   <div class="form-group">
					<label for="summary">简介</label>
					<textarea id="summary" name="summary" class="form-control" style="width:880px;height:200px" placeholder="请输入文章简介"> ${articleDto.summary}</textarea>
				  </div>
				  <br><hr>
				  </form>
				  <button id="updateBtn" type="button" class="btn btn-success" style="float:left;"><i class="glyphicon glyphicon-plus"></i> 修改</button>
				  <button type="button" class="btn btn-default" id="btnCancelUpload" >取消</button>
			  </div>
			</div>
        </div>
      </div>
    </div>
    <form id="uploadForm" action="${APP_PATH}/goto_article_manager/import_article/${articleDto.id}.do" method="post" enctype="multipart/form-data">
        <input type="hidden" id="id" name="id" value="${articleDto.id}">
        <input type="file" id="articleFile" accept="application/pdf" name="articleFile" style="display:none;" >
    </form>
    <script src="${APP_PATH}/static/js/jquery/jquery-3.0.0.js"></script>
    <script src="${APP_PATH}/static/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/static/js/layer/layer.js"></script>
	<script src="${APP_PATH}/static/js/jquery/jquery-form.min.js"></script>
	<script src="${APP_PATH}/static/js/bootstrap/js/select2.js"></script>
        <script type="text/javascript">
        $("#uploadBtn").click(function(){
            $("#articleFile").click();
        });
        $("#send_excel").click(function(){
        	layer.msg("请到首页导入Excel", {time:1500, icon:5, shift:6}, function(){
    		});
        })
        $("#articleFile").change(function(event){
           /*  // 判断上传文件的大小
            var files = event.target.files, file;
            if (files && files.length > 0) {
                file = files[0]; 
            }
            
            if ( file.size >= 2 * 1024 * 1024 ) {
                layer.msg("流程定义文件超出了指定的大小：2M，请重新选择文件", {time:2000, icon:5, shift:6});
                return;
            } */
            // 提交文件上传表单
            var loadingIndex = -1;
	    	$("#uploadForm").ajaxSubmit({
	    		beforeSubmit : function() {
	    			loadingIndex = layer.load(2, {time: 10*1000});
	    		},
	    		success : function( r ) {
	    			layer.close(loadingIndex);
	    			if ( r.success ) {
	    				layer.msg("文章上传成功", {time:1000, icon:6}, function(){
	    					window.location.reload();
	    				    $("#uploadForm")[0].reset();
	    				});
	    			} else {
	    	    		layer.msg("文件上传失败", {time:1000, icon:5, shift:6});
	    			}
	    		}
	    	});
        });
        
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
		    $("#btnCancelUpload").click(function(){
		    	 document.getElementById("articleForm").reset(); 
		    });
        $("#sel_menu2").select2({
        	placeholder:"请输入技术点",
            multiple: true
        });
        $("#sel_menu1").select2({
        	placeholder:"请输入文章来源"
        });
	    var loadingIndex = -1;
	    $("#updateBtn").click(function(){
	    	var id=$("#id").val();
	    	var title = $("#title").val(); 
	    	var author = $("#author").val(); 
	    	var authorAffiliation = $("#authorAffiliation").val(); 
	    	var pbdate = $("#pbdate").val(); 
	    	var type = $("input[name='type']:checked").val(); 
	    	var issue = $("#issue").val(); 
	    	var volume = $("#volume").val();
	    	var summary = $("#summary").val();
	    	var isforecast = $("input[name='isforecast']:checked").val();
	    	var jsdNames = $("#sel_menu2").select2().val(); 
	    	var sourceName = $("#sel_menu1").select2().val(); 
	    	var summary = $("#summary").val();
	    	if ( title == "" ) {
	    		layer.msg("标题不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	        		title.focus();
	    		});
	    		return;
	    	}
	    	if(id==""){
	    		id=0;
	    	}
	    	if ( author == "" ) {
	    		layer.msg("作者不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	    			author.focus();
	    		});
	    		return;
	    	}
	    	if ( pbdate == "" ) {
	    		layer.msg("发布时间不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	    			pbdate.focus();
	    		});
	    		return;
	    	}
	    	if ( type == "" ) {
	    		layer.msg("文章类型不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	    			type.focus();
	    		});
	    		return;
	    	}
	    	if ( issue == "" ) {
	    		layer.msg("期刊号不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	    			issue.focus();
	    		});
	    		return;
	    	}
	    	if ( volume == "" ) {
	    		layer.msg("卷不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	    			volume.focus();
	    		});
	    		return;
	    	}
	    	if ( summary == "" ) {
	    		layer.msg("简介不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	    			summary.focus();
	    		});
	    		return;
	    	}
	    	if ( isforecast == "" ) {
	    		layer.msg("相关或预测不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
	    			isforecast.focus();
	    		});
	    		return;
	    	}
	    	$.ajax({
	            type: "post",
	            url: "${APP_PATH}/goto_article_manager/update_article.do",
                data: {"id":id,"title":title,"author":author,
                	"authorAffiliation":authorAffiliation,"pbdate":pbdate,"type":type,
                	"issue":issue,"volume":volume,"sourceName":sourceName,
                	"isforecast":isforecast,"jsdNames":jsdNames+"","summary":summary},
                success : function( r ) {
                	if ( r.success ) {
	    				layer.msg("修改文章成功", {time:1000, icon:6, shift:6});
	    			} else {
	    	    		layer.msg("修改文章失败", {time:1000, icon:5, shift:6});
	    			}
                }
	        });
	    })
        </script>
  </body>
</html>
