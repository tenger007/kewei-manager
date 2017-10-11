package kewei.manager.service;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Apply;
import kewei.manager.bean.Article;
import kewei.manager.bean.Page;
import kewei.manager.bean.User;
import kewei.manager.bean.User_imessage;
import kewei.manager.bean.User_menu;
import kewei.manager.bean.User_menuDto;

public interface UserManagerServiceInf {
	//根据用户名密码查询用户
		User queryUser4Login(User user);
	
	//查询所有用户
	List<User> query_all_user();
		
	//根据用户id删除用户
		int delete_user_id(Integer id);
	
	//根据用户名查找用户id
	Integer queryUserIdByName(String name);
	
	//更改用户密码
    int edit_User(User user);
    
    Page<User_menuDto> query_by_field(Map<String, Object> paramMap); 
    
  //为用户增加权限
  	int insert_user_permission(Integer userid,Integer pid);
  	
  	Page<User_menuDto> query_by_jsd(Map<String, Object> paramMap);
  	
  void 	send_User_imessage(User_imessage user_imessage); 
  
  	List<User_menu> query_user_status(String name);
  	
  	List<String> query_menuByusername_jsdname(String name, String username);
  	
  	Page<User_menuDto> query_by_user(Map<String, Object> paramMap);
}
