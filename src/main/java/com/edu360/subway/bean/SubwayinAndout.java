package com.edu360.subway.bean;

import java.io.Serializable;

public class SubwayinAndout implements Serializable {
    private String station;
    private int sint;
    private int sout;

    public String getStation() {
        return station;
    }

    public void setStation(String station) {
        this.station = station;
    }

    public int getSint() {
        return sint;
    }

    public void setSint(int sint) {
        this.sint = sint;
    }

    public int getSout() {
        return sout;
    }

    public void setSout(int sout) {
        this.sout = sout;
    }

    @Override
    public String toString() {
        return "SubwayinAndout{" +
                "station='" + station + '\'' +
                ", sint=" + sint +
                ", sout=" + sout +
                '}';
    }
}
