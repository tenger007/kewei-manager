<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="margin-left:50px;font-size:32px;" href="#">首都科技大数据管理平台</a></div>
          </div>
           <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav " style="margin-left:55%;">
          <li style="padding-top:8px;">
          <div class="btn-group">
				  <button type="button"  class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i>${loginUser.name} <span class="caret"></span>
				  </button>
				   <ul class="dropdown-menu" role="menu">
				   <c:if test="${loginUser.name!='Admin'}">
						<li><a href="${APP_PATH}/goto_menu_manager/other_imessage.htm"><i class="glyphicon glyphicon-comment"></i> 消息
						<span class="badge" style="margin-left: 20%">${imessage_count}</span>
						</a></li>
						<li><a href="${APP_PATH}/goto_menu_manager/login_out.htm"><i class="glyphicon glyphicon-off"></i>退出
						</a></li>
						</c:if>
				   <c:if test="${loginUser.name=='Admin'}">
						<li><a href="${APP_PATH}/goto_user_manager/user_imessage.htm"><i class="glyphicon glyphicon-comment"></i> 消息
						<span class="badge" style="margin-left: 20%">${imessage_count}</span>
						</a></li>
						<li><a href="${APP_PATH}/goto_menu_manager/login_out.htm"><i class="glyphicon glyphicon-off"></i> 退出
						</a></li>
						</c:if>
					  </ul>
			    </div>
			    </li>
          </ul>
        </div>
      </div>
    </nav>
