<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/26
  Time: 16:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<span style="font-weight: bolder;font-size: 25px;margin-left: 300px;">出库申请</span><br><br>
状态:
<select id="status3" class="easyui-combobox" style="width:200px;">
    <option value="-1">请选择</option>
    <option value="0">待审核</option>
    <option value="1">已批准</option>
    <option value="2">未批准</option>
</select>
<a id="btnSearchRequest3" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>

<table id="dgvRequest3" align="center">
</table>

<script type="text/javascript">
    //初始化绑定数据
    var dgvRequest3Params = {
        url: 'Sell/fenYe.action',
        columns: [[
            {field: 'checked', checkbox: true, title: '全选'},
            {field: 'sellId', title: 'ID', width: 50, align: 'center'},
            {field: 'name', title: '名称', width: 150, align: 'center', formatter: function (value, rows) {
                    return rows.medicine.name;
                }},
            {field: 'guige', title: '规格', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.medicine.inventory.stock.goods.guige;
                }},
            {field: 'category', title: '类型', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.medicine.category;
                }},
            {
                field: 'sname', title: '供应商', align: 'center', formatter: function (value, rows) {
                    return rows.medicine.inventory.stock.goods.supplier.name;
                }},
            {field: 'createtime', title: '生产时间', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.medicine.inventory.stock.goods.createtime;
                }},
            {field: 'quantity', title: '数量', width: 100, align: 'center'},
            {field: 'price', title: '单价', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.medicine.price;
                }},
            {field: 'time', title: '售卖时间', width: 100, align: 'center'},
            {field: 'seller',title: '售货人',width: 100,align: 'center'},
            {field: 'clientId', title: '客户', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.client.name;
                }},
            {
                field: 'status', title: '状态', align: 'center', formatter: function (value, rows) {
                    if (rows.status == 0) {
                        return '<font color="blue">待审核</font>';
                    } else if (rows.status == 1) {
                        return '<font color="green">已批准</font>';
                    } else if (rows.status == 2) {
                        return '<font color="red">未批准</font>';
                    }
                }
            },
            {
                field: 'caozuo', title: '操作', width: '100', align: 'center', formatter: function (value, rows) {
                    if (rows.status == 0) {
                        return '<button class="requestList3Up">批准</button>' +
                            '<button class="requestList3Down">不批</button> ';
                    }
                }
            }
        ]],
        pagination: true,  //分页工具栏 显示
        singleSelect: true, //只能选一行
        pageList: [5, 10, 15, 20]
    };
    $("#dgvRequest3").datagrid(dgvRequest3Params);

    //查询
    $("#btnSearchRequest3").click(function () {
        $("#dgvRequest3").datagrid('load', {status: $("#status3").val(),type: $("#type").val()});
    });

    //批准
    $(document).on('click', ".requestList3Up", function (e) {
        var selrows = $("#dgvRequest3").datagrid('getSelections');
        $.get("Sell/pizhun.action", {sellId: selrows[0].sellId}, function (data) {
            $.messager.show({
                title: '5秒后自动关闭',
                msg: data == true ? "操作成功" : "操作失败",
                timeout: 5000,
                showType: 'slide'
            });
            //刷新表格
            $("#dgvRequest3").datagrid('reload', {status: $("#status3").val()});
        });

    });
    //不批
    $(document).on('click', ".requestList3Down", function (e) {
        var selrows = $("#dgvRequest3").datagrid('getSelections');
        $.get("Sell/bupi.action", {sellId: selrows[0].sellId}, function (data) {
            $.messager.show({
                title: '5秒后自动关闭',
                msg: data == true ? "操作成功" : "操作失败",
                timeout: 5000,
                showType: 'slide'
            });
            $("#dgvRequest3").datagrid('reload', {status: $("#status3").val()});
        });
    });
</script>
</body>
</html>
