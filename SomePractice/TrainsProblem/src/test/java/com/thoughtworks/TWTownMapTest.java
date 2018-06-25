package com.thoughtworks;

import com.thoughtworks.util.TWTownMapImpl;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

import java.io.FileNotFoundException;
import java.util.Arrays;
import java.util.List;

public class TWTownMapTest {
    private TWTownMapImpl map = null;

    @Before
    public void initMap() throws FileNotFoundException {
        map = new TWTownMapImpl();
        map.initWithFile("src/resource/graph.txt");
    }

    @Test
    public void testMapShortestPathDistance1() {
        int distance = map.shortestPathDistanceBetween("A","B");
        assertEquals(5,distance);
    }

    @Test
    public void testMapShortestPathDistance2() {
        int distance = map.shortestPathDistanceBetween("A","C");
        assertEquals(9,distance);
    }

    @Test
    public void testMapShortestPathDistance3() {
        int distance = map.shortestPathDistanceBetween("A","D");
        assertEquals(5,distance);
    }

    @Test
    public void testDistanceWithPath1() {
        List<String> townNames = Arrays.asList("A","B","C");
        int distance = map.distanceWithPath(townNames);
        assertEquals(9,distance);
    }

    @Test
    public void testDistanceWithPath2() {
        List<String> townNames = Arrays.asList("A","B","C","E","B");
        int distance = map.distanceWithPath(townNames);
        assertEquals(14,distance);
    }

    @Test
    public void testDistanceWithPath3() {
        List<String> townNames = Arrays.asList("E","B","C","D");
        int distance = map.distanceWithPath(townNames);
        assertEquals(15,distance);
    }

    @Test
    public void testRouteWithMaxStations1() {
        int routes = map.numOfRoutesWithMaxStations("C","C",3);
        assertEquals(2, routes);
    }

    @Test
    public void testRouteWithMaxStations2() {
        int routes = map.numOfRoutesWithMaxStations("A","C",4);
        assertEquals(6, routes);
    }

    @Test
    public void testRouteWithMaxStations3() {
        int routes = map.numOfRoutesWithMaxStations("B","D",4);
        assertEquals(2, routes);
    }


    @Test
    public void testRouteWithStations1() {
        int routes = map.numOfRoutesWithStations("A","C",4);
        assertEquals(3, routes);
    }

    @Test
    public void testRouteWithStations2() {
        int routes = map.numOfRoutesWithStations("C","C",4);
        assertEquals(2, routes);
    }

    @Test
    public void testRouteWithMaxDistance1() {
        int routes = map.numOfRoutesWithMaxDistance("C","C",29);
        assertEquals(7,routes);
    }

}
