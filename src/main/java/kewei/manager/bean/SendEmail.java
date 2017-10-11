package kewei.manager.bean;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class SendEmail {
  private String imessages;
  private List<Integer> ids;
  private List<Integer> statuss;
  private MultipartFile file;
  private List<String> emails;
  private String title;
  private String subject;

  
public String getTitle() {
	return title;
}
public void setTitle(String title) {
	this.title = title;
}
public String getSubject() {
	return subject;
}
public void setSubject(String subject) {
	this.subject = subject;
}
public List<Integer> getStatuss() {
	return statuss;
}
public void setStatuss(List<Integer> statuss) {
	this.statuss = statuss;
}
public List<String> getEmails() {
	return emails;
}
public void setEmails(List<String> emails) {
	this.emails = emails;
}
public String getImessages() {
	return imessages;
}
public void setImessages(String imessages) {
	this.imessages = imessages;
}

public List<Integer> getIds() {
	return ids;
}
public void setIds(List<Integer> ids) {
	this.ids = ids;
}
public MultipartFile getFile() {
	return file;
}
public void setFile(MultipartFile file) {
	this.file = file;
}
  
  
}
