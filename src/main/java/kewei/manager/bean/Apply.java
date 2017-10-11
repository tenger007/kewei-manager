package kewei.manager.bean;

import java.sql.Date;

public class Apply {
	private Integer id;
	private Long jsdid;
	private String fieldname;
	private String jsdname;
	private String jsd_describe;
	private String applicant;
	private String applicant_unit;
	private String tel;
	private Integer status;
	private String apply_time;
	
	
	public String getApply_time() {
		return apply_time;
	}
	public void setApply_time(String apply_time) {
		this.apply_time = apply_time;
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Long getJsdid() {
		return jsdid;
	}
	public void setJsdid(Long jsdid) {
		this.jsdid = jsdid;
	}
	
	public String getFieldname() {
		return fieldname;
	}
	public void setFieldname(String fieldname) {
		this.fieldname = fieldname;
	}
	public String getJsdname() {
		return jsdname;
	}
	public void setJsdname(String jsdname) {
		this.jsdname = jsdname;
	}
	public String getJsd_describe() {
		return jsd_describe;
	}
	public void setJsd_describe(String jsd_describe) {
		this.jsd_describe = jsd_describe;
	}
	public String getApplicant() {
		return applicant;
	}
	public void setApplicant(String applicant) {
		this.applicant = applicant;
	}
	public String getApplicant_unit() {
		return applicant_unit;
	}
	public void setApplicant_unit(String applicant_unit) {
		this.applicant_unit = applicant_unit;
	}
	public String getTel() {
		return tel;
	}
	public void setTel(String tel) {
		this.tel = tel;
	}
	public Integer getStatus() {
		return status;
	}
	public void setStatus(Integer status) {
		this.status = status;
	}
	
	
	

}
 