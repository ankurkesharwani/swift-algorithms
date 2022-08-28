
class TopSortRecursive {

    /// Gives topologiocal ordering of all nodes in a graph
    /// - Parameters:
    ///     - edges: An arry of edges where each edge is a represented as an array os size 2, ex: [V1, V2]. 
    ///              V1 and V2 are two vertices that form an edge
    ///     - numNodes: Number of nodes `N` in the graph. Nodes are numbered from `0` to `N - 1`
    /// - Returns: An array of nodes sorted in topological order.
    func sort(_ edges: [[Int]], _ numNodes: Int) -> [Int] {

        // Will contain the graph as adjacency list
        var graph: [Int: [Int]] = [:]

        // Convert edges to adjacency list
        for e in edges {
            if graph[e[0]] == nil {
                graph[e[0]] =  [Int]()
            }
            graph[e[0]]!.append(e[1])
        }

        var index = numNodes - 1
        var output: [Int] = [Int](repeating: -1, count: numNodes)
        var visited: [Bool] = [Bool](repeating: false, count: numNodes)

        // Pick a node that is not visited yet and
        for i in 0..<visited.count {
            if visited[i] {
                continue
            }

            // Start DFS from that node
            var path = [Int]()
            dfs(graph, &visited, &path, i)
            for node in path {
                output[index] = node
                index -= 1
            }
        }

        return output
    }

    /// Iterates the graph recursively and sorts the nodes in `path` as its traverse
    /// - Parameters:
    ///     - graph: The graph as adjacency list
    ///     - visited: A visited array
    ///     - path: The sorted path
    ///     - node: Starting node  
    func dfs(_ graph: [Int: [Int]], _ visited: inout [Bool], _ path: inout [Int], _ node: Int) {
        visited[node] = true
        
        if graph[node] != nil {
            for dest in graph[node]! {
                if visited[dest] == false {
                    dfs(graph, &visited, &path, dest)
                }
            }
        }
    
        path.append(node)
    }
}

// MARK: Use

let edges = [
    [0, 1],
    [0, 3],
    [1, 4],
    [3, 4], 
    [3, 5],
    [4, 2],
    [4, 5]
]

let ts = TopSortRecursive()          
let result = ts.sort(edges, 6)
print(result)