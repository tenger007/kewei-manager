package kewei.manager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.function.LongToDoubleFunction;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kewei.manager.bean.Field;
import kewei.manager.bean.JsdDto;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Expert;
import kewei.manager.bean.Menu;
import kewei.manager.bean.MenuDto;
import kewei.manager.bean.Page;
import kewei.manager.mapper.FieldManagerMapper;
import kewei.manager.mapper.MenuManagerMapper;

@Service
public class FieldManagerServiceImp implements FieldManagerServiceInf{
@Autowired
FieldManagerMapper fieldManagerMapper;

//更新领域下的专家页面
public int updateExpertcontent(Expert expert ){
	return fieldManagerMapper.updateExpertcontent(expert);
}


@Override
public Page<Expert> queryFieldExpert4Page(Map<String, Object> paramMap) {
	Page<Expert> page = new Page<Expert>();
	List<Expert> experts = fieldManagerMapper.queryFieldExperts4Page(paramMap);
	int count = fieldManagerMapper.queryFieldExpertCount4Page(paramMap);
	page.setTotalsize(count);
	page.setDatas(experts);
	return page;
}

@Override
public List<Expert> queryFieldExperts4Page(Integer pageno, Integer pagesize) {
	Map<String, Object> paramMap = new HashMap<String, Object>();
	paramMap.put("start", (pageno-1)*pagesize);
	paramMap.put("size", pagesize);
	return fieldManagerMapper.queryFieldExperts4Page(paramMap);
}

@Override
public int queryFieldExpertCount4Page() {
	return 0;
}

@Override
public Expert queryExpertContentById(Long id) {
	return fieldManagerMapper.queryExpertContentById(id);
}


@Override
public void insertExpertcontent(Expert e) {
	fieldManagerMapper.insertExpertcontent(e);
	
}


@Override
public int delete_expert_by_id(long id) {
	return fieldManagerMapper.delete_expert_by_id(id);
}

}
