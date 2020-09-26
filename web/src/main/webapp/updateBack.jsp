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
名称：<input type="text" id="nameUpBack"> 类型：<input type="text" id="categoryUpBack">
<a id="btnSearchUpBack" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<table id="dgvUpBack">

</table>
<form id="upBack_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input name="backId" class="easyui-validatebox" readonly="readonly" data-options="required:true"></td></tr>
        <tr><td>退货类型</td><td><select id="type" limitToList="true"  data-options="required:true" name="type" class="easyui-combobox" style="width:167px;">
            <option value="1">公司退货</option>
            <option value="2">客户退货</option>
            </select></td></tr>
        <tr><td>药品ID</td><td><input id="medicineId" name="medicineId" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>数量</td><td><input name="quantity"  class="easyui-validatebox" data-options="required:true," /></td></tr>
        <tr><td>日期</td><td><input name="time"  class="easyui-datebox" data-options="required:true" /></td></tr>
        <tr><td>质检人</td><td><input id="inspectorUp"  name="inspector" class="easyui-validatebox" limitToList="true"  data-options="required:true" /></td></tr>
        <tr><td><a id="btnUpBack" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">保存</a></td></tr>
    </table>
</form>

<script type="text/javascript">
    //初始化绑定数据
    var dgvUpBackParam = {
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
    $("#dgvUpBack").datagrid(dgvUpBackParam);

    //所有员工
    $('#inspectorUp').combobox({
        url:'user/fenYe2.action',
        valueField:'name',
        textField:'name'
    });
    $(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvBack").datagrid('getSelections');
        //将查询到的数据 绑定到编辑页面
        var id = selrows[0].backId;

        $('#upBack_form').form('load','Back/queryById.action?backId='+id);

    });

    //查询
    $("#btnSearchUpBack").click(function () {
        $("#dgvUpBack").datagrid('load', {name: $("#nameUpBack").val(), category: $("#categoryUpBack").val()});
    });

    //保存
    $("#btnUpBack").click(function () {
        //表单提交
        $('#upBack_form').form('submit', {
            url:"Back/update.action",
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
                $("#editBackWin").window("close");
                //刷新后台表格数据
                $("#dgvBack").datagrid('reload',{status:$("#statusBack").val(),type: $("#typeBack").val()});
            }
        });
    });

</script>
</body>
</html>
