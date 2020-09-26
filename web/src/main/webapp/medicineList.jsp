<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/17
  Time: 15:41
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
名称：<input type="text" id="nameMedicineList"> 类型：<input type="text" id="categoryMedicineList">
<a id="btnSearchMedicine" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<div id="MedicineTool">
    <a id="btnAddMedicine" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">添加</a>
    <a id="btnEditMedicine" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">编辑</a>
    <a id="btnDeleteMedicine" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除</a>
</div>
<table id="dgvMedicine">

</table>


<div id="addMedicineWin" class="easyui-window" title="添加"
     style="width:900px;height:600px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'addMedicine.jsp'">

</div>
<div id="editMedicineWin" class="easyui-window" title="编辑"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'updateMedicine.jsp'">

</div>

<script type="text/javascript">
    //点击添加用户按钮  面板 显示
    $("#btnAddMedicine").click(function () {
        $("#addMedicineWin").window("open");
    });

    //初始化绑定数据
    var dgvMedicineParam = {
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
        onLoadSuccess: function () {
            $.parser.parse($("a:contains('重新申请')").parent());
        },
        pagination: true,  //分页工具栏 显示
        singleSelect: true, //只能选一行
        pageList: [5, 10, 15, 20],
        toolbar: '#MedicineTool'
    };
    $("#dgvMedicine").datagrid(dgvMedicineParam);

    //查询
    $("#btnSearchMedicine").click(function () {
        $("#dgvMedicine").datagrid('load', {name: $("#nameMedicineList").val(), category: $("#categoryMedicineList").val()});
    });


    //点击添加按钮
    $("#btnAddMedicine").click(function () {
        $("#addMedicineWin").window('refresh', 'addMedicine.jsp');
        $("#addMedicineWin").window("open");
    });

    //点击修改按钮
    $("#btnEditMedicine").click(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvMedicine").datagrid('getSelections');
        if(selrows.length==0 || selrows.length>1){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        $("#editMedicineWin").window('refresh', 'updateMedicine.jsp');
        $("#editMedicineWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteMedicine").click(function () {
        //获取当前的选中的行记录
        var selrows = $("#dgvMedicine").datagrid('getSelections');
        if (selrows.length == 0) {
            $.messager.alert('消息', '请选中一条记录', 'info');
            return;
        }
        var arrayId = [];
        $.each(selrows, function (index) {
            arrayId[index] = this.medicineId;
        })
        console.log(arrayId)
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function (r) {
            if (r) {
                var param = {
                    url: 'Medicine/delete.action',
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
                        $("#dgvMedicine").datagrid('reload', {name: $("#name").val(), category: $("#category").val()});
                    }
                };

                $.ajax(param);

            }
        });
    });
</script>
</body>
</html>
