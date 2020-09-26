package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.*;
import com.weikang.service.BackService;
import com.weikang.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;

@Service
public class BackServiceImpl implements BackService {
    @Autowired
    BackDao dao;
    @Autowired
    InventoryDao inventoryDao;
    @Autowired
    BackReportDao backReportDao;
    @Autowired
    MedicineDao medicineDao;
    @Autowired
    FinanceDao financeDao;

    @Override
    public PageVo<Back> fenYe(Back back, int page, int rows) {
        PageVo<Back> pageVo = new PageVo<>();
        PageHelper.startPage(page, rows);
        pageVo.setRows(dao.fenYe(back));
        pageVo.setTotal(dao.fenYeCount(back));
        return pageVo;
    }

    @Override
    public int add(Back back) {
        Medicine medicine = medicineDao.queryById(back.getMedicineId());
        Inventory inventory = inventoryDao.queryById(medicine.getInventoryId());
        if (back.getType()==1){

        if (back.getQuantity()>inventory.getQuantity()){
            return -1;
        }
            inventory.setQuantity(inventory.getQuantity() - back.getQuantity());
            inventoryDao.update(inventory);
        }

        return dao.add(back);
    }

    @Override
    public int update(Back back) {

        if (back.getType()==2){
            Medicine medicine = medicineDao.queryById(back.getMedicineId());
            Inventory inventory = inventoryDao.queryById(medicine.getInventoryId());
            inventory.setQuantity(inventory.getQuantity() + back.getQuantity());
            inventoryDao.update(inventory);
        }
        return dao.update(back);
    }

    @Override
    public int update2(int id) {
        Back back=dao.queryById(id);
        Inventory inventory = inventoryDao.queryByIdGoodsId(back.getMedicine().getInventory().getStock().getGoodsId());
        if (back.getType()==1){
            inventory.setQuantity(inventory.getQuantity() - back.getQuantity());
            inventoryDao.update(inventory);
        }
        return dao.update2(id);
    }

    @Override
    public int update3(int id) {
        dao.update3(id);
        Back back=dao.queryById(id);
        Inventory inventory = inventoryDao.queryByIdGoodsId(back.getMedicine().getInventory().getStock().getGoodsId());
        if (back.getType()==1){
            //公司退货
            //生成订单报表
            BackReport backReport=new BackReport();

            backReport.setBackId(back.getBackId());
            backReport.setTime(back.getTime());
            BigDecimal bg = new BigDecimal(back.getQuantity()*back.getMedicine().getInventory().getStock().getGoods().getPrice()).setScale(2, RoundingMode.UP);
            backReport.setSum(bg.doubleValue());
            backReportDao.add(backReport);

            //生成财务报表
            Finance finance=new Finance();
            finance.setRemark("公司退货");
            finance.setSum(bg.doubleValue());
            finance.setTime(back.getTime());
            finance.setName(back.getMedicine().getName());
            finance.setQuantity(back.getQuantity());
            finance.setPrice(back.getMedicine().getInventory().getStock().getGoods().getPrice());
            financeDao.add(finance);

        }else {     //客户退货
            inventory.setQuantity(inventory.getQuantity() + back.getQuantity());

            //生成订单报表
            BackReport backReport=new BackReport();

            backReport.setBackId(back.getBackId());
            backReport.setTime(back.getTime());
            BigDecimal bg = new BigDecimal(back.getQuantity()*back.getMedicine().getPrice()*-1).setScale(2, RoundingMode.UP);

            backReport.setSum(bg.doubleValue());
            backReportDao.add(backReport);

            //生成财务报表
            Finance finance=new Finance();
            finance.setRemark("客户退货");
            finance.setSum(bg.doubleValue());
            finance.setTime(back.getTime());
            finance.setName(back.getMedicine().getName());
            finance.setQuantity(back.getQuantity());
            finance.setPrice(back.getMedicine().getPrice());
            financeDao.add(finance);
        }
        return inventoryDao.update(inventory);
    }

    @Override
    public int update4(int id) {
        Back back=dao.queryById(id);
        Inventory inventory = inventoryDao.queryByIdGoodsId(back.getMedicine().getInventory().getStock().getGoodsId());
        if (back.getType()==1){
            inventory.setQuantity(inventory.getQuantity() + back.getQuantity());
            inventoryDao.update(inventory);
        }
        return dao.update4(id);
    }

    @Override
    public int delete(int[] id) {
        return dao.delete(id);
    }

    @Override
    public Back queryById(int id) {
        return dao.queryById(id);
    }

}
