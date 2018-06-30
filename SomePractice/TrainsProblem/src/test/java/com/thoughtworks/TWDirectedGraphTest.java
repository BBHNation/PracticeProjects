package com.thoughtworks;

import com.thoughtworks.model.TWTown;
import com.thoughtworks.util.TWDirectedGraph;
import org.junit.Before;
import org.junit.Test;

import java.util.*;

import static org.junit.Assert.*;

public class TWDirectedGraphTest {
    private TWDirectedGraph<TWTown> graph;
    private Map<String, TWTown> towns;
    private TWDirectedGraph<TWTown> innerGraph;

    @Before
    public void initTowns() {
        towns = new HashMap<>();

        towns.put("A", new TWTown("A"));
        towns.put("B", new TWTown("B"));
        towns.put("C", new TWTown("C"));
        towns.put("D", new TWTown("D"));
        towns.put("E", new TWTown("E"));
    }

    @Before
    public void initGraph() {

        graph = new TWDirectedGraph<>();

        TWTown townA = towns.get("A");
        TWTown townB = towns.get("B");
        TWTown townC = towns.get("C");
        TWTown townD = towns.get("D");
        TWTown townE = towns.get("E");

        graph.addNode(townA);
        graph.addNode(townB);
        graph.addNode(townC);
        graph.addNode(townD);
        graph.addNode(townE);

        try {
            graph.addEdge(townA, townB, 5);
            graph.addEdge(townB, townC, 4);
            graph.addEdge(townC, townD, 8);
            graph.addEdge(townD, townC, 8);
            graph.addEdge(townD, townE, 6);
            graph.addEdge(townA, townD, 5);
            graph.addEdge(townC, townE, 2);
            graph.addEdge(townE, townB, 3);
            graph.addEdge(townA, townE, 7);
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @Test
    public void testBefore() {
        TWTown town = towns.get("B");
        assertTrue(graph.contains(town));
    }

    @Test
    public void testAddNode() {
        innerGraph = new TWDirectedGraph<>();
        TWTown town = towns.get("A");
        innerGraph.addNode(town);
        assertTrue(innerGraph.contains(town));
    }

    @Test
    public void testAddEdge() {
        innerGraph = new TWDirectedGraph<>();
        TWTown townA = towns.get("A");
        TWTown townB = towns.get("B");
        innerGraph.addNode(townA);
        innerGraph.addNode(townB);
        try {
            innerGraph.addEdge(townA, townB, 13);
            assertTrue(innerGraph.checkEdgeExists(townA,townB));
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @Test
    public void testGetNeighbours() {
        innerGraph = new TWDirectedGraph<>();
        TWTown townA = towns.get("A");
        TWTown townB = towns.get("B");
        TWTown townC = towns.get("C");

        innerGraph.addNode(townA);
        innerGraph.addNode(townB);
        innerGraph.addNode(townC);

        try {
            innerGraph.addEdge(townA, townB, 7);
            innerGraph.addEdge(townA, townC, 5);
            Set<TWTown> neighbours = innerGraph.getNeighbours(townA);
            assertEquals(neighbours.size(),2);
            assertTrue(neighbours.contains(townB));
            assertTrue(neighbours.contains(townC));
            assertFalse(neighbours.contains(townA));
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }

    }

    @Test
    public void testShortestPathBetween1() {
        TWDirectedGraph.GraphPath path;
        try {
            path = graph.shortestPathBetween(towns.get("A"), towns.get("B"));
            assertEquals("A-->B", path.toString());

            path = graph.shortestPathBetween(towns.get("A"), towns.get("D"));
            assertEquals("A-->D", path.toString());

            path = graph.shortestPathBetween(towns.get("A"), towns.get("E"));
            assertEquals("A-->E", path.toString());

            path = graph.shortestPathBetween(towns.get("D"), towns.get("E"));
            assertEquals("D-->E", path.toString());

            path = graph.shortestPathBetween(towns.get("E"), towns.get("B"));
            assertEquals("E-->B", path.toString());

            path = graph.shortestPathBetween(towns.get("B"), towns.get("C"));
            assertEquals("B-->C", path.toString());

            path = graph.shortestPathBetween(towns.get("C"), towns.get("E"));
            assertEquals("C-->E", path.toString());

            path = graph.shortestPathBetween(towns.get("C"), towns.get("D"));
            assertEquals("C-->D", path.toString());

            path = graph.shortestPathBetween(towns.get("D"), towns.get("C"));
            assertEquals("D-->C", path.toString());
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }


    @Test
    public void testShortestPathBetween2() {
        TWDirectedGraph.GraphPath path;

        try {
            path = graph.shortestPathBetween(towns.get("B"), towns.get("E"));
            assertEquals("B-->C-->E", path.toString());
            assertEquals(6, path.distance().intValue());
            assertEquals(2, path.stationCount().intValue());

            path = graph.shortestPathBetween(towns.get("E"), towns.get("C"));
            assertEquals("E-->B-->C", path.toString());
            assertEquals(7, path.distance().intValue());
            assertEquals(2, path.stationCount().intValue());

            path = graph.shortestPathBetween(towns.get("D"), towns.get("B"));
            assertEquals("D-->E-->B", path.toString());
            assertEquals(9, path.distance().intValue());
            assertEquals(2, path.stationCount().intValue());
        } catch (Exception e) {
            throw new RuntimeException(e.getMessage());
        }
    }

    @Test(expected = TWDirectedGraph.CanNotGetToNodeException.class)
    public void testShortestPathBetween3() throws TWDirectedGraph.CanNotGetToNodeException, TWDirectedGraph.NoSuchNodeException {
        graph.shortestPathBetween(towns.get("E"), towns.get("A"));
    }

    @Test(expected = TWDirectedGraph.CanNotGetToNodeException.class)
    public void testShortestPathBetween4() throws TWDirectedGraph.CanNotGetToNodeException, TWDirectedGraph.NoSuchNodeException {
        graph.shortestPathBetween(towns.get("C"), towns.get("A"));
    }

    @Test
    public void testDistance1() throws TWDirectedGraph.CanNotGetToNodeException, TWDirectedGraph.NoSuchNodeException {
        List<TWTown> route = new ArrayList<TWTown>();
        route.add(towns.get("A"));
        route.add(towns.get("B"));
        route.add(towns.get("C"));

        int distance = graph.distanceWithNodes(route);
        assertEquals(9, distance);
    }

    @Test
    public void testDistance2() throws TWDirectedGraph.CanNotGetToNodeException, TWDirectedGraph.NoSuchNodeException, TWDirectedGraph.CanNotGetToNodeException {
        List<TWTown> route = new ArrayList<TWTown>();
        route.add(towns.get("A"));
        route.add(towns.get("D"));
        route.add(towns.get("E"));

        int distance = graph.distanceWithNodes(route);
        assertEquals(11, distance);
    }

    @Test
    public void testDistance3() throws TWDirectedGraph.CanNotGetToNodeException, TWDirectedGraph.NoSuchNodeException, TWDirectedGraph.CanNotGetToNodeException {
        List<TWTown> route = new ArrayList<TWTown>();
        route.add(towns.get("B"));
        route.add(towns.get("C"));
        route.add(towns.get("D"));
        route.add(towns.get("E"));
        route.add(towns.get("B"));

        int distance = graph.distanceWithNodes(route);
        assertEquals(21, distance);
    }



    @Test
    public void testCountRoutesWithMaxHops1() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithMaxStations(towns.get("C"), towns.get("C"), 3);
        assertEquals(2,distance);
    }

    @Test
    public void testCountRoutesWithMaxHops2() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithMaxStations(towns.get("A"), towns.get("B"), 3);
        assertEquals(3,distance);
    }

    @Test
    public void testCountRoutesWithMaxHops3() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithMaxStations(towns.get("B"), towns.get("C"), 3);
        assertEquals(2,distance);
    }

    @Test
    public void testCountRoutesWithMaxHops4() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithMaxStations(towns.get("B"), towns.get("C"), 2);
        assertEquals(1,distance);
    }

    @Test
    public void testCountRoutesWithHops1() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithStations(towns.get("B"), towns.get("D"), 1);
        assertEquals(0, distance);
    }

    @Test
    public void testCountRoutesWithHops2() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithStations(towns.get("B"), towns.get("D"), 2);
        assertEquals(1, distance);
    }

    @Test
    public void testCountRoutesWithHops3() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithMaxStations(towns.get("B"), towns.get("D"), 2);
        assertEquals(1, distance);
    }

    @Test
    public void testCountRoutesWithMaxDistance1() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithMaxDistance(towns.get("B"), towns.get("D"), 1);
        assertEquals(0, distance);
    }


    @Test
    public void testCountRoutesWithMaxDistance2() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithMaxDistance(towns.get("B"), towns.get("E"), 6);
        assertEquals(1, distance);
    }

    @Test
    public void testCountRoutesWithMaxDistance3() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithMaxDistance(towns.get("B"), towns.get("E"), 18);
        assertEquals(3, distance);
    }

    @Test
    public void testCountRoutesWithMaxDistance4() throws TWDirectedGraph.NoSuchNodeException {
        int distance = graph.numOfRouteWithMaxDistance(towns.get("C"), towns.get("C"), 29);
        assertEquals(7, distance);
    }
}
