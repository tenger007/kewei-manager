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
<input type="text" class="form-control" style="width:700px;" id="channelId"  value="" name="channelId" placeholder="请输入频道Id">
<button id="editDownloader"  type="button" class="btn btn-danger"><i class="glyphicon glyphicon-ok"></i>提交</button>
<script src="${APP_PATH}/static/js/jquery/jquery-3.0.0.js"></script>
<script type="text/javascript">
$("#editDownloader").click(function(){
	var channelId=$("#channelId").val();
	var reg = /^\d+([,，]\d+)*$/;
	if(!reg.test(channelId)){
		//用户名格式不正确
		alert("请输入含有字母、数字、下划线、-的3~16的用户名");
		//取消默认行为
		return false;
	}
});

</script>
</body>
</html>