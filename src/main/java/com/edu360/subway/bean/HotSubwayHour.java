package com.edu360.subway.bean;

import java.io.Serializable;

public class HotSubwayHour implements Serializable {
    private String station;
    private int hour;
    private int sin;
    private int sout;

    @Override
    public String toString() {
        return "HotSubwayHour{" +
                "station='" + station + '\'' +
                ", hour=" + hour +
                ", sin=" + sin +
                ", sout=" + sout +
                '}';
    }

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public int getHour() {
        return hour;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public int getSin() {
        return sin;
    }

    public void setSin(int sin) {
        this.sin = sin;
    }

    public int getSout() {
        return sout;
    }

    public void setSout(int sout) {
        this.sout = sout;
    }
}
