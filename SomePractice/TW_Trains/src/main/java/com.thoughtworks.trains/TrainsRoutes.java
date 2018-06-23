package com.thoughtworks.trains;

import java.util.Arrays;
import java.util.HashMap;
import java.util.LinkedList;
import java.util.List;
import java.util.concurrent.atomic.AtomicInteger;

public class TrainsRoutes {

    // A map to save all the towns and the routes of any one in the towns list
    private HashMap<Town<String>, List<Route>> trainsMap;

    public TrainsRoutes(String inputString) {
        trainsMap = new HashMap<>();
        initTrainsRoutes(inputString); // Use input string to init all the trans routes
    }

    /**
     * Aim to init all the trains routes
     * @param inputString: string data to input
     */
    public void initTrainsRoutes(String inputString) {
        if (inputString == null) { return; }
        Town<String> town = null; // Starting town
        Town<String> destinationTown = null; // Destination town
        Route route = null; // A route from starting town to destination town
        List<String> listOfInputString = Arrays.asList(inputString.split("[\\s]*,[\\s]*"));
        for (String string : listOfInputString) {
            town = new Town<>(string.substring(0,1));
            destinationTown = new Town<>(string.substring(1,2));
            route = new Route(destinationTown, Integer.valueOf(string.substring(2)));
            trainsMap.putIfAbsent(town, new LinkedList<>()); // Add if absent
            trainsMap.get(town).add(route); // Add route for starting town
        }
    }

    /**
     * Aim to return the map of trains routes
     * Solve the question 1 to 5
     * @return A hash map of trains routes
     */
    public HashMap<Town<String>, List<Route>> getTrainsMap() {
        return trainsMap;
    }


    /**
     * Aim to find out the distance between the first and the last of some given routes.
     * @param townsList: A list of given towns.
     * @return The distance between given towns.
     */
    public String distanceBetweenTowns(List<Town<String>> townsList) {
        if (townsList.size() <= 1) { return Const.NOT_FOUND; }

        Integer distance = 0; // Final distance sum
        List<Route> routes = null; // All of the current town routes
        Route route = null; // A route to next town
        Town<String> currentTown = null; // The current town

        for (int i = 0; i < townsList.size(); i++) {
            currentTown = townsList.get(i);
            if (i < townsList.size()-1) {
                Town<String> nextTown = townsList.get(i+1); // Find the next town
                routes = trainsMap.get(currentTown); // Get routes of current town
                route = routes.stream()
                        .filter(t -> t.getDestinationTown().equals(nextTown))
                        .findFirst()
                        .orElse(null); // Find a route to next town
                if (route == null) {
                    return Const.NOT_FOUND;
                } else {
                    // If route to next town isn't null, plus distance
                    distance += route.getDistance();
                }
            }
        }

        return String.valueOf(distance);
    }

    public String numberOfTripsWithMaxStops(Town<String> start, Town<String> end, int maxStops) {
        if (maxStops <= 0) { return "0"; }
        return "0";
    }

    public String numberOfTripsWithExactlyStops(Town<String> start, Town<String> end, int exactlyStops) {
        if (exactlyStops <= 0) { return "0"; }
        return "0";
    }

    public void countTripsWithStops(Town<String> start, Town<String> end, boolean isMaxStop, int stops, AtomicInteger counter) {
        if (stops > 0) {
            counter.incrementAndGet();
            countTripsWithStops(start, end, isMaxStop, stops-1, counter);
        }
    }

}
