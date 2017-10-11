package kewei.manager.controller;



import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.junit.validator.PublicClassValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kewei.manager.bean.Apply;
import kewei.manager.bean.Article;
import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Datas;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.Menu;
import kewei.manager.bean.Page;
import kewei.manager.bean.Temp_menu;
import kewei.manager.bean.User;
import kewei.manager.bean.User_menu;
import kewei.manager.bean.User_menuDto;
import kewei.manager.service.ApplyManagerServiceImp;
import kewei.manager.service.ArticleManagerServiceImp;
import kewei.manager.service.JsdManagerServiceImp;
import kewei.manager.service.MenuManagerServiceImp;
import kewei.manager.service.UserManagerServiceImp;
import kewei.manager.util.Const;
import kewei.manager.util.ImportUtil;
import kewei.manager.util.MD5Util;

@Controller
@RequestMapping("goto_count_manager")
public class CountController extends BaseController{
  @Autowired
  JsdManagerServiceImp jsdManager;
  @Autowired
  UserManagerServiceImp userManager;
  @Autowired
  ApplyManagerServiceImp applyManager;
  
  
  @RequestMapping("")
  public String count_manager(HttpSession session){
	  session.setAttribute("imessage_count", userManager.selectImessageCount());
			session.setAttribute("count", applyManager.selectCount());
		return "manager_count";
	}
  
  @ResponseBody
	@RequestMapping("/user_menuQuery")
	public Object userQuery( String querytext,String querytext2, Integer pageno, Integer pagesize ) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			List<User> users = userManager.query_all_user();
			paramMap.put("start", (pageno-1)*pagesize);
			paramMap.put("size", pagesize);
			paramMap.put("querytext", querytext);
			Page<User_menuDto> page = new Page<User_menuDto>();
			if(querytext2.equals("技术领域")){
			 page = userManager.query_by_field(paramMap);
			}
			if(querytext2.equals("跟踪技术点")){
			page = userManager.query_by_jsd(paramMap);
			}
			
			if(querytext2.equals("服务方")){
			 page = userManager.query_by_user(paramMap);
			}
			resultMap.put("page", page);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		return resultMap;
	}
  
}
