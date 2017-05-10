package com.zz.service.admin.impl;


import com.zz.dao.admin.AdminDao;
import com.zz.dao.admin.RoleDao;
import com.zz.model.admin.Admin;
import com.zz.model.admin.Authority;
import com.zz.model.admin.Role;
import com.zz.model.basic.Page;
import com.zz.model.basic.Pageable;
import com.zz.service.admin.AdminService;
import com.zz.util.shengyuan.StringUtil;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.persistence.criteria.Predicate;
import java.util.*;

import static antlr.build.ANTLR.root;

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
		Role role = admin.getRole();
		List<Authority> list = role.getAuthorities();
		for (Authority authority:list) {
			authorities.add(authority.getName());
		}
		return authorities;
	}


	@Override
	public Long saveAdmin(Admin admin, Long roleId) {
		admin.setCreateDate(new Date());
		admin.setModifyDate(new Date());
		Role role = roleDao.findOne(roleId);
		admin.setRole(role);
		Admin save = adminDao.save(admin);
		return save.getId();
	}

	@Override
	public void updateAdmin(Admin admin, Long roleId) {
		admin.setModifyDate(new Date());
		Role role = roleDao.findOne(roleId);
		if(role != null){
			admin.setRole(role);
		}
		adminDao.saveAndFlush(admin);

	}


	@Override
	public Page<Admin> findPage(Pageable pageable) {
		int pageSize = pageable.getPageSize();
		int pageNo = pageable.getPageNumber();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if (!StringUtil.isEmpty(pageable.getSearchValue())) {
			paramMap.put(pageable.getSearchProperty(), pageable.getSearchValue());
		}
		return adminDao.findAll(new PageRequest(pageSize,pageNo),(root,query,cb) -> {
			// 查询条件
			List<Predicate> predicates = new ArrayList<>();

		},pageable);
	}

}