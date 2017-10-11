package kewei.manager.bean;

import java.sql.Date;

public class Expert {
	private long id;
	private long fieldid;
	private String name;
	private String title;
	private String summary;
	private String content;
	private String keyword;
	private Date pbdate;
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getFieldid() {
		return fieldid;
	}
	public void setFieldid(long fieldid) {
		this.fieldid = fieldid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public Date getPbdate() {
		return pbdate;
	}
	public void setPbdate(Date pbdate) {
		this.pbdate = pbdate;
	}
	
	

}
