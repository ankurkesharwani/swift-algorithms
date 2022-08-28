import XCTest
@testable import SwiftAlgorithms

final class DijkstraShortestPathTests: XCTestCase {
    func testDijkstraShortestPath() throws {
        let edges:[[Int]] = [
            [0, 1, 4],
            [1, 2, 5],
            [2, 6, 2],
            [6, 5, 2], 
            [5, 2, 3],
            [1, 4, 1],
            [3, 4, 1],
            [0, 3, 2]
        ]

        let dsp = DijkstraShortestPath.init(edges, 7, false)
        let result = dsp.findShortest(0)

        XCTAssertEqual(result.parent, [-1, 0, 1, 0, 3, 2, 2])
        XCTAssertEqual(result.distance, [0, 4, 9, 2, 3, 12, 11])
    }
}
