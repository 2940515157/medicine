<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/9/3
  Time: 10:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
<span style="font-weight: bolder;font-size: 25px;margin-left: 200px;">账单</span><br><br>
开始时间：<input id="financeStartTime" class="easyui-datebox"  />
截至时间: <input id="financeEndTime" class="easyui-datebox"  />
<a id="btnSearchFinance" href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'">查询</a>
<table id="dgvFinance">

</table>
收入：<span id="sr" style="color:red;font-size: 18px"></span>
&nbsp;&nbsp;&nbsp;
支出：<span id="zc" style="color:red;font-size: 18px"></span>
&nbsp;&nbsp;&nbsp;
利润：<span id="lr" style="color:red;font-size: 18px"></span>
<script type="text/javascript">
    //初始化绑定数据
    var dgvFinanceParams = {
        url: 'Finance/fenYe.action',
        columns: [[
            {field: 'checked', checkbox: true, title: '全选'},
            {field: 'financeId', title: 'ID', width: 50, align: 'center'},
            {field: 'remark', title: '类型', width: 100, align: 'center'},
            {field: 'name', title: '药品', width: 100, align: 'center'},
            {field: 'quantity', title: '数量', width: 100, align: 'center'},
            {field: 'price', title: '单价', width: 100, align: 'center'},
            {field: 'sum', title: '金额', width: 100, align: 'center'},
            {field: 'time', title: '日期', width: 100, align: 'center'}
        ]],
        pagination: true,  //分页工具栏 显示
        singleSelect: true, //只能选一行
        pageList: [5, 10, 15, 20],
        onLoadSuccess:function () {
            var rows = $("#dgvFinance").datagrid("getRows");
            var srmoney=0;
            var zcmoney=0;
            for(var i=0;i<rows.length;i++){
                //获取每一行的数据
                if (rows[i].sum>0){
                    srmoney+=rows[i].sum;
                }
                if (rows[i].sum<0){
                    zcmoney+=rows[i].sum;
                }
            }
            $("#sr").text(srmoney);
            $("#zc").text(zcmoney);
            $("#lr").text(srmoney+zcmoney);
        }
    };
    $("#dgvFinance").datagrid(dgvFinanceParams);

    //查询
    $("#btnSearchFinance").click(function () {
        $("#dgvFinance").datagrid('load',{starttime:$("#financeStartTime").val(),endtime:$("#financeEndTime").val()});
    });
</script>
</body>
</html>
