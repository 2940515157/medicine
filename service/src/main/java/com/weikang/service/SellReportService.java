package com.weikang.service;

import com.weikang.vo.PageVo;
import com.weikang.vo.SellReport;
import com.weikang.vo.StockReport;

public interface SellReportService {
    //查分页
    PageVo<SellReport> fenYe(SellReport sellReport, int page, int rows);

    //添加
    public int add(SellReport sellReport);
}
