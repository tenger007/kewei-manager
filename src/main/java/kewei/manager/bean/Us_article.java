package kewei.manager.bean;

import java.util.Date;

public class Us_article {
	private long id;	
	private String abst;
	private String access_num;
	
	private String ana_desc;
	
	private String article_type;
	
	private String author;

	private String classification;
	
	private Date pbdate;
	
	private String cont_num;
	
	//作者所在机构
	private String data_base;
	//issn号
	private String duc_type;
	//期
	private String  duc_url;
	//卷
	private String language;
	//语言
	private String page_count;
	//主题词
	private String title;
	
	//作者通讯地址
	private String pb_title;
	private String year;
	private String pb_location;
	private String rep_num;
	private String source_disc;
	private String subject;
	private String jsdname;
	
	
	public String getJsdname() {
		return jsdname;
	}
	public void setJsdname(String jsdname) {
		this.jsdname = jsdname;
	}
	public String getAbst() {
		return abst;
	}
	public void setAbst(String abst) {
		this.abst = abst;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public String getAccess_num() {
		return access_num;
	}
	public void setAccess_num(String access_num) {
		this.access_num = access_num;
	}
	public String getAna_desc() {
		return ana_desc;
	}
	public void setAna_desc(String ana_desc) {
		this.ana_desc = ana_desc;
	}
	public String getArticle_type() {
		return article_type;
	}
	public void setArticle_type(String article_type) {
		this.article_type = article_type;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getClassification() {
		return classification;
	}
	public void setClassification(String classification) {
		this.classification = classification;
	}
	public Date getPbdate() {
		return pbdate;
	}
	public void setPbdate(Date pbdate) {
		this.pbdate = pbdate;
	}
	public String getCont_num() {
		return cont_num;
	}
	public void setCont_num(String cont_num) {
		this.cont_num = cont_num;
	}
	
	public String getData_base() {
		return data_base;
	}
	public void setData_base(String data_base) {
		this.data_base = data_base;
	}
	public String getDuc_type() {
		return duc_type;
	}
	public void setDuc_type(String duc_type) {
		this.duc_type = duc_type;
	}
	public String getDuc_url() {
		return duc_url;
	}
	public void setDuc_url(String duc_url) {
		this.duc_url = duc_url;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getPage_count() {
		return page_count;
	}
	public void setPage_count(String page_count) {
		this.page_count = page_count;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getPb_title() {
		return pb_title;
	}
	public void setPb_title(String pb_title) {
		this.pb_title = pb_title;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getPb_location() {
		return pb_location;
	}
	public void setPb_location(String pb_location) {
		this.pb_location = pb_location;
	}
	public String getRep_num() {
		return rep_num;
	}
	public void setRep_num(String rep_num) {
		this.rep_num = rep_num;
	}
	public String getSource_disc() {
		return source_disc;
	}
	public void setSource_disc(String source_disc) {
		this.source_disc = source_disc;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
	
}
