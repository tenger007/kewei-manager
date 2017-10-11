package kewei.manager.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.sql.Date;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.objenesis.instantiator.basic.NewInstanceInstantiator;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kewei.manager.bean.Article;
import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Page;
import kewei.manager.service.ApplyManagerServiceImp;
import kewei.manager.service.ArticleManagerServiceImp;
import kewei.manager.service.JsdManagerServiceImp;
import kewei.manager.service.UserManagerServiceImp;
import kewei.manager.util.ImportUtil;

@Controller
@RequestMapping("goto_article_manager")
public class ArticleController extends BaseController{
  @Autowired
  ArticleManagerServiceImp articleManager;
  @Autowired
  JsdManagerServiceImp jsdManager;
  @Autowired
  UserManagerServiceImp userManager;
  @Autowired
  ApplyManagerServiceImp applyManager;
  
  @RequestMapping("")
	public String goto_article_manager(ModelMap map,HttpSession session){
	  List<String> field = jsdManager.query_field();
	  session.setAttribute("imessage_count", userManager.selectImessageCount());
		session.setAttribute("count", applyManager.selectCount());
		map.put("list_field", field);
		return "article/article_manager";
	}
  
	@ResponseBody
	@RequestMapping("/import_article/{id}")
	public Object import_article(@PathVariable("id")Long id ,HttpServletRequest req) {
		start();
		try {
			MultipartHttpServletRequest request = (MultipartHttpServletRequest)req;
			MultipartFile file = request.getFile("articleFile");
			String realPath = req.getSession().getServletContext().getRealPath("/WEB-INF/export/article");
			file.transferTo(new File(realPath+"/"+ file.getOriginalFilename()));
			String pdf = realPath+"/"+file.getOriginalFilename();
			int num = articleManager.update_article_pdf(id,pdf);
			success(true);
		} catch( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}
  
  @ResponseBody
	@RequestMapping("/update_article")
	public Object update_article(long id, String title,String author,
			String authorAffiliation,Date pbdate,int type,
      	int issue,int volume,String sourceName,
      	int isforecast,String jsdNames,String summary) throws Exception {
	   Map<String, Object> resultMap = new HashMap<String, Object>();
		Article article = new Article();
		List<Article_Jsd> article_Jsds = new ArrayList<Article_Jsd>();
		Datas datas = new Datas();
		try {
			article.setId(id);
			article.setTitle(title);
			article.setAuthor(author);
			article.setAuthoraffiliation(authorAffiliation);
			article.setIssue(issue);
			article.setPbdate(pbdate.toLocaleString());
			article.setSourceid(articleManager.query_sourceId(sourceName));
			article.setSourcename(sourceName);
			article.setSummary(summary);
			article.setVolume(volume);
			article.setType(type);
			if(id==0){
				articleManager.insert_article(article);
				article.setId(articleManager.query_articleId_by_title_author(title, author));
			}
			else{
				articleManager.update_article(article);
			}
			String[] jsd = jsdNames.split(",");
			List<String> jsdNamess = Arrays.asList(jsd);
			datas.setNames(jsdNamess);
			List<Long> jsdIds = articleManager.query_jsdId_by_jsdName(datas);
			for (Long jsdId : jsdIds) {
				Article_Jsd article_Jsd = new Article_Jsd();
				article_Jsd.setArticleId(article.getId());
				article_Jsd.setIsforecast(isforecast);
				article_Jsd.setJsdId(jsdId);
				article_Jsds.add(article_Jsd);
			}
			//将和文章有关的技术点删除
			articleManager.delete_jsdArticle_articleId(article.getId());
			//加入和文章有关的技术点
			articleManager.insert_article_jsds(article_Jsds);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		return resultMap;
	}

  
  @RequestMapping("/edit_article_by_id/{id}")
 	public String edit( @PathVariable("id")Long id, Model model ) {
 		
 		ArticleDto articleDto = articleManager.query_articleDto_by_id(id);
 		List<Long> jsdids = articleManager.query_jsdids_by_articleId(id);
 		List<String> jsdNames = new ArrayList<String>();
 		for(Long jsdid:jsdids){
 		String jsdName = articleManager.query_jsdName_by_jsdId(jsdid);
 		jsdNames.add(jsdName);
 		}
 		model.addAttribute("articleDto", articleDto);
 		model.addAttribute("sourceNames", articleManager.query_allSourceName());
 		model.addAttribute("jsdNames", jsdNames);
 		model.addAttribute("jsdNamess",articleManager.query_allJsdName());
 		return "article/article_edit";
 	}
  
   @ResponseBody
 	@RequestMapping("/delete_articles_by_ids")
 	public Object deleteArticles( Datas ids ) {
 		start();
 		try {
 			int cnt = articleManager.delete_articles_ids(ids);
 			//将jsd_article中有关的文章删除
 			articleManager.delete_jsdArticle_articleIds(ids);
 			success(cnt == ids.getIds().size());
 		} catch ( Exception e ) {
 			e.printStackTrace();
 			success(false);
 		}
 		return end();
 	}
  
    @ResponseBody
 	@RequestMapping("/delete_article_by_id")
 	public Object delete_article_by_id(long id){
    Map<String, Object> resultMap = new HashMap<String, Object>();
 		
 		try {
 			int cnt = articleManager.delete_article_id(id);
 			//将jsd_article中有关的文章删除
 			articleManager.delete_jsdArticle_articleId(id);
 			resultMap.put("success", cnt == 1);
 		} catch ( Exception e ) {
 			e.printStackTrace();
 			resultMap.put("success", false);
 		}
 		
 		return resultMap;
 	}
    @ResponseBody
	@RequestMapping(value = "/article_add", method = RequestMethod.POST)
	public Object article_add(ArticleDto articleDto) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		Article article = new Article();
		List<Article_Jsd> article_Jsds = new ArrayList<Article_Jsd>();
		Datas datas = new Datas();
		try {
			article.setTitle(articleDto.getTitle());
			article.setAuthor(articleDto.getAuthor());
			article.setIssue(articleDto.getIssue());
			article.setPbdate(articleDto.getPbdate().toLocaleString());
			article.setSourceid(articleManager.query_sourceId(articleDto.getSourceName()));
			article.setSourcename(articleDto.getSourceName());
			article.setSummary(articleDto.getSummary());
			article.setVolume(articleDto.getVolume());
			article.setType(articleDto.getType());
			articleManager.insert_article(article);
			String jsds = articleDto.getJsds();
			String[] jsd = jsds.split("，");
			List<String> jsdNames = Arrays.asList(jsd);
			datas.setNames(jsdNames);
			List<Long> jsdIds = articleManager.query_jsdId_by_jsdName(datas);
			for (Long jsdId : jsdIds) {
				Article_Jsd article_Jsd = new Article_Jsd();
				article_Jsd.setArticleId(articleManager.query_articleId_by_title_author(articleDto.getTitle(),articleDto.getAuthor()));
				article_Jsd.setIsforecast(articleDto.getIsforecast());
				article_Jsd.setJsdId(jsdId);
				article_Jsds.add(article_Jsd);
			}
			articleManager.insert_article_jsds(article_Jsds);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
  
   @ResponseBody
 @RequestMapping("/article/pageQuery")
 	public Object pageQuery( String jsdName, Integer pageno, Integer pagesize ) {
 		
 		Map<String, Object> resultMap = new HashMap<String, Object>();
 		
 		try {
 			// 分页查询
 			Map<String, Object> paramMap = new HashMap<String, Object>();
 			paramMap.put("start", (pageno-1)*pagesize);
 			paramMap.put("size", pagesize);
 			paramMap.put("jsdName", jsdName);
 			Page<Article> page = articleManager.queryArticlePage(paramMap);
 			resultMap.put("page", page);
 			resultMap.put("success", true);
 		} catch ( Exception e ) {
 			e.printStackTrace();
 			resultMap.put("success", false);
 		}
 		return resultMap;
 	}
  
}
