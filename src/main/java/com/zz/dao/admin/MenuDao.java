package com.zz.dao.admin;



import com.zz.model.admin.Menu;
import org.springframework.data.domain.Page;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 后台管理员持久层接口
 * @Date 2014-12-29
 * @author 欧志辉
 * @version 1.0
 */
public interface MenuDao extends JpaRepository<Menu,Long> {
	
	/**
	 * 查找顶级菜单
	 * @return 顶级菜单
	 */
	 @Query("select m from Menu m where m.parent is null order by orders")
	 List<Menu> findRoots();
	
	/**
	 * 查询一级菜单列表
	 * @param pageNo 页码
	 * @param pageSize 页记录数
	 * @return 分页对象
	 */
	 @Query("select m from Menu m where m.parent is null order by orders")
	 Page<Menu> findRootsForPage(int pageNo, int pageSize);
	
	/**
	 * 查找下级菜单
	 * @param parentId 上级菜单ID
	 * @return List<MenuMenuValue> 下级菜单菜单权限值关联关系
	 */
	 @Query("select m from Menu m where m.parent = ?1")
	 List<Menu> findChildren(Long parentId);
	
	/**
	 * 查找下级菜单
	 * @param parentId 上级菜单ID
	 * @return List<Menu> 下级菜单
	 */
	 @Query("select m from Menu m where m.parent = ?1")
	 List<Menu> findChildrenMenu(Long parentId);
	
	/**
	 * 根据菜单权限值ID查找菜单
	 * @param menuValueId 菜单权限值ID
	 * @return 下级菜单
	 */
	 @Query("select m from Menu m where m.menuValue = ?1")
	 List<Menu> findMenuByMenuValueId(Long menuValueId);
	
	/**
	 * 查找所有的菜单菜单值关联关系
	 * @return List<MenuMenuValue>
	 */
	 @Query("select m from Menu m")
	 List<Menu> getAllMenuMenuValue();
}