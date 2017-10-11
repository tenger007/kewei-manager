<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page isELIgnored="false" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+request.getContextPath()+"/";%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<base href="<%=basePath %>" />
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>菜单管理</title>
</head>
<body>
<form action="menu_add.do"  id="menuForm" method="post" >
       父菜单id: <input type="text" id="fid" name="fid"><br>
        技术点id: <input type="text" id="jishudian" name="jsdid"><br>
        等级: <input type="text" id="level" name="level"><br>
        菜单名: <input type="text" id="menuName" name="name"><br>
   是否是最后一级: <input type="checkbox" value="0" name="isend" onclick="this.value=(this.value==0)?1:0"><br> 
    是否有子菜单：   <input type="checkbox" value="0" name="hasson" onclick="this.value=(this.value==0)?1:0">
</form>
  <button id="saveBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
  <button id="resetBtn" type="button" class="btn btn-danger"><i class="glyphicon glyphicon-refresh"></i> 重置</button>
<script type="text/javascript">
$("#resetBtn").click(function(){
	document.getElementById("menuForm").reset(); 
});


$("#saveBtn").click(function(){
  	var fid = $("#fid");
  	var jsdid = $("#jishudian");
  	var level = $("#level");
  	var menuName = $("#menuName");
  	if ( fid.val() == "" ) {
  		layer.msg("父菜单id不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
  			fid.focus();
  		});
  		return;
  	}
   	if ( jsdid.val() == "" ) {
  		layer.msg("技术点id不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
  			jsdid.focus();
  		});
  		return;
  	} 
  	if ( level.val() == "" ) {
  		layer.msg("等级不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
  			level.focus();
  		});
  		return;
  	}
  	if ( menuName.val() == "" ) {
  		layer.msg("菜单名不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
  			menuName.focus();
  		});
  		return;
  	}
  	$("#menuForm").ajaxSubmit({
  		success : function( r ) {
  			layer.msg("增加成功");
  	  		return;	
  		}
  	});
});
  	
</script>
</body>
</html>