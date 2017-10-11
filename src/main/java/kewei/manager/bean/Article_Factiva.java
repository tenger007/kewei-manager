package kewei.manager.bean;

import org.apache.log4j.varia.StringMatchFilter;

public class Article_Factiva {
 private String title;
 private String author;
 private String keyword;
 private String country;
 private String source;
 private String publicDay;
 private String agency;
 private String language;
 private String intro;
 private String discribe;
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
public String getKeyword() {
	return keyword;
}
public void setKeyword(String keyword) {
	this.keyword = keyword;
}
public String getCountry() {
	return country;
}
public void setCountry(String country) {
	this.country = country;
}
public String getSource() {
	return source;
}
public void setSource(String source) {
	this.source = source;
}
public String getPublicDay() {
	return publicDay;
}
public void setPublicDay(String publicDay) {
	this.publicDay = publicDay;
}
public String getAgency() {
	return agency;
}
public void setAgency(String agency) {
	this.agency = agency;
}
public String getLanguage() {
	return language;
}
public void setLanguage(String language) {
	this.language = language;
}
public String getIntro() {
	return intro;
}
public void setIntro(String intro) {
	this.intro = intro;
}
public String getDiscribe() {
	return discribe;
}
public void setDiscribe(String discribe) {
	this.discribe = discribe;
}
@Override
public String toString() {
	return "Article_Factiva [title=" + title + ", author=" + author + ", keyword=" + keyword + ", country=" + country
			+ ", source=" + source + ", publicDay=" + publicDay + ", agency=" + agency + ", language=" + language
			+ ", intro=" + intro + ", discribe=" + discribe +  "]";
}
 
 
}
