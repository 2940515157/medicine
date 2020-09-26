package com.weikang.controller;

import com.alibaba.fastjson.JSONObject;
import com.weikang.service.StockService;
import com.weikang.vo.Stock;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/Stock")
public class StockController {
    @Autowired
    StockService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public String fenYe(Stock stock,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "rows", defaultValue = "10") int rows) {
        return JSONObject.toJSONString(service.fenYe(stock, page, rows));
    }

    //根据id查
    @RequestMapping("/queryById.action")
    @ResponseBody
    public String queryById(int stockId) {
        return JSONObject.toJSONString(service.queryById(stockId));
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public boolean add(Stock stock) {
        int num = service.add(stock);
        return num > 0;
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update(Stock stock) {
        int num = service.update(stock);
        return num > 0;
    }

    //申请
    @RequestMapping("/shenqing.action")
    @ResponseBody
    public boolean update1(int stockId) {
        int num = service.update2(stockId);
        return num > 0;
    }
    //申请
    @RequestMapping("/pizhun.action")
    @ResponseBody
    public boolean update2(int stockId) {
        int num = service.update3(stockId);
        return num > 0;
    }
    //申请
    @RequestMapping("/bupi.action")
    @ResponseBody
    public boolean update3(int stockId) {
        int num = service.update4(stockId);
        return num > 0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete(@RequestBody int[] stockId) {
        int num = service.delete(stockId);
        return num > 0;
    }
}
