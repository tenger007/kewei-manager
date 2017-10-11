package kewei.manager.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kewei.manager.bean.JsdDto;
import kewei.manager.bean.Jsd_expert;
import kewei.manager.bean.Article_Downloader;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Company;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Downloader_record;
import kewei.manager.bean.JiShuDian;
import kewei.manager.bean.Page;
import kewei.manager.bean.Us_article;
import kewei.manager.mapper.JsdManagerMapper;

@Service
public class JsdManagerServiceImp implements JsdManagerServiceInf{
@Autowired
JsdManagerMapper jsdManagerMapper;
	@Override
	public int insert_jsds(List<JiShuDian> jsds) {
		return jsdManagerMapper.insert_jsds(jsds);
	}
	@Override
	public Page<JsdDto> queryJsdPage(Map<String, Object> paramMap) {
		Page<JsdDto> page = new Page<JsdDto>();
		List<JsdDto> JsdDaos = jsdManagerMapper.queryJsds4Page(paramMap);
		int count = jsdManagerMapper.queryJsdCount4Page(paramMap);
		page.setTotalsize(count);
		page.setDatas(JsdDaos);
		return page;
	}
	@Override
	public List<JsdDto> queryJsds4Page(Integer pageno, Integer pagesize) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("start", (pageno-1)*pagesize);
		paramMap.put("size", pagesize);
		return jsdManagerMapper.queryJsds4Page(paramMap);
	}
	@Override
	public int queryJsdCount4Page() {
		return 0;
	}
	@Override
	public int insert_jsd(JiShuDian jsd) {
		return jsdManagerMapper.insert_jsd(jsd);
	}
	@Override
	public int delete_jsd_id(Long id) {
		return jsdManagerMapper.delete_jsd_id(id);
	}
	@Override
	public int delete_jsds_ids(Datas ids) {
		return jsdManagerMapper.delete_jsds_ids(ids);
	}
	@Override
	public JsdDto query_jsdDto_by_id(Long id) {
		return jsdManagerMapper.query_jsdDto_by_id(id);
	}

	@Override
	public List<JsdDto> get_all_jsdDto() {
		return jsdManagerMapper.get_all_jsdDto();
	}
	@Override
	public long query_fieldid_by_fieldName(String fieleName) {
		return jsdManagerMapper.query_fieldid_by_fieldName(fieleName);
	}
	@Override
	public List<String> query_jsd_by_fieldName(String fieldName) {
		return jsdManagerMapper.query_jsd_by_fieldName(fieldName);
	}
	@Override
	public List<String> query_field() {
		return jsdManagerMapper.query_field();
	}
	@Override
	public int update_jsd(JiShuDian jsd) {
		return jsdManagerMapper.update_jsd(jsd);
	}
	@Override
	public int insert_field(String fieldName) {
		return jsdManagerMapper.insert_field(fieldName);
	}
	@Override
	public List<String> query_GenZongJsd_by_fieldName(String fieldName) {
		return jsdManagerMapper.query_GenZongJsd_by_fieldName(fieldName);
	}
	@Override
	public Long query_jsdId_by_jsdName(String jsdName) {
		return jsdManagerMapper.query_jsdId_by_jsdName(jsdName);
	}
	@Override
	public int insert_company(Company com) {
		return jsdManagerMapper.insert_company(com);
	}
	@Override
	public int update_jsd_genzong(String jsdname) {
		return jsdManagerMapper.update_jsd_genzong(jsdname);
	}
	@Override
	public int insert_us_article(Us_article us_article) {
		return jsdManagerMapper.insert_us_article(us_article);
	}
	@Override
	public int update_jsdimg(long id, String img) {
		return jsdManagerMapper.update_jsdimg(id,img);
	}
	@Override
	public long query_max_jsdid() {
		return jsdManagerMapper.query_max_jsdid();
	}
	@Override
	public int query_Isshow_by_jsdname(String name) {
		return jsdManagerMapper.query_Isshow_by_jsdname(name);
	}
	@Override
	public void set_Isshow_by_jsdname(String name) {
		 jsdManagerMapper.set_Isshow_by_jsdname(name);
	}
	@Override
	public void set_IsNotshow_by_jsdname(String name) {
		jsdManagerMapper.set_IsNotShow_by_jsdname(name);		
	}
	@Override
	public String query_jsdName_by_jsdid(long id) {
		
		return jsdManagerMapper.query_jsdName_by_jsdid(id);
	}
	@Override
	public List<JiShuDian> byIsqianyanjishudian(int i) {
		return jsdManagerMapper.byIsqianyanjishudian(i);
	}

	@Override
	public void update_jsd_score(double score, double scoreJigou, double scoreZazhi, double scoreDb, double scoreExpert,long jsdid) {
       jsdManagerMapper.update_jsd_score(score,scoreJigou,scoreZazhi,scoreDb,scoreExpert,jsdid);		
	}

	@Override
	public List<Article_Jsd> query_jsd_article(long id) {
		return jsdManagerMapper.query_jsd_article(id);
		
	}

	@Override
	public List<String> query_AllGenzongjsd() {
		return jsdManagerMapper.query_AllGenzongjsd();
	}

	@Override
	public List<String> query_Alluser() {
		return jsdManagerMapper.query_Alluser();
	}

	@Override
	public void insert_jsd_expert(Jsd_expert jsd_expert) {
        jsdManagerMapper.insert_jsd_expert(jsd_expert);	
	}

	@Override
	public List<String> query_GenZong_noshowJsd_by_fieldName(String fieldName) {
		return jsdManagerMapper.query_GenZong_noshowJsd_by_fieldName(fieldName);
	}

	@Override
	public void set_User_menu_Status1(String name, String username) {
		 jsdManagerMapper.set_User_menu_Status1(name,username);
	}

	@Override
	public int get_all_jsdDownloaderArticle(String jsdname) {
		return jsdManagerMapper.get_all_jsdDownloaderArticle(jsdname);
	}
	
	@Override
	public int insert_downloader_record(Downloader_record downloader_record) {
		
		return jsdManagerMapper.insert_downloader_record(downloader_record);
	}
	
	@Override
	public void delete_article_Downloaders(String name) {
		jsdManagerMapper.delete_article_Downloaders(name);
		
	}
	
	@Override
	public Downloader_record get_jsdDownloader_channel(String name) {
		return jsdManagerMapper.get_jsdDownloader_channel(name);
	}

	@Override
	public int insert_article_Downloaders(List<Article_Downloader> article_Downloaders) {
        return jsdManagerMapper.insert_article_Downloaders(article_Downloaders);	
	}
	
	@Override
	public int update_jsd_genzong(long jsdid) {
		return 0;
	}

	@Override
	public List<String> get_all_jsdDownloader() {
		return jsdManagerMapper.get_all_jsdDownloader();
	}
	@Override
	public List<String> query_fjsd_by_fieldName(String fieldName) {
		return jsdManagerMapper.query_fjsd_by_fieldName(fieldName);
	}
	@Override
	public Us_article get_us_articleByAces_numAndJsdName(String access_num, String jsdName) {
		return jsdManagerMapper.get_us_articleByAces_numAndJsdName(access_num,jsdName);
	}
	@Override
	public Jsd_expert getJsd_expertByExpertNameAndJsdName(String expert_name, String jsdName) {
		return jsdManagerMapper.getJsd_expertByExpertNameAndJsdName(expert_name,jsdName);
	}
	@Override
	public Company getCompanyByCmpanyNameAndJsdName(String companyName, String jsdName) {
		return jsdManagerMapper.getCompanyByCmpanyNameAndJsdName(companyName,jsdName);
	}

}
