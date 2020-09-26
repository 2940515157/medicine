package com.weikang.service.impl;

import com.github.pagehelper.PageHelper;
import com.weikang.dao.GoodsDao;
import com.weikang.service.GoodsService;
import com.weikang.vo.Goods;
import com.weikang.vo.PageVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    GoodsDao dao;

    @Override
    public PageVo<Goods> fenYe(Goods goods, int page, int rows) {
        PageVo<Goods> pageVo=new PageVo<>();
        PageHelper.startPage(page,rows);
        pageVo.setRows(dao.fenYe(goods));
        pageVo.setTotal(dao.fenYeCount(goods));
        return pageVo;
    }

    @Override
    public int add(Goods goods) {
        return dao.add(goods);
    }

    @Override
    public int update(Goods goods) {
        return dao.update(goods);
    }

    @Override
    public int delete(int[] id) {
        return dao.delete(id);
    }

    @Override
    public Goods queryById(int id) {
        return dao.queryById(id);
    }

}
