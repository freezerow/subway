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
    <div id="main2" style="width: 600px;height:400px;float: left"></div>
    <div style="float: left">
      <h1>地铁旅行比例</h1>
      <h3>地铁站旅行比例图依据地铁价格而编写的，<br>
        上海地铁按照上海市物价主管部门的轨道交通<br>
        网络票价体系定价。即：轨道交通实行按里程<br>
        计价的多级票价，小于6公里定价3元，6公里<br>
        之后每10公里增加1元。数据处理时，3元以下<br>
        为短途旅行，4到8元为中途旅行，超过9元为<br>
        长途陆行。这张图说明了上海旅客的地铁旅行<br>
        习惯，很少的旅客选择了长途旅行，大部分乘<br>
        客以短途旅行为主。</h3>
    </div>
  </div>

  <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
  <script type="text/javascript">
      // 基于准备好的dom，初始化echarts实例
      var myChart2 = echarts.init(document.getElementById('main2'));
      // 指定图表的配置项和数据
      var option2 = {
          title : {
              text: '地铁旅行比例',
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
      var names = [];
      $.post({           //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
          url : "http://localhost:8080/subwaytravel",
          dataType : "json",
          success: function (res) {
              if(res){
                  for(var i = 0; i < res.length; i++){
                      names.push(res[i].name);
                  }
              }
//              alert(res)
              option2.legend.data=names
              option2.series[0].data = res; // json string => json object JSON.parse(data)
              // 为echarts对象加载数据
              myChart2.setOption(option2);
          }, error: function (errorMsg) {
              //请求失败时执行该函数
              alert("图表请求数据失败!");
              myChart2.hideLoading();
          }
      });


  </script>

  </body>
</html>
