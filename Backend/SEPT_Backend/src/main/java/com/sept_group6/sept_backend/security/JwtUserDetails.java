package com.sept_group6.sept_backend.security;

import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.GrantedAuthority;

import java.util.Collection;

import com.sept_group6.sept_backend.model.User;

public class JwtUserDetails implements UserDetails {
    private User user;
    private Collection<? extends GrantedAuthority> authorities;

    /*
     * UserDetails interface methods
     */

    public JwtUserDetails(User user) {
        this.user = user;
    }

    // public JwtUserDetails(User user) {
    // super(user.getById(), )
    // List<GrantedAuthority> grantedAuthorities = new ArrayList<>();
    // grantedAuthorities.add(new SimpleGrantedAuthority(role));
    // this.authorities = grantedAuthorities;
    // }

    public User getUser() {
        return user;
    }

    @Override
    public Collection<? extends GrantedAuthority> getAuthorities() {
        return authorities;
    }

    @Override
    public String getPassword() {
        return user.getPassword();
    }

    @Override
    public String getUsername() {
        return user.getEmail();
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
