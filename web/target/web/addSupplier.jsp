<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/19
  Time: 18:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>添加</h3>
<form id="addSupplier_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>名称</td><td><input name="name" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>电话</td><td><input name="tel" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>地址</td><td><input name="address" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnSaveSupplier" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">保存</a></td></tr>
    </table>
</form>
<script type="text/javascript">
    $("#btnSaveSupplier").click(function () {
        //表单提交
        $('#addSupplier_form').form('submit', {
            url:"supplier/add.action",

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
                $('#addSupplier_form').form('clear');
                //关闭添加窗口
                $("#addSupplierWin").window("close");
                //刷新后台表格数据
                $("#dgvSupplier").datagrid('reload');
            }
        });
    });
</script>
</body>
</html>
