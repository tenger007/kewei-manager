package kewei.manager.bean;

import java.sql.Date;


public class ArticleDto {
    private long id;
    private String img;
    private int issue;
    private String issn;
    private long sourceid;
    private String sourceName;
    private String pdf;
    private String title;
    private String language;
    private String author;
    private String authorAffiliation;
    private int type;
    private int volume;
    private String summary;
    private String subjects;
    private Date pbdate;
    private String jsds;    
    private int isforecast;
    private String authorrp;
    private String realizetime;
    
    
	public String getPdf() {
		return pdf;
	}
	public void setPdf(String pdf) {
		this.pdf = pdf;
	}
	public String getRealizetime() {
		return realizetime;
	}
	public void setRealizetime(String realizetime) {
		this.realizetime = realizetime;
	}
	public String getAuthorrp() {
		return authorrp;
	}
	public void setAuthorrp(String authorrp) {
		this.authorrp = authorrp;
	}
	public String getSubjects() {
		return subjects;
	}
	public void setSubjects(String subjects) {
		this.subjects = subjects;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getIssn() {
		return issn;
	}
	public void setIssn(String issn) {
		this.issn = issn;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	
	public String getAuthorAffiliation() {
		return authorAffiliation;
	}
	public void setAuthorAffiliation(String authorAffiliation) {
		this.authorAffiliation = authorAffiliation;
	}
	public void setId(long id) {
		this.id = id;
	}
	public void setSourceid(long sourceid) {
		this.sourceid = sourceid;
	}
	public int getIsforecast() {
		return isforecast;
	}
	public void setIsforecast(int isforecast) {
		this.isforecast = isforecast;
	}
	public String getJsds() {
		return jsds;
	}
	public void setJsds(String jsds) {
		this.jsds = jsds;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public Date getPbdate() {
		return pbdate;
	}
	public void setPbdate(Date pbdate) {
		this.pbdate = pbdate;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getSourceName() {
		return sourceName;
	}
	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public int getIssue() {
		return issue;
	}
	public void setIssue(int issue) {
		this.issue = issue;
	}
	public Long getSourceid() {
		return sourceid;
	}
	public void setSourceid(Long sourceid) {
		this.sourceid = sourceid;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public int getVolume() {
		return volume;
	}
	public void setVolume(int volume) {
		this.volume = volume;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	
    
}
