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
<title>Insert title here</title>
</head>
<body>
<c:forEach items="${list_menu_jsdid}" var="menus" >
		<input onclick="article_show_value(this.value,this.checked)"  type="checkbox"  value="${menus.id}"/>
		父菜单:${menus.fid } 技术点:${menus.jsdid} 菜单名:${menus.name}       
		<a href="update_article"><img src="image/2.png"></a>
		<a href="delete_article"><img src="image/stop.png"></a>
		<br><hr>
	</c:forEach>
</body>
</html>