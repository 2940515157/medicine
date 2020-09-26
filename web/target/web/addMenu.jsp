<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/18
  Time: 21:00
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>添加</h3>
<form id="addMenu_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>名称</td><td><input name="text" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>URL</td><td><input name="url" class="easyui-validatebox"  /></td></tr>
        <tr><td>图标</td><td><input name="iconCls" class="easyui-validatebox" /></td></tr>
        <tr><td>状态</td><td><input name="state" class="easyui-validatebox" /></td></tr>
        <tr><td>类型</td><td><select name="parentid" limitToList="true"  data-options="required:true" class="easyui-combobox" style="width:167px;">
            <option value="0">权限管理</option>
            <option value="1">用户管理</option>
            <option value="2">供应商管理</option>
            <option value="3">药品管理</option>
            <option value="4">订单管理</option>
            <option value="5">仓库管理</option>
            <option value="6">财务管理</option>
            </select></td></tr>
        <tr><td><a id="btnSaveMenu" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">保存</a></td></tr>
    </table>
</form>
<script type="text/javascript">
    $("#btnSaveMenu").click(function () {
        //表单提交
        $('#addMenu_form').form('submit', {
            url:"menu/add.action",

            onSubmit: function(){
                return $(this).form("validate");
            },
            success:function(data){
                $.messager.show({
                    title:'5秒后自动关闭',
                    msg: data=="true"?"添加成功":"添加失败",
                    timeout:5000,
                    showType:'slide'
                });
                $('#addMenu_form').form('clear');
                //关闭添加窗口
                $("#addMenuWin").window("close");
                //刷新后台表格数据
                $("#dgvMenu").datagrid('reload');
                //刷新菜单
                $("#tree").tree('reload');
            }
        });
    });
</script>
</body>
</html>
