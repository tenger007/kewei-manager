package kewei.manager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kewei.manager.bean.Apply;
import kewei.manager.bean.Article;
import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Page;
import kewei.manager.bean.SendEmail;
import kewei.manager.bean.Temp_menu;
import kewei.manager.bean.User;
import kewei.manager.mapper.ApplyManagerMapper;
import kewei.manager.mapper.ArticleManagerMapper;
import kewei.manager.util.EmailUtil;

@Service
public class ApplyManagerServiceImp implements ApplyManagerServiceInf{
@Autowired
ApplyManagerMapper applyManagerMapper;

@Override
public int selectCount() {
	return applyManagerMapper.selectCount();
}

@Override
public List<Apply> get_all_apply() {
	return applyManagerMapper.get_all_apply();
}

@Override
public List<Apply> queryApplysPage(Map<String, Object> paramMap) {
	return applyManagerMapper.queryApplysPage(paramMap);
}

@Override
public int queryApplyCount4Page(Map<String, Object> paramMap) {
	return applyManagerMapper.queryApplyCount4Page(paramMap);
}

@Override
public Page<Apply> queryApplyPage(Map<String, Object> paramMap) {
	Page<Apply> page = new Page<Apply>();
	List<Apply> applys = applyManagerMapper.queryApplysPage(paramMap);
	int count = applyManagerMapper.queryApplyCount4Page(paramMap);
	page.setTotalsize(count);
	page.setDatas(applys);
	return page;
}

public Page<Apply> query_new_ApplyPage(Map<String, Object> paramMap) {
	Page<Apply> page = new Page<Apply>();
	List<Apply> applys = applyManagerMapper.query_new_ApplysPage(paramMap);
	int count = applyManagerMapper.query_new_ApplyCount4Page(paramMap);
	page.setTotalsize(count);
	page.setDatas(applys);
	return page;
}

@Override
public void agreeApplyByid(int id) {
	applyManagerMapper.agreeApplyByid(id);
}

@Override
public int disagreeApplyByid(int id, String imessage) {
	applyManagerMapper.setImessageToApplyid(id, imessage);
	return applyManagerMapper.disagreeApplyByid(id);
}

@Override
public List<Temp_menu> get_apply_by_id(int id) {
	return applyManagerMapper.get_apply_by_id(id);
}

@Override
public List<String> get_all_user() {
	return applyManagerMapper.get_all_user();
}

@Override
public int insert_temp_menu(Temp_menu temp_menu) {
	return applyManagerMapper.insert_temp_menu(temp_menu);
}

@Override
public Long query_maxId() {
	return applyManagerMapper.query_maxId();
}

@Override
public int update_menu(Temp_menu temp_menu) {
	return applyManagerMapper.update_menu(temp_menu);
}

@Override
public void delete_menu_id(Long id) {
	applyManagerMapper.delete_temp_menu_id(id);
	List<Long> ids =applyManagerMapper.select_temp_menuId_fid(id);
	if(ids!=null){
	for (int i = 0; i < ids.size(); i++) {
		delete_menu_id(ids.get(i));
	}
	}
}

@Override
public List<String> queryApplyDisImessage(long id) {
   return 	applyManagerMapper.queryApplyDisImessage(id);
}

public void sendEmail(SendEmail sendEmail) {
      applyManagerMapper.agreeApplyByids(sendEmail);
      for(int i = 0;i<sendEmail.getIds().size();i++){
    	  if(sendEmail.getStatuss().get(i)==3){
    	  applyManagerMapper.agreeApply_imessageByid(sendEmail.getIds().get(i),sendEmail.getImessages());
    	  }
    	  if(sendEmail.getStatuss().get(i)==0){
    		  applyManagerMapper.sendEmailApplyByid(sendEmail.getIds().get(i),sendEmail.getImessages());
    	  }
      }
}

public void completeApplyByid(int i) {
	applyManagerMapper.completeApplyByid(i);
}

}
