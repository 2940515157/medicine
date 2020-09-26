package com.weikang.dao;

import com.weikang.vo.Goods;

import java.util.List;

public interface GoodsDao {
    public List<Goods> fenYe(Goods goods);

    public int fenYeCount(Goods goods);

    //添加
    public int add(Goods goods);

    //修改
    public int update(Goods goods);

    //根据id删
    public int delete(int[] ids);

    //根据id查
    public Goods queryById(int id);

}
