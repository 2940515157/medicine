package com.weikang.controller;

import com.alibaba.fastjson.JSONObject;
import com.weikang.service.GoodsService;
import com.weikang.vo.Goods;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/goods")
public class GoodsController {
    @Autowired
    GoodsService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public String fenYe(Goods goods,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "rows", defaultValue = "10") int rows) {
        return JSONObject.toJSONString(service.fenYe(goods, page, rows));
    }

    //根据id查
    @RequestMapping("/queryById.action")
    @ResponseBody
    public String queryById(Integer goodsId) {
        return JSONObject.toJSONString(service.queryById(goodsId));
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public boolean add(Goods goods) {
        int num = service.add(goods);
        return num > 0;
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update(Goods goods) {
        int num = service.update(goods);
        return num > 0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete(@RequestBody int[] goodsId) {
        int num = service.delete(goodsId);
        return num > 0;
    }
}
