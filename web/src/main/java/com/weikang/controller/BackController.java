package com.weikang.controller;

import com.alibaba.fastjson.JSONObject;
import com.weikang.service.BackService;
import com.weikang.vo.Back;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/Back")
public class BackController {
    @Autowired
    BackService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public String fenYe(Back back,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "rows", defaultValue = "10") int rows) {
        return JSONObject.toJSONString(service.fenYe(back, page, rows));
    }

    //根据id查
    @RequestMapping("/queryById.action")
    @ResponseBody
    public String queryById(int backId) {
        return JSONObject.toJSONString(service.queryById(backId));
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public int add(Back back) {

        return service.add(back);
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update(Back back) {
        int num = service.update(back);
        return num > 0;
    }

    //申请
    @RequestMapping("/shenqing.action")
    @ResponseBody
    public boolean update1(int backId) {
        int num = service.update2(backId);
        return num > 0;
    }
    //申请
    @RequestMapping("/pizhun.action")
    @ResponseBody
    public boolean update2(int backId) {
        int num = service.update3(backId);
        return num > 0;
    }
    //申请
    @RequestMapping("/bupi.action")
    @ResponseBody
    public boolean update3(int backId) {
        int num = service.update4(backId);
        return num > 0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete(@RequestBody int[] backId) {
        int num = service.delete(backId);
        return num > 0;
    }
}
