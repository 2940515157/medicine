package com.weikang.dao;

import com.weikang.vo.SellReport;

import java.util.List;

public interface SellReportDao {
    public List<SellReport> fenYe(SellReport sellReport);

    public int fenYeCount(SellReport sellReport);

    public int add(SellReport sellReport);
}
