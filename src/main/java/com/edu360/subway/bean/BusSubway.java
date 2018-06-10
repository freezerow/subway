package com.edu360.subway.bean;

import java.io.Serializable;

public class BusSubway implements Serializable {
    private int subway;
    private int bus;

    public int getSubway() {
        return subway;
    }

    public void setSubway(int subway) {
        this.subway = subway;
    }

    public int getBus() {
        return bus;
    }

    public void setBus(int bus) {
        this.bus = bus;
    }

    @Override
    public String toString() {
        return "BusSubway{" +
                "subway=" + subway +
                ", bus=" + bus +
                '}';
    }
}
