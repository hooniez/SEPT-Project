package com.sept_group6.sept_backend.dao;

import com.sept_group6.sept_backend.model.User;
import com.sept_group6.sept_backend.model.Users;
import org.springframework.stereotype.Repository;

/* TODO：put interactions with user database here */
@Repository
public class UserDAO {

    // dummy number
    private static Users users = new Users();

    // dummy number
    private static Integer numberOfUsers = 0;

    public void addUser(User user) {
        users.addUser(user);
    }

    public Integer getNumOfUsers() {
        return numberOfUsers;
    }
}
