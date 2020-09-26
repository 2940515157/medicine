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
名称：<input type="text" id="nameUpStock"> 类型：<input type="text" id="categoryUpStock">
<a id="btnSearchUpStock" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<table id="dgvUpStock">

</table>
<form id="upStock_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input name="stockId" class="easyui-validatebox" readonly="readonly" data-options="required:true"></td></tr>
        <tr><td>药品ID</td><td><input id="goodsId2" name="goodsId" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>数量</td><td><input name="quantity" class="easyui-validatebox" data-options="required:true," /></td></tr>
        <tr><td>日期</td><td><input name="time" class="easyui-datebox" data-options="required:true" /></td></tr>
        <tr><td>质检人</td><td><input id="accepterUpStock" name="accepter" class="easyui-validatebox" limitToList="true"  data-options="required:true" /></td></tr>
        <tr><td><a id="btnUpStock" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">保存</a></td></tr>
    </table>
</form>

<script type="text/javascript">
    //初始化绑定数据
    var dgvUpStockParam = {
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
            $("#goodsId2").val(row.goodsId);
        }
    };
    $("#dgvUpStock").datagrid(dgvUpStockParam);

    //所有员工
    $('#accepterUpStock').combobox({
        url:'user/fenYe2.action',
        valueField:'name',
        textField:'name'
    });
    $(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvStock").datagrid('getSelections');
        //将查询到的数据 绑定到编辑页面
        var id = selrows[0].stockId;

        $('#upStock_form').form('load','Stock/queryById.action?stockId='+id);

    });

    //查询
    $("#btnSearchUpStock").click(function () {
        $("#dgvUpStock").datagrid('load', {name: $("#nameUpStock").val(), category: $("#categoryUpStock").val()});
    });

    $("#btnUpStock").click(function () {
        //表单提交
        $('#upStock_form').form('submit', {
            url:"Stock/update.action",
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
                $("#editStockWin").window("close");
                //刷新后台表格数据
                $("#dgvStock").datagrid('reload',{status:$("#statusStock").val()});
            }
        });
    });

</script>
</body>
</html>
