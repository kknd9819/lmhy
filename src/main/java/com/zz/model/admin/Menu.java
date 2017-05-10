package com.zz.model.admin;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by X-man on 2017/5/10.
 */
@Entity
@Table(name = "t_menu")
public class Menu implements Serializable {


    private static final long serialVersionUID = 299544619736055006L;

    @Id
    @GeneratedValue
    private Long id;

    /** 创建日期 */
    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate;

    /** 修改日期 */
    @Column(nullable = false)
    @Temporal(TemporalType.TIMESTAMP)
    private Date modifyDate;

    /** 名称 */
    @Column(nullable = false)
    private String name;

    /** 全称 */
    @Column(nullable = false)
    private String fullName;

    /** 树路径 */
    private String treePath;

    /**权限值ID*/
    private Long menuValue;

    /** 层级 */
    private Integer grade;

    /**上级菜单ID*/
    private Long parent;

    /** 排序 */
    private Integer orders;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(Date modifyDate) {
        this.modifyDate = modifyDate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getTreePath() {
        return treePath;
    }

    public void setTreePath(String treePath) {
        this.treePath = treePath;
    }

    public Long getMenuValue() {
        return menuValue;
    }

    public void setMenuValue(Long menuValue) {
        this.menuValue = menuValue;
    }

    public Integer getGrade() {
        return grade;
    }

    public void setGrade(Integer grade) {
        this.grade = grade;
    }

    public Long getParent() {
        return parent;
    }

    public void setParent(Long parent) {
        this.parent = parent;
    }

    public Integer getOrders() {
        return orders;
    }

    public void setOrders(Integer orders) {
        this.orders = orders;
    }
}
