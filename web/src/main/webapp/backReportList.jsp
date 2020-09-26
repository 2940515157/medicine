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
<span style="font-weight: bolder;font-size: 25px;margin-left: 200px;">退货报表</span><br><br>
<table id="dgvBackReport">

</table>
<script type="text/javascript">
    //初始化绑定数据
    var dgvBackReportParams = {
        url: 'BackReport/fenYe.action',
        columns: [[
            {field: 'checked', checkbox: true, title: '全选'},
            {field: 'backReportId', title: 'ID', width: 50, align: 'center'},
            {field: 'backId', title: '订单ID', width: 50, align: 'center'},
            {
                field: 'name', title: '名称', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.back.medicine.name;
                }
            },
            {
                field: 'type', title: '退货类型', width: 100, align: 'center', formatter: function (value, rows) {
                    if (rows.back.type==1){
                        return '公司退货';
                    }else if (rows.back.type==2){
                        return '客户退货';
                    }
                }
            },
            {
                field: 'price', title: '单价', width: 100, align: 'center', formatter: function (value, rows) {
                    if (rows.back.type){
                        return rows.back.medicine.inventory.stock.goods.price;
                    }else if (rows.back.type){
                        return rows.back.medicine.price;
                    }
                }
            },
            {
                field: 'quantity', title: '数量', width: 100, align: 'center', formatter: function (value, rows) {
                    return rows.back.quantity;
                }
            },
            {field: 'sum', title: '金额', width: 100, align: 'center'},
            {field: 'time', title: '日期', width: 100, align: 'center'}
        ]],
        pagination: true,  //分页工具栏 显示
        singleSelect: true, //只能选一行
        pageList: [5, 10, 15, 20]
    };
    $("#dgvBackReport").datagrid(dgvBackReportParams);

</script>
</body>
</html>
