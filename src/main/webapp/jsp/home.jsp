<%--
  Created by IntelliJ IDEA.
  User: wk
  Date: 2018/5/28
  Time: 23:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <!-- 引入 ECharts 文件 -->
    <title>home</title>
    <link rel="stylesheet" href="../css/layui.css" media="all">
    <style>
        .top {
            width: 100%;
        }

        .wrap-content > div {
            float: left;
            overflow: hidden;
        }

        .content-right {
            width: 100%;
        }
    </style>
</head>
<body>
<div class="top">

    <ul class="layui-nav layui-bg-blue top-lists" lay-filter="test">
        <span>地铁流量</span>
        <!-- 侧边导航: <ul class="layui-nav layui-nav-tree layui-nav-side"> -->
        <li class="layui-nav-item layui-this"><a href="javascript:;" name="index">一</a></li>
        <li class="layui-nav-item"><a href="javascript:;" name="index2">二</a></li>
        <li class="layui-nav-item"><a href="javascript:;" name="index3">三</a></li>
        <li class="layui-nav-item"><a href="javascript:;" name="index4">四</a></li>
        <li class="layui-nav-item"><a href="javascript:;" name="index5">五</a></li>
        <li class="layui-nav-item"><a href="javascript:;" name="index6">六</a></li>
        <li class="layui-nav-item"><a href="javascript:;" name="index7">七</a></li>
        <li class="layui-nav-item"><a href="javascript:;" name="index8">八</a></li>
    </ul>
</div>
<div class="wrap-content">
    <div class="content-right">
        <iframe id="itable" src="./index" scrolling="auto" frameborder="0" width="100%" height="1000"></iframe>
    </div>
</div>
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/echarts.js"></script>
<script src="../layui.js"></script>
<script>
    layui.use('element', function () {
        var element = layui.element;
        $(".top-lists li").on("click", function (ev) {
            $("#itable").attr("src", $(this).find("a").attr('name'))
            var ifm = document.getElementById("itable");
            ifm.height = document.documentElement.clientHeight;
        })
        //…
    });
</script>
</body>
</html>
