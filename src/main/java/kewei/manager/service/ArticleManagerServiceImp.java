package kewei.manager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kewei.manager.bean.Article;
import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Page;
import kewei.manager.bean.Source;
import kewei.manager.mapper.ArticleManagerMapper;

@Service
public class ArticleManagerServiceImp implements ArticleManagerServiceInf{
@Autowired
ArticleManagerMapper articleManagerMapper;
	
	@Override
	public int insert_articles(List<Article> articles) {
		return articleManagerMapper.insert_articles(articles);
	}


	@Override
	public Page<Article> queryArticlePage(Map<String, Object> paramMap) {
		Page<Article> page = new Page<Article>();
		List<Article> Articles = articleManagerMapper.queryArticles4Page(paramMap);
		int count = articleManagerMapper.queryArticleCount4Page(paramMap);
		page.setTotalsize(count);
		page.setDatas(Articles);
		return page;
	}
	
	@Override
	public List<Article> queryArticles4Page(Integer pageno, Integer pagesize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("start", (pageno-1)*pagesize);
		paramMap.put("size", pagesize);
		return articleManagerMapper.queryArticles4Page(paramMap);
	}

	@Override
	public int queryArticleCount4Page() {
		return 0;
	}

	@Override
	public int insert_article(Article article) {
		return articleManagerMapper.insert_article(article);
	}
	@Override
	public int insert_articleDto(ArticleDto article) {
		return articleManagerMapper.insert_articleDto(article);
	}

	@Override
	public int delete_article_id(Long id) {
		return articleManagerMapper.delete_article_id(id);
	}

	@Override
	public int delete_articles_ids(Datas ids) {
		return articleManagerMapper.delete_articles_ids(ids);
	}

	@Override
	public int delete_jsdArticle_articleIds(Datas ids) {
		return articleManagerMapper.delete_jsdArticle_articleIds(ids);
	}

	@Override
	public int update_article(Article article) {
		return articleManagerMapper.update_article(article);
	}


	@Override
	public ArticleDto query_articleDto_by_id(Long id) {
		return articleManagerMapper.query_articleDto_by_id(id);
	}


	@Override
	public List<ArticleDto> get_all_articleDto() {
		return articleManagerMapper.get_all_articleDto();
	}


	@Override
	public Long query_fieldid_by_fieldName(String fieleName) {
		return articleManagerMapper.query_fieldid_by_fieldName(fieleName);
	}


	@Override
	public Long query_sourceId(String sourceName) {
		return articleManagerMapper.query_sourceId(sourceName);
	}


	@Override
	public int insert_article_jsds(List<Article_Jsd> article_Jsds) {
		return articleManagerMapper.insert_article_jsds(article_Jsds);
	}


	@Override
	public List<Long> query_jsdId_by_jsdName(Datas names) {
		return articleManagerMapper.query_jsdId_by_jsdName(names);
	}

	@Override
	public List<Long> query_jsdids_by_articleId(Long articleId) {
		return articleManagerMapper.query_jsdids_by_articleId(articleId);
	}


	@Override
	public String query_jsdName_by_jsdId(Long id) {
		return articleManagerMapper.query_jsdName_by_jsdId(id);
	}


	@Override
	public int delete_jsdArticle_articleId(Long articleId) {
		return articleManagerMapper.delete_jsdArticle_articleId(articleId);
	}


	@Override
	public Long query_articleId_by_title_author(String title, String author) {
		return articleManagerMapper.query_articleId_by_title_author(title, author);
	}


	@Override
	public List<String> query_allJsdName() {
		return articleManagerMapper.query_allJsdName();
	}


	@Override
	public List<String> query_allSourceName() {
		return articleManagerMapper.query_allSourceName();
	}


	@Override
	public int update_article_pdf(long id, String pdf) {
		return articleManagerMapper.update_article_pdf(id, pdf);
	}

     @Override
	public Source query_source_ById(long zazhiId) {
		return articleManagerMapper.query_source_ById(zazhiId);
	}

     @Override
	public Long query_articleId_by_title(String articleName) {
		return articleManagerMapper.query_articleId_by_title(articleName);
	}

     @Override
	public void insert_article_jsd(Article_Jsd article_Jsd) {
		articleManagerMapper.insert_article_jsd(article_Jsd);
	}


}
