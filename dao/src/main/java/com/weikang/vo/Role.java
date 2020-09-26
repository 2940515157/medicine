package com.weikang.vo;

import java.util.List;

public class Role {
    private Integer roleId;
    private String name;
    private String remark;
    private List<MenuInfo> menus;
    private boolean checked;

    public Role() {
    }
    public Role(Integer roleId, String name, String remark) {
        this.roleId = roleId;
        this.name = name;
        this.remark = remark;
    }

    public Integer getRoleId() {
        return roleId;
    }

    public void setRoleId(Integer roleId) {
        this.roleId = roleId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public List<MenuInfo> getMenus() {
        return menus;
    }

    public void setMenus(List<MenuInfo> menus) {
        this.menus = menus;
    }

    public boolean isChecked() {
        return checked;
    }

    public void setChecked(boolean checked) {
        this.checked = checked;
    }
}
