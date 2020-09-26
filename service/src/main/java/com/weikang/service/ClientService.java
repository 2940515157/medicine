package com.weikang.service;

import com.weikang.vo.Client;
import com.weikang.vo.PageVo;
import com.weikang.vo.User;

public interface ClientService {
    //查分页
    PageVo<Client> fenYe(Client client, int page, int rows);

    //添加
    public int add(Client client);

    //修改
    public int update(Client client);

    //根据id删
    public int delete(int id);

    //根据id查
    public Client queryById(int id);

}
