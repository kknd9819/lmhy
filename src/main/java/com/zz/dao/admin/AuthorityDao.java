package com.zz.dao.admin;

import com.zz.model.admin.Authority;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * Created by X-man on 2017/5/15.
 */
public interface AuthorityDao extends JpaRepository<Authority,Long> {


    Authority findByName(String vName);
}
