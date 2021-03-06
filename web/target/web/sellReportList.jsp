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
<span style="font-weight: bolder;font-size: 25px;margin-left: 200px;">销售报表</span><br><br>
<table id="dgvSellReport">

</table>
<script type="text/javascript">
    //初始化绑定数据
    var dgvSellReportParams = {
        url: 'SellReport/fenYe.action',
        columns: [[
            {field: 'checked', checkbox: true, title: '全选'},
            {field: 'sellReportId', title: 'ID', width: 50, align: 'center'},
            {field: 'sellId', title: '订单ID', width: 50, align: 'center'},
            {
                field: 'name', title: '名称', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.sell.medicine.name;
                }
            },
            {
                field: 'price', title: '单价', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.sell.medicine.price;
                }
            },
            {
                field: 'quantity', title: '数量', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.sell.quantity;
                }
            },
            {field: 'sum', title: '金额', width: 100, align: 'center'},
            {field: 'time', title: '日期', width: 100, align: 'center'}
        ]],
        pagination: true,  //分页工具栏 显示
        singleSelect: true, //只能选一行
        pageList: [5, 10, 15, 20]
    };
    $("#dgvSellReport").datagrid(dgvSellReportParams);

</script>
</body>
</html>
