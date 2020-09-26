package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.InventoryDao;
import com.weikang.service.InventoryService;
import com.weikang.vo.Inventory;
import com.weikang.vo.Medicine;
import com.weikang.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class InventoryServiceImpl implements InventoryService {
    @Autowired
    InventoryDao dao;

    @Override
    public PageVo<Inventory> fenYe(Inventory inventory, int page, int rows) {
        PageVo<Inventory> pageVo=new PageVo<>();
        PageHelper.startPage(page,rows);
        pageVo.setRows(dao.fenYe(inventory));
        pageVo.setTotal(dao.fenYeCount(inventory));
        return pageVo;
    }

    @Override
    public PageVo<Medicine> addfenYe(Medicine medicine, int page, int rows) {
        PageVo<Medicine> pageVo=new PageVo<>();
        PageHelper.startPage(page,rows);
        pageVo.setRows(dao.addfenYe(medicine));
        pageVo.setTotal(dao.addfenYeCount(medicine));
        return pageVo;
    }

    @Override
    public int add(Inventory inventory) {
        return dao.add(inventory);
    }

    @Override
    public int update(Inventory inventory) {
        return dao.update(inventory);
    }

    @Override
    public int delete(int[] id) {
        return dao.delete(id);
    }

    @Override
    public Inventory queryById(int id) {
        return dao.queryById(id);
    }


}
