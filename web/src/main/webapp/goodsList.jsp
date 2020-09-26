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
<a id="btnSearchGoods" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<div id="GoodsTool">
    <a id="btnAddGoods" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">添加</a>
    <a id="btnEditGoods" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">编辑</a>
    <a id="btnDeleteGoods" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除</a>
</div>
<table id="dgvGoods">

</table>


<div id="addGoodsWin" class="easyui-window" title="添加"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'addGoods.jsp'">

</div>

<div id="editGoodsWin" class="easyui-window" title="编辑"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'updateGoods.jsp'">

</div>
<script type="text/javascript">
    //点击添加用户按钮  面板 显示
    $("#btnAddGoods").click(function () {
        $("#addGoodsWin").window("open");
    });

    //初始化绑定数据
    var dgvGoodsParam = {
        url: 'goods/fenYe.action',
        columns: [[
            {field: 'checked', checkbox: true, title: '全选'},
            {field: 'goodsId', title: 'ID', width: 50, align: 'center'},
            {field: 'name', title: '名称', width: 150, align: 'center'},
            {field: 'guige', title: '规格', width: 100, align: 'center'},
            {field: 'category', title: '类型', width: 100, align: 'center'},
            {field: 'price', title: '价格', width: 100, align: 'center'},
            {
                field: 'supplier', title: '供应商', align: 'center', formatter: function (value, rows) {
                    return rows.supplier.name;
                }
            },
            {field: 'createtime', title: '生产时间', width: 100, align: 'center'},
            {field: 'chandi', title: '产地', width: 100, align: 'center'}
        ]],
        pagination: true,  //分页工具栏 显示
        //singleSelect:true, //只能选一行
        pageList: [5, 10, 15, 20],
        toolbar: '#GoodsTool'
    };
    $("#dgvGoods").datagrid(dgvGoodsParam);

    //查询
    $("#btnSearchGoods").click(function () {
        $("#dgvGoods").datagrid('load', {name: $("#name").val(), category: $("#category").val()});
    });

    //点击添加按钮
    $("#btnAddGoods").click(function () {

        $("#addGoodsWin").window("open");
    });

    //点击修改按钮
    $("#btnEditGoods").click(function () {
        //获取当前的选中的行记录
        var selrows = $("#dgvGoods").datagrid('getSelections');
        if (selrows.length == 0 || selrows.length > 1) {
            $.messager.alert('消息', '请选中一条记录', 'info');
            return;
        }
        $("#editGoodsWin").window('refresh', 'updateGoods.jsp');
        $("#editGoodsWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteGoods").click(function () {
        //获取当前的选中的行记录
        var selrows = $("#dgvGoods").datagrid('getSelections');
        if (selrows.length == 0) {
            $.messager.alert('消息', '请选中一条记录', 'info');
            return;
        }
        var arrayId = [];
        $.each(selrows, function (index) {
            arrayId[index] = this.goodsId;
        })
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function (r) {
            if (r) {
        var param = {
            url: 'goods/delete.action',
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
                $("#dgvGoods").datagrid('reload', {name: $("#name").val(), category: $("#category").val()});
            }
        };

                $.ajax(param);

            }
        });
    });
</script>
</body>
</html>
