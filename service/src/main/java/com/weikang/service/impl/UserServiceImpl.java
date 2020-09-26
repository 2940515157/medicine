package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.UserDao;
import com.weikang.service.UserService;
import com.weikang.vo.PageVo;
import com.weikang.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    UserDao userDao;

    @Override
    public PageVo<User> fenYe(User user, int page, int rows) {
        PageVo<User> pageVo=new PageVo<>();
        PageHelper.startPage(page,rows);
        pageVo.setRows(userDao.fenYe(user));
        pageVo.setTotal(userDao.fenYeCount(user));
        return pageVo;
    }

    @Override
    public List<User> queryByCategory() {
        return userDao.queryByCategory();
    }

    @Override
    public int add(User user) {
        return userDao.add(user);
    }

    @Override
    public int update(User user) {
        return userDao.update(user);
    }

    @Override
    public int delete(int id) {
        return userDao.delete(id);
    }

    @Override
    public User queryById(int id) {
        return userDao.queryById(id);
    }

    @Override
    public User login(String username) {
        return userDao.login(username);
    }
}
