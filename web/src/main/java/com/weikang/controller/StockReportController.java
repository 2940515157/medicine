package com.weikang.controller;

import com.alibaba.fastjson.JSONObject;
import com.weikang.service.StockReportService;
import com.weikang.vo.StockReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/StockReport")
public class StockReportController {
    @Autowired
    StockReportService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public String fenYe(StockReport stockReport,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "rows", defaultValue = "10") int rows) {
        return JSONObject.toJSONString(service.fenYe(stockReport, page, rows));
    }

}
