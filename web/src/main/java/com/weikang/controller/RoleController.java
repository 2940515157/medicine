package com.weikang.controller;

import com.weikang.service.RoleService;
import com.weikang.vo.PageVo;
import com.weikang.vo.Role;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;


@Controller
@RequestMapping("/role")
public class RoleController {
    @Autowired
    RoleService roleService;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public PageVo<Role> fenYe(Role role,
                                  @RequestParam(value = "page",defaultValue = "1") int page,
                                  @RequestParam(value = "rows",defaultValue = "10") int rows){
        return roleService.fenYe(role,page,rows);
    }

    //查所有
    @RequestMapping("/queryById.action")
    @ResponseBody
    public Role queryById(Integer roleId){
        return roleService.queryById(roleId);
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public boolean add (Role role){
        int num = roleService.add(role);
        return num>0;
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update (Role role){
        int num = roleService.update(role);
        return num>0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete (Integer roleId){
        int num = roleService.delete(roleId);
        return num>0;
    }
    //根据用户查角色
    @RequestMapping("/queryByUserId.action")
    @ResponseBody
    public List<Role> queryByUserId(int userId){
        return roleService.queryByUserId(userId);
    }

    //用户添加角色
    @RequestMapping("/userAddRole.action")
    @ResponseBody
    public boolean userAddRole(int userId,String roleIds){
        return roleService.userAddRole(userId,roleIds);
    }
}
