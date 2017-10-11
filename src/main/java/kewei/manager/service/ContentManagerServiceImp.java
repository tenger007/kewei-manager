package kewei.manager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.LongToDoubleFunction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kewei.manager.bean.Content;
import kewei.manager.bean.ContentDto;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Menu;
import kewei.manager.bean.MenuDto;
import kewei.manager.bean.Page;
import kewei.manager.mapper.ContentManagerMapper;
import kewei.manager.mapper.MenuManagerMapper;

@Service
public class ContentManagerServiceImp implements ContentManagerServiceInf{
@Autowired
ContentManagerMapper contentManagerMapper;
	
	@Override
	public int insert_contents(List<Content> contents) {
		return contentManagerMapper.insert_contents(contents);
	}

	@Override
	public List<ContentDto> get_all_contentDto() {
		return contentManagerMapper.get_all_contentDto();
	}

	@Override
	public Page<ContentDto> queryContentPage(Map<String, Object> paramMap) {
		Page<ContentDto> page = new Page<ContentDto>();
		List<ContentDto> ContentDtos = contentManagerMapper.queryContents4Page(paramMap);
		int count = contentManagerMapper.queryContentCount4Page(paramMap);
		page.setTotalsize(count);
		page.setDatas(ContentDtos);
		return page;
	}
	
	@Override
	public List<ContentDto> queryContents4Page(Integer pageno, Integer pagesize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("start", (pageno-1)*pagesize);
		paramMap.put("size", pagesize);
		return contentManagerMapper.queryContents4Page(paramMap);
	}

	@Override
	public int queryContentCount4Page() {
		return 0;
	}

	@Override
	public int insert_content(String contents,long menuid,long jsdid,String menuname) {
		return contentManagerMapper.insert_content(contents,menuid,jsdid,menuname);
	}

	@Override
	public int delete_content_id(Long id) {
		return contentManagerMapper.delete_content_id(id);
	}

	@Override
	public int delete_contents_ids(Datas ids) {
		return contentManagerMapper.delete_contents_ids(ids);
	}

	@Override
	public ContentDto query_contentDto_by_id(Long id) {
		return contentManagerMapper.query_contentDto_by_id(id);
	}

	@Override
	public int update_content(String contents,long menuid,long jsdid,String menuname) {
		return contentManagerMapper.update_content(contents,menuid,jsdid,menuname);
	}

	@Override
	public Content query_contents_menuId(long menuId) {
		return contentManagerMapper.query_contents_menuId(menuId);
	}


}
