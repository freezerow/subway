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
    <link rel="stylesheet" href="https://cdn.bootcss.com/bootstrap/3.3.7/css/bootstrap.min.css">
    <link rel="stylesheet" href="../css/layui.css" media="all">
    <title>pflow</title>
</head>
<body>


<h1>地铁站热门进站时间</h1>
<table class="table table-striped table-hover" id="subay-table">
    <thead>
    <th>地铁站点名称</th>
    <th>地铁站点热门时间</th>
    <th>进站客流</th>
    <th>出站客流</th>
    </thead>
    <tbody>
    </tbody>
</table>
<div id="subpage" style="text-align: center"></div>
<h1>地铁站热门出站时间</h1>
<table class="table table-striped table-hover" id="subay-table-out">
    <thead>
    <th>地铁站点名称</th>
    <th>地铁站点热门时间</th>
    <th>进站客流</th>
    <th>出站客流</th>
    </thead>
    <tbody>
    </tbody>
</table>
<div id="subpage2" style="text-align: center"></div>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../layui.js"></script>
<script src="../js/jquery-3.1.1.min.js"></script>
<script type="text/javascript">

    $.post({           //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "http://localhost:8080/hottime1",
        dataType: "json",
        success: function (res) {
//              alert(res);
            var pagess = Math.ceil(res.length / 10);
            var tempObj = res;
            var pageArr = [];
            let tempArr = [];
            tempObj.map(item => {
                tempArr.push(item)
                if (pageArr.length===pagess-1) {
                    pageArr.push(tempArr);
                }
                if (tempArr.length === 10) {
                    pageArr.push(tempArr);
                    tempArr = [];
                }
            })

            $("#subay-table tbody").empty();
            pageArr[0].map(function (item, index) {
//                console.log(item)
                let temp = "<tr><td>" + item.station + "</td><td>" + item.hour + "</td><td>" + item.sin + "</td><td>" + item.sout + "</td></tr>";
                $("#subay-table tbody").append(temp);
            });
            layui.use('laypage', function () {
                var laypage = layui.laypage;
                //执行一个laypage实例
                laypage.render({
                    elem: 'subpage' //注意，这里的 test1 是 ID，不用加 # 号
                    , count: res.length //数据总数，从服务端得到
                    , limit: 10
                    , jump: function (obj, first) {
                        //obj包含了当前分页的所有参数，比如：
                        //console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                        $("#subay-table tbody").empty();
                        pageArr[obj.curr-1].map(function (item, index) {
//                console.log(item)
                            let temp = "<tr><td>" + item.station + "</td><td>" + item.hour + "</td><td>" + item.sin + "</td><td>" + item.sout + "</td></tr>";
                            $("#subay-table tbody").append(temp);
                        });
                        //首次不执行
                        if (!first) {
                            //do something
                        }
                    }
                });
            });
        }, error: function (errorMsg) {
            //请求失败时执行该函数
            alert("请求数据失败!");
        }
    });


</script>
<script type="text/javascript">

    $.post({           //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "http://localhost:8080/hottime2",
        dataType: "json",
        success: function (res) {
//              alert(res);
            var pagess = Math.ceil(res.length / 10);
            var tempObj = res;
            var pageArr = [];
            let tempArr = [];
            tempObj.map(item => {
                tempArr.push(item)
                if (pageArr.length===pagess-1) {
                    pageArr.push(tempArr);
                }
                if (tempArr.length === 10) {
                    pageArr.push(tempArr);
                    tempArr = [];
                }
            })

            $("#subay-table-out tbody").empty();
            pageArr[0].map(function (item, index) {
//                console.log(item)
                let temp = "<tr><td>" + item.station + "</td><td>" + item.hour + "</td><td>" + item.sin + "</td><td>" + item.sout + "</td></tr>";
                $("#subay-table-out tbody").append(temp);
            });
            layui.use('laypage', function () {
                var laypage = layui.laypage;
                //执行一个laypage实例
                laypage.render({
                    elem: 'subpage2' //注意，这里的 test1 是 ID，不用加 # 号
                    , count: res.length //数据总数，从服务端得到
                    , limit: 10
                    , jump: function (obj, first) {
                        //obj包含了当前分页的所有参数，比如：
                        //console.log(obj.curr); //得到当前页，以便向服务端请求对应页的数据。
                        $("#subay-table-out tbody").empty();
                        pageArr[obj.curr-1].map(function (item, index) {
//                console.log(item)
                            let temp = "<tr><td>" + item.station + "</td><td>" + item.hour + "</td><td>" + item.sin + "</td><td>" + item.sout + "</td></tr>";
                            $("#subay-table-out tbody").append(temp);
                        });
                        //首次不执行
                        if (!first) {
                            //do something
                        }
                    }
                });
            });
        }, error: function (errorMsg) {
            //请求失败时执行该函数
            alert("请求数据失败!");
        }
    });


</script>
</body>
</html>
