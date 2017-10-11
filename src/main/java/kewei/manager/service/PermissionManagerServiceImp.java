package kewei.manager.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kewei.manager.bean.Permission;
import kewei.manager.bean.User;
import kewei.manager.mapper.PermissionManagerMapper;
import kewei.manager.mapper.UserManagerMapper;

@Service
public class PermissionManagerServiceImp implements PermissionManagerServiceInf{
@Autowired
PermissionManagerMapper permissionManagerMapper;

@Override
public List<Permission> queryAll() {
	return permissionManagerMapper.queryAll();
}

@Override
public List<Permission> queryUserPermissions(int userid) {
	return permissionManagerMapper.queryUserPermissions(userid);
}

}
