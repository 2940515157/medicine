package com.weikang.dao;

import com.weikang.vo.Finance;

import java.util.List;

public interface FinanceDao {
    public List<Finance> fenYe(Finance finance);

    public int fenYeCount(Finance finance);

    public int add(Finance finance);
}
