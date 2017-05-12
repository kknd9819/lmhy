package com.zz.model.admin;

import org.apache.commons.lang.StringUtils;

import javax.persistence.*;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by X-man on 2017/5/10.
 */
@Entity
@Table(name = "t_menu")
public class Menu implements Serializable {


    private static final long serialVersionUID = 299544619736055006L;

    /** 树路径分隔符 */
    public static final String TREE_PATH_SEPARATOR = ",";

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


    /** 层级 */
    private Integer grade;

    /**上级菜单ID*/
    private Long parent;

    /** 排序 */
    private Integer orders;

    /** 菜单值 */
    @OneToOne(cascade = {CascadeType.REFRESH},fetch = FetchType.EAGER)
    private MenuValue menuValue;

    public MenuValue getMenuValue() {
        return menuValue;
    }

    public void setMenuValue(MenuValue menuValue) {
        this.menuValue = menuValue;
    }

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

    /**
     * 获取树路径
     * @return 树路径
     */
    public List<Long> getTreePaths() {
        List<Long> treePaths = new ArrayList<Long>();
        String[] ids = StringUtils.split(getTreePath(), TREE_PATH_SEPARATOR);
        if (ids != null) {
            for (String id : ids) {
                treePaths.add(Long.valueOf(id));
            }
        }
        return treePaths;
    }
}
