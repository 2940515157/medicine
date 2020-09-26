package com.weikang.dao;

import com.weikang.vo.Back;

import java.util.List;

public interface BackDao {
    public List<Back> fenYe(Back back);

    public int fenYeCount(Back back);

    //添加
    public int add(Back back);

    //修改
    public int update(Back back);

    //修改
    public int update2(int id);
    public int update3(int id);
    public int update4(int id);

    //根据id删
    public int delete(int[] ids);

    //根据id查
    public Back queryById(int id);

}
