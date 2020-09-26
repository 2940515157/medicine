<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/19
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>修改</h3>
<form id="upUser_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input name="userId" type="text" readonly="readonly"/></td></tr>
        <tr><td>用户名</td><td><input name="username" readonly="readonly" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>密码</td><td><input  name="password" class="easyui-passwordbox" data-options="required:true" /></td></tr>
        <tr><td>姓名</td><td><input name="name" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>部门</td><td><select name="department" limitToList="true" data-options="required:true" class="easyui-combobox" style="width:167px;">
            <option value="人事部">人事部</option>
            <option value="财务部">财务部</option>
            <option value="市场部">市场部</option>
            <option value="技术部">技术部</option>
            <option value="后勤部">后勤部</option>
        </select></td></tr>
        <tr><td>性别</td><td><select name="sex" limitToList="true" data-options="required:true" class="easyui-combobox" style="width:167px;">
            <option value="男">男</option>
            <option value="女">女</option>
        </select></td></tr>
        <tr><td>电话</td><td><input name="tel" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>地址</td><td><input name="address" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnUpUser" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">保存</a></td></tr>
    </table>
</form>

<script type="text/javascript">

    $(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvUser").datagrid('getSelections');
        //将查询到的数据 绑定到编辑页面
        var id = selrows[0].userId;

        $('#upUser_form').form('load','user/queryById.action?userId='+id);

    });

    $("#btnUpUser").click(function () {
        //表单提交
        $('#upUser_form').form('submit', {
            url:"user/update.action",
            onSubmit: function(){
                return $(this).form("validate");
            },
            success:function(data){
                $.messager.show({
                    title:'5秒后自动关闭',
                    msg:data=="true"?"修改成功":"修改失败",
                    timeout:5000,
                    showType:'slide'
                });
                //关闭添加窗口
                $("#editUserWin").window("close");
                //刷新后台表格数据
                $("#dgvUser").datagrid('reload',{username:$("#username").val(),department:$("#department").val()});
            }
        });
    });

</script>
</body>
</html>
