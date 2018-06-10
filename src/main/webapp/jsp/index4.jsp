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
    <div id="main2" style="width:1366px;height:768px;float: left"></div>
    <div style="float: left">
        <h1>地铁人员流向</h1>
        <h3>大部分的热门线路的流向就是进入<br>
            自己本线路，基本从所有地铁线都<br>
            有去其他地铁线路的旅客，说明的<br>
            地铁大幅度的方便的人们的出行，<br>
            扩大了人们的出行范围。还有看到<br>
            转路线的人流过多的，地铁转站的<br>
            地铁站要增加管理人员，在大数据<br>
            分析中，与这些相似的数据利用还<br>
            有很多。</h3>
    </div>
</div>

<script type="text/javascript">
    // 基于准备好的dom，初始化echarts实例
    var myChart2 = echarts.init(document.getElementById('main2'));
    // 指定图表的配置项和数据
    var option2 = {
        title: {
            text: '地铁各线客流量流向展示'
        },
        tooltip: {
            trigger: 'item',
            triggerOn: 'mousemove'

        },
        series: {
            type: 'sankey',
            layout: 'none',
            data: [],
            links: []
        }
    };

    // 使用刚指定的配置项和数据显示图表。
    //      myChart2.showLoading();
    //       {value:335, name:'直接访问'},
    var name = [];
    var data = [];
    var flag = 0;
    $.post({
        url: "http://localhost:8080/street",
        dataType: "json",
        success: function (res) {
            flag++
//              res2=eval(res)
////              alert(res)
//              option2.series[0].data= res;
//            myChart2.setOption(option2);
            option2.series.data = res;
            if (flag === 2) {
                myChart2.setOption(option2);

            }
        }, error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败!");
        }
    });
    $.post({
        url: "http://localhost:8080/onetoone",
        dataType: "json",
        success: function (resq) {
            flag++
//              resq2=eval(resq)
//              option2.series[0].links= resq;
//              console.log(resq);
//              myChart2.setOption(option2);
            option2.series.links = resq;
            if (flag === 2) {
                myChart2.setOption(option2);

            }
        }, error: function (errorMsg) {
            //请求失败时执行该函数
            alert("图表请求数据失败!");

        }
    });
    //myChart2.setOption(option2);


</script>
</body>
</html>
