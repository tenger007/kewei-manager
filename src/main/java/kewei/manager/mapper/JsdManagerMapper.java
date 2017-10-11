package kewei.manager.mapper;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.JsdDto;
import kewei.manager.bean.Jsd_expert;
import kewei.manager.bean.Us_article;
import kewei.manager.bean.Article;
import kewei.manager.bean.Article_Downloader;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Company;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Downloader_record;
import kewei.manager.bean.JiShuDian;

public interface JsdManagerMapper {
	//批量插入jsd
	int insert_jsds(List<JiShuDian> jsds);
	
	//根据页面id查找页面
	JsdDto query_jsdDto_by_id(Long id);
	
	//插入技术点相关的公司数据
	int insert_company(Company com);
	
	//插入美国科技项目数据
	int insert_us_article(Us_article us_article);

	//获取最新的技术点id
	long query_max_jsdid();
	
	//设置技术点为显示状态
	void set_Isshow_by_jsdname(String name);
	//设置技术点为隐藏状态
	void set_IsNotShow_by_jsdname(String name);
	//根据技术点名称查找是否展示
	int query_Isshow_by_jsdname(String name);
	
	//根据技术点名称查找技术点id
	Long query_jsdId_by_jsdName(String jsdName);
	
	//将技术点添加到跟踪
	int update_jsd_genzong(String jsdname);
	
	//添加技术领域
	int insert_field(String fieldName);
	
	//查找某的领域下的技术点
 	List<String> query_jsd_by_fieldName(String fieldName);
 	
 	//查找某的领域下的跟踪技术点
 	List<String> query_GenZongJsd_by_fieldName(String fieldName);
	
 	//查询所有的领域名称
 	List<String> query_field();
 	
	//修改技术点
	int update_jsd(JiShuDian jsd);
	
	//删除多个jsd
   int delete_jsds_ids(Datas ids);
	   
	//根据id删除jsd
	int delete_jsd_id(Long id);
	
	//根据属性名称查找属性id
	long query_fieldid_by_fieldName(String fieleName);
	
	//添加页面
	int insert_jsd(JiShuDian jsd);
	
	//查找所有的jsd
	List<JsdDto> get_all_jsdDto();
	
	//查找jsd并分页
	 List<JsdDto> queryJsds4Page(Map<String, Object> paramMap);
	 int queryJsdCount4Page(Map<String, Object> paramMap);

	int update_jsdimg(long id, String img);

	//通过jsdid查找jsd名称
	String query_jsdName_by_jsdid(long id);

	List<JiShuDian> byIsqianyanjishudian(int i);

	void update_jsd_score(double score, double scoreJigou, double scoreZazhi, double scoreDb, double scoreExpert,long jsdid);

	List<Article_Jsd> query_jsd_article(long id);

	List<String> query_AllGenzongjsd();

	List<String> query_Alluser();

	void insert_jsd_expert(Jsd_expert jsd_expert);

	List<String> query_GenZong_noshowJsd_by_fieldName(String fieldName);

	void set_User_menu_Status1(String name, String username);

	int insert_article_Downloaders(List<Article_Downloader> article_Downloaders);

	int get_all_jsdDownloaderArticle(String jsdname);

	int insert_downloader_record(Downloader_record downloader_record);

	void delete_article_Downloaders(String jsdname);

	Downloader_record get_jsdDownloader_channel(String name);

	List<String> get_all_jsdDownloader();

	List<String> query_fjsd_by_fieldName(String fieldName);

	Us_article get_us_articleByAces_numAndJsdName(String access_num, String jsdName);

	Jsd_expert getJsd_expertByExpertNameAndJsdName(String expert_name, String jsdName);

	Company getCompanyByCmpanyNameAndJsdName(String companyName, String jsdName);

}
