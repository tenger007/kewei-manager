package kewei.manager.mapper;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.Datas;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.Menu;
import kewei.manager.bean.MenuDto;
import kewei.manager.bean.User_menu;

public interface MenuManagerMapper {
	//根据菜单名称和技术端id查询菜单id
	Long query_menuId_by_jsd_menuName(Long jsdid,String menuName);
	
	//查询所有的菜单项
   List<MenuDto> get_all_menuDto();
   
   //根据父菜单名称查找父菜单id
   Long query_menuFid_by_fMenuName(String fMenuName,Long jsdid);
   
   //根据菜单id查找技术点id
   long query_jsdId_by_menuId(long id);
   
   //根据菜单id查找父菜单id
   long query_fid_menuId(long id);
   
   //批量插入菜单
   int insert_menus(List<Menu> menus);
   
   //根据菜单ids查询菜单
  List<Menu> query_menu_by_ids(List<Long> ids);
   
   //批量插入第三方菜单
   int insert_user_menus(List<User_menu> user_menus);
   
   //根据第三方id和技术点名称查找对应的菜单
 List<Long> query_user_menuid_by_userid_jsdid(String username,String jsdname);
   
 //删除第三方对应的技术点菜单
 void delete_user_menu_by_jsdid(String jsdid,String userid);
 
   //根据技术点名称查找菜单个数
  int query_menu_by_jsdName(String jsdName);
   
   //根据技术点名称查找技术点
   JiShuDian query_jiShuDian_by_jsdName(String jsdName);
   
   //更新菜单
   int update_menu(Menu menu);
   
   //添加菜单
   int insert_menu(Menu menu);
   
   //跟进技术点id查找菜单
   List<Menu> query_menu_by_jsdid(Long jsdid);
   
   //根据菜单id查找菜单
   MenuDto query_menuDto_by_id(Long id);
   
   //获取最大的id
  long query_maxId();
   
   //根据菜单id删除菜单
   void delete_menu_id(Long menuid);
   
   //得到fid对应的所有id
  List<Long> select_menuId_fid(long id);
   
   //删除多个菜单
   int delete_menus_ids(Datas ds);
   
   //删除技术点下所有的菜单
   int delete_menu_jsdid(Long jsdid);
   
   //查询结果分页
   List<MenuDto> queryMenus4Page(Map<String, Object> paramMap);
   int queryMenuCount4Page(Map<String, Object> paramMap);
}
