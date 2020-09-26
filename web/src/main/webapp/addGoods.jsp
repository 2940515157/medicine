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
<form id="addGoods_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>名称</td><td><input name="name" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>规格</td><td><input name="guige" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>类型</td><td><input name="category" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>价格</td><td><input name="price" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>供应商</td><td><input id="supp" name="supplierId"  limitToList="true"  data-options="required:true" /></td></tr>
        <tr><td>生产时间</td><td><input name="createtime" class="easyui-datebox" data-options="required:true" /></td></tr>
        <tr><td>产地</td><td><input name="chandi" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnSaveGoods" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">保存</a></td></tr>
    </table>
</form>
<script type="text/javascript">

    $('#supp').combobox({
        url:'supplier/queryAll.action',
        valueField:'supplierId',
        textField:'name'
    });

    $("#btnSaveGoods").click(function () {
        //表单提交
        $('#addGoods_form').form('submit', {
            url:"goods/add.action",

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
                $('#addGoods_form').form('clear');
                //关闭添加窗口
                $("#addGoodsWin").window("close");
                //刷新后台表格数据
                $("#dgvGoods").datagrid('reload');
            }
        });
    });
</script>
</body>
</html>
