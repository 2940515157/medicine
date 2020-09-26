package com.weikang.dao;

import com.weikang.vo.Sell;
import com.weikang.vo.Stock;

import java.util.List;

public interface SellDao {
    public List<Sell> fenYe(Sell sell);

    public int fenYeCount(Sell sell);

    //添加
    public int add(Sell sell);

    //修改
    public int update(Sell sell);
    //修改
    public int update2(int id);
    public int update3(int id);
    public int update4(int id);

    //根据id删
    public int delete(int[] ids);

    //根据id查
    public Sell queryById(int id);

}
