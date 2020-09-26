package com.weikang.controller;

import com.alibaba.fastjson.JSONObject;
import com.weikang.service.BackReportService;
import com.weikang.service.SellReportService;
import com.weikang.vo.BackReport;
import com.weikang.vo.SellReport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/BackReport")
public class BackReportController {
    @Autowired
    BackReportService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public String fenYe(BackReport backReport,
                        @RequestParam(value = "page", defaultValue = "1") int page,
                        @RequestParam(value = "rows", defaultValue = "10") int rows) {
        return JSONObject.toJSONString(service.fenYe(backReport, page, rows));
    }

}
