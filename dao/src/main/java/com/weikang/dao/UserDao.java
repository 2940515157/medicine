package com.weikang.dao;

import com.weikang.vo.User;

import java.util.List;

public interface UserDao {
    public List<User> fenYe(User user);

    public int fenYeCount(User user);

    public List<User> queryByCategory();
    //添加
    public int add(User user);

    //修改
    public int update(User user);

    //根据id删
    public int delete(int userId);

    //根据id查
    public User queryById(int userId);

    //登录
    public User login(String username);
}
