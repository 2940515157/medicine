package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.SellReportDao;
import com.weikang.dao.StockReportDao;
import com.weikang.service.SellReportService;
import com.weikang.service.StockReportService;
import com.weikang.vo.PageVo;
import com.weikang.vo.SellReport;
import com.weikang.vo.StockReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SellReportServiceImpl implements SellReportService {
    @Autowired
    SellReportDao dao;

    @Override
    public PageVo<SellReport> fenYe(SellReport sellReport, int page, int rows) {
        PageVo<SellReport> pageVo = new PageVo<>();
        PageHelper.startPage(page, rows);
        pageVo.setRows(dao.fenYe(sellReport));
        pageVo.setTotal(dao.fenYeCount(sellReport));
        return pageVo;
    }

    @Override
    public int add(SellReport sellReport) {
        return dao.add(sellReport);
    }

}
