package com.weikang.dao;

import com.weikang.vo.Inventory;
import com.weikang.vo.Medicine;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface InventoryDao {
    public List<Inventory> fenYe(Inventory inventory);

    public List<Medicine> addfenYe(Medicine medicine);

    public int fenYeCount(Inventory inventory);

    public int addfenYeCount(Medicine medicine);

    //添加
    public int add(Inventory inventory);

    //修改
    public int update(Inventory inventory);

    //根据id删
    public int delete(int[] id);

    //根据id查
    public Inventory queryById(int id);

    //根据id查
    public Inventory queryByIdGoodsId(int id);

}
