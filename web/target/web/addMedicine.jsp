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
名称：<input type="text" id="nameAddMedicine"> 类型：<input type="text" id="categoryAddMedicine">
<a id="btnSearchAddMedicine" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<table id="dgvAddMedicine">

</table>
<form id="addMedicine_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input id="addMedicineInventoryId" readonly name="inventoryId" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>名称</td><td><input id="addMedicineName"  readonly name="name" class="easyui-validatebox" data-options="required:true," /></td></tr>
        <tr><td>类型</td><td><input id="addMedicineCategory" readonly name="category" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>售价</td><td><input id="price" type="number" name="price" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnSaveAddMedicine" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">保存</a></td></tr>
    </table>
</form>
<script type="text/javascript">
    //初始化绑定数据
    var AddMedicineParam = {
        url: 'Inventory/addfenYe.action',
        columns: [[
            {field: 'checked', checkbox: true, title: '全选'},
            {field: 'inventoryId', title: 'ID', width: 50, align: 'center'},
            {field: 'name', title: '名称', width: 150, align: 'center'},
            {field: 'guige', title: '规格', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.stock.goods.guige;
                }},
            {field: 'category', title: '类型', width: 100, align: 'center'},
            {
                field: 'sname', title: '供应商', align: 'center', formatter: function (value, rows) {
                    return rows.stock.goods.supplier.name;
                }},
            {field: 'createtime', title: '生产时间', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.stock.goods.createtime;
                }},
            {field: 'quantity', title: '数量', width: 100, align: 'center'},
            {field: 'price', title: '进价', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.stock.goods.price;
                }}
        ]],
        pagination: true,  //分页工具栏 显示
        singleSelect:true, //只能选一行
        pageList: [5, 10, 15, 20],
        onClickRow: function (index,row){
            $("#addMedicineInventoryId").val(row.inventoryId);
            $("#addMedicineName").val(row.name);
            $("#addMedicineCategory").val(row.category);
        }
    };
    $("#dgvAddMedicine").datagrid(AddMedicineParam);

    //查询
    $("#btnSearchAddMedicine").click(function () {
        $("#dgvAddMedicine").datagrid('load', {name: $("#nameAddMedicine").val(), category: $("#categoryAddMedicine").val()});
    });

    //添加
    $("#btnSaveAddMedicine").click(function () {

        //表单提交
        $('#addMedicine_form').form('submit', {
            url:"Medicine/add.action",

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
                $('#addMedicine_form').form('clear');

                //关闭添加窗口
                $("#addMedicineWin").window("close");
                //刷新后台表格数据
                $("#dgvMedicine").datagrid('reload',{name: $("#nameMedicineList").val(), category: $("#categoryMedicineList").val()});
            }
        });
    });
</script>
</body>
</html>
