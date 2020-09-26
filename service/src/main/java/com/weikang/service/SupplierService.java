package com.weikang.service;

import com.weikang.vo.PageVo;
import com.weikang.vo.Supplier;

public interface SupplierService {
    //查分页
    PageVo<Supplier> fenYe(Supplier supplier, int page, int rows);

    //添加
    public int add(Supplier supplier);

    //修改
    public int update(Supplier supplier);

    //根据id删
    public int delete(int id);

    //根据id查
    public Supplier queryById(int id);

}
