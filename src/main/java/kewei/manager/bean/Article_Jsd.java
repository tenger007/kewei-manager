package kewei.manager.bean;

public class Article_Jsd {
   private long id;
   private Long articleId;
   private Long jsdId;
   private String articleName;
   private String jsdName;
   private int isforecast;
   private String realizetime;

public String getArticleName() {
	return articleName;
}
public void setArticleName(String articleName) {
	this.articleName = articleName;
}
public String getJsdName() {
	return jsdName;
}
public void setJsdName(String jsdName) {
	this.jsdName = jsdName;
}
public String getRealizetime() {
	return realizetime;
}
public void setRealizetime(String realizetime) {
	this.realizetime = realizetime;
}
public void setId(long id) {
	this.id = id;
}
public void setArticleId(long articleId) {
	this.articleId = articleId;
}
public void setJsdId(long jsdId) {
	this.jsdId = jsdId;
}
public Long getId() {
	return id;
}
public void setId(Long id) {
	this.id = id;
}
public Long getArticleId() {
	return articleId;
}
public void setArticleId(Long articleId) {
	this.articleId = articleId;
}
public Long getJsdId() {
	return jsdId;
}
public void setJsdId(Long jsdId) {
	this.jsdId = jsdId;
}
public int getIsforecast() {
	return isforecast;
}
public void setIsforecast(int isforecast) {
	this.isforecast = isforecast;
}
   
   
}
