package com.zz.dao.admin;


import com.zz.model.admin.Role;
import org.springframework.data.jpa.repository.JpaRepository;


/**
 * 角色持久层接口
 * @Date 2014-12-29
 * @author 欧志辉
 * @version 1.0
 */
public interface RoleDao extends JpaRepository<Role, Long> {
	

}