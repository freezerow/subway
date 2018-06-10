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
    <div id="main2" style="width:1024px;height:768px;float: left"></div>
    <div style="float: left">
        <h1 style="
        display: block;
        font-size: 2em;
        -webkit-margin-before: 0.67em;
        -webkit-margin-after: 0.67em;
        -webkit-margin-start: 0px;
        -webkit-margin-end: 0px;
        font-weight: bold;">地铁异常率</h1>
        <h3 style="display: block;
        font-size: 1.17em;
         -webkit-margin-before: 1em;
        -webkit-margin-after: 1em;
        -webkit-margin-start: 0px;
        -webkit-margin-end: 0px;
        font-weight: bold;">地铁各站点的客流量让我们可以直观的看出那些地铁站更受欢迎，在增加管理<br>
            人员的同时，还要根据不同地点增加保护，因为客流量的大就决定了犯罪容易<br>
            在此滋生，同时加强周边的管理也是必不可少的。</h3>
    </div>
</div>

<h1>表格</h1>
<table class="table table-striped table-hover" id="subay-table">
    <thead>
    <th>地铁站点名称</th>
    <th>进站客流</th>
    <th>出站客流</th>
    </thead>
    <tbody>
    </tbody>
</table>
<div id="subpage" style="text-align: center"></div>

<script src="https://cdn.bootcss.com/jquery/2.1.1/jquery.min.js"></script>
<script src="https://cdn.bootcss.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="../js/jquery.min.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../layui.js"></script>
<script src="../js/jquery-3.1.1.min.js"></script>
<!-- 引入 ECharts 文件 -->
<script src="../js/echarts.js"></script>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart2 = echarts.init(document.getElementById('main2'));
    // 指定图表的配置项和数据
    var option2 = {
//          color:['#C33531', '#64BD3D', '#EE9201', '#29AAE3', '#B74AE5', '#0AAF9F', '#E89589', '#16A085', '#4A235A', '#C39BD3 ']，
        title: {
            text: '地铁各站客流量展示'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['客流量']
        },
        xAxis: {
            type: 'category',
            data: [],
            boundaryGap: false
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            name: '进站客流量',
            type: 'bar',
            data: [],
            markPoint: {
                data: [
                    {type: 'max', name: '最大值'},
                    {type: 'min', name: '最小值'}
                ]
            },
            markLine: {
                data: [
                    {type: 'average', name: '平均值'}
                ]
            }
        },
            {
                name: '出站客流量',
                type: 'bar',
                data: [],
                itemStyle: {
                    normal: {
                        color: '#2e43c3'


                    }
                },
                markPoint: {
                    data: [
                        {type: 'max', name: '最大值'},
                        {type: 'min', name: '最小值'}
                    ]
                },
                markLine: {
                    data: [
                        {type: 'average', name: '平均值'}
                    ]
                }
            }]
    };
    var len = 0;
    var tempObj = {};

    // 使用刚指定的配置项和数据显示图表。
    //      myChart.showLoading();
    //       {value:335, name:'直接访问'},
    var names2 = [];    //类别数组（实际用来盛放X轴坐标值）
    var nums1 = [];    //销量数组（实际用来盛放Y坐标值）
    var nums2 = [];    //销量数组（实际用来盛放Y坐标值）
    $.post({           //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "http://localhost:8080/InAndOut",
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
//            console.log(pageArr)
            for (var i = 0; i < res.length; i++) {
                names2.push(res[i].station.split("线")[1]);    //挨个取出类别并填入类别数组
            }
            for (var i = 0; i < res.length; i++) {

                nums1.push(res[i].sint);    //挨个取出销量并填入销量数组
                nums2.push(res[i].sout);    //挨个取出销量并填入销量数组
            }
            option2.xAxis.data = names2; // json string => json object JSON.parse(data)
            option2.series[0].data = nums1;
            option2.series[1].data = nums2;
            // 为echarts对象加载数据
            myChart2.setOption(option2);


            $("#subay-table tbody").empty();
            pageArr[0].map(function (item, index) {
//                console.log(item)
                let temp = "<tr><td>" + item.station + "</td><td>" + item.sint + "</td><td>" + item.sout + "</td></tr>";
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
                            let temp = "<tr><td>" + item.station + "</td><td>" + item.sint + "</td><td>" + item.sout + "</td></tr>";
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
            alert("图表请求数据失败!");
            myChart2.hideLoading();
        }
    });


</script>
</body>
</html>
