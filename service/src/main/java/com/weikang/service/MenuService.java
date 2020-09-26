package com.weikang.service;


import com.weikang.vo.MenuInfo;
import com.weikang.vo.PageVo;

import java.util.List;

public interface MenuService {
    //根据父id查询子菜单信息
    public List<MenuInfo> querymenuBypid(int pid);

    //根据角色id查权限
    public List<MenuInfo> queryMenuByRoleId(int roleId);

    //根据用户id查权限
    public List<MenuInfo> queryMenuByUserId(int userId,int pid);

    //根据角色id删除权限
    public int deleteByRoleId(int roleId);

    //添加权限
    public boolean addAuthority(int roleId,String menuIds);

    //查分页
    PageVo<MenuInfo> fenYe(MenuInfo menuInfo, int page, int rows);

    //添加
    public int add(MenuInfo menuInfo);

    //修改
    public int update(MenuInfo menuInfo);

    //根据id删
    public int delete(int id);

    //根据id查
    public MenuInfo queryById(int id);
}
