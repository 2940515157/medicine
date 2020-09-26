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
<span style="font-weight: bolder;font-size: 25px;margin-left: 300px;">退货申请</span><br><br>
退货类型
<select id="typeRequest2" class="easyui-combobox" style="width:200px;">
    <option value="-1">请选择</option>
    <option value="1">公司退货</option>
    <option value="2">客户退货</option>
</select>
状态:
<select id="status2" class="easyui-combobox" style="width:200px;">
    <option value="-1">请选择</option>
    <option value="0">待审核</option>
    <option value="1">已批准</option>
    <option value="2">未批准</option>
</select>
<a id="btnSearchRequest2" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>

<table id="dgvRequest2" align="center">
</table>

<script type="text/javascript">
    //初始化绑定数据
    var dgvRequest2Params = {
        url: 'Back/fenYe.action',
        columns: [[
            {field: 'checked', checkbox: true, title: '全选'},
            {field: 'backId', title: 'ID', width: 50, align: 'center'},
            {field: 'type', title: '退货类型', width: 100, align: 'center', formatter: function (value, rows) {
                    if (rows.type==1){
                        return '公司退货';
                    }else if (rows.type=2){
                        return '客户退货';
                    }
                }},
            {
                field: 'name', title: '名称', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.medicine.inventory.stock.goods.name;
                }
            },
            {field: 'quantity', title: '数量', width: 100, align: 'center'},
            {field: 'time', title: '日期', width: 100, align: 'center'},
            {
                field: 'price', title: '价格', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.medicine.inventory.stock.goods.price;
                }
            },
            {field: 'inspector', title: '质检人', width: 100, align: 'center'},
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
                        return '<button class="requestList2Up">批准</button>' +
                            '<button class="requestList2Down">不批</button> ';
                    }
                }
            }
        ]],
        pagination: true,  //分页工具栏 显示
        singleSelect: true, //只能选一行
        pageList: [5, 10, 15, 20]
    };
    $("#dgvRequest2").datagrid(dgvRequest2Params);

    //查询
    $("#btnSearchRequest2").click(function () {
        $("#dgvRequest2").datagrid('load', {status: $("#status2").val(),type: $("#typeRequest2").val()});
    });

    //批准
    $(document).on('click', ".requestList2Up", function (e) {
        var selrows = $("#dgvRequest2").datagrid('getSelections');
        $.get("Back/pizhun.action", {backId: selrows[0].backId}, function (data) {
            $.messager.show({
                title: '5秒后自动关闭',
                msg: data == true ? "操作成功" : "操作失败",
                timeout: 5000,
                showType: 'slide'
            });
            //刷新表格
            $("#dgvRequest2").datagrid('reload', {status: $("#status2").val(),type: $("#typeRequest2").val()});
        });

    });
    //不批
    $(document).on('click', ".requestList2Down", function (e) {
        var selrows = $("#dgvRequest2").datagrid('getSelections');
        $.get("Back/bupi.action", {backId: selrows[0].backId}, function (data) {
            $.messager.show({
                title: '5秒后自动关闭',
                msg: data == true ? "操作成功" : "操作失败",
                timeout: 5000,
                showType: 'slide'
            });
            $("#dgvRequest2").datagrid('reload', {status: $("#status2").val(),type: $("#typeRequest2").val()});
        });
    });
</script>
</body>
</html>
