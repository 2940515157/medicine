package com.weikang.service;

import com.weikang.vo.PageVo;
import com.weikang.vo.Stock;

public interface StockService {
    //查分页
    PageVo<Stock> fenYe(Stock stock, int page, int rows);

    //添加
    public int add(Stock stock);

    //修改
    public int update(Stock stock);
    public int update2(int id);
    public int update3(int id);
    public int update4(int id);

    //根据id删
    public int delete(int[] id);

    //根据id查
    public Stock queryById(int id);

}
