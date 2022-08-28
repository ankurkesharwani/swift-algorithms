import XCTest
@testable import SwiftAlgorithms

final class PriorityQueueTests: XCTestCase {
    func testPriorityQueue() throws {
        class Task {
            let priority: Int

            init(_ priority: Int) {
                self.priority = priority
            }
        }

        let pq = PriorityQueue<Task>(compare: { $0.priority - $1.priority })
  
        XCTAssertTrue(pq.isEmpty)

        for i in [3, 4, 1, 9, 6, 2, 5, 8, 7, 0] {
            pq.insert(Task(i))
        }

        XCTAssertFalse(pq.isEmpty)
        
        var prev = pq.pop()
        for _ in 1..<10 {
            let item = pq.pop()
            
            XCTAssertTrue(item!.priority > prev!.priority)
            
            prev = item
        }

        XCTAssertTrue(pq.isEmpty)
    }
}
