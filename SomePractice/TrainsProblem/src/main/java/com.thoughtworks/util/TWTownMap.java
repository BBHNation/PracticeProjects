package com.thoughtworks.util;

import java.io.FileNotFoundException;
import java.util.List;

public interface TWTownMap {
    public void solveSingleInput(String input) throws IllegalAccessException, TWDirectedGraph.NoSuchNodeException, TWDirectedGraph.InputIllegalException;

    public void initWithFile(String filePath) throws FileNotFoundException;

    public Integer shortestPathDistanceBetween(String start, String destination);

    public Integer distanceWithPath(List<String> townNames);

    public Integer numOfRoutesWithMaxStations(String start, String destination, Integer maxStation);

    public Integer numOfRoutesWithStatinos(String start, String destination, Integer maxStation);

    public Integer numOfRoutesWithMaxDistance(String start, String destination, Integer maxDistance);

}
