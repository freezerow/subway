package com.edu360.subway.bean;

import java.io.Serializable;

public class NormalMen implements Serializable {
    private String name;
    private int value;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getValue() {
        return value;
    }

    public void setValue(int value) {
        this.value = value;
    }

    @Override
    public String toString() {
        return "NormalMen{" +
                "name='" + name + '\'' +
                ", value=" + value +
                '}';
    }
}
