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
名称：<input type="text" id="nameaddStock"> 类型：<input type="text" id="categoryaddStock">
<a id="btnSearchAddStock" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<table id="dgvAddStock">

</table>
<form id="addStock_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>药品ID</td><td><input id="goodsId1" readonly name="goodsId" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>数量</td><td><input name="quantity" class="easyui-validatebox" data-options="required:true," /></td></tr>
        <tr><td>日期</td><td><input name="time" class="easyui-datebox" data-options="required:true" /></td></tr>
        <tr><td>质检人</td><td><input id="accepterAddStock" name="accepter" limitToList="true"  class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnSaveStock" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">保存</a></td></tr>
    </table>
</form>
<script type="text/javascript">

    //初始化绑定数据
    var dgvAddStockParam = {
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
        singleSelect:true, //只能选一行
        pageList: [5, 10, 15, 20],
        onClickRow: function (index,row){
            $("#goodsId1").val(row.goodsId);
        }
    };
    $("#dgvAddStock").datagrid(dgvAddStockParam);

    //所有员工
    $('#accepterAddStock').combobox({
        url:'user/fenYe2.action',
        valueField:'name',
        textField:'name'
    });


    //查询
    $("#btnSearchAddStock").click(function () {
        $("#dgvAddStock").datagrid('load', {name: $("#nameaddStock").val(), category: $("#categoryaddStock").val()});
    });

    $("#btnSaveStock").click(function () {
        //表单提交
        $('#addStock_form').form('submit', {
            url:"Stock/add.action",

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
                $('#addStock_form').form('clear');
                //关闭添加窗口
                $("#addStockWin").window("close");
                //刷新后台表格数据
                $("#dgvStock").datagrid('reload',{status: $("#statusStock").val()});
            }
        });
    });
</script>
</body>
</html>
