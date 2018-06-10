package com.edu360.subway.bean;

import java.io.Serializable;

public class SubwayStationHot implements Serializable {
    private String sin;
    private String sout;
    private int count;

    public String getSin() {
        return sin;
    }

    public void setSin(String sin) {
        this.sin = sin;
    }

    public String getSout() {
        return sout;
    }

    public void setSout(String sout) {
        this.sout = sout;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "SubwayStationHot{" +
                "sin='" + sin + '\'' +
                ", sout='" + sout + '\'' +
                ", count=" + count +
                '}';
    }
}
