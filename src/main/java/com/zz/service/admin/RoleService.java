package com.zz.service.admin;


import com.zz.model.admin.Role;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Set;

/**
 * 角色服务层接口
 * @Date 2014-12-29
 * @author 欧志辉
 * @version 1.0
 */
public interface RoleService {
	/**
	 * 新增角色
	 * @param role 角色
	 * @param authorities 权限值数组
	 * @return Long 保存实体的主键
	 */
	public Long saveRole(Role role, String authorities);
	
	/**
	 * 新增角色
	 * @param role 角色
	 * @param authorities 权限值数组
	 */
	public void updateRole(Role role, String authorities);

	/**
	 * 批量删除角色
	 * @param roles
	 */
	public void batchDelete(List<Role> roles);
	
	/**
	 * 分页查找所有的角色
	 * @param pageable
	 * @return Page<Role>
	 */
	public Page<Role> findPage(Pageable pageable);
	
	/**
	 * 根据管理员ID查询管理员的角色ID
	 * @param adminId
	 * @return Set<Long>
	 */
	public Set<Long> getRoleIdsByAdminId(Long adminId);

	public List<Role> findRoleByAdminId(Long id);
	
}