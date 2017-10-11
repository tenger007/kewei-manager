package kewei.manager.mapper;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.Apply;
import kewei.manager.bean.Article;
import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Datas;
import kewei.manager.bean.SendEmail;
import kewei.manager.bean.Temp_menu;
import kewei.manager.bean.User;

public interface ApplyManagerMapper {
	 
	int selectCount();
	
	 //获取所以用户
	List<String> get_all_user();
	 
	 //获取所有的未通过的申请信息
	 List<Apply> get_all_apply();
	 
	 //通过applyid查找相应模板信息
	List<Temp_menu> get_apply_by_id(int id);
	 
	//插入一个菜单
	int insert_temp_menu(Temp_menu temp_menu);
	
	//根据id删除菜单
	void delete_temp_menu_id(Long id);
	List<Long> select_temp_menuId_fid(Long id);
	
	//查找最新的temp_menu的id
	Long query_maxId();
	
	//更改菜单名称
	int update_menu(Temp_menu temp_menu);
	
	 //查找申请信息分页
	List<Apply> queryApplysPage(Map<String, Object> paramMap);
	int queryApplyCount4Page(Map<String, Object> paramMap);
	
	//查看新的申请信息分页
	List<Apply> query_new_ApplysPage(Map<String, Object> paramMap);
	int query_new_ApplyCount4Page(Map<String, Object> paramMap);
	
	//同意申请
	int agreeApply_imessageByid(int id,String imessage);
	void agreeApplyByid(int id);
	
	//不同意申请
	int disagreeApplyByid(int id);
	
   //给申请人发送消息
	int setImessageToApplyid(int id, String imessage);

	List<String> queryApplyDisImessage(long id);

	void agreeApplyByids(SendEmail sendEmail);

	void sendEmail(SendEmail sendEmail);

	void completeApplyByids(int i);

	void sendEmailApplyByid(Integer integer, String imessages);

	void completeApplyByid(int i);

}
