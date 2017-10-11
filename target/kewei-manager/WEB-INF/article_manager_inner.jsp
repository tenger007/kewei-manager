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
<script type="text/javascript" src="js/jquery-1.7.2.min.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>文章库</title>
</head>
<body>
<form action="article_add.do" method="post" >
       期号: <input type="text" name="issue"><br>
        来源: <input type="text" name="sourceid"><br>
       文章标题: <input type="text" name="title"><br>
       文章类型: <input type="text" name="type"><br>
       卷: <input type="text" name="volume"><br>
       <input type="submit" value="添加文章"/>
</form>


<script type="text/javascript">
</script>
</body>
</html>