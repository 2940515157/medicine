package com.weikang.dao;


import com.weikang.vo.Role;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface RoleDao {

    //分页
    public List<Role> fenYe(Role role);

    //数量
    public int fenYeCount(Role role);

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
    public int userAddRole(@Param("userId") int userId, @Param("roleId") int roleId);
}
