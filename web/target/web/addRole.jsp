<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/19
  Time: 10:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>添加</h3>
<form id="addRole_form" method="post">
    角色:<input name="name" class="easyui-validatebox" data-options="required:true" /><br><br>
    备注:<input name="remark" class="easyui-validatebox"  /><br><br>
    <a id="btnSaveRole" href="javascript:void(0)" class="easyui-linkbutton"
       data-options="iconCls:'icon-add'">保存</a>
</form>
<script type="text/javascript">
    $("#btnSaveRole").click(function () {
        //表单提交
        $('#addRole_form').form('submit', {
            url:"role/add.action",

            onSubmit: function(){
                return $(this).form("validate");
            },
            success:function(data){
                $.messager.show({
                    title:'5秒后自动关闭',
                    msg: data=="true"?"添加成功":"添加失败",
                    timeout:5000,
                    showType:'slide'
                });
                $('#addRole_form').form('clear');
                //关闭添加窗口
                $("#addRoleWin").window("close");
                //刷新后台表格数据
                $("#dgvRole").datagrid('reload');
            }
        });
    });
</script>
</body>
</html>
