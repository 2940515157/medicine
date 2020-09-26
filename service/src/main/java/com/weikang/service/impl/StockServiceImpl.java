package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.FinanceDao;
import com.weikang.dao.InventoryDao;
import com.weikang.dao.StockDao;
import com.weikang.dao.StockReportDao;
import com.weikang.service.StockService;
import com.weikang.vo.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.math.RoundingMode;

@Service
public class StockServiceImpl implements StockService {
    @Autowired
    StockDao dao;
    @Autowired
    StockReportDao stockReportDao;
    @Autowired
    InventoryDao inventoryDao;
    @Autowired
    FinanceDao financeDao;

    @Override
    public PageVo<Stock> fenYe(Stock stock, int page, int rows) {
        PageVo<Stock> pageVo = new PageVo<>();
        PageHelper.startPage(page, rows);
        pageVo.setRows(dao.fenYe(stock));
        pageVo.setTotal(dao.fenYeCount(stock));
        return pageVo;
    }

    @Override
    public int add(Stock stock) {
        return dao.add(stock);
    }

    @Override
    public int update(Stock stock) {
        return dao.update(stock);
    }

    @Override
    public int update2(int id) {
        return dao.update2(id);
    }

    @Override
    public int update3(int id) {
        dao.update3(id);
        //查询订单
        Stock stock = dao.queryById(id);
        //生产订单报表
        StockReport stockReport=new StockReport();

        stockReport.setStockId(stock.getStockId());
        stockReport.setTime(stock.getTime());

        BigDecimal bg = new BigDecimal(stock.getQuantity()*stock.getGoods().getPrice()*-1).setScale(2, RoundingMode.UP);
        
        stockReport.setSum(bg.doubleValue());

        stockReportDao.add(stockReport);

        //生成财务报表
        Finance finance=new Finance();
        finance.setRemark("进货");
        finance.setName(stock.getGoods().getName());
        finance.setQuantity(stock.getQuantity());
        finance.setPrice(stock.getGoods().getPrice());
        finance.setSum(stockReport.getSum());
        finance.setTime(stock.getTime());
        financeDao.add(finance);


        //判断仓库有没有这个药
        Inventory inventory = inventoryDao.queryByIdGoodsId(stock.getGoods().getGoodsId());
        if (inventory == null) {
            Inventory inventory1=new Inventory();
            inventory1.setStock(stock);
            inventory1.setStockId(stock.getStockId());
            inventory1.setName(stock.getGoods().getName());
            inventory1.setCategory(stock.getGoods().getCategory());
            inventory1.setQuantity(stock.getQuantity());
            return inventoryDao.add(inventory1);
        }
        inventory.setQuantity(inventory.getQuantity() + stock.getQuantity());
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
    public Stock queryById(int id) {
        return dao.queryById(id);
    }

}
