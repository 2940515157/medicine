<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/19
  Time: 18:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<h3>修改</h3>
<form id="upGoods_form" method="post">
    <table style="border-spacing:0px 10px;">
        <tr><td>ID</td><td><input name="goodsId" type="text" readonly="readonly"/></td></tr>
        <tr><td>名称</td><td><input name="name" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>规格</td><td><input name="guige" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>类型</td><td><input name="category" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>价格</td><td><input name="price" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td>供应商</td><td><input id="sup" name="supplierId"   limitToList="true"  data-options="required:true" /></td></tr>
        <tr><td>生产时间</td><td><input name="createtime" class="easyui-datebox" data-options="required:true" /></td></tr>
        <tr><td>产地</td><td><input name="chandi" class="easyui-validatebox" data-options="required:true" /></td></tr>
        <tr><td><a id="btnUpGoods" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-edit'">保存</a></td></tr>
    </table>
</form>

<script type="text/javascript">
    $('#sup').combobox({
        url:'supplier/queryAll.action',
        valueField:'supplierId',
        textField:'name',
        editable:false
    });
    $(function () {
        //获取当前的选中的行记录
        var selrows  =$("#dgvGoods").datagrid('getSelections');
        //将查询到的数据 绑定到编辑页面
        var id = selrows[0].goodsId;

        $('#upGoods_form').form('load','goods/queryById.action?goodsId='+id);

    });

    $("#btnUpGoods").click(function () {
        //表单提交
        $('#upGoods_form').form('submit', {
            url:"goods/update.action",
            onSubmit: function(){
                return $(this).form("validate");
            },
            success:function(data){
                $.messager.show({
                    title:'5秒后自动关闭',
                    msg:data=="true"?"修改成功":"修改失败",
                    timeout:5000,
                    showType:'slide'
                });
                //关闭添加窗口
                $("#editGoodsWin").window("close");
                //刷新后台表格数据
                $("#dgvGoods").datagrid('reload',{name:$("#name").val(),category:$("#category").val()});
            }
        });
    });

</script>
</body>
</html>
