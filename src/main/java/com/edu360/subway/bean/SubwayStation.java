package com.edu360.subway.bean;

import java.io.Serializable;

public class SubwayStation implements Serializable {
    private String name;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "SubwayStation{" +
                "name='" + name + '\'' +
                '}';
    }

}
