package kewei.manager.service;

import java.util.List;
import java.util.Map;

import kewei.manager.bean.ArticleDto;
import kewei.manager.bean.Article_Jsd;
import kewei.manager.bean.Datas;
import kewei.manager.bean.Apply;
import kewei.manager.bean.Article;
import kewei.manager.bean.Page;
import kewei.manager.bean.Permission;
import kewei.manager.bean.User;

public interface PermissionManagerServiceInf {
	
	//查询所有的权限
		List<Permission> queryAll();
		
		//根据用户id查找用户权限
		List<Permission> queryUserPermissions(int userid);
}
