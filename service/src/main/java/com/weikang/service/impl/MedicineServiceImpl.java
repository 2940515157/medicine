package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.InventoryDao;
import com.weikang.dao.MedicineDao;
import com.weikang.service.MedicineService;
import com.weikang.vo.Inventory;
import com.weikang.vo.Medicine;
import com.weikang.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MedicineServiceImpl implements MedicineService {
    @Autowired
    MedicineDao dao;
    @Autowired
    InventoryDao inventoryDao;

    @Override
    public PageVo<Medicine> fenYe(Medicine medicine, int page, int rows) {
        PageVo<Medicine> pageVo=new PageVo<>();
        PageHelper.startPage(page,rows);
        pageVo.setRows(dao.fenYe(medicine));
        pageVo.setTotal(dao.fenYeCount(medicine));
        return pageVo;
    }

    @Override
    public int add(Medicine medicine) {
        Inventory inventory=inventoryDao.queryById(medicine.getInventoryId());
        medicine.setInventory(inventory);
        medicine.setName(inventory.getStock().getGoods().getName());
        medicine.setCategory(inventory.getStock().getGoods().getCategory());
        return dao.add(medicine);
    }

    @Override
    public int update(Medicine medicine) {
        return dao.update(medicine);
    }

    @Override
    public int delete(int[] id) {
        return dao.delete(id);
    }

    @Override
    public Medicine queryById(int id) {
        return dao.queryById(id);
    }


}
