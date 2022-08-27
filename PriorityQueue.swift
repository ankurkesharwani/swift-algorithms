import Foundation

class PriorityQueue<K> {
    private var compare: (K, K) -> Int
    private var arr: [K]
        
    init(compare: @escaping (K, K) -> Int) {
        self.compare = compare
        arr = [K]()
    }
        
    func min() -> K? {
        if arr.isEmpty {
            return nil
        }
        
        return arr[0]
    }
    
    func pop() -> K? {
        if arr.isEmpty { return nil }
        let min = arr[0]; let last = arr.removeLast()
        if arr.isEmpty { return min }
        if last != nil { arr[0] = last }
        
        heapifyDown()
        
        return min
    }

    func insert(_ num: K) {
        arr.append(num)
        
        heapifyUp()
    }
    
    private func heapifyUp() {
        var index = arr.count - 1
        while(index > 0) {
            let parent = parentIndex(index)
            if compare(arr[index], arr[parent]) < 0 {
                swap(&arr, index, parent)
                index = parent
            } else {
                break
            }
        }
    }
    
    private func heapifyDown() {
        var index = 0
        while(index < arr.count) {
            let l = leftChildIndex(index)
            let r = rightChildIndex(index)
            var minIndex = index
            if l == nil && r == nil {
                break
            } else if l != nil && r != nil {
                let c = compare(arr[l!], arr[r!])
                minIndex = c < 0 ? l! : r!
            } else {
                minIndex = l == nil ? r! : l!
                minIndex = r == nil ? l!: r!
            }
            if compare(arr[minIndex], arr[index]) < 0 {
                swap(&arr, index, minIndex)
                index = minIndex
            } else {
                break
            }
        }
    }
    
    private func leftChildIndex(_ index: Int) -> Int? {
        let index = (index * 2) + 1
        if index < arr.count {
            return index
        }
        
        return nil
    } 
        
    private func rightChildIndex(_ index: Int) -> Int? {
       let index = (index * 2) + 2
        if index < arr.count {
            return index
        }
        
        return nil
    } 
        
    private func parentIndex(_ index: Int) -> Int {
        if index % 2 == 0 {
            return (index - 2) / 2
        } else {
            return (index - 1) / 2
        }
    }
        
    private func swap(_ arr: inout [K], _ i: Int, _ j: Int) {
        let temp = arr[i]
        arr[i] = arr[j]
        arr[j] = temp
    }
}

// MARK: Use

let q = PriorityQueue<Int>(compare: { i, j in i - j })
q.insert(3)
q.insert(4)
q.insert(2)
q.insert(5)
q.insert(1)
q.insert(6)
q.insert(8)
q.insert(0)
q.insert(7)

print(q.pop())
print(q.pop())
print(q.pop())
print(q.pop())
print(q.pop())
print(q.pop())
print(q.pop())
print(q.pop())
print(q.pop())