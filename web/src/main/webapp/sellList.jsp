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
<span style="font-weight: bolder;font-size: 25px;margin-left: 300px;">销售订单</span><br><br>
售货人:<input id="sellerSell"  />
状态<select id="statusSell" class="easyui-combobox" style="width:200px;">
    <option value="-1">请选择</option>
    <option value="0">待审核</option>
    <option value="1">已批准</option>
    <option value="2">未批准</option>
</select>
<a id="btnSearchSell" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<div id="SellTool">
    <a id="btnAddSell" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">添加</a>
    <a id="btnEditSell" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">编辑</a>
    <a id="btnDeleteSell" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除</a>
</div>
<table id="dgvSell">

</table>


<div id="addSellWin" class="easyui-window" title="添加"
     style="width:900px;height:600px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'addSell.jsp'">

</div>
<div id="editSellWin" class="easyui-window" title="编辑"
     style="width:900px;height:600px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'updateSell.jsp'">

</div>

<script type="text/javascript">
    //点击添加用户按钮  面板 显示
    $("#btnAddSell").click(function () {
        $("#addSellWin").window("open");
    });

    //初始化绑定数据
    var dgvSellParam = {
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
                        return '<font color="red">没批准</font>';
                    }
                }
            },
            {
                field: 'caozuo', title: '操作',width:'100', align: 'center', formatter: function (value, rows) {
                    if (rows.status == 2) {
                        return '<button  class="reSell">重新申请</button> ';
                    }
                }
            }
        ]],
        pagination: true,  //分页工具栏 显示
        singleSelect: true, //只能选一行
        pageList: [5, 10, 15, 20],
        toolbar: '#SellTool'
    };
    $("#dgvSell").datagrid(dgvSellParam);
    //所有员工
    $('#sellerSell').combobox({
        url:'user/fenYe2.action',
        valueField:'name',
        textField:'name'
    });

    //查询
    $("#btnSearchSell").click(function () {
        $("#dgvSell").datagrid('load', {status:$("#statusSell").val(),seller: $("#sellerSell").val()});
    });

    //重新申请
    $(document).on('click',".reSell",function (e) {
        var selrows = $("#dgvSell").datagrid('getSelections');
        $.get("Sell/shenqing.action",{sellId:selrows[0].sellId},function (data) {
            $.messager.show({
                title:'5秒后自动关闭',
                msg:data==true?"申请成功":"申请失败",
                timeout:5000,
                showType:'slide'
            });
            //刷新表格
            $("#dgvSell").datagrid('reload',{status:$("#statusSell").val(),seller: $("#sellerSell").val()});

        });
    });

    //点击添加按钮
    $("#btnAddSell").click(function () {
        $("#addSellWin").window('refresh', 'addSell.jsp');
        $("#addSellWin").window("open");
    });

    //点击修改按钮
    $("#btnEditSell").click(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvSell").datagrid('getSelections');
        if(selrows.length==0 || selrows.length>1){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        if (selrows[0].status==1){
            $.messager.alert('消息','已批准不能修改','info');
            return ;
        }
        $("#editSellWin").window('refresh', 'updateSell.jsp');
        $("#editSellWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteSell").click(function () {
        //获取当前的选中的行记录
        var selrows = $("#dgvSell").datagrid('getSelections');
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
            arrayId[index] = this.sellId;
        })
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function (r) {
            if (r) {
                var param = {
                    url: 'Sell/delete.action',
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
                        $("#dgvSell").datagrid('reload', {status: $("#statusSell").val(),seller: $("#sellerSell").val()});
                    }
                };

                $.ajax(param);

            }
        });
    });

</script>
</body>
</html>
