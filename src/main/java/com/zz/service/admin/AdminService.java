package com.zz.service.admin;



import com.zz.model.admin.Admin;
import com.zz.model.basic.Page;
import com.zz.model.basic.Pageable;

import java.util.List;


public interface AdminService {

	/**
	 * 判断用户名是否存在
	 * @param username 用户名(忽略大小写)
	 * @return 用户名是否存在
	 */
	 boolean usernameExists(String username);

	/**
	 * 根据用户名查找管理员
	 * @param username 用户名(忽略大小写)
	 * @return 管理员，若不存在则返回null
	 */
	 Admin findByUsername(String username);

	/**
	 * 根据ID查找权限
	 * @param id ID
	 * @return 权限,若不存在则返回null
	 */
	 List<String> findAuthorities(Long id);

	
	/**
	 * 新增后台管理员
	 * @param admin 后台管理员实体
	 * @param roleId 角色主键数组
	 * @return Long 保存实体的主键
	 */
	 Long saveAdmin(Admin admin, Long roleId);

	/**
	 * 新增后台管理员
	 * @param admin 后台管理员实体
	 * @param roleId 角色主键数组
	 */
	 void updateAdmin(Admin admin, Long roleId);

	
	/**
	 * 分页查找所有的后台管理员
	 * @param pageable
	 * @return Page<Admin>
	 */
	 Page<Admin> findPage(Pageable pageable);
}