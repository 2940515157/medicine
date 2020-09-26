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
名称：<input type="text" id="name">
<a id="btnSearchSupplier" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<div id="SupplierTool">
    <a id="btnAddSupplier" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">添加</a>
    <a id="btnEditSupplier" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">编辑</a>
    <a id="btnDeleteSupplier" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除</a>
</div>
<table id="dgvSupplier">

</table>


<div id="addSupplierWin" class="easyui-window" title="添加"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'addSupplier.jsp'">

</div>

<div id="editSupplierWin" class="easyui-window" title="编辑"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'updateSupplier.jsp'">

</div>
<script type="text/javascript" >
    //点击添加用户按钮  面板 显示
    $("#btnAddSupplier").click(function () {
        $("#addSupplierWin").window("open");
    });

    //初始化绑定数据
    var dgvSupplierParam ={
        url:'supplier/fenYe.action',
        columns:[[
            {field:'checked',checkbox:true,title:'全选'},
            {field:'supplierId',title:'ID',width:50,align:'center'},
            {field:'name',title:'名称',align:'center'},
            {field:'tel',title:'电话',width:100,align:'center'},
            {field:'address',title:'地址',width:100,align:'center'}
        ]],
        pagination:true,  //分页工具栏 显示
        //singleSelect:true, //只能选一行
        pageList:[5,10,15,20],
        toolbar:'#SupplierTool'
    };
    $("#dgvSupplier").datagrid(dgvSupplierParam);

    //查询
    $("#btnSearchSupplier").click(function () {
        $("#dgvSupplier").datagrid('load',{name:$("#name").val()});
    });

    //点击添加按钮
    $("#btnAddSupplier").click(function () {

        $("#addSupplierWin").window("open");
    });

    //点击修改按钮
    $("#btnEditSupplier").click(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvSupplier").datagrid('getSelections');
        if(selrows.length==0 || selrows.length>1){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        $("#editSupplierWin").window('refresh', 'updateSupplier.jsp');
        $("#editSupplierWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteSupplier").click(function (){
        //获取当前的选中的行记录
        var selrows  =$("#dgvSupplier").datagrid('getSelections');
        if(selrows.length==0 ){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        //确认删除
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function(r){
            if (r){
                for(var i=0;i<selrows.length;i++){
                    $.get("supplier/delete.action",{supplierId:selrows[i].supplierId},function (data) {
                        $.messager.show({
                            title:'5秒后自动关闭',
                            msg:data==true?"删除成功":"删除失败",
                            timeout:5000,
                            showType:'slide'
                        });
                        //刷新表格
                        $("#dgvSupplier").datagrid('reload',{name:$("#name").val()});
                    });
                }

            }
        });
    });
</script>
</body>
</html>
