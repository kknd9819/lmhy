package com.zz.service.admin.impl;


import com.zz.dao.admin.AdminDao;
import com.zz.model.admin.Admin;
import com.zz.model.admin.Authority;
import com.zz.model.admin.Role;
import com.zz.model.admin.vo.AdminRoleAuthority;
import com.zz.model.basic.Page;
import com.zz.model.basic.Pageable;
import com.zz.service.admin.AdminService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.security.auth.Subject;
import java.util.*;

/**
 * 后台管理员服务层实现
 * @Date 2014-12-29
 * @author 欧志辉
 * @version 1.0
 */
@Service("adminServiceImpl")
public class AdminServiceImpl implements AdminService {
	
	@Resource(name = "adminDao")
	private AdminDao adminDao;

	
	@Override
	public boolean usernameExists(String username) {
		List<Admin> list = adminDao.findByUsername(username);
		return list != null && list.size() > 0;
	}

	@Override
	public Admin findByUsername(String username) {
		List<Admin> list = adminDao.findByUsername(username);
		if (list == null || list.size() == 0) {
			return null;
		}
		return list.get(0);
	}

	@Override
	public List<String> findAuthorities(Long id) {
		Admin admin  = adminDao.findOne(id);
		List<String> authorities = new ArrayList<String>();
		Role role = admin.getRole();
		List<Authority> list = role.getAuthorities();
		for (Authority authority:list) {
			authorities.add(authority.getName());
		}
		return authorities;
	}


	@Override
	public Long saveAdmin(Admin admin, Long[] roleIds) {
		admin.setCreateDate(new Date());
		admin.setModifyDate(new Date());
		Long adminId = adminDao.save(admin);
		List<AdminRole> adminRoles = new ArrayList<AdminRole>();
		for (Long roleId : roleIds) {
			AdminRole adminRole = new AdminRole();
			adminRole.setAdminId(adminId);
			adminRole.setRoleId(roleId);
			adminRoles.add(adminRole);
		}
		adminRoleDao.batchSaveAdminRole(adminRoles);
		return adminId;
	}

	@Override
	public void updateAdmin(Admin admin, Long[] roleIds) {
		admin.setModifyDate(new Date());
		adminDao.update(admin);
		if (roleIds != null) {
			adminRoleDao.deleteByAdminId(admin.getId());
			List<AdminRole> adminRoles = new ArrayList<AdminRole>();
			for (Long roleId : roleIds) {
				AdminRole adminRole = new AdminRole();
				adminRole.setAdminId(admin.getId());
				adminRole.setRoleId(roleId);
				adminRoles.add(adminRole);
			}
			adminRoleDao.batchSaveAdminRole(adminRoles);
		}
	}

	@Override
	public void batchDelete(List<Admin> admins) {
		adminDao.batchDelete(admins);
	}

	@Override
	public Page<Admin> findPage(Pageable pageable) {
		return null;
	}

	@Override
	public Page<Admin> findPage(Pageable pageable) {
		int pageSize = pageable.getPageSize();
		int pageNo = pageable.getPageNumber();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if (!StringUtil.isEmpty(pageable.getSearchValue())) {
			paramMap.put(pageable.getSearchProperty(), pageable.getSearchValue());
		}
		return adminDao.queryForPage(pageSize, pageNo, paramMap);
	}

}