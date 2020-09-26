package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.MenuDao;
import com.weikang.service.MenuService;
import com.weikang.vo.MenuInfo;
import com.weikang.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class MenuServiceImpl implements MenuService {

    @Autowired
    MenuDao menuDao;

    @Override
    public List<MenuInfo> querymenuBypid(int pid) {
        //父菜单
        List<MenuInfo> menus =menuDao.querymenuBypid(pid);

        //将每个菜单查询到的url 组装到attributs属性中
        for (MenuInfo menuInfo: menus) {
                if(menuInfo.getUrl()!=null && menuInfo.getUrl()!=""){
                    menuInfo.getAttributes().put("url",menuInfo.getUrl());
                }
        }
        return menus ;
    }

    public List<MenuInfo> queryMenuByRoleId(int roleId) {
        //根据角色id，查询拥有权限的菜单集合
        List<MenuInfo> menu_priv=menuDao.queryMenuByRoleId(roleId);

        // 获取所有的父菜单
        List<MenuInfo> rootnodes =menuDao.querymenuBypid(0);
        //获取每个父菜单的子菜单集合
        for (MenuInfo rootmenu:rootnodes ) {
            List<MenuInfo> children = menuDao.querymenuBypid(rootmenu.getId());


            for (MenuInfo menuInfo: children) {
                //attributes.url
                if(menuInfo.getUrl()!=null && menuInfo.getUrl()!=""){
                    menuInfo.getAttributes().put("url",menuInfo.getUrl());
                }
                //checked   有权限  true
                for(MenuInfo menuInfo1: menu_priv){   //子菜单id  ==有权限菜单的id
                    if(menuInfo.getId() == menuInfo1.getId()){
                        menuInfo.setChecked(true);  //状态设置为true
                    }
                }
            }

            rootmenu.setChildren(children);
        }

        return rootnodes;
    }

    @Override
    public List<MenuInfo> queryMenuByUserId(int userId,int pid) {
        //父菜单
        List<MenuInfo> menus =menuDao.queryMenuByUserId(userId,pid);

        //将每个菜单查询到的url 组装到attributs属性中
        for (MenuInfo menuInfo: menus) {
            if(menuInfo.getUrl()!=null && menuInfo.getUrl()!=""){
                menuInfo.getAttributes().put("url",menuInfo.getUrl());
            }
        }
        return menus ;
    }

    @Override
    public int deleteByRoleId(int roleId) {
        return menuDao.deleteByRoleId(roleId);
    }

    @Override
    public boolean addAuthority(int roleId, String menuIds) {
            menuDao.deleteByRoleId(roleId);
            String[] menuId = menuIds.split(",");
            for (int i=0;i< menuId.length;i++){
                try {
                    menuDao.addAuthority(roleId,Integer.parseInt(menuId[i]));
                }catch (Exception e){
                    e.printStackTrace();
                }
            }
            return true;
    }

    @Override
    public PageVo<MenuInfo> fenYe(MenuInfo menuInfo, int page, int rows) {
        PageVo<MenuInfo> pageVo = new PageVo<>();
        PageHelper.startPage(page, rows);
        pageVo.setRows(menuDao.fenYe(menuInfo));
        pageVo.setTotal(menuDao.fenYeCount(menuInfo));
        return pageVo;
    }

    @Override
    public int add(MenuInfo menuInfo) {
        return menuDao.add(menuInfo);
    }

    @Override
    public int update(MenuInfo menuInfo) {
        return menuDao.update(menuInfo);
    }

    @Override
    public int delete(int id) {
        return menuDao.delete(id);
    }

    @Override
    public MenuInfo queryById(int id) {
        return menuDao.queryById(id);
    }

}
