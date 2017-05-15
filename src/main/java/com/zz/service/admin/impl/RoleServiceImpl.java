package com.zz.service.admin.impl;


import com.zz.dao.admin.AuthorityDao;
import com.zz.dao.admin.RoleDao;
import com.zz.model.admin.Authority;
import com.zz.model.admin.Role;
import com.zz.service.admin.RoleService;
import com.zz.util.shengyuan.StringUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
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
	private AuthorityDao authorityDao;

	@Override
	public Long saveRole(Role role, String authorities) {
		role.setCreateDate(new Date());
		role.setModifyDate(new Date());
		Role save = roleDao.save(role);
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
		return save.getId();
	}

	@Override
	public void updateRole(Role role, String authorities) {
		role.setModifyDate(new Date());
		roleDao.update(role);
		roleAuthorityDao.deleteByRoleId(role.getId());
		List<RoleAuthority> roleAuthoritys = new ArrayList<RoleAuthority>();
		String[] arrayAuthority = authorities.split(",");
		for (String authority : arrayAuthority) {
			if (!StringUtil.isEmpty(authority)) {
				RoleAuthority roleAuthority = new RoleAuthority();
				roleAuthority.setRoleId(role.getId());
				roleAuthority.setAuthority(authority);
				roleAuthoritys.add(roleAuthority);
			}
		}
		roleAuthorityDao.batchSaveRoleAuthority(roleAuthoritys);
	}

	@Override
	public void batchDelete(List<Role> roles) {
		roleDao.batchDelete(roles);
	}


	@Override
	public Page<Role> findPage(Pageable pageable) {
		int pageSize = pageable.getPageSize();
		int pageNo = pageable.getPageNumber();
		Map<String, Object> paramMap = new HashMap<String, Object>();
		if (!StringUtil.isEmpty(pageable.getSearchValue())) {
			paramMap.put(pageable.getSearchProperty(), pageable.getSearchValue());
		}
		return roleDao.queryForPage(pageSize, pageNo, paramMap);
	}

	@Override
	public Set<Long> getRoleIdsByAdminId(Long adminId) {
		Set<Long> hasRoleIds = new HashSet<Long>();
		List<Role> hasRoles = roleDao.findRoleByAdminId(adminId);
		if (hasRoles != null) {
			for (Role role : hasRoles) {
				hasRoleIds.add(role.getId());
			}
		}
		return hasRoleIds;
	}

	@Override
	public List<Role> findRoleByAdminId(Long id) {
		return roleDao.findRoleByAdminId(id);
	}
	
}