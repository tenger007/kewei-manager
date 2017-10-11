package kewei.manager.bean;

import java.util.Date;

public class Article {
	private long id;	
	
	private long sourceid;
	
	private String realizetime;
	private String sourcename;
	
	private String title;
	
	private String author;
	
	private String pdf;
	
	private String img;

	private String summary;
	
	private String pbdate;
	
	private int type;
	
	//作者所在机构
	private String authoraffiliation;
	//issn号
	private String issn;
	//期
	private int issue;
	//卷
	private int volume;
	//语言
	private String language;
	//主题词
	private String subjects;
	
	//作者通讯地址
	private String authorrp;
	
	
	public String getRealizetime() {
		return realizetime;
	}

	public void setRealizetime(String realizetime) {
		this.realizetime = realizetime;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}


	public long getSourceid() {
		return sourceid;
	}

	public void setSourceid(long sourceid) {
		this.sourceid = sourceid;
	}

	public String getSourcename() {
		return sourcename;
	}

	public void setSourcename(String sourcename) {
		this.sourcename = sourcename;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public String getPdf() {
		return pdf;
	}

	public void setPdf(String pdf) {
		this.pdf = pdf;
	}

	public String getImg() {
		return img;
	}

	public void setImg(String img) {
		this.img = img;
	}

	

	public String getSummary() {
		return summary;
	}

	public void setSummary(String summary) {
		this.summary = summary;
	}


	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}

	



	public String getPbdate() {
		return pbdate;
	}

	public void setPbdate(String pbdate) {
		this.pbdate = pbdate;
	}

	public String getAuthoraffiliation() {
		return authoraffiliation;
	}

	public void setAuthoraffiliation(String authoraffiliation) {
		this.authoraffiliation = authoraffiliation;
	}

	public String getIssn() {
		return issn;
	}

	public void setIssn(String issn) {
		this.issn = issn;
	}

	

	public int getIssue() {
		return issue;
	}

	public void setIssue(int issue) {
		this.issue = issue;
	}

	public int getVolume() {
		return volume;
	}

	public void setVolume(int volume) {
		this.volume = volume;
	}

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getSubjects() {
		return subjects;
	}

	public void setSubjects(String subjects) {
		this.subjects = subjects;
	}

	public String getAuthorrp() {
		return authorrp;
	}

	public void setAuthorrp(String authorrp) {
		this.authorrp = authorrp;
	}

	
	
}
