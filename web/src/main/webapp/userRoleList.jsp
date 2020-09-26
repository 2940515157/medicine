<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/19
  Time: 15:49
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<div id="bb" class="easyui-layout" data-options="fit:true">
    <div data-options="region:'west',title:'用户选择',split:true" style="width:300px;">
        <!-- 显示用户列表-->
        <table id="ur_dgvuser"></table>
    </div>
    <div data-options="region:'center',title:'角色选择'" style="width:400px;padding:5px;">
        <!-- 显示角色 -->
        <table id="ur_dgvrole"></table>
        <a id="btnUserRole" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-vcard_key'">授权</a>
    </div>
</div>

<script>
    var userId =0;
    //加载用户信息
    var ur_dgvuserparam ={
        url:'user/fenYe.action',
        columns:[[
            {field:'userId',title:'ID',width:100,align:'center',hidden:'true'},
            {field:'username',title:'用户名',width:100,align:'center'},
            {field:'department',title:'部门',width:100,align:'center'}
        ]],
        singleSelect:true,
        onClickRow:function (rowIndex, rowData) {
            //点击角色  将角色id传给菜单url  获取菜单数据
            userId = rowData.userId;
            //刷线菜单的加载
            $('#ur_dgvrole').datagrid("reload",{"userId":userId});
        }
    };
    $('#ur_dgvuser').datagrid(ur_dgvuserparam);

    //加载角色信息
    var ur_treeroleparam = {
        url:'role/queryByUserId.action',
        columns:[[
            {field:'checked',checkbox:true,title:'全选'},
            {field:'roleId',title:'ID',width:100,align:'center',hidden:'true'},
            {field:'name',title:'名称',width:100,align:'center'},
            {field:'remark',title:'备注',width:150,align:'center'}
        ]],
        checkbox:true,
        queryParams:{"userId":userId},
        onBeforeLoad:function (rowIndex, rowData) {

        }
    }
    $('#ur_dgvrole').datagrid(ur_treeroleparam);

    //授权
    $("#btnUserRole").click(function () {

        //选中角色id
        var selrow = $("#ur_dgvuser").datagrid('getSelected');
        if(selrow ==null){
            alert("请选择一个角色！");
            return;
        }
        var userId = selrow.userId;

        //选中菜单id
        var nodes = $('#ur_dgvrole').datagrid('getSelections');
        var roleIds="";
        for (var i = 0;i<nodes.length;i++){
            roleIds += nodes[i].roleId+",";
        }
        $.post("role/userAddRole.action",{"userId":userId,"roleIds":roleIds},function (data) {
            $.messager.show({
                title:'5秒后自动关闭',
                msg: data?"授权成功":"授权失败",
                timeout:5000,
                showType:'slide'
            });
            //刷新菜单
            $("#tree").tree('reload');
        },"json");
    });

</script>
</body>
</html>
