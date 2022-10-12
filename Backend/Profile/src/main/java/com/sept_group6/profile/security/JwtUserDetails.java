package com.sept_group6.profile.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

public class JwtUserDetails implements UserDetails {
    private Long uid;
    private String username;
    private String password;
    private String userType;
    private Collection<? extends GrantedAuthority> authorities;

    /*
     * UserDetails interface methods
     */

    // public JwtUserDetails(User user) {
    // this.user = user;
    // }

    public JwtUserDetails(Long uid, String username, String password, String userType) {
        this.uid = uid;
        this.username = username;
        this.password = password;
        this.userType = userType;
    }

    // public JwtUserDetails(User user) {
    // super(user.getById(), )
    // List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
    // grantedAuthorities.add(new SimpleGrantedAuthority(role));
    // this.authorities = grantedAuthorities;
    // }

    // public User getUser() {
    // return user;
    // }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public String getUsername() {

        return username;
    }

    public Long getUid() {

        return uid;
    }

    public String getUserType() {

        return userType;
    }

    @Override
    public boolean isAccountNonExpired() {
        return true;
    }

    @Override
    public boolean isAccountNonLocked() {
        return true;
    }

    @Override
    public boolean isCredentialsNonExpired() {
        return true;
    }

    @Override
    public boolean isEnabled() {
        return true;
    }

    // public JwtUserDetails(String username, String password, String role) {
    // this.username = username;
    // this.password = password;
    // List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
    // grantedAuthorities.add(new SimpleGrantedAuthority(role));
    // this.authorities = grantedAuthorities;
    // }

}
