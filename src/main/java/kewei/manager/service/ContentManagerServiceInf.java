package kewei.manager.service;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.Content;
import kewei.manager.bean.ContentDto;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Menu;
import kewei.manager.bean.MenuDto;
import kewei.manager.bean.Page;

public interface ContentManagerServiceInf {
	//批量插入content
	int insert_contents(List<Content> contents);
	
	//根据id修改页面
	int update_content(String contents,long id,long jsdid,String menuname);
	
	//根据菜单id查找页面内容
	Content query_contents_menuId(long menuId);
	
	//根据页面id查找页面
	ContentDto query_contentDto_by_id(Long id);
	
	//删除多个页面
   int delete_contents_ids(Datas ds);
	
	//根据id删除content
	int delete_content_id(Long id);
	
	//添加页面
	int insert_content(String contents,long menuid,long jsdid,String menuname);
		
	//查找所有的content
	List<ContentDto> get_all_contentDto();
	
	//查找content并分页
	Page<ContentDto> queryContentPage(Map<String, Object> paramMap);
	 List<ContentDto> queryContents4Page(Integer pageno, Integer pagesize);
	 int queryContentCount4Page();
}
