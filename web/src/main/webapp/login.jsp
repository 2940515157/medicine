<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/22
  Time: 9:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>登录</title>
    <!-- jquery-->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- easyui-->
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <!-- 语言包-->
    <script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <!-- 主题-->
    <link rel="stylesheet" href="themes/default/easyui.css" />
    <!-- 图标-->
    <link rel="stylesheet" href="themes/icon.css" />
    <!-- 扩展图标的样式-->
    <link rel="stylesheet" href="themes/IconExtension.css" />
</head>
<body bgcolor="#dcdcdc">
<div style="margin:auto;margin-top:280px;width: 350px;height: 250px;text-align: center;">
<form method="post" id="loginform">
    <table style="margin: auto;border-spacing: 10px 10px">
        <br>
        <tr><th colspan="2"><h2>用户登录</h2></th></tr>
        <tr><th>用户名</th><td><input id="username" class="easyui-textbox" data-options="required:true" name="username"></td></tr>
        <tr><th>&nbsp密 码</th><td><input id="password" class="easyui-passwordbox" data-options="required:true" name="password"></td></tr>
        <tr><th colspan="2">&nbsp&nbsp&nbsp&nbsp&nbsp<input id="btnlogin" type="button" style="width: 100px;font-size: 18px" value="登录"/></th></tr>
    </table>
</form>
</div>
<script type="text/javascript">
    $("#btnlogin").click(function () {
        if($('#username').val()==null || $('#username').val()==""){
            alert("请输入用户名");
            return ;
        }
        if($('#password').val()==null || $('#password').val()==""){
            alert("请输入密码");
            return ;
        }
        $('#loginform').form('submit', {
            url:"user/login.action",
            onSubmit: function(){
                return true;
            },
            success:function(data){
                if(data!="登录成功"){
                    alert(data);
                    return;
                }
                window.location ="index.jsp";
            }
        });
    });
</script>
</body>
</html>
