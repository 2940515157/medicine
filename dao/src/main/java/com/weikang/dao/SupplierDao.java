package com.weikang.dao;

import com.weikang.vo.Supplier;

import java.util.List;

public interface SupplierDao {
    public List<Supplier> fenYe(Supplier supplier);

    public int fenYeCount(Supplier supplier);

    //添加
    public int add(Supplier supplier);

    //修改
    public int update(Supplier supplier);

    //根据id删
    public int delete(int id);

    //根据id查
    public Supplier queryById(int id);

}
