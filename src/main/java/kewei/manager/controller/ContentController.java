package kewei.manager.controller;

import java.sql.Date;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Content;
import kewei.manager.bean.ContentDto;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Expert;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.JsdDto;
import kewei.manager.bean.Menu;
import kewei.manager.bean.MenuDto;
import kewei.manager.bean.Page;
import kewei.manager.mapper.FieldManagerMapper;
import kewei.manager.mapper.JsdManagerMapper;
import kewei.manager.mapper.MenuManagerMapper;
import kewei.manager.service.ApplyManagerServiceImp;
import kewei.manager.service.ContentManagerServiceImp;
import kewei.manager.service.FieldManagerServiceImp;
import kewei.manager.service.JsdManagerServiceImp;
import kewei.manager.service.MenuManagerServiceImp;
import kewei.manager.service.UserManagerServiceImp;

@Controller
@RequestMapping("goto_expert_content_manager")
public class ContentController extends BaseController{
  @Autowired
  MenuManagerServiceImp menuManager;
  @Autowired
  JsdManagerServiceImp jsdManager;
  @Autowired
  FieldManagerServiceImp fieldManager;
  @Autowired
  UserManagerServiceImp userManager;
  @Autowired
  ApplyManagerServiceImp applyManager;
     
    @ResponseBody
 	@RequestMapping("/expert/pageQuery")
 	public Object Query( String fieldName, String order,Integer pageno, Integer pagesize ) {
 		Map<String, Object> resultMap = new HashMap<String, Object>();
 		try {
 			long fieldid = jsdManager.query_fieldid_by_fieldName(fieldName);
 			Map<String, Object> paramMap = new HashMap<String, Object>();
 			paramMap.put("start", (pageno-1)*pagesize);
 			paramMap.put("size", pagesize);
 			paramMap.put("fieldid", fieldid);
 			paramMap.put("order", order);
 			Page<Expert> page = fieldManager.queryFieldExpert4Page(paramMap);
 			resultMap.put("page", page);
 			resultMap.put("success", true);
 		} catch ( Exception e ) {
 			e.printStackTrace();
 			resultMap.put("success", false);
 		}
 		return resultMap;
 	}
    
    @RequestMapping("/edit_expert_by_id/{id}/{fieldname}")
 	public String edit( @PathVariable("id")Long id, @PathVariable("fieldname")String fieldname, Model model ) {
    	model.addAttribute("field", fieldname);
    	model.addAttribute("fields", jsdManager.query_field());
 		model.addAttribute("expert",fieldManager.queryExpertContentById(id));
 		return "field_expert/expert_content_edit";
 	}
    
    @ResponseBody
    @RequestMapping("/expertcontent/update")
    public Object updateExpertContent(long id,String title,String name,
    								 String summary,Date pbdate,String keyword,String contents,String fieldname ) {
    	Map<String, Object> resultMap = new HashMap<String, Object>();
    	Expert expert = new Expert();
    	try {
    		expert.setId(id);
    		expert.setFieldid(jsdManager.query_fieldid_by_fieldName(fieldname));
    		expert.setTitle(title);
    		expert.setContent(contents);
    		expert.setName(name);
    		expert.setKeyword(keyword);
    		expert.setPbdate(pbdate);
    		expert.setSummary(summary);
    	 if(id==0){
    		fieldManager.insertExpertcontent(expert);
    	 }
    	 else{
    		 fieldManager.updateExpertcontent(expert);
    	 }
    	 resultMap.put("success", true);
    	} catch ( Exception e ) {
    		e.printStackTrace();
    		resultMap.put("success", false);
    	}
    	return resultMap;
    }
  
  @RequestMapping("")
  public String goto_expert_content_manager(ModelMap map,HttpSession session){
	  session.setAttribute("imessage_count", userManager.selectImessageCount());
		session.setAttribute("count", applyManager.selectCount());
	  List<String> field = jsdManager.query_field();
		map.put("list_field", field);
		return "field_expert/expert_manager";
	}
  
  
 
  /*
  @ResponseBody
	@RequestMapping("delete_contents_by_ids")
	public Object deleteContents( Datas ids ) {
		start();
		
		try {
			int cnt = contentManager.delete_contents_ids(ids);
			success(cnt == ids.getIds().size());
		} catch ( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}
  
  @ResponseBody
	@RequestMapping("delete_content_by_id")
	public Object delete_content_by_id(long id){
Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			int cnt = contentManager.delete_content_id(id);
			resultMap.put("success", cnt == 1);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}*/
  @ResponseBody
  @RequestMapping("/delete_expert_by_id")
  public Object delete_expert_by_id(long id){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  
	  try {
		  int cnt = fieldManager.delete_expert_by_id(id);
		  resultMap.put("success", cnt == 1);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  resultMap.put("success", false);
	  }
	  
	  return resultMap;
  }
  
  
  /*@ResponseBody
	@RequestMapping("content/pageQuery")
	public Object pageQuery( String querytext, Integer pageno, Integer pagesize ) {
		
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			// 分页查询
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("start", (pageno-1)*pagesize);
			paramMap.put("size", pagesize);
			paramMap.put("querytext", querytext);
			
			Page<ContentDto> page = contentManager.queryContentPage(paramMap);
			resultMap.put("page", page);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		return resultMap;
	}*/
}
