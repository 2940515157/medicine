package com.weikang.dao;

import com.weikang.vo.StockReport;

import java.util.List;

public interface StockReportDao {
    public List<StockReport> fenYe(StockReport stockReport);

    public int fenYeCount(StockReport stockReport);

    public int add(StockReport stockReport);
}
