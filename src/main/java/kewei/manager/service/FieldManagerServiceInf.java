package kewei.manager.service;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.Field;
import kewei.manager.bean.JsdDto;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Expert;
import kewei.manager.bean.Menu;
import kewei.manager.bean.MenuDto;
import kewei.manager.bean.Page;

public interface FieldManagerServiceInf {
	//通过领域id查找领域内专家页面内容
 Expert queryExpertContentById(Long id);
 
//更新领域下的专家页面
int updateExpertcontent(Expert e);

//插入专家信息
void insertExpertcontent(Expert e);

//根据id删除专家信息
int delete_expert_by_id(long id);

//查找jsd并分页
	 Page<Expert> queryFieldExpert4Page(Map<String, Object> paramMap);
			 List<Expert> queryFieldExperts4Page(Integer pageno, Integer pagesize);
			 int queryFieldExpertCount4Page();
}
