package com.weikang.controller;

import com.alibaba.fastjson.JSONObject;
import com.weikang.service.SellService;
import com.weikang.vo.Sell;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/Sell")
public class SellController {
    @Autowired
    SellService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public String fenYe(Sell sell,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "rows", defaultValue = "10") int rows) {
        return JSONObject.toJSONString(service.fenYe(sell, page, rows));
    }

    //根据id查
    @RequestMapping("/queryById.action")
    @ResponseBody
    public String queryById(int sellId) {
        return JSONObject.toJSONString(service.queryById(sellId));
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public int add(Sell sell) {
        return service.add(sell);
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update(Sell sell) {
        int num = service.update(sell);
        return num > 0;
    }
    //申请
    @RequestMapping("/shenqing.action")
    @ResponseBody
    public boolean update1(int sellId) {
        int num = service.update2(sellId);
        return num > 0;
    }
    //申请
    @RequestMapping("/pizhun.action")
    @ResponseBody
    public boolean update2(int sellId) {
        int num = service.update3(sellId);
        return num > 0;
    }
    //申请
    @RequestMapping("/bupi.action")
    @ResponseBody
    public boolean update3(int sellId) {
        int num = service.update4(sellId);
        return num > 0;
    }
    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete(@RequestBody int[] sellId) {
        int num = service.delete(sellId);
        return num > 0;
    }
}
