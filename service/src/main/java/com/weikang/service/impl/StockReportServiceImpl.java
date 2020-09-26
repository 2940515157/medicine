package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.StockReportDao;
import com.weikang.service.StockReportService;
import com.weikang.vo.PageVo;
import com.weikang.vo.StockReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class StockReportServiceImpl implements StockReportService {
    @Autowired
    StockReportDao dao;

    @Override
    public PageVo<StockReport> fenYe(StockReport stockReport, int page, int rows) {
        PageVo<StockReport> pageVo = new PageVo<>();
        PageHelper.startPage(page, rows);
        pageVo.setRows(dao.fenYe(stockReport));
        pageVo.setTotal(dao.fenYeCount(stockReport));
        return pageVo;
    }

    @Override
    public int add(StockReport stockReport) {
        return dao.add(stockReport);
    }

}
