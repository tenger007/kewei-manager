<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="/kewei-manager/js/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="/kewei-manager/css/font-awesome.min.css">
	<link rel="stylesheet" href="/kewei-manager/css/login.css">
	<style>

	</style>
  </head>
  <body>
    <%@include file="/WEB-INF/common/userinfo.jsp"%>

    <div class="container">

      <form class="form-signin" role="form">
        <h2 class="form-signin-heading"><i class="glyphicon glyphicon-user"></i> 用户登录</h2>
		  <div class="form-group has-success has-feedback">
			<input type="text" class="form-control" id="floginacct" placeholder="请输入登录账号" autofocus>
			<span class="glyphicon glyphicon-pencil form-control-feedback"></span>
		  </div>
		  <div class="form-group has-success has-feedback">
			<input type="password" class="form-control" id="fuserpswd" placeholder="请输入登录密码" style="margin-top:10px;">
			<span class="glyphicon glyphicon-lock form-control-feedback"></span>
		  </div>
		  <!-- <div class="form-group has-success has-feedback">
			<select id="usertype" class="form-control" >
			    <option value="member">前台会员</option>
			    <option value="user">管理用户</option>
			</select>
		  </div> -->
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> 记住我
          </label>
        </div>
        <a class="btn btn-lg btn-success btn-block" id="loginBtn" ><i class="glyphicon glyphicon-log-in"></i> 登录</a>
      </form>
    </div>
    <script src="/kewei-manager/js/jquery/jquery-3.0.0.js"></script>
     <script src="/kewei-manager/js/bootstrap/js/bootstrap.min.js"></script>
   <script src="/kewei-manager/js/layer/layer.js"></script>
    <script type="text/javascript">
    $("#loginBtn").click(function(){
    	var floginacct = $("#floginacct");
    	if ( floginacct.val() == "" ) {
    		//alert("登陆账号不能为空，请输入");
    		layer.msg("登陆账号不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
        		floginacct.focus();
    		});
    		return;
    	}
    	
    	var fuserpswd = $("#fuserpswd");
    	if ( fuserpswd.val() == "" ) {
    		//alert("登陆密码不能为空，请输入");
    		layer.msg("登陆密码不能为空，请输入", {time:1000, icon:5, shift:6}, function(){
    			fuserpswd.focus();
    		});
    		return;
    	}
    	var loadingIndex = -1;
    	
    	var usertype = $("#usertype").val();
    	
    	var url = "${APP_PATH}/doLogin.do";
    	var paramObj = {
    		url  : url,
    		type : "POST",
    		data : {
    			"loginname" : floginacct.val(),
    			"password"  : fuserpswd.val()
    		},
    		beforeSend : function(){
    			//loadingIndex = layer.msg('数据处理中', {icon: 16});
    			loadingIndex = layer.load(2, {time: 10*1000});
    		},
    		success : function(result) {
    			layer.close(loadingIndex);
    			if ( result.success ) {
    					window.location.href = "${APP_PATH}/main.htm";
    			} else {
    	    		layer.msg(result.error, {time:1000, icon:5, shift:6}, function(){
    	    			//fuserpswd.focus();
    	    		});
    			}
    		}
    	};
    	
    	$.ajax(paramObj);
    });
    </script>
  </body>
</html>
