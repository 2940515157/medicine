package com.weikang.service;

import com.weikang.vo.BackReport;
import com.weikang.vo.PageVo;
import com.weikang.vo.StockReport;

public interface BackReportService {
    //查分页
    PageVo<BackReport> fenYe(BackReport backReport, int page, int rows);

    //添加
    public int add(BackReport backReport);
}
