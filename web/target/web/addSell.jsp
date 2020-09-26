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
名称：<input type="text" id="nameAddSell"> 类型：<input type="text" id="categoryAddSell">
<a id="btnSearchSell2" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<table id="dgvAddSell">

</table>
<form id="addSell_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input id="medicineIdAddSell" readonly="true" name="medicineId" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>数量</td><td><input type="number" name="quantity"  class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>日期</td><td><input name="time" class="easyui-datebox" data-options="required:true" /></td></tr>
        <tr><td>售货人</td><td><input id="sellerAdd" name="seller" class="easyui-validatebox" limitToList="true"  data-options="required:true" /></td></tr>
        <tr><td>客户</td><td><input id="addSellClient" name="clientId" limitToList="true" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnSaveAddSell" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">保存</a></td></tr>
    </table>
</form>
<script type="text/javascript">
    //初始化绑定数据
    var dgvAddSellParam = {
        url: 'Medicine/fenYe.action',
        columns: [[
            {field: 'medicineId', title: 'ID', width: 50, align: 'center'},
            {field: 'name', title: '名称', width: 150, align: 'center'},
            {field: 'guige', title: '规格', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.inventory.stock.goods.guige;
                }},
            {field: 'category', title: '类型', width: 100, align: 'center'},
            {
                field: 'sname', title: '供应商', align: 'center', formatter: function (value, rows) {
                    return rows.inventory.stock.goods.supplier.name;
                }},
            {field: 'createtime', title: '生产时间', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.inventory.stock.goods.createtime;
                }},
            {field: 'quantity', title: '数量', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.inventory.quantity;
                }},
            {field: 'price', title: '单价', width: 100, align: 'center'}
        ]],
        pagination: true,  //分页工具栏 显示
        singleSelect:true, //只能选一行
        pageList: [5, 10, 15, 20],
        onClickRow: function (index,row){
            $("#medicineIdAddSell").val(row.medicineId);
        }
    };
    $("#dgvAddSell").datagrid(dgvAddSellParam);
    //所有员工
    $('#sellerAdd').combobox({
        url:'user/fenYe2.action',
        valueField:'name',
        textField:'name'
    });
    //所有客户
    $('#addSellClient').combobox({
        url:'client/fenYe2.action',
        valueField:'clientId',
        textField:'name'
    });
    //查询
    $("#btnSearchAddSell").click(function () {
        $("#dgvAddSell").datagrid('load', {name: $("#nameAddSell").val(), category: $("#categoryAddSell").val()});
    });

    //添加
    $("#btnSaveAddSell").click(function () {

        //表单提交
        $('#addSell_form').form('submit', {
            url:"Sell/add.action",

            onSubmit: function(){
                return $(this).form("validate");
            },
            success:function(data){
                $.messager.show({
                    title:'5秒后自动关闭',
                    msg: data=="1"?"添加成功":"添加失败",
                    timeout:5000,
                    showType:'slide'
                });
                $('#addSell_form').form('clear');

                //关闭添加窗口
                $("#addSellWin").window("close");
                //刷新后台表格数据
                $("#dgvSell").datagrid('reload',{status:$("#statusSell").val(),seller: $("#sellerSell").val()});
            }
        });
    });
</script>
</body>
</html>
