
class TopSortIterative {
    
    /// Gives topologiocal ordering of all nodes in a graph
    /// - Parameters:
    ///     - edges: An arry of edges where each edge is a represented as an array os size 2, ex: [V1, V2]. V1 and V2 are two vertices that form an edge
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
        var stack: [Int] = []
        var visited: [Bool] = [Bool](repeating: false, count: numNodes)

        // Pick a node that is not visited yet and
        for i in 0..<visited.count {
            if visited[i] {
                continue
            }

            // Start DFS from that node
            stack.append(i)
            
            // This will hold the current path as visited by DFS
            var path = [Int]()
            while(!stack.isEmpty) {
                let popped = stack.removeLast()
                visited[popped] = true
                path.append(popped)

                if graph[popped] == nil {
                    
                    // When we hit the end of the path we should try to update the output
                    addToOutput(&output, &index, &path, graph, visited)
                    continue
                }

                var hasMoreOfPath = false
                for dest in graph[popped]! {
                    if visited[dest] {
                        continue
                    }

                    stack.append(dest)
                    hasMoreOfPath = true
                }

                // Or when there is no new path from this node then too we need to updarte the output
                if !hasMoreOfPath {
                    addToOutput(&output, &index, &path, graph, visited)
                }
            }
        }

        return output
    }

    // Takes a path and finds nodes that are part of the output
    func addToOutput(_ output: inout [Int], _ index: inout Int, _ path: inout [Int], _ graph: [Int: [Int]], _ visited: [Bool]) {
        var i = path.count - 1
        while(i >= 0) {
            let node = path[i]; i -= 1
            
            if graph[node] != nil {
                for dest in graph[node]! {
                    if visited[dest] == false {
                        return
                    }
                }
            }
            
            output[index] = node
            index -= 1
            path.removeLast()
        }              
    }
}

// MARK: Use
/*
let edges = [
    [0, 1],
    [0, 3],
    [1, 4],
    [3, 4], 
    [3, 5],
    [4, 2],
    [4, 5]
]

let ts = TopSortIterative()          
let result = ts.sort(edges, 6)
print(result)*/