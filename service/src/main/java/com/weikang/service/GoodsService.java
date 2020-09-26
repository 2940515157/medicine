package com.weikang.service;

import com.weikang.vo.Goods;
import com.weikang.vo.PageVo;

public interface GoodsService {
    //查分页
    PageVo<Goods> fenYe(Goods goods, int page, int rows);

    //添加
    public int add(Goods goods);

    //修改
    public int update(Goods goods);

    //根据id删
    public int delete(int[] id);

    //根据id查
    public Goods queryById(int id);

}
