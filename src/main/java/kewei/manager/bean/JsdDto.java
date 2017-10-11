package kewei.manager.bean;

import java.sql.Date;

public class JsdDto {
	
	private long id;
	private long fid;
	private String jsdName;
	private String fjsdName;
	private String civil;
	private String international;
    private String isGenZongJsd;
    private int isQianYan;
    private String isQianYanJsd;
    private String isMainField;
    private Date upDate;
    private int year;
	private double score;
	private double scoreJigou;
	private double scoreZazhi;
	private double scoreDb;
	private double scoreExpert;
	private String fieldName;
	private String img;
	private String definition;
	private String enname;
	private String keyword;
	private int isshow;
	
	
	public long getFid() {
		return fid;
	}
	public void setFid(long fid) {
		this.fid = fid;
	}
	public String getFjsdName() {
		return fjsdName;
	}
	public void setFjsdName(String fjsdName) {
		this.fjsdName = fjsdName;
	}
	public int getIsshow() {
		return isshow;
	}
	public void setIsshow(int isshow) {
		this.isshow = isshow;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getImg() {
		return img;
	}
	public void setImg(String img) {
		this.img = img;
	}
	public String getDefinition() {
		return definition;
	}
	public void setDefinition(String definition) {
		this.definition = definition;
	}
	public String getEnname() {
		return enname;
	}
	public void setEnname(String enname) {
		this.enname = enname;
	}
	public Date getUpDate() {
		return upDate;
	}
	public void setUpDate(Date upDate) {
		this.upDate = upDate;
	}
	public String getCivil() {
		return civil;
	}
	public void setCivil(String civil) {
		this.civil = civil;
	}
	public String getInternational() {
		return international;
	}
	public void setInternational(String international) {
		this.international = international;
	}
	public int getIsQianYan() {
		return isQianYan;
	}
	public void setIsQianYan(int isQianYan) {
		this.isQianYan = isQianYan;
	}

	public String getIsGenZongJsd() {
		return isGenZongJsd;
	}
	public void setIsGenZongJsd(String isGenZongJsd) {
		this.isGenZongJsd = isGenZongJsd;
	}
	public String getIsQianYanJsd() {
		return isQianYanJsd;
	}
	public void setIsQianYanJsd(String isQianYanJsd) {
		this.isQianYanJsd = isQianYanJsd;
	}
	public String getIsMainField() {
		return isMainField;
	}
	public void setIsMainField(String isMainField) {
		this.isMainField = isMainField;
	}
	
	
	public int getYear() {
		return year;
	}
	public void setYear(int year) {
		this.year = year;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	
	public String getJsdName() {
		return jsdName;
	}
	public void setJsdName(String jsdName) {
		this.jsdName = jsdName;
	}
	
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public double getScoreJigou() {
		return scoreJigou;
	}
	public void setScoreJigou(double scoreJigou) {
		this.scoreJigou = scoreJigou;
	}
	public double getScoreZazhi() {
		return scoreZazhi;
	}
	public void setScoreZazhi(double scoreZazhi) {
		this.scoreZazhi = scoreZazhi;
	}
	public double getScoreDb() {
		return scoreDb;
	}
	public void setScoreDb(double scoreDb) {
		this.scoreDb = scoreDb;
	}
	public double getScoreExpert() {
		return scoreExpert;
	}
	public void setScoreExpert(double scoreExpert) {
		this.scoreExpert = scoreExpert;
	}
	public String getFieldName() {
		return fieldName;
	}
	public void setFieldName(String fieldName) {
		this.fieldName = fieldName;
	}
	

	
}
