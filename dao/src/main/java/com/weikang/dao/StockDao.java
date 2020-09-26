package com.weikang.dao;

import com.weikang.vo.Stock;

import java.util.List;

public interface StockDao {
    public List<Stock> fenYe(Stock stock);

    public int fenYeCount(Stock stock);

    //添加
    public int add(Stock stock);

    //修改
    public int update(Stock stock);

    //修改
    public int update2(int id);
    public int update3(int id);
    public int update4(int id);

    //根据id删
    public int delete(int[] ids);

    //根据id查
    public Stock queryById(int id);

}
