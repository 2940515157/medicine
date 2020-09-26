package com.weikang.dao;

import com.weikang.vo.Client;

import java.util.List;

public interface ClientDao {
    public List<Client> fenYe(Client client);

    public int fenYeCount(Client client);

    //添加
    public int add(Client client);

    //修改
    public int update(Client client);

    //根据id删
    public int delete(int clientId);

    //根据id查
    public Client queryById(int clientId);

}
