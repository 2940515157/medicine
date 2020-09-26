<%--
  Created by IntelliJ IDEA.
  User: weikang
  Date: 2020/8/17
  Time: 14:17
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <!-- jquery-->
    <script type="text/javascript" src="js/jquery.min.js"></script>
    <!-- easyui-->
    <script type="text/javascript" src="js/jquery.easyui.min.js"></script>
    <!-- 语言包-->
    <script type="text/javascript" src="js/easyui-lang-zh_CN.js"></script>
    <!-- 主题-->
    <link rel="stylesheet" href="themes/default/easyui.css"/>
    <!-- 图标-->
    <link rel="stylesheet" href="themes/icon.css"/>
    <!-- 扩展图标的样式-->
    <link rel="stylesheet" href="themes/IconExtension.css" />
</head>
<body class="easyui-layout">

<div data-options="region:'north'" style="height:110px;">
    <h1>药品管理系统</h1>
    <h4 style="margin-left: 30px">
    ${user.username} 登陆了
    <button id="exit">注销</button>
    </h4>
</div>

<div data-options="region:'west',title:'菜单管理'" style="width:180px;">
    <div id="tree" class="easyui-tree" data-options="url:'menu/queryMenu3.action?userId=${user.userId}' "></div>
</div>

<div  data-options="region:'center'">
    <div id="tt" class="easyui-tabs" data-options="fit:true" style="width:500px;height:250px;">
        <div title="首页" style="padding:20px;display:none;">
            <h2>欢迎使用本系统</h2>
        </div>
    </div>
</div>

<div  data-options="region:'center',href:'center.jsp'"></div>
<script type="text/javascript">
    $(window).load(function () {
        $("#tree").tree({
            onClick: function(node){

                var url =node.attributes.url;
                if(url==undefined || url==""){
                    return;
                }
 
                if($("#tt").tabs('exists',node.text)){
                    //select
                    $("#tt").tabs('select',node.text);
                }else{
                    //add
                    $("#tt").tabs('add',
                        {title:node.text,
                            selected:true,
                            href:node.attributes.url,
                            iconCls:'icon-reload',
                            closable:true});
                }
            }

        });
    });
    $("#exit").click(function (){
        window.location="login.jsp";
    })
</script>
</body>
</html>
