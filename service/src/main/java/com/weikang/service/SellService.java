package com.weikang.service;

import com.weikang.vo.PageVo;
import com.weikang.vo.Sell;

public interface SellService {
    //查分页
    PageVo<Sell> fenYe(Sell stock, int page, int rows);

    //添加
    public int add(Sell sell);

    //修改
    public int update(Sell sell);
    public int update2(int id);
    public int update3(int id);
    public int update4(int id);

    //根据id删
    public int delete(int[] id);

    //根据id查
    public Sell queryById(int id);

}
