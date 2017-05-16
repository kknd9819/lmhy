package com.zz.service.admin.impl;


import com.zz.dao.admin.AdminDao;
import com.zz.dao.admin.AuthorityDao;
import com.zz.dao.admin.RoleDao;
import com.zz.model.admin.Admin;
import com.zz.model.admin.Authority;
import com.zz.model.admin.Role;
import com.zz.service.admin.RoleService;
import com.zz.util.shengyuan.StringUtil;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import com.zz.model.basic.Pageable;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.persistence.criteria.Predicate;
import java.util.*;


/**
 * 角色服务层实现
 * @Date 2014-12-29
 * @author 欧志辉
 * @version 1.0
 */
@Service("roleServiceImpl")
public class RoleServiceImpl implements RoleService {
	
	@Resource
	private RoleDao roleDao;

	@Resource
	private AdminDao adminDao;

	@Resource
	private AuthorityDao authorityDao;

	@Override
	public Long saveRole(Role role, String authorities) {
		role.setCreateDate(new Date());
		role.setModifyDate(new Date());
		List<Authority> authorityList = new ArrayList<Authority>();
		String[] arrayAuthority = authorities.split(",");
		for (String authority : arrayAuthority) {
			if (!StringUtil.isEmpty(authority)) {
				Authority authority1 = new Authority();
				authority1.setRole(role);
				authority1.setName(authority);
				authorityList.add(authority1);
			}
		}
		authorityDao.save(authorityList);
		Role save = roleDao.save(role);
		return save.getId();
	}

	@Override
	public void updateRole(Role role, String authorities) {
		role.setModifyDate(new Date());
		List<Authority> authorityList = new ArrayList<Authority>();
		String[] arrayAuthority = authorities.split(",");
		for (String authority : arrayAuthority) {
			if (!StringUtil.isEmpty(authority)) {
				Authority roleAuthority = new Authority();
				roleAuthority.setRole(role);
				roleAuthority.setName(authority);
				authorityList.add(roleAuthority);
			}
		}
		authorityDao.save(authorityList);
		roleDao.save(role);
	}

	@Override
	public List<Role> findAll() {
		return roleDao.findAll();
	}


	@Override
	public Page<Role> findPage(Pageable pageable) {
		int pageSize = pageable.getPageSize();
		int pageNo = pageable.getPageNumber();
		PageRequest pageRequest = new PageRequest(pageNo,pageSize);
		return roleDao.findAll((root,query,cb) -> {
			List<Predicate> predicates = new ArrayList<>();
			if (StringUtil.isNotBlank(pageable.getSearchProperty()) && StringUtil.isNotBlank(pageable.getSearchValue())) {
				predicates.add(cb.like(root.get(pageable.getSearchProperty()).as(String.class), "%" + pageable.getSearchValue() + "%"));
			}
			query.where(predicates.toArray(new Predicate[predicates.size()]));
			return null;
		},pageRequest);
	}

	@Override
	public Set<Long> findRoleIdsByAdminId(Long adminId) {
		Set<Long> longs = new HashSet<>();
		Admin one = adminDao.findOne(adminId);
		List<Admin> admins = new ArrayList<>();
		admins.add(one);
		Set<Role> roles = roleDao.findByAdmins(admins);
		if (roles != null) {
			for (Role role : roles) {
				longs.add(role.getId());
			}
		}
		return longs;
	}

	@Override
	public Set<Role> findRoleByAdminId(Long id) {
		Admin one = adminDao.findOne(id);
		List<Admin> admins = new ArrayList<>();
		admins.add(one);
		Set<Role> roles = roleDao.findByAdmins(admins);
		return roles;
	}
	
}