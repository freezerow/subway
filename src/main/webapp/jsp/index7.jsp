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
    <div id="main2" style="width:1024px;height:768px;float: left"></div>
    <div style="float: left">
        <h1>地铁各时段平均时间展示</h1>
        <h3>地铁各时段平均时间展示的是各时段的旅客<br>
            在地铁站的平均旅行时间。其中可以看出<br>
            很多东西，例如在4点走的人一般都是要<br>
            去遥远的地方的乘客，0点还有旅客进入车<br>
            站可能是误入或者工作人员。还有我们可<br>
            以看到在高峰期的时段，旅客平均乘车时<br>
            间反而低于平均线，说明旅客在这是比较<br>
            匆忙，而且此时地铁的间隔也很快，到车<br>
            站基本不用等车...我们从中可以了解到很多。</h3>
    </div>
</div>
<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart2 = echarts.init(document.getElementById('main2'));
    // 指定图表的配置项和数据
    var fotmatArr = {};
    var option2 = {
        title: {
            text: '地铁各时段平均时间展示'
        },
        tooltip: {
            trigger: 'axis',
            axisPointer: {
                type: 'cross'
            },
            formatter: (item)=>{
                return "平均时间："+fotmatArr[item[0].name.split('时')[0]]
            }
        },
        legend: {
            data: ['平均时间']
        },
        xAxis: {
            type: 'category',
            data: []
        },
        yAxis: {
            type: 'value'
        },
        series: [{
            name: '平均时间',
            type: 'bar',
            data: [],
            itemStyle: {
                normal: {
                    // 随机显示
                    color:function(d){return "#"+Math.floor(Math.random()*(256*256*256-1)).toString(16);}

                  /*  // 定制显示（按顺序）
                    color: function (params) {
                        var colorList = ['#C33531', '#EFE42A', '#64BD3D', '#EE9201', '#29AAE3', '#B74AE5', '#0AAF9F', '#E89589', '#16A085', '#4A235A', '#C39BD3 ', '#F9E79F', '#BA4A00', '#ECF0F1', '#616A6B', '#EAF2F8', '#4A235A', '#3498DB'];
                        return colorList[params.dataIndex]
                    }*/
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
        }],

    };

    // 使用刚指定的配置项和数据显示图表。
    //      myChart.showLoading();
    //       {value:335, name:'直接访问'},
    var names2 = [];    //类别数组（实际用来盛放X轴坐标值）
    var nums2 = [];    //销量数组（实际用来盛放Y坐标值）
    $.post({           //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
        url: "http://localhost:8080/Avetime",
        dataType: "json",
        success: function (res) {
//              alert(res);
            if (res) {
                for (var i = 0; i < res.length; i++) {
                    names2.push(res[i].thour + "时");    //挨个取出类别并填入类别数组
                }
                for (var i = 0; i < res.length; i++) {
                    nums2.push(res[i].ave);    //挨个取出销量并填入销量数组
                }
                res.map(item=>{
                    fotmatArr[item.thour]=item.avet
                })

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
