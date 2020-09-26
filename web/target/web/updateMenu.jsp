<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/18
  Time: 21:02
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>修改</h3>
<form id="upMenu_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input name="id" type="text" readonly="readonly"/></td></tr>
        <tr><td>名称</td><td><input name="text" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>URL</td><td><input  name="url" class="easyui-validatebox"  /></td></tr>
        <tr><td>图标</td><td><input  name="iconCls" class="easyui-validatebox" /></td></tr>
        <tr><td>状态</td><td><input  name="state" class="easyui-validatebox" /></td></tr>
        <tr><td>类型ID</td><td><select limitToList="true"  data-options="required:true" name="parentid" class="easyui-combobox" style="width:167px;">
            <option value="0">权限管理</option>
            <option value="1">用户管理</option>
            <option value="2">供应商管理</option>
            <option value="3">药品管理</option>
            <option value="4">订单管理</option>
            <option value="5">仓库管理</option>
            <option value="6">财务管理</option>
        </select></td></tr>
        <tr><td><a id="btnUpMenu" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">保存</a></td></tr>
    </table>
</form>

<script type="text/javascript">

    $(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvMenu").datagrid('getSelections');
        //将查询到的数据 绑定到编辑页面
        var id = selrows[0].id;

        $('#upMenu_form').form('load','menu/queryById.action?id='+id);

    });

    $("#btnUpMenu").click(function () {
        //表单提交
        $('#upMenu_form').form('submit', {
            url:"menu/update.action",
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
                $("#editMenuWin").window("close");
                //刷新后台表格数据
                $("#dgvMenu").datagrid('reload',{parentid:$("#parentid").val(),text:$("#text").val()});
                //刷新菜单
                $("#tree").tree('reload');
            }
        });
    });

</script>
</body>
</html>
