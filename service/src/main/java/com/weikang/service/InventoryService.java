package com.weikang.service;

import com.weikang.vo.Inventory;
import com.weikang.vo.Medicine;
import com.weikang.vo.PageVo;

public interface InventoryService {
    //查分页
    PageVo<Inventory> fenYe(Inventory inventory, int page, int rows);

    //查分页
    PageVo<Medicine> addfenYe(Medicine medicine, int page, int rows);

    //添加
    public int add(Inventory inventory);

    //修改
    public int update(Inventory inventory);

    //根据id删
    public int delete(int[] id);

    //根据id查
    public Inventory queryById(int id);


}
