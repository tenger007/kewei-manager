package kewei.manager.bean;

import java.util.Date;

public class Downloader_record {
 private int id;
 private String jsdname;
 private String channel_id;
 private String updatetime;
 private int size;
 private int this_size;
 
public int getThis_size() {
	return this_size;
}
public void setThis_size(int this_size) {
	this.this_size = this_size;
}
public int getId() {
	return id;
}
public void setId(int id) {
	this.id = id;
}
public String getJsdname() {
	return jsdname;
}
public void setJsdname(String jsdname) {
	this.jsdname = jsdname;
}
public String getChannel_id() {
	return channel_id;
}
public void setChannel_id(String channel_id) {
	this.channel_id = channel_id;
}

public String getUpdatetime() {
	return updatetime;
}
public void setUpdatetime(String updatetime) {
	this.updatetime = updatetime;
}
public int getSize() {
	return size;
}
public void setSize(int size) {
	this.size = size;
}
 
 
}
