<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/21
  Time: 19:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
姓名：<input type="text" id="name">
<a id="btnSearchClient" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<div id="ClientTool">
    <a id="btnAddClient" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">添加</a>
    <a id="btnEditClient" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">编辑</a>
    <a id="btnDeleteClient" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除</a>
</div>
<table id="dgvClient">

</table>


<div id="addClientWin" class="easyui-window" title="添加"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'addClient.jsp'">

</div>

<div id="editClientWin" class="easyui-window" title="编辑"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'updateClient.jsp'">

</div>
<script type="text/javascript" >
    //点击添加用户按钮  面板 显示
    $("#btnAddClient").click(function () {
        $("#addClientWin").window("open");
    });

    //初始化绑定数据
    var dgvClientParam ={
        url:'client/fenYe.action',
        columns:[[
            {field:'checked',checkbox:true,title:'全选'},
            {field:'clientId',title:'ID',width:50,align:'center'},
            {field:'name',title:'姓名',width:100,align:'center'},
            {field:'sex',title:'性别',width:100,align:'center'},
            {field:'tel',title:'电话',width:100,align:'center'},
            {field:'address',title:'地址',width:100,align:'center'}
        ]],
        pagination:true,  //分页工具栏 显示
        //singleSelect:true, //只能选一行
        pageList:[5,10,15,20],
        toolbar:'#ClientTool'
    };
    $("#dgvClient").datagrid(dgvClientParam);

    //查询
    $("#btnSearchClient").click(function () {
        $("#dgvClient").datagrid('load',{name:$("#name").val()});
    });

    //点击添加按钮
    $("#btnAddClient").click(function () {

        $("#addClientWin").window("open");
    });

    //点击修改按钮
    $("#btnEditClient").click(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvClient").datagrid('getSelections');
        if(selrows.length==0 || selrows.length>1){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        $("#editClientWin").window('refresh', 'updateClient.jsp');
        $("#editClientWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteClient").click(function (){
        //获取当前的选中的行记录
        var selrows  =$("#dgvClient").datagrid('getSelections');
        if(selrows.length==0 ){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        //确认删除
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function(r){
            if (r){
                for(var i=0;i<selrows.length;i++){
                    $.get("client/delete.action",{clientId:selrows[i].clientId},function (data) {
                        $.messager.show({
                            title:'5秒后自动关闭',
                            msg:data==true?"删除成功":"删除失败",
                            timeout:5000,
                            showType:'slide'
                        });
                        //刷新表格
                        $("#dgvClient").datagrid('reload',{name:$("#name").val()});
                    });
                }

            }
        });
    });
</script>
</body>
</html>
