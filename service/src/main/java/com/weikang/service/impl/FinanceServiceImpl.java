package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.FinanceDao;
import com.weikang.service.FinanceService;
import com.weikang.vo.Finance;
import com.weikang.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class FinanceServiceImpl implements FinanceService {
    @Autowired
    FinanceDao dao;

    @Override
    public PageVo<Finance> fenYe(Finance finance, int page, int rows) {
        PageVo<Finance> pageVo = new PageVo<>();
        PageHelper.startPage(page, rows);
        pageVo.setRows(dao.fenYe(finance));
        pageVo.setTotal(dao.fenYeCount(finance));
        return pageVo;
    }

    @Override
    public int add(Finance finance) {
        return dao.add(finance);
    }

}
