package com.weikang.service;

import com.weikang.vo.PageVo;
import com.weikang.vo.StockReport;

public interface StockReportService {
    //查分页
    PageVo<StockReport> fenYe(StockReport stockReport, int page, int rows);

    //添加
    public int add(StockReport stockReport);
}
