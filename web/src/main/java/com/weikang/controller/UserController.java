package com.weikang.controller;

import com.weikang.service.UserService;
import com.weikang.vo.PageVo;
import com.weikang.vo.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    UserService service;

    //查所有
    @RequestMapping("/fenYe.action")
    @ResponseBody
    public PageVo<User> fenYe(User user,
                              @RequestParam(value = "page",defaultValue = "1") int page,
                              @RequestParam(value = "rows",defaultValue = "10") int rows){
        return service.fenYe(user,page,rows);
    }

    //查所有
    @RequestMapping("/fenYe2.action")
    @ResponseBody
    public List<User> fenYe2(User user,
                            @RequestParam(value = "page",defaultValue = "1") int page,
                            @RequestParam(value = "rows",defaultValue = "10") int rows){
        user.setDepartment("市场部");
        return service.fenYe(user,page,rows).getRows();
    }

    //查
    @RequestMapping("/queryById.action")
    @ResponseBody
    public User queryById(Integer userId){
        return service.queryById(userId);
    }

    //添加
    @RequestMapping(value = "/add.action")
    @ResponseBody
    public boolean add (User user){
        int num = service.add(user);
        return num>0;
    }

    //修改
    @RequestMapping("/update.action")
    @ResponseBody
    public boolean update (User user){
        int num = service.update(user);
        return num>0;
    }

    //删除
    @RequestMapping("/delete.action")
    @ResponseBody
    public boolean delete (Integer userId){
        int num = service.delete(userId);
        return num>0;
    }

    //登录
    @RequestMapping(value = "/login.action",produces = "text/json;charset=utf-8")
    @ResponseBody
    public String login(String username,String password, HttpSession session){
        User user1 = service.login(username);
        if (user1!=null) {
            if (user1.getPassword().equals(password)) {
                //将对象 存入session
                session.setAttribute("user", user1);
                return "登录成功";
            }else {
                return "密码错误";
            }
        }
        return "该用户不存在";
    }
}
