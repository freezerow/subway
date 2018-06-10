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
    <div id="main" style="width: 600px;height:400px;float: left"></div>
    <div style="float: left">
      <h1>乘坐交通展示</h1>
      <h3>随着社会的不断发展，城市的人口越来越多，城市的范围越来越大，<br>
        人们肯定会越来越选择更快捷的交通工具地铁作为出行的首选，乘地<br>
        铁的客流更说明一个城市的地铁建设情况。</h3>
    </div>
  </div>
  <div style="overflow: hidden">
    <div id="main2" style="width: 600px;height:400px;float: left"></div>
    <div style="float: left">
      <h1>地铁异常率</h1>
      <h3>这是一个展示车站管理情况的饼图，正常的部分越多说明管理越完善。<br>
        其中异常的部分说明在地铁运行的过程中，有些地铁乘坐卡出现了违规<br>
        操作，例如多次进站，出站次数比进站多，逃票等情况。其中一些是由<br>
        于旅客的操作不当，但也有一些是地铁的进出站系统可能的故障，和工<br>
        作人员的不及时检查。所以在系统的记录中，出现的异常的数据，这样<br>
        的数据比例过高，就说明了地铁站存在一些问题，因此这个比例应当低<br>
        于一定的水平。</h3>
    </div>
  </div>


  <script type="text/javascript">
      // 基于准备好的dom，初始化echarts实例
      var myChart = echarts.init(document.getElementById('main'));
      // 指定图表的配置项和数据
      var option = {
          backgroundColor: '#2c343c',
//          color:['#c23531','#2f4554', '#61a0a8', '#d48265', '#91c7ae','#749f83',  '#ca8622', '#bda29a','#6e7074', '#546570', '#c4ccd3']
          title: {
              text: '乘坐城市交通的类型',
              left: 'center',
              top: 20,
              textStyle: {
                  color: '#ccc'
              }
          },

          tooltip : {
              trigger: 'item',
              formatter: "{a} <br/>{b} : {c} ({d}%)"
          },

          visualMap: {
              min: 80,
              max: 600,
              inRange: {
                  colorLightness: [0, 0.5]
              }
          },
          series : [
              {
                  name:'访问来源',
                  type:'pie',
                  radius : '55%',
                  center: ['50%', '50%'],
                  data:[].sort(function (a, b) { return a.value - b.value; }),
                  roseType: 'radius',
                  label: {
                      normal: {
                          textStyle: {
                              color: 'rgba(255, 255, 255, 0.3)'
                          }
                      }
                  },
                  labelLine: {
                      normal: {
                          lineStyle: {
                              color: 'rgba(255, 255, 255, 0.3)'
                          },
                          smooth: 0.2,
                          length: 10,
                          length2: 20
                      }
                  },
                  itemStyle: {
                      normal: {
                          color: '#5174c2',
                          borderColor: '#c23531',
                          shadowBlur: 200
                      }
                  },
                  emphasis:{
                      itemStyle:{
                      normal:{
                          color: '#6dc264'

                              }
                      }
                   },

                  animationType: 'scale',
                  animationEasing: 'elasticOut',
                  animationDelay: function (idx) {
                      return Math.random() * 200;
                  }
              }
          ]
      };

      // 使用刚指定的配置项和数据显示图表。
//      myChart.showLoading();

//       {value:335, name:'直接访问'},
      var nums=[];    //数组

      $.get({
          //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
          url : "http://localhost:8080/subway_bus",
          dataType : "json",
          success: function (res) {

              nums.push({value:res[0].subway,name:'地铁'});
              nums.push({value:res[0].bus,name:'公交'});
              option.series[0].data = [{name:nums[0].name,value:nums[0].value},{name:nums[1].name,value:nums[1].value}]; // json string => json object JSON.parse(data)
              option.series[0].itemStyle = {
                  normal: {
                      color: '#5174c2',
                      borderColor: '#c23531',
                      shadowBlur: 200
                  }};
              // 为echarts对象加载数据
              myChart.setOption(option);
          }, error: function (errorMsg) {
              //请求失败时执行该函数
              alert("图表请求数据失败!");
              myChart.hideLoading();
          }
      });


  </script>
  <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
  <script type="text/javascript">
      // 基于准备好的dom，初始化echarts实例
      var myChart2 = echarts.init(document.getElementById('main2'));
      // 指定图表的配置项和数据
      var option2 = {
          title : {
              text: '地铁站异常率',
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
              data: ['正常人物','异常人物']
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

      $.post({           //异步请求（同步请求将会锁住浏览器，用户其他操作必须等待请求完成才可以执行）
          url : "http://localhost:8080/normalmen",
          dataType : "json",
          success: function (res) {
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
