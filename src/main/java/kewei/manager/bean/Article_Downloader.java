package kewei.manager.bean;

import java.io.Serializable;
import java.sql.Date;
import java.util.List;

public class Article_Downloader {
 public long id;
	public String title;
	public String author;
	private String keywords;
	 private String Abstract;
	 private String content;
	 private String url;
	 private String siteName;
	 private String source;
	 private int channel_id;
	 private List<String> extras;
	 private List<String> attachments;
	 private String publishedDate;
	 private String publishedDateStr;
	 private String jsdname;
	 
	public String getJsdname() {
		return jsdname;
	}
	public void setJsdname(String jsdname) {
		this.jsdname = jsdname;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
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
	public String getKeywords() {
		return keywords;
	}
	public void setKeywords(String keywords) {
		this.keywords = keywords;
	}
	public String getAbstract() {
		return Abstract;
	}
	public void setAbstract(String abstract1) {
		Abstract = abstract1;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getSiteName() {
		return siteName;
	}
	public void setSiteName(String siteName) {
		this.siteName = siteName;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	public int getChannel_id() {
		return channel_id;
	}
	public void setChannel_id(int channel_id) {
		this.channel_id = channel_id;
	}
	public List<String> getExtras() {
		return extras;
	}
	public void setExtras(List<String> extras) {
		this.extras = extras;
	}
	public List<String> getAttachments() {
		return attachments;
	}
	public void setAttachments(List<String> attachments) {
		this.attachments = attachments;
	}
	public String getPublishedDate() {
		return publishedDate;
	}
	public void setPublishedDate(String publishedDate) {
		this.publishedDate = publishedDate;
	}
	public String getPublishedDateStr() {
		return publishedDateStr;
	}
	public void setPublishedDateStr(String publishedDateStr) {
		this.publishedDateStr = publishedDateStr;
	}
	
	
}
