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
名称：<input type="text" id="nameUpSell"> 类型：<input type="text" id="categoryUpSell">
<a id="btnSearchUpSell" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<table id="dgvUpSell">

</table>
<form id="upSell_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input name="sellId" type="text" readonly="readonly"/></td></tr>
        <tr><td>药品ID</td><td><input id="medicineIdUpSell" name="medicineId" class="easyui-validatebox" readonly="readonly" /></td></tr>
        <tr><td>数量</td><td><input type="number" name="quantity" class="easyui-validatebox" /></td></tr>
        <tr><td>日期</td><td><input name="time" class="easyui-datebox" data-options="required:true" /></td></tr>
        <tr><td>质检人</td><td><input id="sellerUp" name="seller" class="easyui-validatebox" limitToList="true"  data-options="required:true" /></td></tr>
        <tr><td>客户</td><td><input id="upSellClient" name="clientId" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnUpSell" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">保存</a></td></tr>
    </table>
</form>

<script type="text/javascript">
    //初始化绑定数据
    var dgvUpSellParam = {
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
            $("#medicineIdUpSell").val(row.medicineId);
        }
    };
    $("#dgvUpSell").datagrid(dgvUpSellParam);
    //所有员工
    $('#sellerUp').combobox({
        url:'user/fenYe2.action',
        valueField:'name',
        textField:'name'
    });
    //所有客户
    $('#upSellClient').combobox({
        url:'client/fenYe2.action',
        valueField:'clientId',
        textField:'name'
    });

    $(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvSell").datagrid('getSelections');
        //将查询到的数据 绑定到编辑页面
        var id = selrows[0].sellId;

        $('#upSell_form').form('load','Sell/queryById.action?sellId='+id);

    });
    //查询
    $("#btnSearchUpSell").click(function () {
        $("#dgvUpSell").datagrid('load', {name: $("#nameUpSell").val(), category: $("#categoryUpSell").val()});
    });

    $("#btnUpSell").click(function () {
        //表单提交
        $('#upSell_form').form('submit', {
            url:"Sell/update.action",
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
                $("#editSellWin").window("close");
                //刷新后台表格数据
                $("#dgvSell").datagrid('reload',{status:$("#statusSell").val(),seller: $("#sellerSell").val()});
            }
        });
    });

</script>
</body>
</html>
