package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.*;
import com.weikang.service.SellService;
import com.weikang.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;

@Service
public class SellServiceImpl implements SellService {
    @Autowired
    SellDao dao;
    @Autowired
    InventoryDao inventoryDao;
    @Autowired
    MedicineDao medicineDao;
    @Autowired
    SellReportDao sellReportDao;
    @Autowired
    FinanceDao financeDao;

    @Override
    public PageVo<Sell> fenYe(Sell sell, int page, int rows) {
        PageVo<Sell> pageVo = new PageVo<>();
        PageHelper.startPage(page, rows);
        pageVo.setRows(dao.fenYe(sell));
        pageVo.setTotal(dao.fenYeCount(sell));
        return pageVo;
    }

    @Override
    public int add(Sell sell) {
        Medicine medicine = medicineDao.queryById(sell.getMedicineId());
        Inventory inventory=inventoryDao.queryById(medicine.getInventoryId());
        if (sell.getQuantity()>inventory.getQuantity()){
            return -1;
        }
        dao.add(sell);
        return inventoryDao.update(inventory);
    }

    @Override
    public int update(Sell sell) {
        return dao.update(sell);
    }

    @Override
    public int update2(int id) {
        return dao.update2(id);
    }

    @Override
    public int update3(int id) {
        dao.update3(id);
        Sell sell=dao.queryById(id);
        //生产订单报表
        SellReport sellReport=new SellReport();

        sellReport.setSellId(sell.getSellId());
        sellReport.setTime(sell.getTime());
        BigDecimal bg = new BigDecimal(sell.getQuantity()*sell.getMedicine().getPrice()).setScale(2, RoundingMode.UP);
        sellReport.setSum(bg.doubleValue());
        sellReportDao.add(sellReport);

        //生成财务报表
        Finance finance=new Finance();
        finance.setRemark("销售");
        finance.setSum(bg.doubleValue());
        finance.setTime(sell.getTime());
        finance.setName(sell.getMedicine().getName());
        finance.setQuantity(sell.getQuantity());
        finance.setPrice(sell.getMedicine().getPrice());
        financeDao.add(finance);

        //售卖后更改仓库数量
        Medicine medicine = medicineDao.queryById(sell.getMedicineId());
        Inventory inventory=inventoryDao.queryById(medicine.getInventoryId());
        inventory.setQuantity(inventory.getQuantity()-sell.getQuantity());

        return inventoryDao.update(inventory);
    }

    @Override
    public int update4(int id) {
        return dao.update4(id);
    }

    @Override
    public int delete(int[] id) {
        return dao.delete(id);
    }

    @Override
    public Sell queryById(int id) {
        return dao.queryById(id);
    }

}
