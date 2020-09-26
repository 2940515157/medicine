package com.weikang.controller;

import com.alibaba.fastjson.JSONObject;
import com.weikang.service.InventoryService;
import com.weikang.vo.Inventory;
import com.weikang.vo.Medicine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/Inventory")
public class InventoryController {
    @Autowired
    InventoryService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public String fenYe(Inventory inventory,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "rows", defaultValue = "10") int rows) {
        return JSONObject.toJSONString(service.fenYe(inventory, page, rows));
    }

    @RequestMapping("/addfenYe.action")
    @ResponseBody
    public String addfenYe(Medicine medicine,
                           @RequestParam(value = "page", defaultValue = "1") int page,
                           @RequestParam(value = "rows", defaultValue = "10") int rows) {
        return JSONObject.toJSONString(service.addfenYe(medicine, page, rows));
    }

    //根据id查
    @RequestMapping("/queryById.action")
    @ResponseBody
    public String queryById(int inventoryId) {
        return JSONObject.toJSONString(service.queryById(inventoryId));
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public boolean add(Inventory inventory) {
        int num = service.add(inventory);
        return num > 0;
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update(Inventory inventory) {
        int num = service.update(inventory);
        return num > 0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete(@RequestBody int[] inventoryId) {
        int num = service.delete(inventoryId);
        return num > 0;
    }
}
