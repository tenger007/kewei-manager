package kewei.manager.mapper;


import java.util.List;
import java.util.Map;

import kewei.manager.bean.Temp_menu;
import kewei.manager.bean.User;
import kewei.manager.bean.User_imessage;
import kewei.manager.bean.User_menu;

public interface UserManagerMapper {
	//根据用户名密码查询用户
	User queryUser4Login(User user);
	
	//查询所有用户
	List<User> query_all_user();
	
	//根据用户名查找用户id
	Integer queryUserIdByName(String name);
	
	//根据用户id删除用户
	int delete_user_id(Integer id);

	//新增用户
	int insert_user(User user);
	
	//为用户增加权限
	int insert_user_permission(Integer userid,Integer pid);
	
	//更改用户密码
    int edit_User(User user);

    //根据技术点名称查找服务方
    List<String> query_user_by_jsd(String jsdname);
    
    //根据技术领域查找技术点分配信息
	List<String> queryUser_menusPageByField(Map<String, Object> paramMap);
	int queryUser_menuCount4PageByField(Map<String, Object> paramMap);
	
	//根据技术点查找技术点分配信息
	String queryUser_menusPageByJsd(Map<String, Object> paramMap);
	int queryUser_menuCount4PageByJsd(Map<String, Object> paramMap);

	//根据技术点，服务方查询分配信息
	List<String> query_menu_by_user_jsd(String jsdname, String username);
	
	//根据服务方查找技术点分配信息
	List<User_menu> queryUser_menusPageByUser(Map<String, Object> paramMap);
	int queryUser_menuCount4PageByUser(Map<String, Object> paramMap);

	List<Integer> query_StatusByName(String username,String jsdname);

	void send_User_imessage(User_imessage user_imessage);

	List<User_imessage> query_all_User_imessages4Page(Map<String, Object> paramMap);
	
	List<User_imessage> queryUser_imessages4Page(Map<String, Object> paramMap);

	List<User_imessage> query_OtherUser_imessages4Page(Map<String, Object> paramMap);
	
	List<User_imessage> query_OtherUser_all_imessages4Page(Map<String, Object> paramMap);
	
	int selectImessageCount();

	int select_Other_ImessageCount(String loginname);
	
	int queryUser_imessageCount4Page(Map<String, Object> paramMap);

	int query_all_User_imessageCount4Page(Map<String, Object> paramMap);

	int query_OtherUser_imessageCount4Page(Map<String, Object> paramMap);
	
	int query_OtherUser_all_imessageCount4Page(Map<String, Object> paramMap);

	void setStatusImessage(List<User_imessage> datas);

}
