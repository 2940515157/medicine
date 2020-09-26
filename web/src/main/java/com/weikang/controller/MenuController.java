package com.weikang.controller;

import com.weikang.service.MenuService;
import com.weikang.vo.MenuInfo;
import com.weikang.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/menu")
public class MenuController {

    @Autowired
    MenuService menuService;


    @RequestMapping("/query.action")
    @ResponseBody
    public List<MenuInfo> queryByPid(
            @RequestParam(value = "id",defaultValue = "0") int parentid){
        return  menuService.querymenuBypid(parentid);
    }

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public PageVo<MenuInfo> fenYe(MenuInfo menuInfo,
                                  @RequestParam(value = "page",defaultValue = "1") int page,
                                  @RequestParam(value = "rows",defaultValue = "10") int rows){
        return menuService.fenYe(menuInfo,page,rows);
    }

    //根据角色id查菜单
    @RequestMapping("/queryMenu2.action")
    @ResponseBody
    public List<MenuInfo> queryMenuByRoleId(
            @RequestParam(value = "roleId",defaultValue = "0") int roleId){
        return  menuService.queryMenuByRoleId(roleId);
    }

    //根据用户id查菜单
    @RequestMapping("/queryMenu3.action")
    @ResponseBody
    public List<MenuInfo> queryMenuByUserId(int userId,@RequestParam(value = "id",defaultValue = "0") int id){
        return  menuService.queryMenuByUserId(userId,id);
    }

    //根据id查
    @RequestMapping("/queryById.action")
    @ResponseBody
    public MenuInfo queryById(Integer id){
        return menuService.queryById(id);
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public boolean add (MenuInfo menuInfo){
        int num = menuService.add(menuInfo);
        return num>0;
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update (MenuInfo menuInfo){
        int num = menuService.update(menuInfo);
        return num>0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete (Integer id){
        int num = menuService.delete(id);
        return num>0;
    }

    //授权
    @RequestMapping("/addAuthority.action")
    @ResponseBody
    public boolean addAuthority(int roleId,String mids){
        return menuService.addAuthority(roleId,mids);
    }

}
