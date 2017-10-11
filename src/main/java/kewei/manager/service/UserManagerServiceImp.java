package kewei.manager.service;


import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import kewei.manager.bean.Apply;
import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Page;
import kewei.manager.bean.Temp_menu;
import kewei.manager.bean.User;
import kewei.manager.bean.User_imessage;
import kewei.manager.bean.User_menu;
import kewei.manager.bean.User_menuDto;
import kewei.manager.mapper.UserManagerMapper;

@Service
public class UserManagerServiceImp implements UserManagerServiceInf{
@Autowired
UserManagerMapper userManagerMapper;

@Override
public User queryUser4Login(User user) {
	return userManagerMapper.queryUser4Login(user);
}

@Override
public Integer queryUserIdByName(String name) {
	return userManagerMapper.queryUserIdByName(name);
}

@Override
public List<User> query_all_user() {
	return userManagerMapper.query_all_user();
}

@Override
public int delete_user_id(Integer id) {
	return userManagerMapper.delete_user_id(id);
}

public int insert_user(User user) {
	return userManagerMapper.insert_user(user);
}

@Override
public int edit_User(User user) {
	return userManagerMapper.edit_User(user);
}

@Override
public int insert_user_permission(Integer userid, Integer pid) {
	return userManagerMapper.insert_user_permission(userid, pid);
}

@Override
public Page<User_menuDto> query_by_field(Map<String, Object> paramMap) {
	Page<User_menuDto> page = new Page<User_menuDto>();
	List<User_menuDto> user_menuDtos = new ArrayList<User_menuDto>();
	List<String> jsdnames = userManagerMapper.queryUser_menusPageByField(paramMap);
	for(String jsdname:jsdnames){
		List<String> usernames = userManagerMapper.query_user_by_jsd(jsdname);
		User_menuDto user_menuDto = new User_menuDto();
		user_menuDto.setFieldname((String)paramMap.get("querytext"));
		user_menuDto.setJsdname(jsdname);
		user_menuDto.setUsername( StringUtils.collectionToDelimitedString( usernames, ",") );
		String menuname = "";
		for(int i = 0;i<usernames.size()-1;i++){
			List<String> menunames = userManagerMapper.query_menu_by_user_jsd(jsdname,usernames.get(i));
			menuname += StringUtils.collectionToDelimitedString( menunames, ",")+"#";
		}
		menuname+= StringUtils.collectionToDelimitedString( userManagerMapper.query_menu_by_user_jsd(jsdname,usernames.get(usernames.size()-1)), ",");
		user_menuDto.setMenuname(menuname );
		user_menuDtos.add(user_menuDto);
	}
	int count = userManagerMapper.queryUser_menuCount4PageByField(paramMap);
	page.setTotalsize(count);
	page.setDatas(user_menuDtos);
	return page;
}

@Override
public Page<User_menuDto> query_by_jsd(Map<String, Object> paramMap) {
	Page<User_menuDto> page = new Page<User_menuDto>();
	List<User_menuDto> user_menuDtos = new ArrayList<User_menuDto>();
	String fieldname = userManagerMapper.queryUser_menusPageByJsd(paramMap);
		List<String> usernames = userManagerMapper.query_user_by_jsd((String)paramMap.get("querytext"));
		if(usernames!=null){
		User_menuDto user_menuDto = new User_menuDto();
		user_menuDto.setFieldname(fieldname);
		user_menuDto.setJsdname((String)paramMap.get("querytext"));
		user_menuDto.setUsername( StringUtils.collectionToDelimitedString( usernames, ",") );
		String menuname = "";
		for(int i = 0;i<usernames.size()-1;i++){
			List<String> menunames = userManagerMapper.query_menu_by_user_jsd((String)paramMap.get("querytext"),usernames.get(i));
			menuname += StringUtils.collectionToDelimitedString( menunames, ",")+"#";
		}
		menuname+= StringUtils.collectionToDelimitedString( userManagerMapper.query_menu_by_user_jsd((String)paramMap.get("querytext"),usernames.get(usernames.size()-1)), ",");
		user_menuDto.setMenuname(menuname );
		user_menuDtos.add(user_menuDto);
	int count = userManagerMapper.queryUser_menuCount4PageByJsd(paramMap);
	page.setTotalsize(count);
	page.setDatas(user_menuDtos);
		}
	return page;
}

@Override
public Page<User_menuDto> query_by_user(Map<String, Object> paramMap) {
	Page<User_menuDto> page = new Page<User_menuDto>();
	List<User_menuDto> user_menuDtos = new ArrayList<User_menuDto>();
	List<User_menu> user_menus = userManagerMapper.queryUser_menusPageByUser(paramMap);
	for(User_menu user_menu:user_menus){
		User_menuDto user_menuDto = new User_menuDto();
		user_menuDto.setFieldname(user_menu.getFieldname());
		user_menuDto.setJsdname(user_menu.getJsdname());
		user_menuDto.setUsername((String)paramMap.get("querytext"));
			List<String> menunames = userManagerMapper.query_menu_by_user_jsd(user_menu.getJsdname(),(String)paramMap.get("querytext"));
		user_menuDto.setMenuname(StringUtils.collectionToDelimitedString( menunames, ",") );
		user_menuDtos.add(user_menuDto);
	}
	int count = userManagerMapper.queryUser_menuCount4PageByUser(paramMap);
	page.setTotalsize(count);
	page.setDatas(user_menuDtos);
	return page;
}

@Override
public List<User_menu> query_user_status(String name) {
List<User_menu> user_menus	= new ArrayList<User_menu>();
List<String> usernames = userManagerMapper.query_user_by_jsd(name);
for(String username:usernames){
	User_menu user_menu = new User_menu();
	user_menu.setUsername(username);
	List<Integer> statuss = userManagerMapper.query_StatusByName(username,name);
	if(statuss.size()==1){
		user_menu.setStatus(statuss.get(0));
	}
	else{
		user_menu.setStatus(0);
	}
	user_menus.add(user_menu);
}
	return user_menus;
}

@Override
public void send_User_imessage(User_imessage user_imessage) {
	userManagerMapper.send_User_imessage(user_imessage);
}

public List<String> query_menuByusername_jsdname(String name, String username) {
	return  userManagerMapper.query_menu_by_user_jsd(name,username);
}

public Page<User_imessage> query_all_user_imessage(Map<String, Object> paramMap) {
	Page<User_imessage> page = new Page<User_imessage>();
	List<User_imessage> user_imessages = userManagerMapper.query_all_User_imessages4Page(paramMap);
	int count = userManagerMapper.query_all_User_imessageCount4Page(paramMap);
	page.setTotalsize(count);
	page.setDatas(user_imessages);
	return page;
}

public Page<User_imessage> query_user_imessage(Map<String, Object> paramMap) {
	Page<User_imessage> page = new Page<User_imessage>();
	List<User_imessage> user_imessages = userManagerMapper.queryUser_imessages4Page(paramMap);
	int count = userManagerMapper.queryUser_imessageCount4Page(paramMap);
	page.setTotalsize(count);
	page.setDatas(user_imessages);
	return page;
}

public Page<User_imessage> query_other_imessage(Map<String, Object> paramMap) {
	Page<User_imessage> page = new Page<User_imessage>();
	List<User_imessage> user_imessages = userManagerMapper.query_OtherUser_imessages4Page(paramMap);
	int count = userManagerMapper.query_OtherUser_imessageCount4Page(paramMap);
	page.setTotalsize(count);
	page.setDatas(user_imessages);
	return page;
}

public int selectImessageCount() {
	return userManagerMapper.selectImessageCount();
}

public int select_Other_ImessageCount(String loginname) {
	return userManagerMapper.select_Other_ImessageCount(loginname);
}

public void setStatusImessage(List<User_imessage> datas) {
	userManagerMapper.setStatusImessage(datas);
}

public Page<User_imessage> query_other_all_imessage(Map<String, Object> paramMap) {
	Page<User_imessage> page = new Page<User_imessage>();
	List<User_imessage> user_imessages = userManagerMapper.query_OtherUser_all_imessages4Page(paramMap);
	int count = userManagerMapper.query_OtherUser_all_imessageCount4Page(paramMap);
	page.setTotalsize(count);
	page.setDatas(user_imessages);
	return page;
}

public void insert_Other_Imessage(String username, String jsdname, String fieldname) {
	 User_imessage user_imessage = new User_imessage();
	 user_imessage.setLoginname("Admin");
	 user_imessage.setStatus(0);
	 user_imessage.setJsdname(jsdname);
	 user_imessage.setSendname(username);
	 user_imessage.setImessage("请在技术领域："+fieldname+";"+"\t"+"技术点:"+jsdname+";"+"\t"+"下补充内容");
	 userManagerMapper.send_User_imessage(user_imessage);
}




}
