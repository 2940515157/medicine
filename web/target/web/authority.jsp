<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/17
  Time: 16:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>

<div id="cc" class="easyui-layout" data-options="fit:true">

    <div data-options="region:'west',title:'角色选择',split:true" style="width:300px;">
        <!-- 显示角色列表-->
        <table id="priv_dgvrole"></table>
    </div>
    <div data-options="region:'center',title:'菜单选择'" style="width:300px;padding:5px;">
        <!-- 显示菜单树控件 -->
        <ul id="priv_treemenu"></ul>
        <a id="btnAuthority" href="#" class="easyui-linkbutton" data-options="iconCls:'icon-vcard_key'">授权</a>
    </div>

</div>

<script>
    var roleId =0;
    //加载角色信息
    var priv_dgvroleparam ={
        url:'role/fenYe.action',
        columns:[[
            {field:'checked',checkbox:true,title:'全选'},
            {field:'roleId',title:'ID',width:50,align:'center',hidden:'true'},
            {field:'name',title:'名称',width:100,align:'center'},
            {field:'remark',title:'备注',width:100,align:'center'},
        ]],
        singleSelect:true,
        onClickRow:function (rowIndex, rowData) {
            //点击角色  将角色id传给菜单url  获取菜单数据
            roleId = rowData.roleId;
            //刷线菜单的加载
            $('#priv_treemenu').tree("reload");
        }
    };
    $('#priv_dgvrole').datagrid(priv_dgvroleparam);

    //加载菜单信息
    var priv_treemenuparam = {
        url:'menu/queryMenu2.action',
        checkbox:true,
        queryParams:{"roleId":roleId},
        onBeforeLoad:function (node, param) {
            param.roleId =roleId;
        }
    }
    $('#priv_treemenu').tree(priv_treemenuparam);

    //授权
    $("#btnAuthority").click(function () {

        //选中角色id   datagrid
        var selrow = $("#priv_dgvrole").datagrid('getSelected');
        if(selrow ==null){
            alert("请选择一个角色！");
            return;
        }
        var roleId = selrow.roleId;

        //选中菜单id
        var nodes = $('#priv_treemenu').tree('getChecked', ['checked','indeterminate']);
        var mids="";
        for (var i = 0;i<nodes.length;i++){
            mids += nodes[i].id+",";
        }

        $.post("menu/addAuthority.action",{"roleId":roleId,"mids":mids},function (data) {
                $.messager.show({
                    title:'5秒后自动关闭',
                    msg: data?"授权成功":"授权失败",
                    timeout:5000,
                    showType:'slide'
                });
            //刷新菜单
            $("#tree").tree('reload');
        },"json")
    });

</script>
</body>
</html>
