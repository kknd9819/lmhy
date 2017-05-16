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

    @OneToOne(fetch = FetchType.EAGER,cascade = {CascadeType.REFRESH})
    private Authority authority;

    private String vName;

    @OneToOne(mappedBy = "menuValue")
    private Menu menu;

    public String getvName() {
        return this.authority.getName();
    }

    public void setvName(String vName) {
        this.vName = vName;
    }

    public Menu getMenu() {
        return menu;
    }

    public void setMenu(Menu menu) {
        this.menu = menu;
    }

    public Authority getAuthority() {
        return authority;
    }

    public void setAuthority(Authority authority) {
        this.authority = authority;
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

}
