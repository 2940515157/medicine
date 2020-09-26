package com.weikang.vo;

public class Supplier {
    private Integer supplierId;
    private String name;
    private String tel;
    private String address;

    public Supplier() {
    }

    public Supplier(Integer supplierId, String name, String tel, String address) {
        this.supplierId = supplierId;
        this.name = name;
        this.tel = tel;
        this.address = address;
    }

    public Integer getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTel() {
        return tel;
    }

    public void setTel(String tel) {
        this.tel = tel;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }
}
