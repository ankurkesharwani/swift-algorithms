import XCTest
@testable import SwiftAlgorithms

final class TopSortRecursiveTests: XCTestCase {
    func testTopSortRecursive() throws {
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
        XCTAssert(result == [0, 3, 1, 4, 5, 2])
    }
}
