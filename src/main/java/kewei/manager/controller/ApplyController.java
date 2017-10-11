package kewei.manager.controller;



import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
import kewei.manager.bean.SendEmail;
import kewei.manager.bean.Temp_menu;
import kewei.manager.bean.User;
import kewei.manager.bean.User_menu;
import kewei.manager.service.ApplyManagerServiceImp;
import kewei.manager.service.ArticleManagerServiceImp;
import kewei.manager.service.JsdManagerServiceImp;
import kewei.manager.service.MenuManagerServiceImp;
import kewei.manager.service.UserManagerServiceImp;
import kewei.manager.util.Const;
import kewei.manager.util.EmailUtil;
import kewei.manager.util.ImportUtil;

@Controller
@RequestMapping("goto_apply_manager")
public class ApplyController extends BaseController{
  @Autowired
 ApplyManagerServiceImp applyManager;
  @Autowired
  JsdManagerServiceImp jsdManager;
  @Autowired
  UserManagerServiceImp userManager;
  @Autowired
  MenuManagerServiceImp menuManager;
  
  
  @RequestMapping("")
  public String goto_apply_manager(ModelMap map,HttpSession session){
	  List<Apply> applys = applyManager.get_all_apply();
	  List<String> users = applyManager.get_all_user();
	session.setAttribute("imessage_count", userManager.selectImessageCount());
	session.setAttribute("count", applyManager.selectCount());
	  map.put("applys", applys);
	  map.put("users", users);
		return "apply/apply_manager";
  }
  
  @RequestMapping("/apply_all_manager")
  public String goto_all_apply_manager(ModelMap map,HttpSession session){
	  List<Apply> applys = applyManager.get_all_apply();
	  List<String> users = applyManager.get_all_user();
	  session.setAttribute("imessage_count", userManager.selectImessageCount());
		session.setAttribute("count", applyManager.selectCount());
	  map.put("applys", applys);
	  map.put("users", users);
		return "apply/apply_all_manager";
  }
  
  @ResponseBody
	@RequestMapping("/apply/pageQuery")
	public Object page_all_Query( String querytext,String querytext2, Integer pageno, Integer pagesize ,HttpSession session) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			session.setAttribute("imessage_count", userManager.selectImessageCount());
			session.setAttribute("count", applyManager.selectCount());
			// 分页查询
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("start", (pageno-1)*pagesize);
			paramMap.put("size", pagesize);
			paramMap.put("querytext2", querytext);
			paramMap.put("querytext", querytext);
			Page<Apply> page= applyManager.queryApplyPage(paramMap);
			resultMap.put("page", page);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		return resultMap;
	}
  
  @ResponseBody
  @RequestMapping("/apply/page_new_Query")
  public Object page_new_Query( String querytext,String querytext2, Integer pageno, Integer pagesize,HttpSession session ) {
	  
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  
	  try {
		  session.setAttribute("imessage_count", userManager.selectImessageCount());
			session.setAttribute("count", applyManager.selectCount());
		  // 分页查询
		  Map<String, Object> paramMap = new HashMap<String, Object>();
		  paramMap.put("start", (pageno-1)*pagesize);
		  paramMap.put("size", pagesize);
		  paramMap.put("querytext2", querytext);
		  paramMap.put("querytext", querytext);
		  Page<Apply> page= applyManager.query_new_ApplyPage(paramMap);
		  resultMap.put("page", page);
		  resultMap.put("success", true);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  resultMap.put("success", false);
	  }
	  return resultMap;
  }
  
  @ResponseBody
	@RequestMapping(value="/menu_add/{id}/{name}/{applyid}",method = RequestMethod.POST)
	public long menu_add(@PathVariable("id") Long id,@PathVariable("name") String name,
			@PathVariable("applyid")Integer applyid,HttpSession session) {
	  Temp_menu temp_menu = new Temp_menu();
		try {
			session.setAttribute("imessage_count", userManager.selectImessageCount());
			session.setAttribute("count", applyManager.selectCount());
			temp_menu.setName(name);
			temp_menu.setFid(id);
			temp_menu.setApplyid(applyid);
			applyManager.insert_temp_menu(temp_menu);
			Long maxId = applyManager.query_maxId();
			return maxId;
		} catch ( Exception e ) {
			e.printStackTrace();
		}
		return applyManager.query_maxId();
	}
  
  @ResponseBody
	@RequestMapping(value="/edit_menu_by_id/{id}/{name}",method = RequestMethod.POST)
	public Object edit( @PathVariable("id")Long id,@PathVariable("name") String name,HttpSession session) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Temp_menu temp_menu = new Temp_menu();
		try {
			session.setAttribute("imessage_count", userManager.selectImessageCount());
			session.setAttribute("count", applyManager.selectCount());
			temp_menu.setId(id);
			temp_menu.setName(name);
			applyManager.update_menu(temp_menu);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		return resultMap;
	}
  
  @ResponseBody
	@RequestMapping("/delete_menu_by_id")
	public Object delete_menu_by_id(long id,HttpSession session){
Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			session.setAttribute("imessage_count", userManager.selectImessageCount());
			session.setAttribute("count", applyManager.selectCount());
			applyManager.delete_menu_id(id);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
  
  @ResponseBody
  @RequestMapping("/queryApplyDisImessage")
  public Object queryApplyDisImessage(long id,HttpSession session){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		  session.setAttribute("imessage_count", userManager.selectImessageCount());
			session.setAttribute("count", applyManager.selectCount());
		  List<String> disImessages = applyManager.queryApplyDisImessage(id);
		  resultMap.put("disImessage", disImessages);
		  resultMap.put("success", true);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  resultMap.put("success", false);
	  }
	  
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/addApply")
  public Object addApply(String username,String jsdname,String fieldname,String id){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		  List<User_menu> user_menus=  new ArrayList<User_menu>();
			 String[] ids = id.split(",");
			 for (int i = 0; i < ids.length; i++) {
				 User_menu user_menu = new User_menu();
				 user_menu.setJsdname(jsdname);
				 user_menu.setFieldname(fieldname);
				 user_menu.setMenuid(Long.parseLong(ids[i]));
				 user_menu.setUsername(username);
				 user_menu.setStatus(0);
				 user_menus.add(user_menu);
			}
			 menuManager.delete_user_menu_by_jsdid(jsdname, username);
			 menuManager.insert_user_menus(user_menus);
			 userManager.insert_Other_Imessage(username,jsdname,fieldname);
			 resultMap.put("success", true);
	} catch (Exception e) {
		resultMap.put("success", false);
	}
	 return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/editApplyById")
  public Object editApply( int id) {
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		  List<Temp_menu> temp_menus = applyManager.get_apply_by_id(id);
		  resultMap.put("temp_menus", temp_menus);
		  resultMap.put("success", true);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  resultMap.put("success", false);
	  }
	  return resultMap;
  }
  @ResponseBody
  @RequestMapping("/query_temp_menu/{id}")
  public Object query_temp_menu(@PathVariable("id") int id) {
	  List<Temp_menu> roots = new ArrayList<Temp_menu>();
	  try {
		  List<Temp_menu> temp_menus = applyManager.get_apply_by_id(id);
		  Map<Long, Temp_menu> menuMap = new HashMap<Long, Temp_menu>();
			for ( Temp_menu p : temp_menus ) {
				menuMap.put(p.getId(), p);
			}
			for ( Temp_menu p : temp_menus ) {
				Temp_menu childMenu = p;
				if ( p.getFid() == 0 ) {
					roots.add(p);
				} else {
					Temp_menu parentMenu = menuMap.get(p.getFid());
					parentMenu.getChildren().add(childMenu);
				}
			}
	  } catch ( Exception e ) {
		  e.printStackTrace();
	  }
	  return roots;
  }

  @ResponseBody
  @RequestMapping("/agree_menu")
  public Object agree_menu(Long jsdid,String jsdname,String fieldname,
		  String menunames,String menuids,String menufids){
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Menu menu = new Menu();
		List<Menu> menus = new ArrayList<Menu>();
		try {
			long fieldid = jsdManager.query_fieldid_by_fieldName(fieldname);
			if(jsdManager.query_jsdId_by_jsdName(jsdname)==null){
				JiShuDian jsd = new JiShuDian();
				jsd.setFieldid(fieldid);
				jsd.setName(jsdname);
				jsd.setImg(jsdname);
				jsd.setIsqianyan(0);
				jsd.setIsgenzongjishudian(0);
				jsd.setIsmainfield(1);
				jsdManager.insert_jsd(jsd);
				Long jid = jsdManager.query_max_jsdid();
				String[] names = menunames.split(",");
				String[] ids = menuids.split(",");
				String[] fids = menufids.split(",");
				Long maxId = menuManager.query_maxId();
				menu.setName(jsdname);
				menu.setFid((long) 0);
				menu.setJsdid(jid);
				menu.setId(Long.parseLong(ids[0])+maxId);
				menuManager.insert_menu(menu);
				for(int i=1;i<names.length;i++){
					Menu menu2 = new Menu();
					menu2.setId(maxId+Long.parseLong(ids[i]));
					menu2.setJsdid(jid);
					menu2.setName(names[i]);
					menu2.setFid(Long.parseLong(fids[i])+maxId);
					menus.add(menu2);
				}
				menuManager.insert_menus(menus);
			}
			else{	
			jsdid =	jsdManager.query_jsdId_by_jsdName(jsdname);
				menuManager.delete_menu_jsdid(jsdid);
			 String[] names = menunames.split(",");
				String[] ids = menuids.split(",");
				String[] fids = menufids.split(",");
				Long maxId = menuManager.query_maxId();
				menu.setName(jsdname);
				menu.setFid((long) 0);
				menu.setJsdid(jsdid);
				menu.setId(Long.parseLong(ids[0])+maxId);
				menuManager.insert_menu(menu);
				for(int i=1;i<names.length;i++){
					Menu menu2 = new Menu();
					menu2.setId(maxId+Long.parseLong(ids[i]));
					menu2.setJsdid(jsdid);
					menu2.setName(names[i]);
					menu2.setFid(Long.parseLong(fids[i])+maxId);
					menus.add(menu2);
				}
				menuManager.insert_menus(menus);
			}
			resultMap.put("success", true);
		} catch (Exception e) {
			resultMap.put("success", false);
		}
		return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/agreeApply")
  public Object agreeApply(int id,String jsdname,HttpSession session){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		 applyManager.agreeApplyByid(id);
		 jsdManager.update_jsd_genzong(jsdname);
		 int count = applyManager.selectCount();
		 session.setAttribute("count", count);
		 resultMap.put("success", true);
	} catch (Exception e) {
		resultMap.put("success", false);
	}
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/sendEmail")
  public Object sendEmail(SendEmail sendEmail,HttpSession session){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		  applyManager.sendEmail(sendEmail);
		  EmailUtil.createMimeMessage(EmailUtil.myEmailAccount, sendEmail.getTitle(), sendEmail.getSubject(), sendEmail.getImessages(), sendEmail.getEmails());
		  int count = applyManager.selectCount();
		  session.setAttribute("count", count);
		  resultMap.put("success", true);
	  } catch (Exception e) {
		  resultMap.put("success", false);
	  }
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/sendCompleteEmail")
  public Object sendCompleteEmail(String ids,String emails,String title,String subject,String imessage
		  ,MultipartFile file,HttpSession session,HttpServletRequest req){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		  String[] idss = ids.split("≃");
		  String[] emailss = emails.split("≃");
		  List<String> asList = java.util.Arrays.asList(emailss);
		  for(int i=0;i<idss.length;i++){
			 applyManager.completeApplyByid(Integer.parseInt(idss[i]));
		  }
		  String realPath = req.getSession().getServletContext().getRealPath("");
		file.transferTo(new File(realPath+"/"+"upload/"+file.getOriginalFilename()));
		String filepath=realPath+"/"+"upload/"+file.getOriginalFilename();
		  EmailUtil.createMimeMessageFile(EmailUtil.myEmailAccount, title, subject,imessage, filepath,  asList);
		  int count = applyManager.selectCount();
		  session.setAttribute("count", count);
		  resultMap.put("success", true);
	  } catch (Exception e) {
		  resultMap.put("success", false);
	  }
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/disagreeApply")
  public Object disagreeApply(int id,String imessage,HttpSession session){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		  applyManager.disagreeApplyByid(id,imessage);
		  resultMap.put("success", true);
	  } catch (Exception e) {
		  resultMap.put("success", false);
	  }
	  return resultMap;
  }
  
}
