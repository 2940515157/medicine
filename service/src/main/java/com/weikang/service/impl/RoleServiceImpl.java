package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.RoleDao;
import com.weikang.service.RoleService;
import com.weikang.vo.PageVo;
import com.weikang.vo.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    RoleDao roleDao;

    @Override
    public PageVo<Role> fenYe(Role role, int page, int rows) {
        PageVo<Role> pageVo = new PageVo<>();
        PageHelper.startPage(page, rows);
        pageVo.setRows(roleDao.fenYe(role));
        pageVo.setTotal(roleDao.fenYeCount(role));
        return pageVo;
    }

    @Override
    public int add(Role role) {
        return roleDao.add(role);
    }

    @Override
    public int update(Role role) {
        return roleDao.update(role);
    }

    @Override
    public int delete(int roleId) {
        return roleDao.delete(roleId);
    }

    @Override
    public Role queryById(int roleId) {
        return roleDao.queryById(roleId);
    }

    @Override
    public List<Role> queryByUserId(int userId) {
        List<Role> roleList=roleDao.fenYe(null);
        List<Role> roles=roleDao.queryByUserId(userId);
        for (Role role1:roleList) {
            for (Role role2 : roles) {
                if (role1.getRoleId()==role2.getRoleId())
                role1.setChecked(true);
            }
        }
        return roleList;
    }

    @Override
    public int deleteByUserId(int userId) {
        return roleDao.deleteByUserId(userId);
    }

    @Override
    public boolean userAddRole(int userId, String roleIds) {
            roleDao.deleteByUserId(userId);
            String[] roleId = roleIds.split(",");
            for (int i=0;i< roleId.length;i++){
                roleDao.userAddRole(userId,Integer.parseInt(roleId[i]));
            }
        return true;
    }
}
