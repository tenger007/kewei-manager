package kewei.manager.bean;

import java.sql.Date;

public class User_imessage {
  private int id;
  private String loginname;
  private String imessage;
  private String sendtime;
  private int status;
  private String jsdname;
  private String sendname;
  
  
public String getSendname() {
	return sendname;
}
public void setSendname(String sendname) {
	this.sendname = sendname;
}
public String getJsdname() {
	return jsdname;
}
public void setJsdname(String jsdname) {
	this.jsdname = jsdname;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getLoginname() {
	return loginname;
}
public void setLoginname(String loginname) {
	this.loginname = loginname;
}
public String getImessage() {
	return imessage;
}
public void setImessage(String imessage) {
	this.imessage = imessage;
}

public String getSendtime() {
	return sendtime;
}
public void setSendtime(String sendtime) {
	this.sendtime = sendtime;
}
public int getStatus() {
	return status;
}
public void setStatus(int status) {
	this.status = status;
}
  
}
