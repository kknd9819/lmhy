package com.zz.model.admin;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by X-man on 2017/5/10.
 */
@Entity
@Table(name = "t_authority")
public class Authority implements Serializable{


    private static final long serialVersionUID = -1820740990712863351L;

    @Id
    @GeneratedValue
    private Long id;

    @Column(nullable = false)
    private String name;

    private Role role;

    @OneToOne
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

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Role getRole() {
        return role;
    }

    public void setRole(Role role) {
        this.role = role;
    }
}
