import Foundation

fileprivate struct MemoryBanks {
    
    private(set) var block: [[Int]] = []
    
    public init() { }
    
    public mutating func add(_ block: [Int]) {
        self.block.append(block)
    }
    
    public mutating func shouldAdd(_ memoryBlock: [Int]) -> Bool {
        let specificMemoryBlocks = block.filter { return $0 == memoryBlock }
        return specificMemoryBlocks.count <= 1
    }
}

fileprivate func process(input: inout [Int]) {
    
    guard input.count > 0 else { return }
    var maxValue = input.max()!
    let maxValueIndex = input.index(of: maxValue)!
    
    var rhsArr = Array(input[(maxValueIndex + 1)...])
    var lhsArr = Array(input[..<maxValueIndex])
    
    // TODO: Write condition that can satisfy the sample input as well as advent input
    while maxValue >= (lhsArr + rhsArr).max()! {
        if rhsArr.count > 0 && maxValue > 0 {
            for (index, value) in rhsArr.enumerated() {
                if maxValue > 0 {
                    rhsArr[index] = value + 1
                    maxValue--
                    input[maxValueIndex] = maxValue
                }
            }
            input.replaceSubrange((maxValueIndex + 1)..., with: rhsArr)
        }
        
        if lhsArr.count > 0 && maxValueIndex > 0 {
            for (index, value) in lhsArr.enumerated() {
                if maxValue > 0 {
                    lhsArr[index] = value + 1
                    maxValue--
                    input[maxValueIndex] = maxValue
                }
            }
            input.replaceSubrange(..<maxValueIndex, with: lhsArr)
        }
    }
}

public typealias CompletionBlock = ([[Int]], [Int], Int) -> Void

public func processMemoryBank(queue: DispatchQueue = DispatchQueue.global(), _ inputArr: [Int], _ completion: @escaping CompletionBlock) {
    
    queue.async {
        var steps = 0
        
        var currentInput = inputArr
        var memoryBanks = MemoryBanks()
        
        repeat {
            process(input: &currentInput)
            memoryBanks.add(currentInput)
            steps++
        }while memoryBanks.shouldAdd(currentInput)
        
        completion(memoryBanks.block,currentInput, steps)
    }
}


fileprivate extension Int {
    postfix static func --(value: inout Int) {
        value = value - 1
    }
    
    postfix static func ++(value: inout Int) {
        value = value + 1
    }
}
