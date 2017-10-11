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
	<link rel="stylesheet" href="/kewei-manager/css/style.css" />
	<link href="/kewei-manager/js/bootstrap/css/select2.min.css" rel="stylesheet" />
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	.tree-closed {
	    height : auto;
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
			<ul style="padding-left:0px;" class="list-group">
							<%@include file="/WEB-INF/common/common.jsp"%>
				</ul>
        </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-9 col-md-offset-3 main">
          <c:if test="${!empty jsdDto}">
				<ol class="breadcrumb">
				  <li class="active">修改</li>
				  <li>附件地址：${jsdDto.img }&nbsp; &nbsp;&nbsp; &nbsp;<button type="button" id="uploadBtn" class="btn btn-primary" ><i class="glyphicon glyphicon-open"></i> 上传图片</button></li>
				</ol>
				  </c:if>
			<div class="panel panel-default">
              <div class="panel-heading">技术点数据<div style="float:right;cursor:pointer;" ></div></div>
			  <div class="panel-body">
				  <input type="hidden" id="id" name="id" value="${jsdDto.id}">
				  <input type="hidden" id="scoreDb" name="score" value="${jsdDto.scoreDb}">
				  <input type="hidden" id="scoreZazhi" name="score" value="${jsdDto.scoreZazhi}">
				  <input type="hidden" id="scoreJigou" name="score" value="${jsdDto.scoreJigou}">
				<div class="form-group has-feedback">
				  <div class="input-group">
				    <div class="input-group-addon">技术领域</div>
				    <select id="sel_menu1" class="form-control"  onchange="fieldChange()" style="width:800px;">
				    <option value="${jsdDto.fieldName }">${jsdDto.fieldName }</option>
				    <c:forEach var="obj" items="${list_field}" varStatus="i">
				          <option value="${obj}">${obj}</option>
				     		</c:forEach>
				 	  </select>
				    </div>
				  </div>
				  <div class="input-group">
				  <div class="input-group-addon">技术点</div>
				    <select id="sel_menu2" class="form-control required js-example-tags" style="width:815px;">
				    <option value="${jsdDto.jsdName }">${jsdDto.jsdName }</option>
				 	  </select>
				    </div>
				    <br>
					 <div class="input-group">
					<div class="input-group-addon" >英文名称</div>
					<input type="text" class="form-control" style="width:800px;" id="enname"  value="${jsdDto.enname }" name="enname" placeholder="请输入平均发布年">
					</div>
					<br>
					 <div class="input-group">
					<div class="input-group-addon" >关键词</div>
					<input type="text" class="form-control" style="width:812px;" id="keyword"  value="${jsdDto.keyword }" name="keyword" placeholder="请输入关键词">
					</div>
					<br>
					 <div class="input-group">
					<div class="input-group-addon">国内分布</div>
					<input type="text" class="form-control" style="width:800px;" id="civil"  value="${jsdDto.civil }" name="civil" placeholder="请输入国内分布">
					</div>
					<br>
					 <div class="input-group">
					<div class="input-group-addon">国际分布</div>
					<input type="text" class="form-control" style="width:800px;" id="international"  value="${jsdDto.international}" name="international" placeholder="请输入国际分布">
					</div>
					<br>
					<form>
					<div class="form-group">
					<label for="isGenZongJsd">是否是跟踪技术点</label>
					<input type="text" class="form-control" id="isGenZongJsd" value="${jsdDto.isGenZongJsd }" name="isGenZongJsd" onclick="this.value=(this.value=='否')?'是':'否'" >
				  </div>
				  <div class="form-group">
					<label for="isQianYanJsd">是否前沿技术点</label>
					<input type="text" class="form-control" id="isQianYanJsd" value="${jsdDto.isQianYanJsd }" name="isQianYanJsd" onclick="this.value=(this.value=='否')?'是':'否'" >
				  </div>
				  <div class="form-group">
					<label for="isMainField">是否是主要领域</label>
					<input type="text" class="form-control" id="isMainField" value="${jsdDto.isMainField }" name="isMainField" onclick="this.value=(this.value=='否')?'是':'否'"  >
				  </div> 
				  </form>
					<br>
					<label for="isQianYan">前沿技术点得分</label>
					<br>
					<div class="User_ratings User_grade" id="div_fraction0">
						<div class="ratings_bars">
						<span id="title0">${jsdDto.scoreExpert}</span>
						<span class="bars_10">0</span>
						<div class="scale" id="bar0">
							<span id="btn0" style="left:${jsdDto.scoreExpert*3}px;"></span>
							<div style="width:${jsdDto.scoreExpert*3}px;"></div>
						</div>
						<span class="bars_10">100</span>
					</div>
					</div>
				</div>
				 <button id="updateBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 修改</button>
			  </div>
			</div>
        </div>
        </div>
    <form id="uploadForm" action="/kewei-manager/goto_jsd_manager/import_jsdimg/${jsdDto.id}.do" method="post" enctype="multipart/form-data">
        <input type="hidden" id="id" name="id" value="${jsdDto.id}">
        <input type="file" id="jsdFile" accept="image/png,image/gif,image/jpeg " name="jsdFile" style="display:none;" >
    </form>
    <script src="/kewei-manager/js/jquery/jquery-3.0.0.js"></script>
    <script src="/kewei-manager/js/bootstrap/js/bootstrap.min.js"></script>
	<script src="/kewei-manager/js/layer/layer.js"></script>
	<script src="/kewei-manager/js/jquery/jquery-form.min.js"></script>
	<script src="/kewei-manager/js/bootstrap/js/select2.js"></script>
        <script type="text/javascript">
        $("#uploadBtn").click(function(){
            $("#jsdFile").click();
        });
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
 	    					window.location.reload();
 	    				    $("#uploadForm")[0].reset();
 	    				});
 	    			} else {
 	    	    		layer.msg("图片上传失败", {time:1000, icon:5, shift:6});
 	    			}
 	    		}
 	    	});
         });
        scale = function (btn, bar, title) {
        	this.btn = document.getElementById(btn);
        	this.bar = document.getElementById(bar);
        	this.title = document.getElementById(title);
        	this.step = this.bar.getElementsByTagName("DIV")[0];
        	this.init();
        };
        scale.prototype = {
        	init: function () {
        		var f = this, g = document, b = window, m = Math;
        		f.btn.onmousedown = function (e) {
        			var x = (e || b.event).clientX;
        			var l = this.offsetLeft;
        			var max = f.bar.offsetWidth - this.offsetWidth;
        			g.onmousemove = function (e) {
        				var thisX = (e || b.event).clientX;
        				var to = m.min(max, m.max(-2, l + (thisX - x)));
        				f.btn.style.left = to + 'px';
        				f.ondrag(m.round(m.max(0, to / max) * 100), to);
        				b.getSelection ? b.getSelection().removeAllRanges() : g.selection.empty();
        			};
        			g.onmouseup = new Function('this.onmousemove=null');
        		};
        	},
        	ondrag: function (pos, x) {            /* 元素正在拖动时触发 */
        		this.step.style.width = Math.max(0, x) + 'px';
        		this.title.innerHTML = pos  + '';
        	}
        }
        new scale('btn0', 'bar0', 'title0');
        $(".js-example-tags").select2({
            tags:true
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
	    var loadingIndex = -1;
	    $("#updateBtn").click(function(){
	    	var scoreDb = $("#scoreDb").val()+0;
	    	var scoreZazhi = $("#scoreZazhi").val()+0;
	    	var scoreJigou = $("#scoreJigou").val()+0;
	    	var jsdName = $("#sel_menu2").select2().val(); 
	    	var fieldName = $("#sel_menu1").select2().val(); 
	    	var enname=$("#enname").val();
	    	var keyword=$("#keyword").val();
	    	var civil=$("#civil").val();
	    	var international=$("#international").val();
	    	var isGenZongJsd=$("#isGenZongJsd").val();
	    	var isQianYanJsd=$("#isQianYanJsd").val();
	    	var isMainField=$("#isMainField").val();
	    	var scoreExpert=$("#title0").html();
	    	if ( fieldName == "" ) {
	    		layer.msg("技术属性不能为空，请选择", {time:1000, icon:5, shift:6}, function(){
	        		fieldName.focus();
	    		});
	    		return;
	    	}
	    	if ( jsdName == "" ) {
	    		layer.msg("技术点不能为空，请选择", {time:1000, icon:5, shift:6}, function(){
	        		jsdName.focus();
	    		});
	    		return;
	    	}
	    	$.ajax({
	            type: "post",
	            url: "/kewei-manager/goto_jsd_manager/update_jsd.do",
                data: {"fieldName":fieldName,"jsdName":jsdName,
                	"enname":enname,"keyword":keyword,"civil":civil,"international":international,
                	"isGenZongJsd":isGenZongJsd,"isQianYanJsd":isQianYanJsd,
                	"isMainField":isMainField,"scoreExpert":scoreExpert,
                	"scoreDb":scoreDb,"scoreJigou":scoreJigou,"scoreZazhi":scoreZazhi},
                success : function( r ) {
                	if ( r.success ) {
	    				layer.msg("修改菜单成功", {time:1000, icon:6, shift:6});
	    			} else {
	    	    		layer.msg("修改菜单失败", {time:1000, icon:5, shift:6});
	    			}
                }
	        });
	    });
        </script>
  </body>
</html>
