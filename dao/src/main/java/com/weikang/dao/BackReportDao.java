package com.weikang.dao;

import com.weikang.vo.BackReport;

import java.util.List;

public interface BackReportDao {
    public List<BackReport> fenYe(BackReport backReport);

    public int fenYeCount(BackReport backReport);

    public int add(BackReport backReport);
}
