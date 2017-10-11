package kewei.manager.mapper;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.Content;
import kewei.manager.bean.ContentDto;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Expert;
import kewei.manager.bean.JsdDto;

public interface FieldManagerMapper {
	//通过id查找领域内专家页面内容
Expert queryExpertContentById(long id);
 
  //更新领域下的专家页面
int updateExpertcontent(Expert e);

//插入专家信息
void insertExpertcontent(Expert e);
//根据id删除专家信息
int delete_expert_by_id(long id);

  //查找jsd并分页
	 List<Expert> queryFieldExperts4Page(Map<String, Object> paramMap);
	 int queryFieldExpertCount4Page(Map<String, Object> paramMap);
} 
