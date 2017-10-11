<%@page pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
							<ul style="padding-left:0px;" class="list-group">
							<li class="list-group-item tree-closed" >
								<a href="${APP_PATH}/main.htm"><i class="fa fa-fw"></i> 首页</a> 
							</li>
				    <c:forEach items="${menus}" var="menu" >
				        <c:if test="${empty menu.children}">
							<li class="list-group-item tree-closed" >
								<a href="${APP_PATH}${menu.url}"><i class="fa fa-fw"></i> ${menu.name}</a> 
							</li>
				        </c:if>
				        <c:if test="${not empty menu.children}">
							<li class="list-group-item tree-closed">
								<span><i class="fa fa-fw "></i> ${menu.name} <span class="badge" style="float:right"></span></span> 
								<ul style="margin-top:10px;display:none;">
									<c:forEach items="${menu.children}" var="childMenu">
									<c:if test="${childMenu.name=='批量导入'}">
									<li style="height:30px;">
											<a id="send_excel" data-toggle="modal" data-target="#excelModal"  href="${APP_PATH}${childMenu.url}"><i class="fa fa-fw "></i> ${childMenu.name} </a>
										</li>
									</c:if>
									<c:if test="${childMenu.name=='申请信息'}">
									<li style="height:30px;">
											<a href="${APP_PATH}${childMenu.url}"><i class="fa fa-fw "></i> ${childMenu.name}
											<span class="badge" style="margin-left: 20%">${count}</span>
											</a>
										</li>
									</c:if>
									<c:if test="${childMenu.name!='批量导入'&&childMenu.name!='申请信息'}">
									<li style="height:30px;">
											<a  href="${APP_PATH}${childMenu.url}"><i class="fa fa-fw "></i> ${childMenu.name} </a>
										</li>
										</c:if>
									</c:forEach>
								</ul>
							</li>
				        </c:if>
				    </c:forEach>
				</ul>
