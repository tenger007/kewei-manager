package kewei.manager.bean;

import java.util.ArrayList;
import java.util.List;

public class Menu {
	private Long id;	
	
	private String name;
	
	private Long jsdid;
	
	private Long fid;
	
	private List<Menu> children=new ArrayList<Menu>();
	
	private boolean open = true;
	
	private boolean checked = false;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Long getJsdid() {
		return jsdid;
	}

	public void setJsdid(Long jsdid) {
		this.jsdid = jsdid;
	}

	public Long getFid() {
		return fid;
	}

	public void setFid(Long fid) {
		this.fid = fid;
	}

	public List<Menu> getChildren() {
		return children;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

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
	
	
}
