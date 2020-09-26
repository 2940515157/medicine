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
用户名：<input type="text" id="username">部门:<select id="department" class="easyui-combobox" style="width:167px;">
    <option value="">请选择</option>
    <option value="人事部">人事部</option>
    <option value="财务部">财务部</option>
    <option value="市场部">市场部</option>
    <option value="技术部">技术部</option>
    <option value="后勤部">后勤部</option>
</select>
<a id="btnSearchUser" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<div id="UserTool">
    <a id="btnAddUser" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">添加</a>
    <a id="btnEditUser" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">编辑</a>
    <a id="btnDeleteUser" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除</a>
</div>
<table id="dgvUser">

</table>


<div id="addUserWin" class="easyui-window" title="添加"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'addUser.jsp'">

</div>

<div id="editUserWin" class="easyui-window" title="编辑"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'updateUser.jsp'">

</div>
<script type="text/javascript" >
    //点击添加用户按钮  面板 显示
    $("#btnAddUser").click(function () {
        $("#addUserWin").window("open");
    });

    //初始化绑定数据
    var dgvUserParam ={
        url:'user/fenYe.action',
        columns:[[
            {field:'checked',checkbox:true,title:'全选'},
            {field:'userId',title:'ID',width:50,align:'center'},
            {field:'username',title:'用户名',width:100,align:'center'},
            {field:'pwd',title:'密码',width:100,align:'center',formatter: function (value, rows) {
                    return "******";
                }},
            {field:'name',title:'姓名',width:100,align:'center'},
            {field:'department',title:'部门',width:100,align:'center'},
            {field:'sex',title:'性别',width:100,align:'center'},
            {field:'tel',title:'电话',width:100,align:'center'},
            {field:'address',title:'地址',width:100,align:'center'}
        ]],
        pagination:true,  //分页工具栏 显示
        //singleSelect:true, //只能选一行
        pageList:[5,10,15,20],
        toolbar:'#UserTool'
    };
    $("#dgvUser").datagrid(dgvUserParam);

    //查询
    $("#btnSearchUser").click(function () {
        $("#dgvUser").datagrid('load',{username:$("#username").val(),department:$("#department").val()});
    });

    //点击添加按钮
    $("#btnAddUser").click(function () {

        $("#addUserWin").window("open");
    });

    //点击修改按钮
    $("#btnEditUser").click(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvUser").datagrid('getSelections');
        if(selrows.length==0 || selrows.length>1){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        $("#editUserWin").window('refresh', 'updateUser.jsp');
        $("#editUserWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteUser").click(function (){
        //获取当前的选中的行记录
        var selrows  =$("#dgvUser").datagrid('getSelections');
        if(selrows.length==0 ){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        //确认删除
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function(r){
            if (r){
                for(var i=0;i<selrows.length;i++){
                    $.get("user/delete.action",{userId:selrows[i].userId},function (data) {
                        $.messager.show({
                            title:'5秒后自动关闭',
                            msg:data==true?"删除成功":"删除失败",
                            timeout:5000,
                            showType:'slide'
                        });
                        //刷新表格
                        $("#dgvUser").datagrid('reload',{username:$("#username").val(),department:$("#department").val()});
                    });
                }
            }
        });
    });
</script>
</body>
</html>
