package kewei.manager.controller;

import static org.hamcrest.CoreMatchers.nullValue;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.ObjectUtils.Null;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import kewei.manager.bean.JsdDto;
import kewei.manager.bean.Article;
import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Downloader;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Content;
import kewei.manager.bean.ContentDto;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Downloader_record;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.Page;
import kewei.manager.bean.Source;
import kewei.manager.mapper.MenuManagerMapper;
import kewei.manager.service.ApplyManagerServiceImp;
import kewei.manager.service.ArticleManagerServiceImp;
import kewei.manager.service.JsdManagerServiceImp;
import kewei.manager.service.UserManagerServiceImp;
import kewei.manager.util.DownloaderUtil;
import net.sf.json.JSONArray;
import net.sf.json.JsonConfig;
import net.sf.json.util.JavaIdentifierTransformer;

@Controller
@RequestMapping("goto_jsd_manager")
public class JsdController extends BaseController{
  @Autowired
  JsdManagerServiceImp jsdManager;
  @Autowired
  ArticleManagerServiceImp articleManager;
  @Autowired
  UserManagerServiceImp userManager;
  @Autowired
  ApplyManagerServiceImp applyManager;
  
  @RequestMapping("")
	public String goto_jsd_manager(ModelMap map,HttpSession session){
	  session.setAttribute("imessage_count", userManager.selectImessageCount());
		session.setAttribute("count", applyManager.selectCount());
	  List<String> field = jsdManager.query_field();
		map.put("list_field", field);
		return "jishudian/jsd_manager";
	}
  
  @ResponseBody
	@RequestMapping("/import_jsdimg/{id}")
	public Object import_article(@PathVariable("id")long id ,HttpServletRequest req) {
		start();
		try {
			MultipartHttpServletRequest request = (MultipartHttpServletRequest)req;
			MultipartFile file = request.getFile("jsdFile");
			String realPath = req.getSession().getServletContext().getRealPath("");
			file.transferTo(new File(realPath+"/"+"upload/"+file.getOriginalFilename()));
			String img = "http://172.18.20.218:8081/kewei-manager/upload/"+file.getOriginalFilename();
			jsdManager.update_jsdimg(id,img);
			success(true);
		} catch( Exception e ) {
			e.printStackTrace();
			success(false);
		}
		return end();
	}

  
   @ResponseBody
 	@RequestMapping("/update_jsd")
 	public Object update_jsd(String fieldName,String jsdName,String fjsdName,
        	String enname,String keyword,String civil,String international,
        	String isGenZongJsd,String isQianYanJsd,
        	String isMainField,double scoreExpert,double scoreDb,
        	double scoreJigou,double scoreZazhi,long id,HttpServletRequest req )  {
 		Map<String, Object> resultMap = new HashMap<String, Object>();
 		JiShuDian jsd = new JiShuDian();
 		long fid = 0;
 		if(fjsdName.equals(jsdName)){
 			 fid = 0;
 		}
 		else{
 			 fid = jsdManager.query_jsdId_by_jsdName(fjsdName);
 		}
 		try {
 			jsd.setFieldid(jsdManager.query_fieldid_by_fieldName(fieldName));
			jsd.setIsgenzongjishudian((isGenZongJsd.equals("是"))?1:0);
			jsd.setScoreexpert(scoreExpert*0.2);
			jsd.setScore(scoreExpert*0.2+scoreDb+scoreJigou+scoreZazhi);
			jsd.setIsqianyanjishudian((isQianYanJsd.equals("是"))?1:0);
			jsd.setName(jsdName);
			jsd.setIsmainfield((isMainField.equals("是"))?0:1);
			jsd.setEn_name(enname);
			jsd.setKeyword(keyword);
			jsd.setCivil(civil);
			jsd.setFid(fid);
			jsd.setInternational(international);
			if(id==0){
				if(null!=jsdManager.query_jsdId_by_jsdName(jsdName)){
					resultMap.put("success", false);
				}
				else{
					jsd.setImg("");
					jsdManager.insert_jsd(jsd);
					resultMap.put("success", true);
				}
			}
			else{
				jsdManager.update_jsd(jsd);
				resultMap.put("success", true);
			}
 			
 		} catch ( Exception e ) {
 			e.printStackTrace();
 			resultMap.put("success", false);
 		}
 		
 		return resultMap;
 	}

  
  @RequestMapping("/edit_jsd_by_id/{id}")
 	public String edit( @PathVariable("id")Long id, Model model ) {
 		
 		JsdDto jsdDto = jsdManager.query_jsdDto_by_id(id);
 		if(id!=0){
 		jsdDto.setFjsdName(jsdManager.query_jsdName_by_jsdid(jsdDto.getFid()));
 		if(null==jsdDto.getFjsdName()){
 			jsdDto.setFjsdName(jsdDto.getJsdName());
 		}
 		}
 		model.addAttribute("jsdDto", jsdDto);
 		List<String> fields = jsdManager.query_field();
 		model.addAttribute("list_field", fields);
 		
 		return "jishudian/jsd_edit";
 	}
  
  @ResponseBody
 	@RequestMapping("/delete_jsds_by_ids")
 	public Object deleteJsds( Datas ids ) {
 		start();
 		
 		try {
 			int cnt = jsdManager.delete_jsds_ids(ids);
 			success(cnt == ids.getIds().size());
 		} catch ( Exception e ) {
 			e.printStackTrace();
 			success(false);
 		}
 		return end();
 	}
  
  @ResponseBody
  @RequestMapping("/get_jsdDownloader_channel")
  public Object get_jsdDownloader_channel(String jsdName){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  try {
		 Downloader_record downloader_channel = jsdManager.get_jsdDownloader_channel(jsdName);
		  resultMap.put("downloader_channel", downloader_channel);
		  resultMap.put("success", true);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  resultMap.put("success", false);
	  }
	  
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/set_jsdDownloader_channel")
  public Object set_jsdDownloader_channel( String name,String channelId) {
	  start();
	  try {
		  SimpleDateFormat sdf = new SimpleDateFormat("2000/MM/dd HH:mm:ss");
		String time = sdf.format(new Date());
		String time2 = URLEncoder.encode(time,"utf-8");
		DownloaderUtil downloaderUtil = new DownloaderUtil();
		String jsonSize = downloaderUtil.loadJsonSize("http://zhxinfo.yuncis.com/articles/count?channelids="+channelId+"&datefrom="+time2);
		int i1 = Integer.parseInt(jsonSize);
		if(i1>0){
			List<Article_Downloader> article_Downloaders = new ArrayList<Article_Downloader>();
			for(int j = 1;j<=i1/500+1;j++){
		String loadJson = downloaderUtil.loadJson("http://zhxinfo.yuncis.com/articles/list?channelids="+channelId+"&datefrom="+time2+"&page="+j+"&size="+jsonSize);
		JSONArray fromObject = JSONArray.fromObject(loadJson);
	        JsonConfig config = new JsonConfig();
	        config.setJavaIdentifierTransformer(new JavaIdentifierTransformer() {

	            @Override
	            public String transformToJavaIdentifier(String str) {
	                char[] chars = str.toCharArray();
	                chars[0] = Character.toLowerCase(chars[0]);
	                return new String(chars);
	            }
	        });
	        config.setRootClass(Article_Downloader.class);
	       article_Downloaders.addAll((List<Article_Downloader>) JSONArray.toCollection(fromObject, config));
			}
			for(int i = 0;i<article_Downloaders.size();i++){
	        	article_Downloaders.get(i).setJsdname(name);
	        }
		    jsdManager.delete_article_Downloaders(name);
	        jsdManager.insert_article_Downloaders(article_Downloaders);
	        Downloader_record downloader_record = new Downloader_record();
	        downloader_record.setChannel_id(channelId);
	        downloader_record.setJsdname(name);
	        downloader_record.setSize(Integer.parseInt(jsonSize));
	        downloader_record.setThis_size(Integer.parseInt(jsonSize));
	        jsdManager.insert_downloader_record(downloader_record);
		}
		  success(true);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  success(false);
	  }
	  return end();
  }
  
  @ResponseBody
  @RequestMapping("/edit_score")
  public Object edit_score() {
	  start();
	  try {
		  List<JiShuDian> Jishudians = jsdManager.byIsqianyanjishudian(1);
			for (JiShuDian jishudian : Jishudians) {
				double score=0.0,scoreJigou=0.0,scoreZazhi=0.0,scoreDb=0.0,scoreExpert=0.0;
				int articleJigouNum=0,articleZazhiNum=0;
				double weight=0.0,weight1=0.0,weightJigou=0.0,weightZazhi=0.0;
				long jishudianId=jishudian.getId();
				//获取技术点相关文章并计算机构和杂志得分
//				Set<Article> articlesSet = jishudian.getArticles();
				List<Article_Jsd> article_jsds = jsdManager.query_jsd_article(jishudian.getId());
				if (article_jsds != null && article_jsds.size() > 0) {
					for(Article_Jsd jishudianArticle : article_jsds){
							ArticleDto article=new ArticleDto();
							article=articleManager.query_articleDto_by_id(jishudianArticle.getArticleId());
							if(!(null==article)){
							//机构得分计算，通过文章数量加权获得权重
							if(article.getType()==0){
								articleJigouNum++;
								String realizetime=jishudianArticle.getRealizetime();
								if(realizetime.equals("1.0")){
									weight=0.3;
								}else if(realizetime.equals("2.0")){
									weight=0.5;
								}else if(realizetime.equals("3.0")){
									weight=0.8;
								}else if(realizetime.equals("4.0")){
									weight=1;
								}
								weightJigou+=weight;
							}else if(article.getType()==1){//杂志得分计算，通过获得相关杂志和其影响因子获得权重
								articleZazhiNum++;
								long zazhiId=article.getSourceid();
								Source zazhi=articleManager.query_source_ById(zazhiId);
								int factor=zazhi.getFactor();
								if(factor==1){
									weight1=1;
								}else if(factor==2){
									weight1=0.9;
								}else if(factor==3){
									weight1=0.8;
								}else if(factor==4){
									weight1=0.7;
								}else if(factor==5){
									weight1=0.6;
								}
								
								weightZazhi+=weight1;
							}else if(article.getType()==2){//数据库有文章预测到则说明命中即得分
								scoreDb=10;
							}
							}
					}
					//机构和杂志得分计算
					if(articleJigouNum==0){
						scoreJigou=0.0;
					}
					else{
						scoreJigou= 40*weightJigou/articleJigouNum;
					}
					if(articleZazhiNum==0){
						scoreZazhi=0.0;
					}
					else{
					scoreZazhi= 30*weightZazhi/articleZazhiNum;
					}
//					System.out.println(scoreZazhi);
//					System.out.println(articleZazhiNum);
					
				}
				//计算总得分
				score=scoreJigou+scoreZazhi+scoreDb+scoreExpert;
			   //更新数据库中技术点各个得分
				jsdManager.update_jsd_score(score,scoreJigou,scoreZazhi,scoreDb,scoreExpert,jishudian.getId());
			}
			success(true);
	  } catch ( Exception e ) {
		  e.printStackTrace();
		  success(false);
	  }
	  return end();
  }
  
  @ResponseBody
 	@RequestMapping("/delete_jsd_by_id")
 	public Object delete_jsd_by_id(long id){
 Map<String, Object> resultMap = new HashMap<String, Object>();
 		
 		try {
 			int cnt = jsdManager.delete_jsd_id(id);
 			resultMap.put("success", cnt == 1);
 		} catch ( Exception e ) {
 			e.printStackTrace();
 			resultMap.put("success", false);
 		}
 		
 		return resultMap;
 	}
  
  /* @ResponseBody
	@RequestMapping(value = "jsd_add", method = RequestMethod.POST)
	public Object jsd_add(JsdDto jsdDto) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		JiShuDian jsd = new JiShuDian();
		try {
			jsd.setFieldid(jsdManager.query_fieldid_by_fieldName(jsdDto.getFieldName()));
			jsd.setIsgenzongjishudian(jsdDto.getIsGenZongJsd());
			jsd.setIsqianyan(jsdDto.getIsQianYan());
			jsd.setIsqianyanjishudian(jsdDto.getIsQianYanJsd());
			jsd.setName(jsdDto.getJsdName());
			jsd.setIsmainfield(jsdDto.getIsMainField());
			jsd.setYear(jsdDto.getYear());
			jsd.setScore(jsdDto.getScore());
			jsd.setScoredb(jsd.getScoredb());
			jsd.setScoreexpert(jsdDto.getScoreExpert());
			jsd.setScorejigou(jsdDto.getScoreExpert());
			jsd.setScorezazhi(jsdDto.getScoreZazhi());
			jsdManager.insert_jsd(jsd);
			resultMap.put("success", true);
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}*/
  @ResponseBody
  @RequestMapping("/queryJsdName")
  public Object queryJsdName(String fieldName){
		Map<String, Object> resultMap = new HashMap<String, Object>();
	  List<String> jsdNames = jsdManager.query_jsd_by_fieldName(fieldName);
	  List<String> fjsdNames =  jsdManager.query_fjsd_by_fieldName(fieldName);
	  resultMap.put("list_jsdName", jsdNames);
	  resultMap.put("list_fjsdName", fjsdNames);
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/queryField")
  public Object queryfield(){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  List<String> fieldnames = jsdManager.query_field();
	  resultMap.put("list_jsdName", fieldnames);
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/queryJsd")
  public Object queryJsd(){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  List<String> jsdNames =jsdManager.query_AllGenzongjsd();
	  resultMap.put("list_jsdName", jsdNames);
	  return resultMap;
  }
  
  @ResponseBody
  @RequestMapping("/queryUser")
  public Object queryUser(){
	  Map<String, Object> resultMap = new HashMap<String, Object>();
	  List<String> userNames =jsdManager.query_Alluser();
	  resultMap.put("list_jsdName", userNames);
	  return resultMap;
  }
  
  
  
  @ResponseBody
 	@RequestMapping("/jsd/pageQuery")
 	public Object pageQuery( String fieldName, String order,Integer pageno, Integer pagesize ) {
 		Map<String, Object> resultMap = new HashMap<String, Object>();
 		try {
 			// 分页查询
 			Map<String, Object> paramMap = new HashMap<String, Object>();
 			paramMap.put("start", (pageno-1)*pagesize);
 			paramMap.put("size", pagesize);
 			paramMap.put("fieldName", fieldName);
 			paramMap.put("order", order);
 			Page<JsdDto> page = jsdManager.queryJsdPage(paramMap);
 			resultMap.put("page", page);
 			resultMap.put("success", true);
 		} catch ( Exception e ) {
 			e.printStackTrace();
 			resultMap.put("success", false);
 		}
 		return resultMap;
 	}
  
}
