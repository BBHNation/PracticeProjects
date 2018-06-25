package com.thoughtworks.util;

import com.thoughtworks.model.*;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.util.*;
import java.util.stream.Collectors;

public class TWTownMapImpl implements TWTownMap {

    private TWDirectedGraph<TWTown> graph;
    private Map<String, TWTown> towns;


<<<<<<< HEAD
    public TWTownMapImpl() {
=======
    TWTownMapImpl() {
>>>>>>> 4c2c229caf9f64c61dfd615b066ef05fe8b1db42
        graph = new TWDirectedGraph<>();
        towns = new HashMap<>();
    }

    public static class NoSuchRouteException extends RuntimeException {
        public NoSuchRouteException(String message) {
            super(message);
        }
    }

    private void addTown(TWTown town) {
        graph.addNode(town);
        towns.putIfAbsent(town.getName(),town);
    }

    @Override
    public void solveSingleInput(String input) throws IllegalAccessException, TWDirectedGraph.NoSuchNodeException, TWDirectedGraph.InputIllegalException {
        if (input.length() < 2) {
            throw new  IllegalArgumentException("input length should be longer than 2");
        } else {
            TWTown startTown = new TWTown(input.substring(0,1));
            TWTown destTown = new TWTown(input.substring(1,2));
            Integer distance = Integer.parseInt(input.substring(2));
<<<<<<< HEAD
            addTown(startTown);
            addTown(destTown);
=======
>>>>>>> 4c2c229caf9f64c61dfd615b066ef05fe8b1db42
            graph.addEdge(startTown, destTown, distance);
        }

    }

    @Override
    public void initWithFile(String filePath) throws FileNotFoundException {
        Scanner in = new Scanner(new FileInputStream(filePath));

        while (in.hasNext()) {
            String input = in.next();
            initWithString(input);
        }
    }

    public void initWithString(String inputString) throws IllegalArgumentException {
        TWTown startTown = null;
        TWTown destTown = null;
        Integer distance = 0;
        List<String> listOfInputString = Arrays.asList(inputString.split("[\\s]*,[\\s]*"));
        for (String singleInput : listOfInputString) {
            try {
                solveSingleInput(singleInput);
            } catch (IllegalAccessException | TWDirectedGraph.NoSuchNodeException | TWDirectedGraph.InputIllegalException e) {
                throw new IllegalArgumentException(e.getMessage());
            }
        }
    }

    @Override
    public Integer shortestPathDistanceBetween(String start, String destination) {
        try {
            TWDirectedGraph.GraphPath path = graph.shortestPathBetween(towns.get(start), towns.get(destination));
            return path.distance();
        } catch (TWDirectedGraph.NoSuchNodeException | TWDirectedGraph.CanNotGetToNodeException e) {
            throw new NoSuchRouteException(e.getMessage());
        }
    }

    @Override
    public Integer distanceWithPath(List<String> townNames) throws  NoSuchRouteException {
        List<TWTown> townList = townNames.stream().map(name-> new TWTown(name)).collect(Collectors.toList());
        try {
            return graph.distanceWithNodes(townList);
        } catch (TWDirectedGraph.NoSuchNodeException | TWDirectedGraph.CanNotGetToNodeException e) {
            throw new NoSuchRouteException(e.getMessage());
        }
    }

    @Override
    public Integer numOfRoutesWithMaxStations(String start, String destination, Integer maxStation) throws NoSuchRouteException {
        try {
            return graph.numOfRouteWithMaxStations(towns.get(start), towns.get(destination), maxStation);
        } catch (TWDirectedGraph.NoSuchNodeException e) {
            throw new NoSuchRouteException(e.getMessage());
        }
    }

    @Override
<<<<<<< HEAD
    public Integer numOfRoutesWithStations(String start, String destination, Integer maxStation) {
=======
    public Integer numOfRoutesWithStatinos(String start, String destination, Integer maxStation) {
>>>>>>> 4c2c229caf9f64c61dfd615b066ef05fe8b1db42
        try {
            return graph.numOfRouteWithStations(towns.get(start), towns.get(destination), maxStation);
        } catch (TWDirectedGraph.NoSuchNodeException e) {
            throw new NoSuchRouteException(e.getMessage());
        }
    }

    @Override
    public Integer numOfRoutesWithMaxDistance(String start, String destination, Integer maxDistance) {
        try {
            return graph.numOfRouteWithMaxDistance(towns.get(start), towns.get(destination), maxDistance);
        } catch (TWDirectedGraph.NoSuchNodeException e) {
            throw new NoSuchRouteException(e.getMessage());
        }
    }
}
