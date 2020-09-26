package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.ClientDao;
import com.weikang.service.ClientService;
import com.weikang.vo.Client;
import com.weikang.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ClientServiceImpl implements ClientService {
    @Autowired
    ClientDao dao;

    @Override
    public PageVo<Client> fenYe(Client client, int page, int rows) {
        PageVo<Client> pageVo=new PageVo<>();
        PageHelper.startPage(page,rows);
        pageVo.setRows(dao.fenYe(client));
        pageVo.setTotal(dao.fenYeCount(client));
        return pageVo;
    }

    @Override
    public int add(Client client) {
        return dao.add(client);
    }

    @Override
    public int update(Client client) {
        return dao.update(client);
    }

    @Override
    public int delete(int id) {
        return dao.delete(id);
    }

    @Override
    public Client queryById(int id) {
        return dao.queryById(id);
    }

}
