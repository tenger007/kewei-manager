package kewei.manager.intercepter;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import kewei.manager.bean.Permission;
import kewei.manager.bean.User;
import kewei.manager.util.Const;
import kewei.manager.util.StringUtil;


public class AuthInterceptor implements HandlerInterceptor {
	
	  //拦截前处理
	  public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object obj) throws Exception {

			// htt://www.cpes.com/test/test.jsp
			//request.getRequestURL(); // ==> htt://www.cpes.com/test/test.jsp
			String uri = request.getRequestURI(); // ==> /test/test.jsp
			//System.out.println( "uri = " + uri );
			// 白名单
			List<String> whiteURIList = new ArrayList<String>();
			whiteURIList.add("/kewei-manager/index.htm");
			whiteURIList.add("/kewei-manager/doLogin.do");
			HttpSession session = request.getSession();
			
			if ( !whiteURIList.contains(uri) ) {
				// 对登陆操作进行拦截
				User user = (User)session.getAttribute(Const.LOGIN_USER);
				if ( user == null ) {
					//System.out.println( "......" );
					response.sendRedirect("/kewei-manager");
					return false;
				}
			}
			String[] uris = uri.split("/");
			String uriTrue="";
			if(uris[2].indexOf(".htm")!=-1){
				uriTrue="/"+uris[2];
			}
			else{uriTrue="/"+uris[2]+".htm";}
			// 对权限进行拦截
			// 获取所有的权限路径
			List<String> allAuthURIs =
				(List<String>)session.getServletContext().getAttribute("AUTH_URI");
				if ( allAuthURIs.contains(uriTrue) ) {
					// 获取当前用户的权限路径
					List<Permission> permissions = (List<Permission>)session.getAttribute(Const.USER_MENU);
				if ( permissions != null ) {
						List<String> authURIs = new ArrayList<String>();
						authURIs.add("/main.htm");
						for ( Permission p : permissions ) {
							if ( StringUtil.isNotEmpty(p.getUrl()) ) {
								authURIs.add(p.getUrl());
							}
							for ( Permission cp : p.getChildren() ) {
								if ( StringUtil.isNotEmpty(cp.getUrl()) ) {
									authURIs.add(cp.getUrl());
								}
							}
						}
						
						if ( !authURIs.contains(uriTrue) ) {
							request.getRequestDispatcher("/WEB-INF/error.jsp").forward(request, response);
							return false;
						}
					}
				}
			return true;

}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		// TODO Auto-generated method stub
		
	}
}
