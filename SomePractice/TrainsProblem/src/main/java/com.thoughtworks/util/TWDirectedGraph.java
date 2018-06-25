package com.thoughtworks.util;

import javax.naming.CannotProceedException;
import java.util.*;

public class TWDirectedGraph<T> {
	/*
	 * 这里是Node不可获取时候抛出的错误
	 */
	public static class CanNotGetToNodeException extends Exception {
		CanNotGetToNodeException(String message) {
			super(message);
		}
	}

    /*
     * 这里是在图中没有这个节点所抛出的错误
     */
	public static class NoSuchNodeException extends Exception {
	    NoSuchNodeException(String message) {
	        super(message);
        }
    }

    /*
     * 这里是函数输入有误所抛出的错误
     */
    public static class InputIllegalException extends Exception {
	    InputIllegalException(String message) {
	        super(message);
        }
    }

    /*
     * 这里是一些其他错误
     */
    public static class SomeOtherException extends Exception {
	    public SomeOtherException(String message) {
	        super(message);
        }
    }

	/*
	 * {@code GraphNode}是一个内部类，保存了一些方便函数计算的属性
	 */
	private class GraphNode implements Comparable<GraphNode> {
		private T data;
		private Integer distance;
		private GraphNode previousNode;
		Map<T, Integer> neighbours; // TODO

		GraphNode(T data) {
			this.data = data;
			// 初始化时候Node只包含数据data，没有邻居节点的信息
			this.neighbours = new HashMap<T, Integer>();
		}

		// Setter and Getter
		T getData() { return data; }

		Integer getDistance() { return distance; }

		void setDistance(Integer distance) { this.distance = distance; }

		GraphNode getPreviousNode() { return previousNode; }

		void setPreviousNode(GraphNode previousNode) { this.previousNode = previousNode; }

		Map<T, Integer> getNetghbourNodes() { return neighbours; }

		// 与另外的节点比较，实际比较的是距离
		public int compareTo(GraphNode node) {
			return distance.compareTo(node.getDistance());
		}

		@Override
		public String toString() {
			return data.toString();
		}

        /**
         * 获取从startNode开始到this node的路径
         * @param startNode 开始节点
         * @return 返回从startNode 到 this node的GraphPath
         */
        GraphPath getAllPreviousPath(GraphNode startNode) {
		    List<T> nodes = new LinkedList<>();
		    Integer distance = 0;
		    GraphNode currentNode = this;

		    if (currentNode.getPreviousNode() == null) {
		        return new GraphPath(nodes, distance);
            } else {
		        nodes.add(currentNode.getData());
		        while (!currentNode.equals(currentNode.getPreviousNode())) {
		            distance += distanceForEdge(currentNode.getPreviousNode().getData(), currentNode.getData());
		            // 向前回溯
		            currentNode = currentNode.getPreviousNode();
		            nodes.add(0, currentNode.getData());

		            if (currentNode.equals(startNode)) {
		                break;
                    }
                }
                return new GraphPath(nodes, distance);
            }
        }

	}
	// End of Class GraphNode

	/**
	 * {@code GraphPath} 是保存了一组按序排列的节点，其顺序表示遍历的顺序
	 */
	public class GraphPath {
		private List<T> nodes;
		private Integer distance;

		// 无参数初始化时候，节点列表为空列表，距离为0
		public GraphPath() {
			this.nodes = new ArrayList<T>();
			this.distance = 0;
		}

		// 带参数的初始化，直接赋值
		public GraphPath(List<T> nodes, Integer distance) {
			this.nodes = nodes;
			this.distance = distance;
		}

		// 获取最后一个节点
		public T last() {
			if (nodes.isEmpty()) {
				return null;
			} else {
				return nodes.get(nodes.size() - 1);
			}
		}

		List<T> getNodes() {
		    return nodes;
        }

		// 获取路线的距离
		public Integer distance() { return distance; }

		// 获取路线中的靠站数量
		public Integer stationCount() { 
			Integer count = nodes.size() - 1;
			return count < 0 ? 0 : count;
		}

		/**
		 * 删除最后一个节点
		 * @param distanceToLastNode 倒数第二个节点到最后一个节点的距离
		 * @return 如果删除成功返回true，失败返回false
		 */
		boolean removeLastNode(Integer distanceToLastNode) {
			if (!this.nodes.isEmpty()) {
				this.distance -= distanceToLastNode;
				this.nodes.remove(this.nodes.size() - 1);
				return true;
			} else {
				return false;
			}
		}

		/**
		 * 添加一个节点到末尾
		 * @param node 需要添加的节点
		 * @param distance 到达该节点的距离
		 * @return 添加成功返回true，失败返回false
		 */
		boolean appendNode(T node, Integer distance) {
			this.distance += distance;
			return this.nodes.add(node);
		}

		@Override
		public String toString() {
			StringBuilder builder = new StringBuilder();
			for (int i = 0; i < nodes.size() - 1; i++) {
				builder.append(nodes.get(i)).append("-->");
            }
			builder.append(nodes.get(nodes.size() - 1));
            return builder.toString();
		}
	}
	// End of Class GraphPath

    // 图的数据结构
	private Map<T, GraphNode> graph;

    // 构造函数
	public TWDirectedGraph() {
		graph = new HashMap<T, GraphNode>();
	}

	/**
	 * 添加一个新的节点到图中
	 * @param node 需要添加的新节点
	 */
	public void addNode(T node) {
		GraphNode graphNode = new GraphNode(node);
		graph.putIfAbsent(node, graphNode);
	}

	/**
	 * 是否包含某个节点
	 * @param node 需要检验是否包含的节点
	 */
	public boolean contains(T node) {
	    return graph.containsKey(node);
    }

    /**
     * 检查输入的节点是否都包含在图中了
     * @param inputNodes 输入的节点列表
     * @throws NoSuchNodeException 在这个图中没有其节点
     */
    @SafeVarargs
    private final void checkInputNodes(T... inputNodes) throws NoSuchNodeException {
	    for (T node : inputNodes) {
	        if (!contains(node)) {
	            throw new NoSuchNodeException("No Such Node In Graph"); // TODO
            }
        }
    }

    /**
     * 添加一条边到图中
     * @param start 开始点
     * @param destination 目的点
     * @param distance 边的长度
     * @throws NoSuchNodeException 在这个图中没有其节点
     * @throws InputIllegalException 输入有误的错误
     */
    public void addEdge(T start, T destination, Integer distance) throws NoSuchNodeException, InputIllegalException {
        checkInputNodes(start, destination);
        if (distance < 0) {
            throw new InputIllegalException("Input Illegal: distance can't be less than 0");
        }
        graph.get(start).getNetghbourNodes().put(destination, distance);
    }

    /**
     * 删除某条边
     * @param start 开始点
     * @param destination 目的点
     * @throws NoSuchNodeException 在图中没有其节点
     */
    public void removeEdge(T start, T destination) throws NoSuchNodeException {
        checkInputNodes(start, destination);
        graph.get(start).getNetghbourNodes().remove(destination);
    }

    /**
     * 获取某个节点的所有邻居数据，不包括距离
     * @param node 需要知道邻居是谁的节点
     * @return 返回node的邻居集合
     * @throws NoSuchNodeException 在图中没有node这个节点
     */
    public Set<T> getNeighbours(T node) throws NoSuchNodeException {
        checkInputNodes(node);
        return graph.get(node).getNetghbourNodes().keySet();
    }

    /**
     * 检查某条边是否存在在图中
     * @param start 边的开始节点
     * @param destination 边的目的节点
     * @return 返回是否存在，存在返回true，否则false
     * @throws NoSuchNodeException 在图中没有start或destination
     */
    public boolean checkEdgeExists(T start, T destination) throws NoSuchNodeException {
        checkInputNodes(start, destination);
        return graph.get(start).getNetghbourNodes().containsKey(destination);
    }

    /**
     * 返回某条边的长度
     * @param start 开始节点
     * @param destination 目的节点
     * @return 返回此条边的长度，没有则是null
     */
    public Integer distanceForEdge(T start, T destination) {
        return graph.get(start).getNetghbourNodes().get(destination);
    }

    /**
     * 返回当前图中的所有节点
     * @return 返回所有节点的集合
     */
    public Set<T> getNodes() {
        return graph.keySet();
    }

    /**
     * 迪杰斯特拉最短路径算法，此问题的两个核心算法之一
     * @param start 开始节点
     * @param destination 目的节点
     * @throws NoSuchNodeException 当前图中没有开始或目的节点
     */
    private void dijkstra(T start, T destination) throws NoSuchNodeException {
        PriorityQueue<GraphNode> queue = new PriorityQueue<GraphNode>();

        // Init graph:
        // Assign to every node a tentative distance value. Set it to zero for our initial node
        // and to infinity for all other graph.
        Set<T> nodes = getNodes();
        for (T node : nodes) {
            GraphNode graphNode = graph.get(node);
            graphNode.setDistance(Integer.MAX_VALUE);
            if (start.equals(node)) {
                graphNode.setDistance(0);
                graphNode.setPreviousNode(graphNode);
            }

            // Add node to priority queue
            queue.add(graphNode);
        }

        // Compute distances
        while (!queue.isEmpty()) {
            GraphNode currentGraphNode = queue.poll(); // Node with shortest distance

            if (currentGraphNode.getData().equals(destination) && !currentGraphNode.equals(currentGraphNode.getPreviousNode())) {
                break;
            }


            for (T neighbour : getNeighbours(currentGraphNode.getData())) {
                GraphNode neighbourGraphNode = graph.get(neighbour);

                final int alternateDist = currentGraphNode.getDistance() + distanceForEdge(currentGraphNode.getData(), neighbour);
                if (alternateDist < neighbourGraphNode.getDistance() || neighbourGraphNode.equals(neighbourGraphNode.getPreviousNode())) { // shorter path to neighbour found
                    queue.remove(neighbourGraphNode);
                    neighbourGraphNode.setDistance(alternateDist);
                    neighbourGraphNode.setPreviousNode(currentGraphNode);
                    queue.add(neighbourGraphNode);
                }
            }
        }
    }

    /**
     * 在深度优先算法中添加的条件判断
     */
    private interface DFSCondition {
        /**
         * 根据给定的边返回判断
         * @param path 给定的边
         * @return 如果条件满足返回true，否则false
         */
        boolean evaluate(TWDirectedGraph.GraphPath path);
    }

    /**
     * 深度优先搜索算法，递归实现
     * @param currentNode 当前的节点
     * @param stop 应该停止的条件
     * @param filter 应该计数的条件
     * @param path 搜索路径
     * @return 返回符合条件的路径数量
     * @throws NoSuchNodeException 当前节点没有在图中出现
     */
    private Integer depthFirstSearch(T currentNode, DFSCondition stop, DFSCondition filter, GraphPath path) throws NoSuchNodeException {
        Integer count = 0;

        if (filter.evaluate(path)) {
            count++; // 满足筛选条件，计数+1
        }

        for (T neighbour : getNeighbours(currentNode)) {

            path.appendNode(neighbour, distanceForEdge(currentNode, neighbour));

            if (stop.evaluate(path)) {
                path.removeLastNode(distanceForEdge(currentNode, neighbour));
                continue; // 遍历下一个邻居Node
            } else {
                // 递归遍历
                count += depthFirstSearch(neighbour, stop, filter, path);
            }

            path.removeLastNode(distanceForEdge(currentNode, neighbour));
        }
        return count;
    }

    /**
     * 获取符合条件的路径
     * @param start 开始节点
     * @param stop 结束条件
     * @param filter 筛选条件
     * @return 返回符合条件的路径数量
     * @throws NoSuchNodeException 过程中某个节点不在图中
     */
    private Integer getLegalPaths(T start, DFSCondition stop, DFSCondition filter) throws NoSuchNodeException {
        Integer count = 0;

        for (T neighbour : getNeighbours(start)) {
            GraphPath path = new GraphPath();
            path.appendNode(start, 0);
            path.appendNode(neighbour, distanceForEdge(start, neighbour));
            count += depthFirstSearch(neighbour, stop, filter, path);
        }

        return count;
    }

    /***************************************************************************************************/
    /*                                      以下是解决问题的直接方法                                        */
    /***************************************************************************************************/

    public GraphPath shortestPathBetween(T start, T destination) throws NoSuchNodeException, CanNotGetToNodeException {
        checkInputNodes(start, destination);

        dijkstra(start, destination);

        GraphNode destNode = graph.get(destination);
        GraphPath path = destNode.getAllPreviousPath(graph.get(start));

        if (path.getNodes().isEmpty()) {
            throw new CanNotGetToNodeException("Can not get to node");
        } else {
            return path;
        }
    }

    public Integer distanceWithNodes(List<T> nodes) throws NoSuchNodeException, CanNotGetToNodeException {
    	checkInputNodes((T[]) nodes.toArray());
    	Integer distance = 0;
    	for (int i = 0; i < nodes.size()-1; i++) {
    		if (checkEdgeExists(nodes.get(i), nodes.get(i+1))) {
    			distance += distanceForEdge(nodes.get(i), nodes.get(i+1));
			} else {
    			throw new CanNotGetToNodeException("There is no path");
			}
		}
		return distance;
	}

	public Integer numOfRouteWithMaxStations(T start, T destination, Integer maxStations) throws NoSuchNodeException {
    	checkInputNodes(start, destination);
		return getLegalPaths(start, (path)->{
			return path.stationCount() > maxStations; // To stop
		}, (path)->{
			return destination.equals(path.last()); // filter
		});
	}

	public Integer numOfRouteWithStations(T start, T destination, Integer stations) throws NoSuchNodeException {
    	checkInputNodes(start, destination);
    	return getLegalPaths(start, (path)->{
    		return path.stationCount() > stations;
		}, (path)->{
    		return destination.equals(path.last()) && path.stationCount() == stations;
		});
	}

	public Integer numOfRouteWithMaxDistance(T start, T destination, Integer maxDistance) throws NoSuchNodeException {
    	checkInputNodes(start, destination);
    	return getLegalPaths(start, path -> {
    		return path.distance() > maxDistance;
		}, path -> {
    		return destination.equals(path.last()) && path.distance <= maxDistance;
		});
	}


}