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
<form id="upSupplier_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input name="supplierId" type="text" readonly="readonly"/></td></tr>
        <tr><td>名称</td><td><input name="name" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>电话</td><td><input name="tel" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>地址</td><td><input name="address" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnUpSupplier" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">保存</a></td></tr>
    </table>
</form>

<script type="text/javascript">

    $(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvSupplier").datagrid('getSelections');
        //将查询到的数据 绑定到编辑页面
        var id = selrows[0].supplierId;

        $('#upSupplier_form').form('load','supplier/queryById.action?supplierId='+id);

    });

    $("#btnUpSupplier").click(function () {
        //表单提交
        $('#upSupplier_form').form('submit', {
            url:"supplier/update.action",
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
                $("#editSupplierWin").window("close");
                //刷新后台表格数据
                $("#dgvSupplier").datagrid('reload',{name:$("#name").val()});
            }
        });
    });

</script>
</body>
</html>
