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

    @ManyToMany
    private Role roles;

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

    public Role getRoles() {
        return roles;
    }

    public void setRoles(Role roles) {
        this.roles = roles;
    }
}
