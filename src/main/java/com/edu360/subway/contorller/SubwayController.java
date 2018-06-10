package com.edu360.subway.contorller;



import com.alibaba.fastjson.JSON;
import com.edu360.subway.bean.BusSubway;
import com.edu360.subway.bean.SubwayStation;
import com.edu360.subway.service.HourFlowService;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * Controller：用来接收用户的请求（request），并给用户响应数据（response）
 */

@Controller
public class SubwayController {

    @Autowired
    private HourFlowService hourFlowService;


    @RequestMapping("/hour_flow")
    @ResponseBody
    public void getStus( HttpServletResponse response)throws ServletException, IOException {
//        logger.info("从数据库读取Student集合");

        String json=JSON.toJSONString(hourFlowService.getList());
        //将json数据返回给客户端
        response.setContentType("text/html; charset=utf-8");
        response.getWriter().write(json);

    }
    @RequestMapping("/subway_bus")
    @ResponseBody
    public String getStus(){
//        logger.info("从数据库读取Student集合");
        List<BusSubway> data = hourFlowService.getList2();
        return JSON.toJSONString(hourFlowService.getList2());
    }
    @RequestMapping("/normalmen")
    @ResponseBody
    public String getMen(){
//        logger.info("从数据库读取Student集合");
        return JSON.toJSONString(hourFlowService.getList3());
    }
    @RequestMapping("/Station")
    @ResponseBody
    public String getStat(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList4());
    }
    @RequestMapping("/InAndOut")
    @ResponseBody
    public String getInandout(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList5());
    }
    @RequestMapping("/onetoone")
    @ResponseBody
    public String getOnetoone(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList6());
    }

    @RequestMapping("/street")
    @ResponseBody
    public String getStation(){
//        logger.info("从数据库读取集合");
        List<SubwayStation> list7 = hourFlowService.getList7();
        list7.addAll(hourFlowService.getList8());
        return JSON.toJSONString(list7);
    }
    @RequestMapping("/hottime1")
    @ResponseBody
    public String getHot1(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList9());
    }
    @RequestMapping("/hottime2")
    @ResponseBody
    public String getHot2(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList10());
    }
    @RequestMapping("/subwaytravel")
    @ResponseBody
    public String getSubwayT(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList11());
    }

    @RequestMapping("/Avetime")
    @ResponseBody
    public String getAvetime(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList14());
    }
    @RequestMapping("/subwaystationhot")
    @ResponseBody
    public String getSubwayH(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList12());
    }
    @RequestMapping("/subwaystationhot2")
    @ResponseBody
    public String getSubwayH2(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList15());
    }
    @RequestMapping("/analysis")
    @ResponseBody
    public String getAnalysis(){
//        logger.info("从数据库读取集合");
        return JSON.toJSONString(hourFlowService.getList16());
    }





    @RequestMapping("/index")
    public String toIndex(){

        return "index";

    }
    @RequestMapping("/index2")
    public String toIndex2(){

        return "index2";

    }
    @RequestMapping("/index3")
    public String toIndex3(){

        return "index3";

    }
    @RequestMapping("/index4")
    public String toIndex4(){

        return "index4";

    }
    @RequestMapping("/index5")
    public String toIndex5(){

        return "index5";

    }
    @RequestMapping("/index6")
    public String toIndex6(){

        return "index6";

    }
    @RequestMapping("/index7")
    public String toIndex7(){

        return "index7";

    }
    @RequestMapping("/index8")
    public String toIndex8(){

        return "index8";

    }
    @RequestMapping("/home")
    public String toHome(){

        return "home";

    }


   /* @ResponseBody
    public String add(@RequestBody Bike bike) { //@RequestBody接收json类型的请求数据
        String flag = "success";
        try {
            bikeService.save(bike);
        } catch (Exception e) {
            //记录log
            //e.printStackTrace();
            flag = "fail";
        }

        return flag;
    }


    @GetMapping(value = "/list")
    @ResponseBody
    public List<GeoResult<Bike>> add(double longitude, double latitude) { //@RequestBody接收json类型的请求数据

        //return bikeService.findAll();

        return bikeService.findNear(longitude, latitude);
    }


    @GetMapping("/host")
    @ResponseBody
    public String host() {

        String hostName = null;
        //当前机器的IP地址
        try {
            hostName = InetAddress.getLocalHost().getHostName();
        } catch (UnknownHostException e) {
            e.printStackTrace();
        }

        return hostName;
    }*/
}
