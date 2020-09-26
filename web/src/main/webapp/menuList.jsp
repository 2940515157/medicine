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
名称：<input type="text" id="text">
类型ID：<input type="text" id="parentid">

<a id="btnSearchMenu" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<br>
<div id="menuTool">
    <a id="btnAddMenu" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">添加</a>
    <a id="btnEditMenu" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-edit'">修改</a>
    <a id="btnDeleteMenu" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-remove'">删除</a>
</div>
<table id="dgvMenu">

</table>


<div id="addMenuWin" class="easyui-window" title="添加用户"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'addMenu.jsp'">

</div>

<div id="editMenuWin" class="easyui-window" title="编辑用户"
     style="width:500px;height:450px;padding:10px;background:#fafafa;"
     data-options="iconCls:'icon-add',closable:true,closed:true,href:'updateMenu.jsp'">

</div>
<script type="text/javascript" >
    //点击添加用户按钮  面板 显示
    $("#btnAddMenu").click(function () {
        $("#addMenuWin").window("open");
    });

    //初始化绑定数据
    var dgvMenuParam ={
        url:'menu/fenYe.action',
        columns:[[
            {field:'checked',checkbox:true,title:'全选'},
            {field:'id',title:'ID',width:50,align:'center'},
            {field:'text',title:'名称',width:100,align:'center'},
            {field:'url',title:'URL',align:'center'},
            {field:'iconCls',title:'图标',align:'center'},
            {field:'state',title:'状态',width:100,align:'center'},
            {field:'parentid',title:'类型',width:110,align:'center', formatter: function (value, rows) {
                    if(rows.parentid==0){
                        return '权限管理';
                    }
                    if(rows.parentid==1){
                        return '用户管理';
                    }
                    if(rows.parentid==2){
                        return '供应商管理管理';
                    }
                    if(rows.parentid==3){
                        return '药品管理';
                    }
                    if(rows.parentid==4){
                        return '订单管理';
                    }
                    if(rows.parentid==5){
                        return '仓库管理';
                    }
                    if(rows.parentid==6){
                        return '财务管理';
                    }
                }
                }
        ]],
        pagination:true,  //分页工具栏 显示
        //singleSelect:true, //只能选一行
        pageList:[5,10,15,20],
        toolbar:'#MenuTool'
    };
    $("#dgvMenu").datagrid(dgvMenuParam);

    //查询
    $("#btnSearchMenu").click(function () {
        $("#dgvMenu").datagrid('load',{parentid:$("#parentid").val(),text:$("#text").val()});
    });

    //点击添加按钮
    $("#btnAddMenu").click(function () {

        $("#addMenuWin").window("open");
    });

    //点击修改按钮
    $("#btnEditMenu").click(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvMenu").datagrid('getSelections');
        if(selrows.length==0 || selrows.length>1){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        $("#editMenuWin").window('refresh', 'updateMenu.jsp');
        $("#editMenuWin").window("open");
    });

    //点击删除按钮
    $("#btnDeleteMenu").click(function (){
        //获取当前的选中的行记录
        var selrows  =$("#dgvMenu").datagrid('getSelections');
        if(selrows.length==0){
            $.messager.alert('消息','请选中一条记录','info');
            return;
        }
        //确认删除
        $.messager.confirm('确认对话框', '确定要删除这些记录吗？', function(r){
            if (r){
                for(var i=0;i<selrows.length;i++){
                    $.get("menu/delete.action",{id:selrows[i].id},function (data) {
                        $.messager.show({
                            title:'5秒后自动关闭',
                            msg:data==true?"删除成功":"删除失败",
                            timeout:5000,
                            showType:'slide'
                        });
                        //刷新表格
                        $("#dgvMenu").datagrid('reload',{parentid:$("#parentid").val(),text:$("#text").val()});
                        //刷新菜单
                        $("#tree").tree('reload');
                    });
                }

            }
        });
    });
</script>
</body>
</html>
