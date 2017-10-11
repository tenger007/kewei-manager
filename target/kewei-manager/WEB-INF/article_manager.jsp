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
<link rel="stylesheet" type="text/css" href="js/easyui/themes/default/easyui.css">
<link rel="stylesheet" type="text/css" href="js/easyui/themes/icon.css">
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<script type="text/javascript" src="js/easyui/jquery.easyui.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文章管理</title>
</head>
<body>
<input type="text"><br>
<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查找文章</a>
<a id="btn" href="javascript:index_add_tabs('insert_article.do','添加文章');" class="easyui-linkbutton" data-options="iconCls:'icon-add'" >添加文章</a>
<a id="btn" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-cut'">删除文章</a>
<hr>
<c:forEach items="${list_article}" var="articles" >
		<input onclick="article_show_value(this.value,this.checked)"  type="checkbox"  value="${articles.id}"/>
		${articles.id} ${articles.title}       
		<a href="update_article"><img src="image/2.png"></a>
		<a href="delete_article"><img src="image/stop.png"></a>
		<br><hr>
	</c:forEach>
	<div id="tt" class="easyui-tabs" >   
 
		</div>  
<script type="text/javascript">
function index_add_tabs(url,title){
	if(!$('#tt').tabs('exists',title)){
		$('#tt').tabs('add',{
			title: title,
			closable:true,
			href:url
		});
	}
}
</script>
</body>
</html>