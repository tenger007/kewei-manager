package kewei.manager.service;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Apply;
import kewei.manager.bean.Article;
import kewei.manager.bean.Page;
import kewei.manager.bean.Temp_menu;
import kewei.manager.bean.User;

public interface ApplyManagerServiceInf {
		
	//查询申请中的申请表
  int  selectCount();
 
 //获取所以用户
	List<String> get_all_user();
 
 //获取所有的未通过的申请信息
 List<Apply> get_all_apply();
 
 	//插入一个菜单
	int insert_temp_menu(Temp_menu temp_menu);
 
	//查找最新的temp_menu的id
		Long query_maxId();
	
	//根据id删除菜单
		void delete_menu_id(Long id);	
		
	//更改菜单名称
		int update_menu(Temp_menu temp_menu);
		
		
 //通过applyid查找相应模板信息
	List<Temp_menu> get_apply_by_id(int id);
 
//同意申请
	void agreeApplyByid(int id);
	
	//不同意申请
		int disagreeApplyByid(int id,String imessage);
		
		List<String> queryApplyDisImessage(long id);
	
 //查找申请信息分页
	Page<Apply> queryApplyPage(Map<String, Object> paramMap);
	List<Apply> queryApplysPage(Map<String, Object> paramMap);
	int queryApplyCount4Page(Map<String, Object> paramMap);
}
