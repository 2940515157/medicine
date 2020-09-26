package com.weikang.service;

import com.weikang.vo.Back;
import com.weikang.vo.PageVo;

public interface BackService {
    //查分页
    PageVo<Back> fenYe(Back back, int page, int rows);

    //添加
    public int add(Back back);

    //修改
    public int update(Back back);
    public int update2(int id);
    public int update3(int id);
    public int update4(int id);

    //根据id删
    public int delete(int[] id);

    //根据id查
    public Back queryById(int id);

}
