package com.weikang.controller;

import com.alibaba.fastjson.JSONObject;
import com.weikang.service.MedicineService;
import com.weikang.vo.Medicine;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/Medicine")
public class MedicineController {
    @Autowired
    MedicineService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public String fenYe(Medicine medicine,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "rows", defaultValue = "10") int rows) {
        return JSONObject.toJSONString(service.fenYe(medicine, page, rows));
    }

    //根据id查
    @RequestMapping("/queryById.action")
    @ResponseBody
    public String queryById(Integer medicineId) {
        return JSONObject.toJSONString(service.queryById(medicineId));
    }


    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public boolean add(Medicine medicine) {
        int num = service.add(medicine);
        return num > 0;
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update(Medicine medicine) {
        int num = service.update(medicine);
        return num > 0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete(@RequestBody int[] medicineId) {
        int num = service.delete(medicineId);
        return num > 0;
    }
}
