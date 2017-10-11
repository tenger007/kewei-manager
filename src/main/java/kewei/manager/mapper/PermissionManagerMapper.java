package kewei.manager.mapper;


import java.util.List;

import kewei.manager.bean.Permission;
import kewei.manager.bean.User;

public interface PermissionManagerMapper {
	//查询所有的权限
	List<Permission> queryAll();
	
	//根据用户id查找用户权限
	List<Permission> queryUserPermissions(int userid);
}
