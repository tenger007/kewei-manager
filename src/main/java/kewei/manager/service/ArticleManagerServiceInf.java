package kewei.manager.service;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Article;
import kewei.manager.bean.Page;
import kewei.manager.bean.Source;

public interface ArticleManagerServiceInf {
		//批量插入article
		int insert_articles(List<Article> articles);
		
		//根据article查找jsds
		List<Long> query_jsdids_by_articleId(Long articleId);
		
		//根据title和作者查找id
		Long query_articleId_by_title_author(String title,String author);
		
		//批量插入article_jsd
		int insert_article_jsds(List<Article_Jsd> article_Jsds);
		
		//查找所有的来源名称
		List<String> query_allSourceName();
		
		//查找所有的技术点
		List<String> query_allJsdName();
		
		//根据多个jsd名称查找jsdId
		List<Long> query_jsdId_by_jsdName(Datas names);
		
		//根据jsdId查找jsdName
		String query_jsdName_by_jsdId(Long id);
		
		//根据来源名称查找sourceId
		Long query_sourceId(String sourceName);
		
		//文章上传pdf地址
		int update_article_pdf(long id,String pdf);
		
		//根据id修改页面
		int update_article(Article article);
		
		//根据页面id查找页面
		ArticleDto query_articleDto_by_id(Long id);
		
		//删除多个article
	   int delete_articles_ids(Datas ds);
		
	 //删除多个jsd_article
	   int delete_jsdArticle_articleIds(Datas ids);
	   
	   	//删除jsdArticle数据
		int delete_jsdArticle_articleId(Long articleId);
	   
		//根据id删除article
		int delete_article_id(Long id);
		
		//根据属性名称查找属性id
		Long query_fieldid_by_fieldName(String fieleName);
		
		//查找所有的article
		List<ArticleDto> get_all_articleDto();
		
		Source query_source_ById(long zazhiId);
		
		//查找article并分页
		Page<Article> queryArticlePage(Map<String, Object> paramMap);
		 List<Article> queryArticles4Page(Integer pageno, Integer pagesize);
		 int queryArticleCount4Page();

		Long query_articleId_by_title(String articleName);

		void insert_article_jsd(Article_Jsd article_Jsd);

		int insert_articleDto(ArticleDto article);

		int insert_article(Article article);
}
