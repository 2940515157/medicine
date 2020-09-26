package com.weikang.service;

import com.weikang.vo.Medicine;
import com.weikang.vo.PageVo;

public interface MedicineService {
    //查分页
    PageVo<Medicine> fenYe(Medicine medicine, int page, int rows);



    //添加
    public int add(Medicine medicine);

    //修改
    public int update(Medicine medicine);

    //根据id删
    public int delete(int[] id);

    //根据id查
    public Medicine queryById(int id);

}
