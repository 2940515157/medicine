package com.weikang.service;

import com.weikang.vo.PageVo;
import com.weikang.vo.Role;

import java.util.List;

public interface RoleService {
    //查分页
    PageVo<Role> fenYe(Role role, int page, int rows);

    //添加
    public int add(Role role);

    //修改
    public int update(Role role);

    //根据id删
    public int delete(int roleId);

    //根据id查
    public Role queryById(int roleId);

    //根据用户id查
    public List<Role> queryByUserId(int userId);

    //根据用户id删除角色
    public int deleteByUserId(int userId);

    //用户添加角色
    public boolean userAddRole(int userId, String roleIds);
}
