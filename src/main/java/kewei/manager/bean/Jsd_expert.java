package kewei.manager.bean;


public class Jsd_expert {
	private long id; 
	private String expert_name; //专家姓名
	private String expert_img; //专家图片
	private String expert_summary; //专家简介
	private String jsdname;
	private String expert_email;
	private String expert_unit;
	private Integer h_index;
	private String screening_basis;
	
	public String getExpert_email() {
		return expert_email;
	}
	public void setExpert_email(String expert_email) {
		this.expert_email = expert_email;
	}
	public String getExpert_unit() {
		return expert_unit;
	}
	public void setExpert_unit(String expert_unit) {
		this.expert_unit = expert_unit;
	}
	public Integer getH_index() {
		return h_index;
	}
	public void setH_index(Integer h_index) {
		this.h_index = h_index;
	}
	public String getScreening_basis() {
		return screening_basis;
	}
	public void setScreening_basis(String screening_basis) {
		this.screening_basis = screening_basis;
	}
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
	public String getExpert_name() {
		return expert_name;
	}
	public void setExpert_name(String expert_name) {
		this.expert_name = expert_name;
	}
	public String getExpert_img() {
		return expert_img;
	}
	public void setExpert_img(String expert_img) {
		this.expert_img = expert_img;
	}
	public String getExpert_summary() {
		return expert_summary;
	}
	public void setExpert_summary(String expert_summary) {
		this.expert_summary = expert_summary;
	}
	
	
	
}	
