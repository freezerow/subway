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
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div style="overflow: hidden">
    <div id="main" style="width:1024px;height:768px;float: left"></div>
    <div style="float: left">
        <h1 style="
        display: block;
        font-size: 2em;
        -webkit-margin-before: 0.67em;
        -webkit-margin-after: 0.67em;
        -webkit-margin-start: 0px;
        -webkit-margin-end: 0px;
        font-weight: bold;">旅客去向目的分析</h1>
        <h3 style="display: block;
        font-size: 1.17em;
         -webkit-margin-before: 1em;
        -webkit-margin-after: 1em;
        -webkit-margin-start: 0px;
        -webkit-margin-end: 0px;
        font-weight: bold;">乘坐地铁的大部分乘客都有明确的目的，根据其做到站点与地铁站的关系可以<br>
                            看出旅客出行的目的，从而对旅客乘坐地铁的目的有一个大致的分析，从而可<br>
                            以给相关旅客给予定制化的推荐服务，本图根据热门路线数据制作，可完善为<br>
                            所有旅行顾客的分析。
            </h3>
    </div>
</div>


<h1>地铁站热门路线</h1>
<table class="table table-striped table-hover" id="subay-table">
    <thead>
    <th>地铁进站站点名称</th>
    <th>地铁出站站点名称</th>
    <th>客流</th>
    </thead>
    <tbody>
    </tbody>
</table>
<%--<div id="subpage" style="text-align: center"></div>--%>
<h1>地铁站热门路线</h1>
<table class="table table-striped table-hover" id="subay-table-out">
    <thead>
    <th>地铁进站站点名称</th>
    <th>地铁出站站点名称</th>
    <th>客流</th>
    </thead>
    <tbody>
    </tbody>
</table>
<div id="subpage2" style="text-align: center"></div>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../layui.js"></script>
<script src="../js/jquery-3.1.1.min.js"></script>
<script src="../js/echarts.js"></script>
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    // 指定图表的配置项和数据
    var option = {
        title : {
            text: '旅客去向目的分析',
            subtext: 'subway',
            x:'center'
        },
        tooltip : {
            trigger: 'item',
            formatter: "{a} <br/>{b} : {c} ({d}%)"
        },
        legend: {
            orient: 'vertical',
            left: 'left',
            data: []
        },
        series : [
            {
                name: '来源',
                type: 'pie',
                radius : '55%',
                center: ['50%', '60%'],
                data:[],
                itemStyle: {
                    emphasis: {
                        shadowBlur: 10,
                        shadowOffsetX: 0,
                        shadowColor: 'rgba(0, 0, 0, 0.5)'
                    }
                }
            }
        ]
    };

    // 使用刚指定的配置项和数据显示图表。
    //      myChart.showLoading();
    //       {value:335, name:'直接访问'},
    var names2 = [];
    $.get({           //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url : "http://localhost:8080/analysis",
        dataType : "json",
        success: function (res) {

            if(res){
                for(var i = 0; i < res.length; i++){
                    names2.push(res[i].name);
                }
            }
            option.legend.data=names2;
            option.series[0].data = res;
            // json string => json object JSON.parse(data)
            // 为echarts对象加载数据
            myChart.setOption(option);
        }, error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败!");
            myChart.hideLoading();
        }
    });


</script>
<script type="text/javascript">

    $.post({           //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "http://localhost:8080/subwaystationhot",
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
                let temp = "<tr><td>" + item.sin + "</td><td>" + item.sout + "</td><td>" + item.count + "</td></tr>";
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
                            let temp = "<tr><td>" + item.sin + "</td><td>" + item.sout + "</td><td>" + item.count + "</td></tr>";
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
        url: "http://localhost:8080/subwaystationhot2",
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
                let temp = "<tr><td>" + item.sin + "</td><td>" + item.sout + "</td><td>" + item.count + "</td></tr>";
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
                            let temp = "<tr><td>" + item.sin + "</td><td>" + item.sout + "</td><td>" + item.count + "</td></tr>";
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
