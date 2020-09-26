package com.weikang.dao;

import com.weikang.vo.MenuInfo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuDao {

    //根据父id查询子菜单信息
    public List<MenuInfo> querymenuBypid(int pid);

    public List<MenuInfo> fenYe(MenuInfo menuInfo);

    public int fenYeCount(MenuInfo menuInfo);

    //添加
    public int add(MenuInfo menuInfo);

    //修改
    public int update(MenuInfo menuInfo);

    //根据id删
    public int delete(int id);

    //根据id查
    public MenuInfo queryById(int id);

    //根据角色id，查询到拥有权限的所有菜单信息
    public List<MenuInfo> queryMenuByRoleId(int roleId);

    //根据用户id，查询到拥有权限的所有菜单信息
    public List<MenuInfo> queryMenuByUserId(@Param("userId")int userId,@Param("pid")int pid);

    //根据角色id删除权限
    public int deleteByRoleId(int roleId);

    //添加权限
    public int addAuthority(@Param("roleId") int roleId,@Param("menuId") int menuId);
}
