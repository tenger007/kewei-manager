<%@ page language="java" contentType="text/html; charset=UTF-8" isErrorPage="true"
	pageEncoding="UTF-8"  %>
	<% response.setStatus(200); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="/kewei-manager/js/bootstrap/css/bootstrap.min.css">
<link rel="stylesheet" href="/kewei-manager/css/font-awesome.min.css">
<link rel="stylesheet" href="/kewei-manager/css/main.css">
<title>错误页面</title>

</head>
<body>
	<%@ include file="/WEB-INF/common/userinfo.jsp" %>
	<div id="main">
		<br><br><br><br><br><br><br><br><br>
		<h1 align="center">没有权限，请不要访问！</h1>
	</div>
</body>
</html>