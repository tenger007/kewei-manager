package kewei.manager.listener;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.ContextLoaderListener;
import org.springframework.web.context.support.WebApplicationContextUtils;

import kewei.manager.bean.Permission;
import kewei.manager.mapper.PermissionManagerMapper;
import kewei.manager.service.PermissionManagerServiceImp;
import kewei.manager.service.PermissionManagerServiceInf;
import kewei.manager.util.StringUtil;


public class KeweiServerStartupListener extends ContextLoaderListener {

	@Override
	public void contextInitialized(ServletContextEvent event) {
        
		// 和Spring框架无关的代码
		
		// 获取web应用对象
		ServletContext application = event.getServletContext();
		
		// 获取web应用路径
		String path = application.getContextPath();
		
		// 将路径保存到应用范围中
		application.setAttribute("APP_PATH", path);
		
		super.contextInitialized(event);
		
		// 和Spring框架相关的代码
		ApplicationContext context =
			WebApplicationContextUtils.getWebApplicationContext(application);
		
		PermissionManagerServiceInf permissionService = context.getBean(PermissionManagerServiceInf.class);
		
		// 查询所有的权限对象
		List<Permission> permissions = permissionService.queryAll();
		List<String> authURIs = new ArrayList<String>();
		for ( Permission p : permissions ) {
			if ( StringUtil.isNotEmpty(p.getUrl()) ) {
				authURIs.add(p.getUrl());
			}
		}
		
		application.setAttribute("AUTH_URI", authURIs);
		
	}

}
