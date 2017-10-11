package kewei.manager.controller;


import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kewei.manager.bean.Apply;
import kewei.manager.bean.Article;
import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Company;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.Jsd_expert;
import kewei.manager.bean.Page;
import kewei.manager.bean.Permission;
import kewei.manager.bean.Us_article;
import kewei.manager.bean.User;
import kewei.manager.service.ApplyManagerServiceImp;
import kewei.manager.service.ArticleManagerServiceImp;
import kewei.manager.service.ContentManagerServiceImp;
import kewei.manager.service.JsdManagerServiceImp;
import kewei.manager.service.MenuManagerServiceImp;
import kewei.manager.service.PermissionManagerServiceImp;
import kewei.manager.service.UserManagerServiceImp;
import kewei.manager.util.Const;
import kewei.manager.util.ExcelUtil;
import kewei.manager.util.MD5Util;
import kewei.manager.util.fieldJs;

@Controller
public class IndexController {
   @Autowired
   MenuManagerServiceImp menuManager;
   @Autowired
   ContentManagerServiceImp contentManager;
   @Autowired
   ArticleManagerServiceImp articleManager;
   @Autowired
   JsdManagerServiceImp jsdManager;
   @Autowired
   ApplyManagerServiceImp applyManager;
   @Autowired
   UserManagerServiceImp userManager;
   @Autowired
   PermissionManagerServiceImp permissionManager;
   
   @RequestMapping("/goto_Ueditor")
   public String goto_Ueditor(){
	   return "Ueditor";
   }
	
	@RequestMapping("/index")
	public String index(){
		return "index";
	}
	@RequestMapping("/main")
	public String main(ModelMap map,HttpSession session){
		User user = (User)session.getAttribute(Const.LOGIN_USER);
		Permission root = null;
		List<Permission> permissions = permissionManager.queryUserPermissions(user.getId());
		Map<Integer, Permission> permissionMap = new HashMap<Integer, Permission>();
		
		for ( Permission p : permissions ) {
			permissionMap.put(p.getId(), p);
		}
		
		for ( Permission p : permissions ) {
			Permission childPermission = p;
			if ( childPermission.getPid() == 0 ) {
				//roots.add(p);
				root = p;
			} else {
				Permission parentPermission = permissionMap.get(childPermission.getPid());
				parentPermission.getChildren().add(childPermission);
			}
		}
		session.setAttribute("imessage_count", userManager.selectImessageCount());
		session.setAttribute("count", applyManager.selectCount());
		session.setAttribute(Const.USER_MENU,root.getChildren());
		List<String> field = jsdManager.query_field();
		map.put("list_field", field);
		return "manager_index";
	}
	
	@ResponseBody
	@RequestMapping("/doLogin")
	public Object doLogin( User user, HttpSession session ) {
		
		// Object ==> { "success" : true }
		// List ==> []
		// User, Student ==> {}
		// Map ==> {key ： value}
		// 参数集合，用于
		Map<String, Object> resultMap = new HashMap<String, Object>();
		
		try {
			String userpswd = MD5Util.digest(user.getPassword());
			user.setPassword(userpswd);
			User dbUser = userManager.queryUser4Login(user);
			if ( dbUser == null ) {
				String errorMsg = "用户账号或密码不正确，请重新登陆";
				resultMap.put("error", errorMsg);
				resultMap.put("success", false);
			} else {
				// pageContext, request,  session,   application(ServletContext)
				// page,        response, exception, config(ServletConfig)
				// out
				int count = applyManager.selectCount();
				session.setAttribute("count", count);
				if(dbUser.getLoginname().equals("admin")){
					int imessage_count=userManager.selectImessageCount();
					session.setAttribute("imessage_count", imessage_count);
				}
				else {
					int imessage_count=userManager.select_Other_ImessageCount(dbUser.getName());
					session.setAttribute("imessage_count", imessage_count);
				}
				session.setAttribute(Const.LOGIN_USER, dbUser);
				session.setAttribute(Const.USERID, dbUser.getId());
				Const.JSDID=jsdManager.query_max_jsdid();
				resultMap.put("success", true);
			}
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	}
	
	@RequestMapping("/DownloadExcel")
	public String download(){
		return "manager_download";
	}
	
	@RequestMapping("/test")
	public String test(){
		return "test";
	}
	
	
	@RequestMapping("DownloadExcel/{path}")
    public void downloadLocal(@PathVariable("path") String fileName,HttpServletRequest request,HttpServletResponse response) throws FileNotFoundException, UnsupportedEncodingException {
        // 下载本地文件
        String filepath = request.getSession().getServletContext().getRealPath("/static/excelTemplet/" + fileName);
        // 读到流中
        InputStream inStream = new FileInputStream(filepath);// 文件的存放路径
        fileName = URLEncoder.encode(fileName,"UTF-8");
        // 设置输出的格式
        response.reset();
        response.setContentType("bin");
        response.addHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
        // 循环取出流中的数据
        byte[] b = new byte[100];
        int len;
        try {
            while ((len = inStream.read(b)) > 0)
                response.getOutputStream().write(b, 0, len);
            inStream.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
	
	@ResponseBody
	@RequestMapping(value = "import_articles", method = RequestMethod.POST)
	public Object import_articles(@RequestParam("updateArticles") MultipartFile[] files,HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			String filepath = request.getSession().getServletContext().getRealPath("/upload/前沿预判文章附件/");
			File file = new File(filepath);
			if(!file.exists()){
				file.mkdir();
			}
			for(int i = 0;i<files.length;i++){
				files[i].transferTo(new File(filepath+"/"+ files[i].getOriginalFilename()));
			}
			resultMap.put("success", true);
		} catch (Exception e) {
			resultMap.put("success",false);
		}
		return resultMap;
	}
	@ResponseBody
	@RequestMapping(value = "import_documents", method = RequestMethod.POST)
	public Object import_documents(@RequestParam("updateFiles") MultipartFile[] files,@RequestParam("jsdName")String jsdName ,HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			 String filepath = request.getSession().getServletContext().getRealPath("/upload/"+jsdName+"专家照片/");
			 File file = new File(filepath);
			 if(!file.exists()){
				file.mkdir();
			 }
			 for(int i = 0;i<files.length;i++){
				 files[i].transferTo(new File(filepath+"/"+ files[i].getOriginalFilename()));
			 }
			 resultMap.put("success", true);
		} catch (Exception e) {
			resultMap.put("success",false);
		}
		return resultMap;
	}
	
	@ResponseBody
	@RequestMapping(value = "import_excel", method = RequestMethod.POST)
	public Object import_excel(@RequestParam("file") MultipartFile file,HttpServletRequest request) {
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try {
			 String filepath = request.getSession().getServletContext().getRealPath("/static/export/excelData/");
			 String[] files = file.getOriginalFilename().split("_");
			 if(files.length>2){
				 if(files[1].equals("专家")){
						file.transferTo(new File(filepath+"/"+ file.getOriginalFilename()));
						List<Jsd_expert> jsd_experts = ExcelUtil.importJsd_expert(filepath+"/"+ file.getOriginalFilename());
						String jsdName = jsd_experts.get(0).getJsdname();
						String path ="/home/xxzx/appwww/kewei-manager/upload/"+jsdName+"专家照片";
						File file2 = new File(path);
						if(!file2.exists()){
						file2.mkdir();
						}
						for(Jsd_expert jsd_expert:jsd_experts){
							jsd_expert.setJsdname(files[0]);
							jsd_expert.setExpert_img("http://172.18.20.218:8081/kewei-manager/upload/"+jsdName+"专家照片/"+jsd_expert.getExpert_img().trim());
							Jsd_expert jsd_expert2 = jsdManager.getJsd_expertByExpertNameAndJsdName(jsd_expert.getExpert_name(),files[0]);
							if(jsd_expert2==null){
								jsdManager.insert_jsd_expert(jsd_expert);
							}
						}
						resultMap.put("success", true);
					}
				 if(files[1].equals("美国政府项目")){
					 file.transferTo(new File(filepath+"/"+ file.getOriginalFilename()));
					 List<Us_article> us_articles = ExcelUtil.importUs_article(filepath+"/"+ file.getOriginalFilename());
					 for(Us_article us_article:us_articles){
						 us_article.setJsdname(files[0]);
						 Us_article us_article2 = jsdManager.get_us_articleByAces_numAndJsdName(us_article.getAccess_num(),files[0]);
						 if(us_article2==null){
							 jsdManager.insert_us_article(us_article);
						 }
					 }
					 resultMap.put("success", true);
				 }
				 if(files[1].equals("相关公司")){
					 file.transferTo(new File(filepath+"/"+ file.getOriginalFilename()));
					 List<Company> coms = ExcelUtil.importCompany(filepath+"/"+ file.getOriginalFilename());
					 for(Company com:coms){
						 com.setJsdname(files[0]);
						 Company com2 = jsdManager.getCompanyByCmpanyNameAndJsdName(com.getName(),files[0]);
						 if(com2==null){
							 jsdManager.insert_company(com);
						 }
					 }
					 resultMap.put("success", true);
				 }
			 }
			 else{
			if(file.getOriginalFilename().equals("文章.xlsx")){
				file.transferTo(new File(filepath+"/"+ file.getOriginalFilename()));
				 List<ArticleDto> articleDtos = ExcelUtil.importArticleExcel(filepath+"/"+ file.getOriginalFilename());
				//Datas datas = new Datas();
				for (ArticleDto articleDto:articleDtos) {
					//List<Article_Jsd> article_Jsds = new ArrayList<Article_Jsd>();
					articleDto.setSourceid(articleManager.query_sourceId(articleDto.getSourceName()));
					Long articleId = articleManager.query_articleId_by_title_author(articleDto.getTitle(), articleDto.getAuthor());
					if(articleId==null){
						articleManager.insert_articleDto(articleDto);
					}
				}
				resultMap.put("success", true);
			}
			if(file.getOriginalFilename().equals("技术点.xlsx")){
				file.transferTo(new File(filepath+"/"+ file.getOriginalFilename()));
				List<JiShuDian> jsdDtos = ExcelUtil.importJsdDistributeExcel(filepath+"/"+ file.getOriginalFilename());
				for(JiShuDian jsdDto:jsdDtos){
					if(jsdDto.getfName()==jsdDto.getName()){
						jsdDto.setFid(0);
					}
					else{
						Long fid = jsdManager.query_jsdId_by_jsdName(jsdDto.getfName());
						jsdDto.setFid(fid);
					}
					Long jsdId = jsdManager.query_jsdId_by_jsdName(jsdDto.getName());
					if(jsdId==null){
						jsdManager.insert_jsd(jsdDto);
					}
				}
				resultMap.put("success", true);
				}
			/*if(file.getOriginalFilename().equals("技术点分布.xlsx")){
				file.transferTo(new File(filepath+"/"+ file.getOriginalFilename()));
				List<JiShuDian> jsdDtos = ExcelUtil.importJsdDistributeExcel(filepath+"/"+ file.getOriginalFilename());
				for(JiShuDian jsdDto:jsdDtos){
					jsdManager.update_jsd(jsdDto);
				}
				resultMap.put("success", true);
			}*/
			if(file.getOriginalFilename().equals("技术点_文章.xlsx")){
				file.transferTo(new File(filepath+"/"+ file.getOriginalFilename()));
				List<Article_Jsd> article_Jsds = ExcelUtil.importJsdArticleExcel(filepath+"/"+ file.getOriginalFilename());
				for(Article_Jsd article_Jsd:article_Jsds){
					Long jsdId = jsdManager.query_jsdId_by_jsdName(article_Jsd.getJsdName());
					Long articleId = articleManager.query_articleId_by_title(article_Jsd.getArticleName());
					article_Jsd.setArticleId(articleId);
					article_Jsd.setJsdId(jsdId);
					articleManager.insert_article_jsd(article_Jsd);
				}
			}
				resultMap.put("success", true);
			}
		} catch ( Exception e ) {
			e.printStackTrace();
			resultMap.put("success", false);
		}
		
		return resultMap;
	} 
	
}
