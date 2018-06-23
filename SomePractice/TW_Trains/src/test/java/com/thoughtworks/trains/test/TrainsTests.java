package com.thoughtworks.trains.test;

import com.thoughtworks.trains.*;
import org.junit.Test;
import static org.junit.Assert.*;

import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class TrainsTests {
    TrainsRoutes trainsRoutes = new TrainsRoutes("AB5, BC4, CD8, DC8, DE6, AD5, CE2, EB3, AE7");

    @Test
    public void testInitTrainsRoutes() {
        Town<String> town = new Town<>("E");
        List<Route> routes = trainsRoutes.getTrainsMap().get(town);
        assertEquals(routes.size(), 1);

        town = new Town<>("A");
        routes = trainsRoutes.getTrainsMap().get(town);
        assertEquals(routes.size(), 3);
    }

    @Test
    public void testDistanceBetweenTowns() {
        String result = null;
        List<Town<String>> towns = new LinkedList<>();
        List<String> townIdentities = Arrays.asList("A","B","C");
        for (String identity : townIdentities) {
            Town<String> town = new Town<>(identity);
            towns.add(town);
        }

        result = trainsRoutes.distanceBetweenTowns(towns);
        assertEquals(result, "9");

        towns.clear();
        townIdentities = Arrays.asList("A","D","C");
        for (String identity : townIdentities) {
            Town<String> town = new Town<>(identity);
            towns.add(town);
        }

        result = trainsRoutes.distanceBetweenTowns(towns);
        assertEquals(result, "13");
    }

    @Test
    public void testOthers() {
        Town<String> t = new Town<>("H");
        AtomicInteger counter = new AtomicInteger(0);
        trainsRoutes.countTripsWithStops(t,t,false,3,counter);
        assertEquals(counter.intValue(), 3);
    }

}
