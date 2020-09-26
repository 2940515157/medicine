<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/17
  Time: 16:21
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<span style="font-weight: bolder;font-size: 25px;margin-left: 300px;">进货订单</span><br><br>
状态
<select id="statusStock" class="easyui-combobox" style="width:200px;">
    <option value="-1">请选择</option>
    <option value="0">待审核</option>
    <option value="1">已批准</option>
    <option value="2">未批准</option>
</select>
<a id="btnSearchStock" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<div id="StockTool">
    <a id="btnAddStock" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">添加</a>
    <a id="btnEditStock" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">编辑</a>
    <a id="btnDeleteStock" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除</a>
</div>

<table id="dgvStock">

</table>


<div id="addStockWin" class="easyui-window" title="添加"
     style="width:900px;height:700px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'addStock.jsp'">

</div>

<div id="editStockWin" class="easyui-window" title="编辑"
     style="width:800px;height:650px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'updateStock.jsp'">

</div>
<script type="text/javascript">
    //点击添加用户按钮  面板 显示
    $("#btnAddStock").click(function () {
        $("#addStockWin").window("open");
    });

    //初始化绑定数据
    var dgvStockParam = {
        url: 'Stock/fenYe.action',
        columns: [[
            {field: 'checked', checkbox: true, title: '全选'},
            {field: 'stockId', title: 'ID', width: 50, align: 'center'},
            {
                field: 'name', title: '名称', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.goods.name;
                }
            },
            {field: 'quantity', title: '数量', width: 100, align: 'center'},
            {field: 'time', title: '日期', width: 100, align: 'center'},
            {
                field: 'price', title: '价格', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.goods.price;
                }
            },
            {field: 'accepter', title: '质检人', width: 100, align: 'center'},
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
                field: 'caozuo', title: '操作',width:'100', align: 'center', formatter: function (value, rows) {
                    if (rows.status == 2) {
                        return '<button  class="reStock">重新申请</button> ';
                    }
                }
            }
        ]],
        pagination: true,  //分页工具栏 显示
        singleSelect: true, //只能选一行
        pageList: [5, 10, 15, 20],
        toolbar: '#StockTool'
    };
    $("#dgvStock").datagrid(dgvStockParam);

    //查询
    $("#btnSearchStock").click(function () {
        $("#dgvStock").datagrid('load', {status: $("#statusStock").val()});
    });

    //重新申请
    $(document).on('click',".reStock",function (e) {

        var selrows = $("#dgvStock").datagrid('getSelections');
                    $.get("Stock/shenqing.action",{stockId:selrows[0].stockId},function (data) {
                        $.messager.show({
                            title:'5秒后自动关闭',
                            msg:data==true?"申请成功":"申请失败",
                            timeout:5000,
                            showType:'slide'
                        });
                        //刷新表格
                        $("#dgvStock").datagrid('reload',{status:$("#statusStock").val()});
                    });
    });

    //点击添加按钮
    $("#btnAddStock").click(function () {

        $("#addStockWin").window("open");
    });

    //点击修改按钮
    $("#btnEditStock").click(function () {
        //获取当前的选中的行记录
        var selrows = $("#dgvStock").datagrid('getSelections');
        if (selrows.length == 0 || selrows.length > 1) {
            $.messager.alert('消息', '请选中一条记录', 'info');
            return;
        }
        if (selrows[0].status==1){
            $.messager.alert('消息','已批准不能修改','info');
            return ;
        }
        $("#editStockWin").window('refresh', 'updateStock.jsp');
        $("#editStockWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteStock").click(function () {
        //获取当前的选中的行记录
        var selrows = $("#dgvStock").datagrid('getSelections');
        if (selrows.length == 0) {
            $.messager.alert('消息', '请选中一条记录', 'info');
            return;
        }
        for (var i = 0; i < selrows.length; i++) {
            if (selrows[i].status!=2){
                $.messager.alert('消息', '未批准才能删除', 'info');
                return ;
            }
        }
        var arrayId = [];
        $.each(selrows, function (index) {
            arrayId[index] = this.stockId;
        })
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function (r) {
            if (r) {
                var param = {
                    url: 'Stock/delete.action',
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
                        $("#dgvStock").datagrid('reload', {status: $("#statusStock").val()});
                    }
                };

                $.ajax(param);

            }
        });
    });
</script>
</body>
</html>
