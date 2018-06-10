package com.edu360.subway.bean;

import java.io.Serializable;

public class HourFlow implements Serializable {
    private int hour;
    private int count;


    public int getHour() {
        return hour;
    }

    public int getCount() {
        return count;
    }

    public void setHour(int hour) {
        this.hour = hour;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @Override
    public String toString() {
        return "HourFlow{" +
                "hour=" + hour +
                ", count=" + count +
                '}';
    }

}
