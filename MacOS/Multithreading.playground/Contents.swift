//: Playground - noun: a place where people can play

import Cocoa
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true


let semaphore = DispatchSemaphore(value: 1)

func asynTask(_ queue: DispatchQueue, symbol: String) {
    queue.async {
        print("\(symbol) waiting")
        semaphore.wait()
        for i in 1...10 {
            print("\(symbol) \(i)")
        }
        print("\(symbol) signal")
        semaphore.signal()
    }
}

let higherPriority = DispatchQueue.global(qos: .userInitiated)
let lowerPriority = DispatchQueue.global(qos: .utility)

asynTask(higherPriority, symbol: "📪")
asynTask(lowerPriority, symbol: "🎈")

/*
var value = 0

extension Int {
    postfix static func ++(value: inout Int) {
        value = value + 1
    }
    
    postfix static func --(value: inout Int) {
        value = value - 1
    }
}

enum OperatorSymbol {
    case increment
    case decrement
}

func change(queue: DispatchQueue = DispatchQueue.global(), _ symbol: OperatorSymbol) {
    let semaphore = DispatchSemaphore(value: 1)
    
    queue.async {
        semaphore.wait()
        switch symbol {
        case .increment:
            value++
        case .decrement:
            value--
        }
        print(value)
        semaphore.signal()
    }
}

let queue0 = DispatchQueue.global(qos: .userInitiated)
let queue1 = DispatchQueue.global(qos: .utility)

change(queue: queue0, .increment)
change(queue: queue1, .decrement)

*/
