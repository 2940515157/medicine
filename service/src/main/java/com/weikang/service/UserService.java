package com.weikang.service;

import com.weikang.vo.PageVo;
import com.weikang.vo.User;

import java.util.List;

public interface UserService {
    //查分页
    PageVo<User> fenYe(User user, int page, int rows);

    public List<User> queryByCategory();

    //添加
    public int add(User user);

    //修改
    public int update(User user);

    //根据id删
    public int delete(int id);

    //根据id查
    public User queryById(int id);

    //登录
    public User login(String username);
}
