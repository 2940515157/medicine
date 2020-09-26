package com.weikang.controller;

import com.alibaba.fastjson.JSONObject;
import com.weikang.service.FinanceService;
import com.weikang.vo.Finance;
import com.weikang.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/Finance")
public class FinanceController {
    @Autowired
    FinanceService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public PageVo<Finance> fenYe(Finance finance,
                                 @RequestParam(value = "page", defaultValue = "1") int page,
                                 @RequestParam(value = "rows", defaultValue = "10") int rows) {
        System.out.println();
        System.out.println();
        System.out.println(finance.getStarttime());
        System.out.println(finance.getEndtime());
        return service.fenYe(finance, page, rows);
    }

}
