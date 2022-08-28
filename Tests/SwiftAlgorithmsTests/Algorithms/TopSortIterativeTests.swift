import XCTest
@testable import SwiftAlgorithms

final class TopSortIterativeTests: XCTestCase {
    func testTopSortIterative() throws {
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
        
        XCTAssert(result == [0, 1, 3, 4, 2, 5])
    }
}
