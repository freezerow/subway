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
    <script src="../js/jquery-3.1.1.min.js"></script>
    <!-- 引入 ECharts 文件 -->
    <script src="../js/echarts.js"></script>
    <title>pflow</title>
</head>
<body>
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div style="overflow: hidden">
    <div id="main" style="width: 1024px;height:768px; float: left"></div>
    <div style="float: left">
        <h1>地铁客流小时统计</h1>
        <h3>地铁每小时客流流量是一项基础的数据统计，通过每小时的客流变化，<br>
            我们可以看到一个城市苏醒和睡眠的时间，同时客流的变化也是我们<br>
            调整地铁运行间隔时间的重要依据。同时这也让有能力选择出行时间<br>
            的旅客可以错峰出行，缓解交通压力。</h3>
    </div>
</div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart = echarts.init(document.getElementById('main'));
    // 指定图表的配置项和数据
    var option = {
        title: {
            text: '地铁客流量小时统计'
        },
        tooltip: {},
        legend: {
            data: ['客流量']
        },
        xAxis: {
            type: 'category',
            data: []
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            name: '客流量',
            type: 'line',
            data: []
        }]
    };

    // 使用刚指定的配置项和数据显示图表。
    myChart.showLoading();
    //      myChart.setOption(option);
    var names = [];    //类别数组（实际用来盛放X轴坐标值）
    var nums = [];    //销量数组（实际用来盛放Y坐标值）
    $.ajax({
        type: "post",
        async: true,            //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "http://localhost:8080/hour_flow",    //请求发送到Controller处
        data: {},
        dataType: "json",//返回数据形式为json
        success: function (result) {
            //  alert(result)

            //请求成功时执行该函数内容，result即为服务器返回的json对象
            if (result) {
                for (var i = 0; i < result.length; i++) {
                    names.push(result[i].hour);    //挨个取出类别并填入类别数组
                }
                for (var i = 0; i < result.length; i++) {
                    nums.push(result[i].count);    //挨个取出销量并填入销量数组
                }

                myChart.hideLoading();    //隐藏加载动画
                myChart.setOption({        //加载数据图表
                    title: {
                        text: '地铁客流量小时统计'
                    },
                    legend: {
                        data: ['客流量']
                    },
                    tooltip: {
                        trigger: 'axis'
                    },
                    xAxis: {
                        type: 'category',
                        data: names
                    },
                    yAxis: {
                        type: 'value'
                    },
                    series: [{
                        // 根据名字对应到相应的系列
                        name: '客流量',
                        type: 'line',
                        data: nums
                    }]
                });

            }

        },
        error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败!");
            myChart.hideLoading();
        }
    })

</script>
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div style="overflow: hidden">
    <div id="main2" style="width:1024px;height:768px;float: left"></div>
    <div style="float: left">
        <h1>地铁各路线客流量展示</h1>
        <h3>地铁各线路客流量展示可以清晰的额看出那些地铁线处于人流量特别大的情况。<br>
            这既可以让地铁管理人员对地铁客流量有一个清晰的认识，同时也给有能力<br>
            选择乘坐地铁的旅客一个帮助，让它们可以自行选择出行路线。<br>
            同时，客流也就代表着商机，因次客流多的地铁线在运营广告的时候就应该<br>
            收取更高的广告费用，客流量不足的地铁线可以用优惠乘车等方式让更多的<br>
            人乘坐地铁出行，为地铁创造收入。</h3>
    </div>
</div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart2 = echarts.init(document.getElementById('main2'));
    // 指定图表的配置项和数据
    var option2 = {
        title: {
            text: '地铁各路线客流量展示'
        },
        tooltip: {
            trigger: 'axis'
        },
        legend: {
            data: ['客流量']
        },
        xAxis: {
            type: 'category',
            data: []
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            name: '客流量',
            type: 'bar',
            data: [],
            itemStyle: {
                normal: {
                    // 随机显示
                    //color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}

                    // 定制显示（按顺序）
                    color: function (params) {
                        var colorList = ['#C33531', '#EFE42A', '#64BD3D', '#EE9201', '#29AAE3', '#B74AE5', '#0AAF9F', '#E89589', '#16A085', '#4A235A', '#C39BD3 ', '#F9E79F', '#BA4A00', '#ECF0F1', '#616A6B', '#EAF2F8', '#4A235A', '#3498DB'];
                        return colorList[params.dataIndex]
                    }
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

    // 使用刚指定的配置项和数据显示图表。
    //      myChart.showLoading();
    //       {value:335, name:'直接访问'},
    var names2 = [];    //类别数组（实际用来盛放X轴坐标值）
    var nums2 = [];    //销量数组（实际用来盛放Y坐标值）
    $.post({           //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "http://localhost:8080/Station",
        dataType: "json",
        success: function (res) {
//              alert(res);
            if (res) {
                for (var i = 0; i < res.length; i++) {
                    names2.push(res[i].hour + "号线");    //挨个取出类别并填入类别数组
                }
                for (var i = 0; i < res.length; i++) {
                    nums2.push(res[i].count);    //挨个取出销量并填入销量数组
                }

                option2.xAxis.data = names2; // json string => json object JSON.parse(data)
                option2.series[0].data = nums2;
                // 为echarts对象加载数据
                myChart2.setOption(option2);
            }
        }, error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败!");
            myChart2.hideLoading();
        }
    });


</script>

</body>
</html>
