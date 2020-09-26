package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.SupplierDao;
import com.weikang.service.SupplierService;
import com.weikang.vo.PageVo;
import com.weikang.vo.Supplier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SupplierServiceImpl implements SupplierService {
    @Autowired
    SupplierDao dao;

    @Override
    public PageVo<Supplier> fenYe(Supplier supplier, int page, int rows) {
        PageVo<Supplier> pageVo=new PageVo<>();
        PageHelper.startPage(page,rows);
        pageVo.setRows(dao.fenYe(supplier));
        pageVo.setTotal(dao.fenYeCount(supplier));
        return pageVo;
    }

    @Override
    public int add(Supplier supplier) {
        return dao.add(supplier);
    }

    @Override
    public int update(Supplier supplier) {
        return dao.update(supplier);
    }

    @Override
    public int delete(int id) {
        return dao.delete(id);
    }

    @Override
    public Supplier queryById(int id) {
        return dao.queryById(id);
    }

}
