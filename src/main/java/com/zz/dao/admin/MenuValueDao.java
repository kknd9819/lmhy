package com.zz.dao.admin;



import com.zz.model.admin.MenuValue;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

/**
 * 菜单值持久层接口
 * @Date 2014-12-30
 * @author 欧志辉
 * @version 1.0
 */
public interface MenuValueDao extends JpaRepository<MenuValue,Long> {
	
	/**
	 * 根据菜单值的名称查找菜单值
	 * @param id 菜单权限主键
	 * @param vName 菜单权限值(忽略大小写)
	 * @return 名称是否存在
	 */
	 List<MenuValue> nameExists(Long id, String vName);
	
	/**
	 * 批量删除
	 * @param menuValues
	 */
	 void batchDelete(List<MenuValue> menuValues);
}