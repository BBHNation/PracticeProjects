package com.thoughtworks;

import com.thoughtworks.question.*;
import com.thoughtworks.util.TWTownMapImpl;
import org.junit.Before;
import org.junit.Test;

import java.io.FileNotFoundException;
import static org.junit.Assert.*;

public class TWQuestionTest {
    private TWTownMapImpl map;
    @Before
    public void initMap() throws FileNotFoundException {
        map = new TWTownMapImpl();
        map.initWithFile("src/resource/graph.txt");
    }

    @Test
    public void testDistanceQuestion() {
        String inputString = "distance_of_towns:A,B,C";
        TWQuestionFactory factory = new TWQuestionFactoryImpl();
        TWQuestion question = factory.product(inputString);
        String result = question.solveWithTownMap(map);
        assertEquals("9",result);
    }

    @Test
    public void testShortestPathQuestion() {
        String inputString = "length_of_shortest_path:B,B";
        TWQuestionFactory factory = new TWQuestionFactoryImpl();
        TWQuestion question = factory.product(inputString);
        String result = question.solveWithTownMap(map);
        assertEquals("9",result);
    }

    @Test
    public void testRouteWithMaxStationsQuestion() {
        String inputString = "num_of_routes_with_max_stations:C,C,3";
        TWQuestionFactory factory = new TWQuestionFactoryImpl();
        TWQuestion question = factory.product(inputString);
        String result = question.solveWithTownMap(map);
        assertEquals("2",result);
    }

    @Test
    public void testRouteWithStationsQuestion() {
        String inputString = "num_of_routes_with_stations:A,C,4";
        TWQuestionFactory factory = new TWQuestionFactoryImpl();
        TWQuestion question = factory.product(inputString);
        String result = question.solveWithTownMap(map);
        assertEquals("3",result);
    }


    @Test
    public void testRouteWithMaxDistanceQuestion() {
        String inputString = "num_of_routes_with_max_distance:C,C,29";
        TWQuestionFactory factory = new TWQuestionFactoryImpl();
        TWQuestion question = factory.product(inputString);
        String result = question.solveWithTownMap(map);
        assertEquals("7",result);
    }

}
