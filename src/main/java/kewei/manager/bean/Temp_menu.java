package kewei.manager.bean;

import java.util.ArrayList;
import java.util.List;

public class Temp_menu {
    private long id;
    private String name;
    private Integer applyid;
    private long fid;
    private List<Temp_menu> children=new ArrayList<Temp_menu>();
private boolean open = true;
	private boolean checked = false;
	
	public boolean isOpen() {
		return open;
	}
	public void setOpen(boolean open) {
		this.open = open;
	}
	public boolean isChecked() {
		return checked;
	}
	public void setChecked(boolean checked) {
		this.checked = checked;
	}
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
	public long getFid() {
		return fid;
	}
	public void setFid(long fid) {
		this.fid = fid;
	}
	public List<Temp_menu> getChildren() {
		return children;
	}
	public void setChildren(List<Temp_menu> children) {
		this.children = children;
	}
	public Integer getApplyid() {
		return applyid;
	}
	public void setApplyid(Integer applyid) {
		this.applyid = applyid;
	}
	
    
	
}
