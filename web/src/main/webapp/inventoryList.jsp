<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/17
  Time: 16:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
名称：<input type="text" id="name"> 类型：<input type="text" id="category">
<a id="btnSearchInventory" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<table id="dgvInventory">

</table>

<script type="text/javascript">
    //点击添加用户按钮  面板 显示
    $("#btnAddInventory").click(function () {
        $("#addInventoryWin").window("open");
    });

    //初始化绑定数据
    var dgvInventoryParam = {
        url: 'Inventory/fenYe.action',
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
            {field: 'time', title: '入库时间', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.stock.time;
                }},
            {field: 'quantity', title: '数量', width: 100, align: 'center'},
            {field: 'price', title: '进价', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.stock.goods.price;
                }}
        ]],
        pagination: true,  //分页工具栏 显示
        //singleSelect:true, //只能选一行
        pageList: [5, 10, 15, 20],
        toolbar: '#InventoryTool'
    };
    $("#dgvInventory").datagrid(dgvInventoryParam);

    //查询
    $("#btnSearchInventory").click(function () {
        $("#dgvInventory").datagrid('load', {name: $("#name").val(), category: $("#category").val()});
    });

    //点击修改按钮
    $("#btnEditInventory").click(function () {
        //获取当前的选中的行记录
        var selrows = $("#dgvInventory").datagrid('getSelections');
        if (selrows.length == 0 || selrows.length > 1) {
            $.messager.alert('消息', '请选中一条记录', 'info');
            return;
        }
        $("#editInventoryWin").window('refresh', 'updateInventory.jsp');
        $("#editInventoryWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteInventory").click(function () {
        //获取当前的选中的行记录
        var selrows = $("#dgvInventory").datagrid('getSelections');
        if (selrows.length == 0) {
            $.messager.alert('消息', '请选中一条记录', 'info');
            return;
        }
        var arrayId = [];
        $.each(selrows, function (index) {
            arrayId[index] = this.inventoryId;
        })
        for (var i = 0; i < arrayId.length; i++) {
        if(selrows[i].quantity>0){
            alert("数量不为0不能删除");
            return;
        }
        }
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function (r) {
            if (r) {
            var param = {
            url: 'Inventory/delete.action',
            type: 'post',
            contentType: 'application/json',
            data: JSON.stringify(arrayId),
            success: function (data) {
                $.messager.show({
                    title:'5秒后自动关闭',
                    msg:data==true?"删除成功":"删除失败",
                    timeout:5000,
                    showType:'slide'
                });
                //刷新表格
                $("#dgvInventory").datagrid('reload', {name: $("#name").val(), category: $("#category").val()});
            }
        };

                $.ajax(param);

            }
        });
        });
</script>
</body>
</html>
