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
import kewei.manager.bean.User_imessage;
import kewei.manager.bean.User_menu;
import kewei.manager.service.ApplyManagerServiceImp;
import kewei.manager.service.ArticleManagerServiceImp;
import kewei.manager.service.JsdManagerServiceImp;
import kewei.manager.service.MenuManagerServiceImp;
import kewei.manager.service.UserManagerServiceImp;
import kewei.manager.util.Const;
import kewei.manager.util.ImportUtil;
import kewei.manager.util.MD5Util;

@Controller
@RequestMapping("goto_user_manager")
public class UserController extends BaseController{
  @Autowired
  UserManagerServiceImp userManager;
  @Autowired
  JsdManagerServiceImp jsdManager;
  @Autowired
  ApplyManagerServiceImp applyManager;
  
  @RequestMapping("")
  public String goto_user_manager(ModelMap map,HttpSession session){
	  session.setAttribute("imessage_count", userManager.selectImessageCount());
		session.setAttribute("count", applyManager.selectCount());
	  List<String> field = jsdManager.query_field();
		map.put("list_field", field);
		return "user/user_manager";
  }
  
  @RequestMapping("/user_all_imessage")
  public String get_user_all_imessage(){
	  return "user/user_all_imessage";
  }
  
  @RequestMapping("/user_imessage")
  public String get_user_imessage(){
	  return "user/user_imessage";
  }
  
  
  
  @ResponseBody
  @RequestMapping("/countQuery")
 public Object countQuery(){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		  resultMap.put("success", true);
	} catch (Exception e) {
		e.printStackTrace();
		resultMap.put("success", false);
	}
	  return resultMap;
  }
  
  @ResponseBody
	@RequestMapping("/user/userQuery")
	public Object userQuery() {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			List<User> users = userManager.query_all_user();
			resultMap.put("users", users);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		return resultMap;
	}
  
  @ResponseBody
  @RequestMapping("/user/user_imessageQuery")
  public Object user_imessageQuery( Integer pageno, Integer pagesize ,HttpSession session) {
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		// 分页查询
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("start", (pageno-1)*pagesize);
			paramMap.put("size", pagesize);
		 Page<User_imessage> page = userManager.query_user_imessage(paramMap);
			resultMap.put("page", page);
			if(page.getTotalsize()>0){
				userManager.setStatusImessage(page.getDatas());
				session.setAttribute("imessage_count", 0);
			}
		  resultMap.put("success", true);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  resultMap.put("success", false);
	  }
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/user/user_all_imessageQuery")
  public Object user_all_imessageQuery(Integer pageno, Integer pagesize ) {
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		// 分页查询
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("start", (pageno-1)*pagesize);
		paramMap.put("size", pagesize);
		  Page<User_imessage> page = userManager.query_all_user_imessage(paramMap);
		  resultMap.put("page", page);
		  resultMap.put("success", true);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  resultMap.put("success", false);
	  }
	  return resultMap;
  }

  @ResponseBody
 	@RequestMapping("/delete_user_by_id")
 	public Object delete_user_by_id(Integer id){
 Map<String, Object> resultMap = new HashMap<String, Object>();
 		
 		try {
 			userManager.delete_user_id(id);
 			resultMap.put("success", true);
 		} catch ( Exception e ) {
 			e.printStackTrace();
 			resultMap.put("success", false);
 		}
 		
 		return resultMap;
 	}
  
  @ResponseBody
  @RequestMapping("/addUser")
  public Object addUser(String name,String loginname,String password){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		  password = MD5Util.digest(password);
		  User user = new User();
		  user.setName(name);
		  user.setLoginname(loginname);
		  user.setPassword(password);
		  Integer userid = userManager.queryUserIdByName(loginname);
		  if(userid==null){
		  userManager.insert_user(user);
		  userManager.insert_user_permission(userManager.queryUserIdByName(loginname),1);
		  userManager.insert_user_permission(userManager.queryUserIdByName(loginname),5);
		  userManager.insert_user_permission(userManager.queryUserIdByName(loginname),2);
		  resultMap.put("success", true);
		  }
		  else{
			  resultMap.put("success", false);
		  }
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  resultMap.put("success", false);
	  }
	  
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/editUser")
  public Object editUser(String name,String password){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		  password = MD5Util.digest(password);
		  User user = new User();
		  user.setName(name);
		  user.setPassword(password);
		  userManager.edit_User(user);
		  resultMap.put("success", true);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  resultMap.put("success", false);
	  }
	  
	  return resultMap;
  }
  
}
