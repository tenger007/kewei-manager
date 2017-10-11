package kewei.manager.bean;

import java.math.BigDecimal;

public class Company {
 private long id;
 private String jsdname;
 private String name;
 private double lat;
 private double lon;
 private String addr;
 private String intro;
 
public String getIntro() {
	return intro;
}
public void setIntro(String intro) {
	this.intro = intro;
}
public long getId() {
	return id;
}
public void setId(long id) {
	this.id = id;
}

public String getJsdname() {
	return jsdname;
}
public void setJsdname(String jsdname) {
	this.jsdname = jsdname;
}
public String getName() {
	return name;
}
public void setName(String name) {
	this.name = name;
}

public double getLat() {
	return lat;
}
public void setLat(double lat) {
	this.lat = lat;
}
public double getLon() {
	return lon;
}
public void setLon(double lon) {
	this.lon = lon;
}
public String getAddr() {
	return addr;
}
public void setAddr(String addr) {
	this.addr = addr;
}
 
 
 
}
