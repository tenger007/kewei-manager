package kewei.manager.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.scripting.xmltags.WhereSqlNode;
import org.apache.taglibs.standard.tag.common.xml.WhenTag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kewei.manager.bean.Content;
import kewei.manager.bean.Datas;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.JsdDto;
import kewei.manager.bean.Menu;
import kewei.manager.bean.Page;
import kewei.manager.bean.User_imessage;
import kewei.manager.bean.User_menu;
import kewei.manager.mapper.JsdManagerMapper;
import kewei.manager.service.ApplyManagerServiceImp;
import kewei.manager.service.ContentManagerServiceImp;
import kewei.manager.service.JsdManagerServiceImp;
import kewei.manager.service.MenuManagerServiceImp;
import kewei.manager.service.UserManagerServiceImp;
import kewei.manager.util.Const;

@Controller
@RequestMapping("goto_menu_manager")
public class MenuController extends BaseController {
  @Autowired
  MenuManagerServiceImp menuManager;
 @Autowired
 JsdManagerServiceImp jsdManager;
 @Autowired
 ContentManagerServiceImp contentManager;
 @Autowired
 UserManagerServiceImp userManager;
 @Autowired
 ApplyManagerServiceImp applyManager;
  
	@RequestMapping("")
	public String goto_menu_manager(ModelMap map,HttpSession session){
		 session.setAttribute("imessage_count", userManager.selectImessageCount());
			session.setAttribute("count", applyManager.selectCount());
		 List<String> field = jsdManager.query_field();
			map.put("list_field", field);
		return "menu/menu_manager";
	}
	
	 /*@ResponseBody
	   @RequestMapping("/queryGenZongJsdName")
	   public Object queryGenZongJsdName(String fieldName){
		   Map<String, Object> resultMap = new HashMap<String, Object>();
		   List<String> jsdNames = jsdManager.query_GenZongJsd_by_fieldName(fieldName);
		   resultMap.put("list_jsdName", jsdNames);
		   return resultMap;
	   }*/
	 
	 @RequestMapping("/other_imessage")
	  public String get_other_imessage(){
		  return "user/user_other_imessage";
	  }
	  
	 @ResponseBody
	  @RequestMapping("/user_other_imessageQuery")
	  public Object user_imessageQuery( Integer pageno, Integer pagesize ,String username,HttpSession session) {
		  Map<String, Object> resultMap = new HashMap<String, Object>();
		  try {
			// 分页查询
				Map<String, Object> paramMap = new HashMap<String, Object>();
				paramMap.put("start", (pageno-1)*pagesize);
				paramMap.put("size", pagesize);
				paramMap.put("userName", username);
			 Page<User_imessage> page = userManager.query_other_imessage(paramMap);
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
	 @RequestMapping("/user_other_all_imessageQuery")
	 public Object user_imessageAllQuery( Integer pageno, Integer pagesize ,String username,HttpSession session) {
		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 try {
			 // 分页查询
			 Map<String, Object> paramMap = new HashMap<String, Object>();
			 paramMap.put("start", (pageno-1)*pagesize);
			 paramMap.put("size", pagesize);
			 paramMap.put("userName", username);
			 Page<User_imessage> page = userManager.query_other_all_imessage(paramMap);
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
	 
	 @RequestMapping("/other_all_imessage")
	  public String get_user_all_imessage(){
		  return "user/user_other_all_imessage";
	  }
	 
	 @ResponseBody
	 @RequestMapping("/queryGenZongJsdName")
	 public Object queryGenZongJsd(String fieldName){
		 Map<String, Object> resultMap = new HashMap<String, Object>();
		 List<String> jsdNames = jsdManager.query_GenZongJsd_by_fieldName(fieldName);
		 resultMap.put("list_jsdName", jsdNames);
		 return resultMap;
	 }
	 
	@ResponseBody
	@RequestMapping("/updateContent")
	public Object updateContent( long menuid,String contents,long jsdid,String menuname) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			int num = contentManager.update_content(contents,menuid,jsdid,menuname);
			if(num==0){
				contentManager.insert_content(contents,menuid,jsdid,menuname);
			}
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	 @RequestMapping("/edit_content/{menuName}/{jsdid}/{id}")
		public String edit(@PathVariable("menuName")String menuName,@PathVariable("jsdid")long jsdid,
				@PathVariable("id")Long id, Model model ) {
			 Content content = contentManager.query_contents_menuId(id);
			 if(content==null){
				 Content content2 = new Content();
				 content2.setId(0);
				 content2.setContents("");
				 content2.setMenuid(id);
				 content2.setJsdid(jsdid);
				 content2.setMenuname(menuName);
				 model.addAttribute("content",content2);
			 }
			 else model.addAttribute("content", content);
			
			return "content_edit";
		}
	  
	@ResponseBody
	@RequestMapping(value="/menu_add/{id}/{name}/{jsdid}",method = RequestMethod.POST)
	public long menu_add(@PathVariable("id") long id,@PathVariable("name") String name,
			@PathVariable("jsdid") long jsdid) {
		Menu menu = new Menu();
		try {
			menu.setName(name);
			menu.setFid(id);
			menu.setJsdid(jsdid);
			menuManager.insert_menu(menu);
			long maxId = menuManager.query_maxId();
			return maxId;
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return 0;
	}
	
	@ResponseBody
	@RequestMapping(value="/edit_menu_by_id/{id}/{name}/{fid}/{jsdid}",method = RequestMethod.POST)
	public Object edit( @PathVariable("id")long id,@PathVariable("name") String name
			,@PathVariable("fid") long fid,@PathVariable("jsdid") long jsdid) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Menu menu = new Menu();
		try {
			menu.setId(id);
			menu.setName(name);
			menu.setFid(fid);
			menu.setJsdid(jsdid);
			menuManager.update_menu(menu);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/set_menu_isshow")
	public Object editShow( String name) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			jsdManager.set_Isshow_by_jsdname(name);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	@ResponseBody
	@RequestMapping("/set_menu_isNotshow")
	public Object editNotShow( String name) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			jsdManager.set_IsNotshow_by_jsdname(name);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/set_usermenu_isshow")
	public Object edit_user_menu( String name,String username) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			jsdManager.set_User_menu_Status1(name,username);
			User_imessage user_imessage = new User_imessage();
			List<String> user_menus = userManager.query_menuByusername_jsdname(name,username);
			user_imessage.setImessage("技术点："+name+";  菜单："+StringUtils.collectionToDelimitedString(user_menus, ",")+";  已完成");
			user_imessage.setJsdname(name);
			user_imessage.setStatus(0);
			user_imessage.setLoginname(username);
			user_imessage.setSendname("Admin");
			userManager.send_User_imessage(user_imessage);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	
	@ResponseBody
	@RequestMapping(value="/edit_menu_by_move/{id}/{fid}/{name}/{jsdid}",method = RequestMethod.POST)
	public Object edit( @PathVariable("id")long id,@PathVariable("fid") long fid 
			,@PathVariable("name") String name,@PathVariable("jsdid") long jsdid) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Menu menu = new Menu();
		try {
			menu.setId(id);
			menu.setName(name);
			menu.setFid(fid);
			menu.setJsdid(jsdid);
			menuManager.update_menu(menu);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping("/menu/menuQuery/{name}")
	public Object menuQuery(@PathVariable("name")String name) throws UnsupportedEncodingException {
		List<Menu> roots = new ArrayList<Menu>();
		Menu menu = new Menu();
		JiShuDian jsd = menuManager.query_jiShuDian_by_jsdName(name);
		menu.setFid((long) 0);
		menu.setName(name);
		menu.setJsdid(jsd.getId());
		if(menuManager.query_menu_by_jsdName(name)==0){
			menuManager.insert_menu(menu);
		}
		List<Menu> menus = menuManager.query_menu_by_jsdid(jsd.getId());
		Map<Long, Menu> menuMap = new HashMap<Long, Menu>();
		for ( Menu p : menus ) {
			menuMap.put(p.getId(), p);
		}
		for ( Menu p : menus ) {
			Menu childMenu = p;
			if ( p.getFid() == 0 ) {
				roots.add(p);
			} else {
				Menu parentMenu = menuMap.get(p.getFid());
				parentMenu.getChildren().add(childMenu);
			}
		}
		return roots;
	}
	
	@ResponseBody
	@RequestMapping("/menu/menuQueryByjsdid/{jsdid}")
	public Object menuQuery(@PathVariable("jsdid")Long jsdid) throws UnsupportedEncodingException {
		List<Menu> roots = new ArrayList<Menu>();
		Menu menu = new Menu();
		JsdDto jsd = jsdManager.query_jsdDto_by_id(jsdid);
		menu.setFid((long) 0);
		menu.setName(jsd.getJsdName());
		menu.setJsdid(jsd.getId());
		List<Menu> menus = menuManager.query_menu_by_jsdid(jsd.getId());
		Map<Long, Menu> menuMap = new HashMap<Long, Menu>();
		for ( Menu p : menus ) {
			menuMap.put(p.getId(), p);
		}
		for ( Menu p : menus ) {
			Menu childMenu = p;
			if ( p.getFid() == 0 ) {
				roots.add(p);
			} else {
				Menu parentMenu = menuMap.get(p.getFid());
				parentMenu.getChildren().add(childMenu);
			}
		}
		return roots;
	}
	
	@RequestMapping("/login_out")
	public String login_out(HttpSession session){
		session.setAttribute(Const.LOGIN_USER, null);
		return "index";
	}
	
	@ResponseBody
	@RequestMapping("/menu/menuQuery2/{name}/{username}")
	public Object user_menuQuery(@PathVariable("name")String name,@PathVariable("username")String username) throws UnsupportedEncodingException {
		/*Integer userid = userManager.queryUserIdByName(username);
		long jsdid = jsdManager.query_jsdId_by_jsdName(name);*/
		List<Long> user_menuids = menuManager.query_user_menuid_by_userid_jsdid(username, name);
		List<Menu> roots = new ArrayList<Menu>();
		List<Menu> menus = menuManager.query_menu_by_ids(user_menuids);
		Map<Long, Menu> menuMap = new HashMap<Long, Menu>();
		for ( Menu p : menus ) {
			menuMap.put(p.getId(), p);
		}
		for ( Menu p : menus ) {
			Menu childMenu = p;
			if ( p.getFid() == 0 ) {
				roots.add(p);
			} else {
				Menu parentMenu = menuMap.get(p.getFid());
				parentMenu.getChildren().add(childMenu);
			}
		}
		return roots;
	}
	
	@ResponseBody
	@RequestMapping("/menu/menuQuery2Byjsdid/{jsdid}/{username}")
	public Object user_menuQuery(@PathVariable("jsdid")Long jsdid,@PathVariable("username")String username) throws UnsupportedEncodingException {
		String name = jsdManager.query_jsdName_by_jsdid(jsdid);
		List<Long> user_menuids = menuManager.query_user_menuid_by_userid_jsdid(username, name);
		List<Menu> roots = new ArrayList<Menu>();
		List<Menu> menus = menuManager.query_menu_by_ids(user_menuids);
		Map<Long, Menu> menuMap = new HashMap<Long, Menu>();
		for ( Menu p : menus ) {
			menuMap.put(p.getId(), p);
		}
		for ( Menu p : menus ) {
			Menu childMenu = p;
			if ( p.getFid() == 0 ) {
				roots.add(p);
			} else {
				Menu parentMenu = menuMap.get(p.getFid());
				parentMenu.getChildren().add(childMenu);
			}
		}
		return roots;
	}
	
	@ResponseBody
	@RequestMapping("/menu/menuQuery2/{jsdid}")
	public Object menuQuery2(@PathVariable("jsdid")long jsdid) throws UnsupportedEncodingException {
		List<Menu> roots = new ArrayList<Menu>();
		List<Menu> menus = menuManager.query_menu_by_jsdid(jsdid);
		Map<Long, Menu> menuMap = new HashMap<Long, Menu>();
		for ( Menu p : menus ) {
			menuMap.put(p.getId(), p);
		}
		for ( Menu p : menus ) {
			Menu childMenu = p;
			if ( p.getFid() == 0 ) {
				roots.add(p);
			} else {
				Menu parentMenu = menuMap.get(p.getFid());
				parentMenu.getChildren().add(childMenu);
			}
		}
		return roots;
	}
	
	@ResponseBody
	@RequestMapping("/menu/pageQuery")
	public Object pageQuery(String name) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		int isshow = jsdManager.query_Isshow_by_jsdname(name);
		List<User_menu> user_menus = userManager.query_user_status(name);
	resultMap.put("success", true);
	resultMap.put("isshow", isshow);
	resultMap.put("user_menus", user_menus);
		return resultMap;
	}
	
	
	
	@ResponseBody
	@RequestMapping("/delete_menu_by_id")
	public Object delete_menu_by_id(long id){
Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			menuManager.delete_menu_id(id);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
}
