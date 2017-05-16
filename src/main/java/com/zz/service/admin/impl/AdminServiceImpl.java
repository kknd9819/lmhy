package com.zz.service.admin.impl;


import com.zz.dao.admin.AdminDao;
import com.zz.dao.admin.RoleDao;
import com.zz.model.admin.Admin;
import com.zz.model.admin.Authority;
import com.zz.model.admin.Role;
import com.zz.model.basic.Pageable;
import com.zz.service.admin.AdminService;
import com.zz.util.shengyuan.StringUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.persistence.criteria.Predicate;
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

	@Resource(name = "roleDao")
	private RoleDao roleDao;

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
		Set<Role> roles = admin.getRole();
		for(Role role : roles){
			List<Authority> authorities1 = role.getAuthorities();
			for(Authority authority : authorities1){
				String authorityName = authority.getName();
				authorities.add(authorityName);
			}
		}
		return authorities;
	}


	@Override
	public Long saveAdmin(Admin admin, Long[] roleId) {
		admin.setCreateDate(new Date());
		admin.setModifyDate(new Date());
		Set<Role> roles = roleDao.findRoles(roleId);
		admin.setRole(roles);
		Admin save = adminDao.save(admin);
		return save.getId();
	}

	@Override
	public void updateAdmin(Admin admin, Long[] roleId) {
		admin.setModifyDate(new Date());
		Set<Role> roles  = roleDao.findRoles(roleId);
		if(roles != null){
			admin.setRole(roles);
		}
		adminDao.saveAndFlush(admin);

	}


	@Override
	public Page<Admin> findPage(Pageable pageable) {
		int pageSize = pageable.getPageSize();
		int pageNo = pageable.getPageNumber();
		PageRequest pageRequest = new PageRequest(pageNo,pageSize);
		return adminDao.findAll((root, query, cb) -> {

			List<Predicate> predicates = new ArrayList<>();
			if (StringUtil.isNotBlank(pageable.getSearchProperty()) && StringUtil.isNotBlank(pageable.getSearchValue())) {
				predicates.add(cb.like(root.get(pageable.getSearchProperty()).as(String.class), "%" + pageable.getSearchValue() + "%"));
			}
			query.where(predicates.toArray(new Predicate[predicates.size()]));
			return null;
		}, pageRequest);

	}

	@Override
	public Admin findOne(Long id) {
		return adminDao.findOne(id);
	}

	@Override
	public List<Admin> findAll() {
		return adminDao.findAll();
	}

	@Override
	public void batchDelete(List<Admin> admins) {
		adminDao.delete(admins);
	}

}