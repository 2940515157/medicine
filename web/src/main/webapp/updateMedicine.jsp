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
<form id="upMedicine_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input name="medicineId" type="text" readonly="readonly"/></td></tr>
        <tr><td>名称</td><td><input name="name" class="easyui-validatebox" readonly="readonly" /></td></tr>
        <tr><td>单价</td><td><input name="price" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnUpMedicine" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">保存</a></td></tr>
    </table>
</form>

<script type="text/javascript">

    $(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvMedicine").datagrid('getSelections');
        //将查询到的数据 绑定到编辑页面
        var id = selrows[0].medicineId;

        $('#upMedicine_form').form('load','Medicine/queryById.action?medicineId='+id);

    });

    $("#btnUpMedicine").click(function () {
        //表单提交
        $('#upMedicine_form').form('submit', {
            url:"Medicine/update.action",
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
                $("#editMedicineWin").window("close");
                //刷新后台表格数据
                $("#dgvMedicine").datagrid('reload',{name:$("#nameAddMedicine").val(), category: $("#categoryAddMedicine").val()});
            }
        });
    });

</script>
</body>
</html>
