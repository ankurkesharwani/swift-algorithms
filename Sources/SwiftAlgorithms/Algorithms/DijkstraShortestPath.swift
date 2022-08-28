class DijkstraShortestPath {

    // Represnets an adjacency list with edge weights.
    // Each key represents a node and the value represents
    // the nodes that can be visited from key node. Each item 
    // in the adjacency list is an array of size 2 where the 1st item 
    // is the node and 2nd item is the weight of the edge formed b/w
    // the nodes.
    private var graph: [Int: [[Int]]] = [:]

    // Number of vertices `N` in the node, nodes are numberes from `0` to `N-1`.
    private var numVertices: Int

    init(_ edges: [[Int]], _ numVertices: Int, _ directed: Bool) {
        self.numVertices = numVertices

        // Convert edges into an adjacency list graph.
        for e in edges {
            if graph[e[0]] == nil {
                graph[e[0]] = [[Int]]()  
            }

            if !directed {
                if graph[e[1]] == nil {
                    graph[e[1]] = [[Int]]()
                }
            }

            graph[e[0]]!.append([e[1], e[2]])
            if !directed {
                graph[e[1]]!.append([e[0], e[2]])
            }
        }
    }

    func findShortest(_ node: Int) -> (parent: [Int], distance: [Int]) {

        // Each index `i` represents a node and the value `parent[i]` represents the 
        // partent of node `i`.
        var parent = [Int](repeating: -1, count: numVertices)

        // Each index `i` represents a node and the value `distance[i]` represents the 
        // shortest distance of node `i` from starting node `node`.
        var distance = [Int](repeating: Int.max, count: numVertices); distance[node] = 0

        // Priority Queue without Key Decreasing Op. 
        let pq = PriorityQueue<[Int]>(compare: { $0[1] - $1[1] }); pq.insert([node, 0])

        // Each index `i` represents a node and the value `visited[i]` represents 
        // if node `i` has been visited or not.
        var visited = [Bool](repeating: false, count: numVertices)

        // While queue is not empty
        while(!pq.isEmpty) {

            // pop an element from the queue. Here popped[0] represents the node and
            // popped[1] represnets the distance of this node from the starting node.
            let popped = pq.pop()!

            // Mark this node as visited
            visited[popped[0]] = true

            // If we have already found a shorted path for this node we can skip to
            // the next node
            if distance[popped[0]] < popped[1] {
                continue
            }
            if graph[popped[0]] == nil {
                continue
            }


            // For every unvisited node that can be visited from the popped node
            for dest in graph[popped[0]]! {
                if visited[dest[0]] {
                    continue
                }

                // Find the new distance including popped node
                let newDistance = distance[popped[0]] + dest[1]

                // Update the distance of this unvisited node and its parent if
                // new distance is better.
                if newDistance < distance[dest[0]] {
                    distance[dest[0]] = newDistance
                    parent[dest[0]] = popped[0]

                    // Append in the priority queue
                    pq.insert([dest[0], newDistance])
                }
            }
        }
        return (parent: parent, distance: distance)
    } 
}