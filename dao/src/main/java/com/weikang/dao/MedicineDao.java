package com.weikang.dao;

import com.weikang.vo.Medicine;

import java.util.List;

public interface MedicineDao {
    public List<Medicine> fenYe(Medicine medicine);

    public int fenYeCount(Medicine medicine);

    //添加
    public int add(Medicine medicine);

    //修改
    public int update(Medicine medicine);

    //根据id删
    public int delete(int[] ids);

    //根据id查
    public Medicine queryById(int id);


}
