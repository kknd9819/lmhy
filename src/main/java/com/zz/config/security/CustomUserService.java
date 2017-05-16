package com.zz.config.security;

import com.zz.dao.admin.AdminDao;
import com.zz.model.admin.Admin;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Component;



@Component
public class CustomUserService implements UserDetailsService{

    @Autowired
    private AdminDao adminDao;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        Admin admin = adminDao.findByUsername(username);
        if(admin == null){
            throw new UsernameNotFoundException("用户名不存在");
        }

        return new SecurityUser(admin);
    }



}
