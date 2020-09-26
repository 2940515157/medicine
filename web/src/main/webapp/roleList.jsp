<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/17
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
名称：<input type="text" id="name">
<a id="btnSearchRole" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<div id="roleTool">
    <a id="btnAddRole" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">添加</a>
    <a id="btnEditRole" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">编辑</a>
    <a id="btnDeleteRole" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除</a>
</div>
<table id="dgvRole">

</table>


<div id="addRoleWin" class="easyui-window" title="添加"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'addRole.jsp'">

</div>

<div id="editRoleWin" class="easyui-window" title="编辑"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'updateRole.jsp'">

</div>
<script type="text/javascript" >
    //点击添加用户按钮  面板 显示
    $("#btnAddRole").click(function () {
        $("#addRoleWin").window("open");
    });

    //初始化绑定数据
    var dgvRoleParam ={
        url:'role/fenYe.action',
        columns:[[
            {field:'checked',checkbox:true,title:'全选'},
            {field:'roleId',title:'ID',width:50,align:'center'},
            {field:'name',title:'名称',width:100,align:'center'},
            {field:'remark',title:'备注',width:200,align:'center'}
        ]],
        pagination:true,  //分页工具栏 显示
        //singleSelect:true, //只能选一行
        pageList:[5,10,15,20],
        toolbar:'#roleTool'
    };
    $("#dgvRole").datagrid(dgvRoleParam);

    //查询
    $("#btnSearchRole").click(function () {
        $("#dgvRole").datagrid('load',{name:$("#name").val()});
    });

    //点击添加按钮
    $("#btnAddRole").click(function () {

        $("#addRoleWin").window("open");
    });

    //点击修改按钮
    $("#btnEditRole").click(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvRole").datagrid('getSelections');
        if(selrows.length==0 || selrows.length>1){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        $("#editRoleWin").window('refresh', 'updateRole.jsp');
        $("#editRoleWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteRole").click(function (){
        //获取当前的选中的行记录
        var selrows  =$("#dgvRole").datagrid('getSelections');
        if(selrows.length==0 ){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        //确认删除
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function(r){
            if (r){
                for(var i=0;i<selrows.length;i++){
                    $.get("role/delete.action",{roleId:selrows[i].roleId},function (data) {
                        $.messager.show({
                            title:'5秒后自动关闭',
                            msg:data==true?"删除成功":"删除失败",
                            timeout:5000,
                            showType:'slide'
                        });
                        //刷新表格
                        $("#dgvRole").datagrid('reload',{name:$("#name").val()});
                    });
                }

            }
        });
    });
</script>
</body>
</html>
