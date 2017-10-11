package kewei.manager.bean;

import java.util.HashSet;
import java.util.Set;

public class Source {
	private long id;	
	
	private String name;
	
	private String img;
	
	private String summary;
	
	//杂志影响因子排名
	private int factor;
	
	//杂志影响因子
	private String ifactor;
	
	//来源类型（0：机构；1：杂志；2：数据库）
	private int sourcetype;
	
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public int getFactor() {
		return factor;
	}

	public void setFactor(int factor) {
		this.factor = factor;
	}

	public String getIfactor() {
		return ifactor;
	}

	public void setIfactor(String ifactor) {
		this.ifactor = ifactor;
	}

	public int getSourcetype() {
		return sourcetype;
	}

	public void setSourcetype(int sourcetype) {
		this.sourcetype = sourcetype;
	}
	
}
