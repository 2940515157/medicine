package com.weikang.controller;

import com.weikang.service.ClientService;
import com.weikang.service.SupplierService;
import com.weikang.vo.Client;
import com.weikang.vo.PageVo;
import com.weikang.vo.Supplier;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/supplier")
public class SupplierController {
    @Autowired
    SupplierService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public PageVo<Supplier> fenYe(Supplier supplier,
                              @RequestParam(value = "page",defaultValue = "1") int page,
                              @RequestParam(value = "rows",defaultValue = "10") int rows){
        return service.fenYe(supplier,page,rows);
    }

    //查所有
    @RequestMapping("/queryAll.action")
    @ResponseBody
    public List<Supplier> queryAll(Supplier supplier,
                                   @RequestParam(value = "page",defaultValue = "1") int page,
                                   @RequestParam(value = "rows",defaultValue = "10") int rows){
        return service.fenYe(supplier,page,rows).getRows();
    }

    //查所有
    @RequestMapping("/queryById.action")
    @ResponseBody
    public Supplier queryById(Integer supplierId){
        return service.queryById(supplierId);
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public boolean add (Supplier supplier){
        int num = service.add(supplier);
        return num>0;
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update (Supplier supplier){
        int num = service.update(supplier);
        return num>0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete (Integer supplierId){
        int num = service.delete(supplierId);
        return num>0;
    }
}
