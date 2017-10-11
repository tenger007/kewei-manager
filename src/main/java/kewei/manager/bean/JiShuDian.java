package kewei.manager.bean;

import java.security.Timestamp;
import java.sql.Date;

public class JiShuDian{
	private long id;
	private Long fid;
	private String fName;
	private String name;
	private String keyword;
	//技术点跟踪图片
	private String img;
		
		
	private double score;
	
	private double scorejigou;
	private double scorezazhi;
	private double scoredb;
	private double scoreexpert;
	
	private Date updatetime;
	
	
	private long fieldid;

	//技术点相关文章（文章包含报告和文献，报告和文献分别来源于机构和杂志）
	/*@ManyToMany(cascade = CascadeType.ALL)
    @JoinTable(name = "JISHUDIAN_ARTICLE", joinColumns = {
            @JoinColumn(name = "JISHUDIAN_ID", referencedColumnName = "ID")}, inverseJoinColumns = {
            @JoinColumn(name = "ARTICLE_ID", referencedColumnName = "ID")})
    
	private Set<Article> articles = new HashSet<Article>();*/
	

	//技术点国际分布
	private String International;
	
	//技术点国内分布
	private String civil;
	
	//技术点发布时间
	private Integer year=0;
	
	//技术点研究情况（历年数量）
	private String num;
	
	//专家是否判定是前言
	private int isqianyan;
	
	//是否是前沿技术点
	private int isqianyanjishudian;
	
	//是否是跟踪技术点
	private int isgenzongjishudian;
	
	//临时添加填充技术点打分页面空白内容
	private String definition;
	
	private String en_name;
	
	private int ismainfield;
	private int isshow;
	
	
	public String getfName() {
		return fName;
	}
	public void setfName(String fName) {
		this.fName = fName;
	}
	public long getId() {
		return id;
	}
	public void setId(long id) {
		this.id = id;
	}
	public long getFid() {
		return fid;
	}
	public void setFid(long fid) {
		this.fid = fid;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
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
	public double getScore() {
		return score;
	}
	public void setScore(double score) {
		this.score = score;
	}
	public double getScorejigou() {
		return scorejigou;
	}
	public void setScorejigou(double scorejigou) {
		this.scorejigou = scorejigou;
	}
	public double getScorezazhi() {
		return scorezazhi;
	}
	public void setScorezazhi(double scorezazhi) {
		this.scorezazhi = scorezazhi;
	}
	public double getScoredb() {
		return scoredb;
	}
	public void setScoredb(double scoredb) {
		this.scoredb = scoredb;
	}
	public double getScoreexpert() {
		return scoreexpert;
	}
	public void setScoreexpert(double scoreexpert) {
		this.scoreexpert = scoreexpert;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
	public long getFieldid() {
		return fieldid;
	}
	public void setFieldid(long fieldid) {
		this.fieldid = fieldid;
	}
	
	public String getInternational() {
		return International;
	}
	public void setInternational(String international) {
		International = international;
	}
	public String getCivil() {
		return civil;
	}
	public void setCivil(String civil) {
		this.civil = civil;
	}
	public Integer getYear() {
		return year;
	}
	public void setYear(Integer year) {
		this.year = year;
	}
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public int getIsqianyan() {
		return isqianyan;
	}
	public void setIsqianyan(int isqianyan) {
		this.isqianyan = isqianyan;
	}
	public int getIsqianyanjishudian() {
		return isqianyanjishudian;
	}
	public void setIsqianyanjishudian(int isqianyanjishudian) {
		this.isqianyanjishudian = isqianyanjishudian;
	}
	public int getIsgenzongjishudian() {
		return isgenzongjishudian;
	}
	public void setIsgenzongjishudian(int isgenzongjishudian) {
		this.isgenzongjishudian = isgenzongjishudian;
	}
	public String getDefinition() {
		return definition;
	}
	public void setDefinition(String definition) {
		this.definition = definition;
	}
	public String getEn_name() {
		return en_name;
	}
	public void setEn_name(String en_name) {
		this.en_name = en_name;
	}
	public int getIsmainfield() {
		return ismainfield;
	}
	public void setIsmainfield(int ismainfield) {
		this.ismainfield = ismainfield;
	}
	public int getIsshow() {
		return isshow;
	}
	public void setIsshow(int isshow) {
		this.isshow = isshow;
	}
	
	
	

	
	
}