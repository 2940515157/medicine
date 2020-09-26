package com.weikang.service;

import com.weikang.vo.Finance;
import com.weikang.vo.PageVo;

public interface FinanceService {
    //查分页
    PageVo<Finance> fenYe(Finance finance, int page, int rows);

    //添加
    public int add(Finance finance);
}
