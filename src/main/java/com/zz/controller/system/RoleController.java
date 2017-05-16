package com.zz.controller.system;

import com.zz.controller.BaseController;
import com.zz.model.admin.Role;
import com.zz.model.basic.Message;
import com.zz.model.basic.Pageable;
import com.zz.service.admin.MenuService;
import com.zz.service.admin.RoleService;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

/**
 * 角色controller
 * @Date 2014-12-31
 * @author 欧志辉
 * @version 1.0
 */
@Controller("roleController")
@RequestMapping("/system/role")
public class RoleController extends BaseController {

	@Resource(name = "roleServiceImpl")
	private RoleService roleService;
	
	@Resource(name = "menuServiceImpl")
	private MenuService menuService;

	/**
	 * 分页查询角色管理列表
	 * @param pageable
	 * @param model
	 * @return String
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String list(Pageable pageable, ModelMap model) {
		Page<Role> page = roleService.findPage(pageable);
		model.addAttribute("page", page);
		model.addAttribute("pageable", pageable);
		return "/system/role/list";
	}
	
	/**
	 * 调整到新增角色页面
	 * @param model
	 * @return String
	 */
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(ModelMap model) {
		model.addAttribute("menus",menuService.generateTree(null));
		return "/system/role/add";
	}

	/**
	 * 新增角色
	 * @param role
	 * @param authorities
	 * @param redirectAttributes
	 * @return String
	 */
	@RequestMapping(value = "/save", method = RequestMethod.POST)
	public String save(Role role, String authorities, RedirectAttributes redirectAttributes) {
		
		role.setSystem(false);
		roleService.saveRole(role, authorities);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}

	/**
	 * 跳转到编辑角色页面
	 * @param id
	 * @param model
	 * @return String
	 */
	@RequestMapping(value = "/edit", method = RequestMethod.GET)
	public String edit(Long id, ModelMap model) {
		
		model.addAttribute("menus",menuService.generateTree(id));
		model.addAttribute("role", roleService.findOne(id));
		return "/system/role/edit";
	}

	/**
	 * 修改角色
	 * @param propertyRole
	 * @param authorities
	 * @param redirectAttributes
	 * @return String
	 */
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(Role propertyRole, String authorities, RedirectAttributes redirectAttributes) {
		
		Role role = roleService.findOne(propertyRole.getId());
		if (role == null || role.getSystem()) {
			return ERROR_VIEW;
		}
		role.setCode(propertyRole.getCode());
		role.setDescription(propertyRole.getDescription());
		role.setName(propertyRole.getName());
		roleService.updateRole(role, authorities);
		addFlashMessage(redirectAttributes, SUCCESS_MESSAGE);
		return "redirect:list.jhtml";
	}
	
	/**
	 * 删除角色
	 * @param ids
	 * @return
	 */
	@ResponseBody
	@RequestMapping(value = "/delete", method = RequestMethod.POST)
	public Message delete(Long[] ids) {
		List<Role> roles = new ArrayList<Role>();
		if (ids != null) {
			for (Long id : ids) {
				Role role = roleService.findOne(id);
				if (role != null && role.getSystem()) {
					return Message.error("{}角色不能被删除", role.getName());
				}
				roles.add(role);
			}
			roleService.batchDelete(roles);
		}
		return SUCCESS_MESSAGE;
	}

}