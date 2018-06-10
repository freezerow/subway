package com.edu360.subway.service;

import com.edu360.subway.bean.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.lang.Nullable;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

/**
 * 时间内人流量
 */
@Service
public class HourFlowService {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    public List<HourFlow> getList(){
        String sql = "SELECT hour,count FROM access_log1 ORDER BY hour ";
        return (List<HourFlow>)jdbcTemplate.query(sql, new RowMapper<HourFlow>(){

            @Override
            public HourFlow mapRow(ResultSet rs, int rowNum) throws SQLException {
                HourFlow hor = new HourFlow();
                hor.setHour(rs.getInt("hour"));
                hor.setCount(rs.getInt("count"));

                return hor;
            }
        });
    }
    public List<BusSubway> getList2() {
        String sql = "SELECT * FROM `access_log1_3`";
        return (List<BusSubway>) jdbcTemplate.query(sql, new RowMapper<BusSubway>() {

            @Override
            public BusSubway mapRow(ResultSet rs, int rowNum) throws SQLException {
                BusSubway hor = new BusSubway();
                hor.setSubway(rs.getInt("subway"));
                hor.setBus(rs.getInt("bus"));

                return hor;
            }
        });
    }
    public List<NormalMen> getList3(){
        String sql = "SELECT * FROM access_log1_4";
        return (List<NormalMen>)jdbcTemplate.query(sql, new RowMapper<NormalMen>(){

            @Override
            public NormalMen mapRow(ResultSet rs, int rowNum) throws SQLException {
                NormalMen hor = new NormalMen();
                hor.setName(rs.getString("object"));
                hor.setValue(rs.getInt("value"));

                return hor;
            }
        });
    }
    public List<HourFlow> getList4(){
        String sql = "SELECT Station,count FROM access_log1_5 ORDER BY Station ";
        return (List<HourFlow>)jdbcTemplate.query(sql, new RowMapper<HourFlow>(){

            @Override
            public HourFlow mapRow(ResultSet rs, int rowNum) throws SQLException {
                HourFlow hor = new HourFlow();
                hor.setHour(rs.getInt("Station"));
                hor.setCount(rs.getInt("count"));

                return hor;
            }
        });
    }

    public List<SubwayinAndout> getList5(){
        String sql = "SELECT * FROM access_log2_1 ORDER BY Station ";
        return (List<SubwayinAndout>)jdbcTemplate.query(sql, new RowMapper<SubwayinAndout>(){

            @Override
            public SubwayinAndout mapRow(ResultSet rs, int rowNum) throws SQLException {
                SubwayinAndout hor = new SubwayinAndout();
                hor.setStation(rs.getString("Station"));
                hor.setSint(rs.getInt("sin"));
                hor.setSout(rs.getInt("sout"));

                return hor;
            }
        });
    }
    public List<Subwayonetoone> getList6(){
        String sql = "SELECT * FROM access_log6_1 ORDER BY LIN ";
        return (List<Subwayonetoone>)jdbcTemplate.query(sql, new RowMapper<Subwayonetoone>(){

            @Override
            public Subwayonetoone mapRow(ResultSet rs, int rowNum) throws SQLException {
                Subwayonetoone hor = new Subwayonetoone();
                hor.setSource(rs.getString("LIN")+"IN");
                hor.setTarget(rs.getString("LOUT")+"OUT");
                hor.setValue(rs.getInt("count"));

                return hor;
            }
        });
    }
    public List<SubwayStation> getList7(){
        String sql1 = "SELECT distinct LIN FROM access_log6_1";
        return (List<SubwayStation>)jdbcTemplate.query(sql1, new RowMapper<SubwayStation>(){

            @Override
            public SubwayStation mapRow(ResultSet rs, int rowNum) throws SQLException {
                SubwayStation hor = new SubwayStation();
                String Station = rs.getString("LIN");
                hor.setName(Station+"IN");
                return hor;
            }
        });
    }
    public List<SubwayStation> getList8(){
        String sql1 = "SELECT distinct LOUT FROM access_log6_1";
        return (List<SubwayStation>)jdbcTemplate.query(sql1, new RowMapper<SubwayStation>(){

            @Override
            public SubwayStation mapRow(ResultSet rs, int rowNum) throws SQLException {
                SubwayStation hor = new SubwayStation();
                hor.setName(rs.getString("LOUT")+"OUT");
                return hor;
            }
        });
    }
    public List<HotSubwayHour> getList9(){
        String sql1 = "SELECT * FROM access_log2_2 ORDER BY station ";
        return (List<HotSubwayHour>)jdbcTemplate.query(sql1, new RowMapper<HotSubwayHour>(){

            @Override
            public HotSubwayHour mapRow(ResultSet rs, int rowNum) throws SQLException {
                HotSubwayHour hor = new HotSubwayHour();
                hor.setStation(rs.getString("station"));
                hor.setHour(rs.getInt("hour"));
                hor.setSin(rs.getInt("sin"));
                hor.setSout(rs.getInt("sout"));
                return hor;
            }
        });
    }
    public List<HotSubwayHour> getList10(){
        String sql = "SELECT * FROM access_log2_3 ORDER BY station ";
        return (List<HotSubwayHour>)jdbcTemplate.query(sql, new RowMapper<HotSubwayHour>(){

            @Override
            public HotSubwayHour mapRow(ResultSet rs, int rowNum) throws SQLException {
                HotSubwayHour hor = new HotSubwayHour();
                hor.setStation(rs.getString("station"));
                hor.setHour(rs.getInt("hour"));
                hor.setSin(rs.getInt("sin"));
                hor.setSout(rs.getInt("sout"));
                return hor;
            }
        });
    }
    public List<NormalMen> getList11(){
        String sql = "SELECT * FROM access_log6_3 ORDER BY object ";
        return (List<NormalMen>)jdbcTemplate.query(sql, new RowMapper<NormalMen>(){

            @Override
            public NormalMen mapRow(ResultSet rs, int rowNum) throws SQLException {
                NormalMen hor = new NormalMen();
                hor.setName(rs.getString("object"));
                hor.setValue(rs.getInt("count"));
                return hor;
            }
        });
    }

    public List<SubwayStationHot> getList13(){
        String sql = "SELECT * FROM access_log3_1,access_log4 ";
        return (List<SubwayStationHot>)jdbcTemplate.query(sql, new RowMapper<SubwayStationHot>(){

            @Override
            public SubwayStationHot mapRow(ResultSet rs, int rowNum) throws SQLException {
                SubwayStationHot hor = new SubwayStationHot();
                hor.setSin(rs.getString("stationin"));
                hor.setSout(rs.getString("stationout"));
                hor.setCount(rs.getInt("count"));
                return hor;
            }
        });
    }
    public List<Avetime> getList14(){
        String sql = "SELECT * FROM access_log3_3 ORDER BY thour ";
        return (List<Avetime>)jdbcTemplate.query(sql, new RowMapper<Avetime>(){

            @Override
            public Avetime mapRow(ResultSet rs, int rowNum) throws SQLException {
                Avetime hor = new Avetime();
                hor.setThour(rs.getInt("thour"));
                hor.setAvet(rs.getString("avet"));
                hor.setAve(rs.getLong("ave"));
                return hor;
            }
        });
    }
    public List<SubwayStationHot> getList12(){
        String sql = "SELECT * FROM access_log3_2 ";
        return (List<SubwayStationHot>)jdbcTemplate.query(sql, new RowMapper<SubwayStationHot>(){

            @Override
            public SubwayStationHot mapRow(ResultSet rs, int rowNum) throws SQLException {
                SubwayStationHot hor = new SubwayStationHot();
                hor.setSin(rs.getString("stationin"));
                hor.setSout(rs.getString("stationout"));
                hor.setCount(rs.getInt("count"));
                return hor;
            }
        });
    }
    public List<SubwayStationHot> getList15(){
        String sql = "SELECT * FROM access_log5_1 ";
        return (List<SubwayStationHot>)jdbcTemplate.query(sql, new RowMapper<SubwayStationHot>(){

            @Override
            public SubwayStationHot mapRow(ResultSet rs, int rowNum) throws SQLException {
                SubwayStationHot hor = new SubwayStationHot();
                hor.setSin(rs.getString("stationin"));
                hor.setSout(rs.getString("stationout"));
                hor.setCount(rs.getInt("likecount"));
                return hor;
            }
        });
    }
    public List<NormalMen> getList16(){
        String sql = "SELECT * FROM behavior_analysis ";
        return (List<NormalMen>)jdbcTemplate.query(sql, new RowMapper<NormalMen>(){

            @Override
            public NormalMen mapRow(ResultSet rs, int rowNum) throws SQLException {
                NormalMen hor = new NormalMen();
                hor.setName(rs.getString("behavior"));
                hor.setValue(rs.getInt("count"));
                return hor;
            }
        });
    }
}
