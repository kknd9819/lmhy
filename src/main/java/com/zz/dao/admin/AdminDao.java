package com.zz.dao.admin;


import com.zz.model.admin.Admin;
import com.zz.model.basic.Page;
import com.zz.model.basic.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * 后台管理员持久层接口
 * @Date 2014-12-29
 * @author 欧志辉
 * @version 1.0
 */
public interface AdminDao extends JpaRepository<Admin, Long>,JpaSpecificationExecutor<Admin> {
	
	/**
	 * 根据用户名查找管理员
	 * @param username 用户名(忽略大小写)
	 * @return List<Admin>
	 */
	 @Query(value = "select a from Admin a where a.username = ?1")
	 List<Admin> findAdminListByUsername( String username);

	 Admin findByUsername(String username);



}