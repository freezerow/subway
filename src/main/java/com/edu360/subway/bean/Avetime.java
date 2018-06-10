package com.edu360.subway.bean;

import java.io.Serializable;

public class Avetime implements Serializable {
    private int thour;
    private String avet;
    private Long ave;

    public int getThour() {
        return thour;
    }

    public void setThour(int thour) {
        this.thour = thour;
    }

    public String getAvet() {
        return avet;
    }

    public void setAvet(String avet) {
        this.avet = avet;
    }

    public Long getAve() {
        return ave;
    }

    public void setAve(Long ave) {
        this.ave = ave;
    }

    @Override
    public String toString() {
        return "Avetime{" +
                "thour=" + thour +
                ", avet='" + avet + '\'' +
                ", ave=" + ave +
                '}';
    }
}
