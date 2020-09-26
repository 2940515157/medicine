package com.weikang.controller;

import com.weikang.service.ClientService;
import com.weikang.vo.Client;
import com.weikang.vo.PageVo;
import com.weikang.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/client")
public class ClientController {
    @Autowired
    ClientService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public PageVo<Client> fenYe(Client client,
                              @RequestParam(value = "page",defaultValue = "1") int page,
                              @RequestParam(value = "rows",defaultValue = "10") int rows){
        return service.fenYe(client,page,rows);
    }

    //查所有
    @RequestMapping("/fenYe2.action")
    @ResponseBody
    public List<Client > fenYe2(Client client,
                             @RequestParam(value = "page",defaultValue = "1") int page,
                             @RequestParam(value = "rows",defaultValue = "10") int rows){
        return service.fenYe(client,page,rows).getRows();
    }

    //根据id查
    @RequestMapping("/queryById.action")
    @ResponseBody
    public Client queryById(Integer clientId){
        return service.queryById(clientId);
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public boolean add (Client client){
        int num = service.add(client);
        return num>0;
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update (Client client){
        int num = service.update(client);
        return num>0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete (Integer clientId){
        int num = service.delete(clientId);
        return num>0;
    }
}
