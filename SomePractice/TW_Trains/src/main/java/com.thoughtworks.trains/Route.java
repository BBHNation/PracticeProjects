package com.thoughtworks.trains;

public class Route {

    private Town<String> destinationTown;

    private Integer distance;

    public Route(Town<String> destinationTown, Integer distance) {
        this.destinationTown = destinationTown;
        this.distance = distance;
    }

    public Town<String> getDestinationTown() {
        return destinationTown;
    }

    public void setDestinationTown(Town<String> destinationTown) {
        this.destinationTown = destinationTown;
    }

    public Integer getDistance() {
        return distance;
    }

    public void setDistance(Integer distance) {
        this.distance = distance;
    }

}
