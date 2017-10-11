package kewei.manager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kewei.manager.bean.Datas;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.Menu;
import kewei.manager.bean.MenuDto;
import kewei.manager.bean.Page;
import kewei.manager.bean.User_menu;
import kewei.manager.mapper.MenuManagerMapper;

@Service
public class MenuManagerServiceImp implements MenuManagerServiceInf{
	   @Autowired
	  MenuManagerMapper menuManagerMapper;

	@Override
	public List<MenuDto> get_all_menuDto() {
		List<MenuDto> menus = menuManagerMapper.get_all_menuDto();
		return menus;
	}

	@Override
	public int insert_menu(Menu menu) {
	     int num = 0;
		menuManagerMapper.insert_menu(menu);
		num++;
		return num;
	}

	@Override
	public List<Menu> query_menu_by_jsdid(Long jsdid) {
		List<Menu> menu = menuManagerMapper.query_menu_by_jsdid(jsdid);
		return menu;
	}

	@Override
	public void delete_menu_id(Long menuid) {
		menuManagerMapper.delete_menu_id(menuid);
		List<Long> ids = menuManagerMapper.select_menuId_fid(menuid);
		if(ids!=null){
		for (int i = 0; i < ids.size(); i++) {
			delete_menu_id(ids.get(i));
		}
		}
		}

	@Override
	public int delete_menu_jsdid(Long jsdid) {
		int num = 0;
		menuManagerMapper.delete_menu_jsdid(jsdid);
		num++;
		return num;
	}

	@Override
	public int  delete_menusDto_ids(Datas ids ){
		return  menuManagerMapper.delete_menus_ids(ids);
	}
	   
	@Override
	public Page<MenuDto> queryMenuPage(Map<String, Object> paramMap) {
		Page<MenuDto> page = new Page<MenuDto>();
		List<MenuDto> menus = menuManagerMapper.queryMenus4Page(paramMap);
		int count = menuManagerMapper.queryMenuCount4Page(paramMap);
		page.setTotalsize(count);
		page.setDatas(menus);
		return page;
	}

	@Override
	public List<MenuDto> queryMenus4Page(Integer pageno, Integer pagesize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("start", (pageno-1)*pagesize);
		paramMap.put("size", pagesize);
		
		return menuManagerMapper.queryMenus4Page(paramMap);
	}

	@Override
	public int queryUserCount4Page() {
		return 0;
	}

	@Override
	public MenuDto query_menuDto_by_id(Long id) {
		MenuDto menuDto = menuManagerMapper.query_menuDto_by_id(id);
		return menuDto;
	}

	@Override
	public JiShuDian query_jiShuDian_by_jsdName(String jsdName) {
		
		return menuManagerMapper.query_jiShuDian_by_jsdName(jsdName);
	}

	@Override
	public int update_menu(Menu menu) {
		int num = 0;
		menuManagerMapper.update_menu(menu);
		num++;
		return num;
	}

	@Override
	public int insert_menus(List<Menu> menus) {
		return menuManagerMapper.insert_menus(menus);
	}

	@Override
	public Long query_menuId_by_jsd_menuName(Long jsdid, String menuName) {
		return menuManagerMapper.query_menuId_by_jsd_menuName(jsdid, menuName);
	}

	@Override
	public Long query_menuFid_by_fMenuName(String fMenuName, Long jsdid) {
		return menuManagerMapper.query_menuFid_by_fMenuName(fMenuName, jsdid);
	}

	@Override
	public long query_jsdId_by_menuId(long id) {
		return menuManagerMapper.query_jsdId_by_menuId(id);
	}

	@Override
	public long query_fid_menuId(long id) {
		return menuManagerMapper.query_fid_menuId(id);
	}


	@Override
	public long query_maxId() {
		return menuManagerMapper.query_maxId();
	}

	@Override
	public List<Long> select_menuId_fid(long id) {
		return menuManagerMapper.select_menuId_fid(id);
	}

	@Override
	public int query_menu_by_jsdName(String jsdName) {
		return menuManagerMapper.query_menu_by_jsdName(jsdName);
	}

	@Override
	public int insert_user_menus(List<User_menu> user_menus) {
		return menuManagerMapper.insert_user_menus(user_menus);
	}

	@Override
	public List<Long> query_user_menuid_by_userid_jsdid(String username,String jsdname) {
		return menuManagerMapper.query_user_menuid_by_userid_jsdid(username, jsdname);
	}

	@Override
	public List<Menu> query_menu_by_ids(List<Long> ids) {
		return menuManagerMapper.query_menu_by_ids(ids);
	}

	@Override
	public void delete_user_menu_by_jsdid(String jsdid, String userid) {
       menuManagerMapper.delete_user_menu_by_jsdid(jsdid, userid);		
	}
}
