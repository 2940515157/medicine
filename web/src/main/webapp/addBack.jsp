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
名称：<input type="text" id="nameAddBack"> 类型：<input type="text" id="categoryAddBack">
<a id="btnSearchAddBack" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<table id="dgvAddBack">

</table>
<form id="addBack_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>退货类型</td>
            <td>
                <select limitToList="true"  data-options="required:true" name="type" class="easyui-combobox" style="width:167px;">
                <option value="1">公司退货</option>
                <option value="2">客户退货</option>
                </select>
            </td>
        </tr>
        <tr><td>药品ID</td><td><input id="medicineId" readonly="true" name="medicineId" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>数量</td><td><input name="quantity" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>日期</td><td><input name="time" class="easyui-datebox" data-options="required:true" /></td></tr>
        <tr><td>质检人</td><td><input id="inspectorAdd" name="inspector" class="easyui-validatebox" limitToList="true"  data-options="required:true" /></td></tr>
        <tr><td><a id="btnSaveBack" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'">保存</a></td></tr>
    </table>

</form>
<script type="text/javascript">

    //初始化绑定数据
    var dgvAddBackParam = {
        url: 'Medicine/fenYe.action',
        columns: [[
        {field: 'checked', checkbox: true, title: '全选'},
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
            $("#medicineId").val(row.medicineId);
        }
    };
    $("#dgvAddBack").datagrid(dgvAddBackParam);

    //所有员工
    $('#inspectorAdd').combobox({
        url:'user/fenYe2.action',
        valueField:'name',
        textField:'name'
    });


    //查询
    $("#btnSearchAddBack").click(function () {
        $("#dgvAddBack").datagrid('load', {name: $("#nameAddBack").val(), category: $("#categoryAddBack").val()});
    });

    $("#btnSaveBack").click(function () {
        //表单提交
        $('#addBack_form').form('submit', {
            url:"Back/add.action",

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
                $('#addBack_form').form('clear');
                //关闭添加窗口
                $("#addBackWin").window("close");
                //刷新后台表格数据
                $("#dgvBack").datagrid('reload',{status:$("#statusBack").val(),type: $("#typeBack").val()});
            }
        });
    });
</script>
</body>
</html>
