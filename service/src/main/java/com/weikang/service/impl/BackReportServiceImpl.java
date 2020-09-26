package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.BackReportDao;
import com.weikang.dao.SellReportDao;
import com.weikang.service.BackReportService;
import com.weikang.service.SellReportService;
import com.weikang.vo.BackReport;
import com.weikang.vo.PageVo;
import com.weikang.vo.SellReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class BackReportServiceImpl implements BackReportService {
    @Autowired
    BackReportDao dao;

    @Override
    public PageVo<BackReport> fenYe(BackReport backReport, int page, int rows) {
        PageVo<BackReport> pageVo = new PageVo<>();
        PageHelper.startPage(page, rows);
        pageVo.setRows(dao.fenYe(backReport));
        pageVo.setTotal(dao.fenYeCount(backReport));
        return pageVo;
    }

    @Override
    public int add(BackReport backReport) {
        return dao.add(backReport);
    }

}
