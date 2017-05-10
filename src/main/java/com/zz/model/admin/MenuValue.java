package com.zz.model.admin;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

/**
 * Created by X-man on 2017/5/10.
 */
@Entity
@Table(name = "t_menu_value")
public class MenuValue implements Serializable{


    private static final long serialVersionUID = -8367914545505099933L;

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

    /** 菜单权限值 */
    @Column(nullable = false)
    private String vName;

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

    public String getvName() {
        return vName;
    }

    public void setvName(String vName) {
        this.vName = vName;
    }
}
