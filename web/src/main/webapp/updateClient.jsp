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
<form id="upClient_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input name="clientId" type="text" readonly="readonly"/></td></tr>
        <tr><td>姓名</td><td><input name="name" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>性别</td><td><select name="sex" data-options="required:true"  limitToList="true" class="easyui-combobox" style="width:167px;">
            <option value="男">男</option>
            <option value="女">女</option>
        </select></td></tr>
        <tr><td>电话</td><td><input name="tel" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>地址</td><td><input name="address" class="easyui-validatebox" data-options="required:true" /></td></tr>
        </td><td><a id="btnUpClient" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">保存</a></td></tr>
    </table>
</form>

<script type="text/javascript">

    $(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvClient").datagrid('getSelections');
        //将查询到的数据 绑定到编辑页面
        var id = selrows[0].clientId;

        $('#upClient_form').form('load','client/queryById.action?clientId='+id);

    });

    $("#btnUpClient").click(function () {
        //表单提交
        $('#upClient_form').form('submit', {
            url:"client/update.action",
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
                $("#editClientWin").window("close");
                //刷新后台表格数据
                $("#dgvClient").datagrid('reload',{name:$("#name").val()});
            }
        });
    });

</script>
</body>
</html>
