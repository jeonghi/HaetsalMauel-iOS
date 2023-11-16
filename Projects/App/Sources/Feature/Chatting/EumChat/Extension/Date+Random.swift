//
//  Date+Random.swift
//  App
//
//  Created by 쩡화니 on 11/12/23.
//  Copyright © 2023 kr.k-eum. All rights reserved.
//

import Foundation

extension Date {
    func randomTime() -> Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: self)
        components.hour = Int.random(min: 0, max: 23)
        components.minute = Int.random(min: 0, max: 59)
        components.second = Int.random(min: 0, max: 59)

        return Calendar.current.date(from: components)!
    }
}

extension Int {
    /**
     Return a random number between `min` and `max`.
     - note: The maximum value cannot be more than `UInt32.max - 1`
     
     - parameter min: The minimum value of the random value (defaults to `0`).
     - parameter max: The maximum value of the random value (defaults to `UInt32.max - 1`)
     
     - returns: Returns a random value between `min` and `max`.
     */
    public static func random(min: Int = 0, max: Int = Int.max) -> Int {
        precondition(min <= max, "attempt to call random() with min > max")
        
        let diff   = UInt(bitPattern: max &- min)
        let result = UInt.random(min: 0, max: diff)
        
        return min + Int(bitPattern: result)
    }
    
    public func randomize(variation: Int) -> Int {
        let multiplier = Double(Int.random(min: 100 - variation, max: 100 + variation)) / 100
        let randomized = Double(self) * multiplier
        
        return Int(randomized) + 1
    }
}

private extension UInt {
    static func random(min: UInt, max: UInt) -> UInt {
        precondition(min <= max, "attempt to call random() with min > max")
        
        if min == UInt.min && max == UInt.max {
            var result: UInt = 0
            arc4random_buf(&result, MemoryLayout.size(ofValue: result))
            
            return result
        } else {
            let range         = max - min + 1
            let limit         = UInt.max - UInt.max % range
            var result: UInt = 0
            
            repeat {
                arc4random_buf(&result, MemoryLayout.size(ofValue: result))
            } while result >= limit
            
            result = result % range
            
            return min + result
        }
    }
}

extension String {
    var firstCapitalized: String {
        var string = self
        string.replaceSubrange(string.startIndex...string.startIndex, with: String(string[string.startIndex]).capitalized)
        return string
    }
}

public extension Array {
    /**
     Shuffle the array in-place using the Fisher-Yates algorithm.
     */
    mutating func shuffle() {
        if count == 0 {
            return
        }

        for i in 0..<(count - 1) {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            if j != i {
                self.swapAt(i, j)
            }
        }
    }
    
    /**
     Return a shuffled version of the array using the Fisher-Yates
     algorithm.
     
     - returns: Returns a shuffled version of the array.
     */
    func shuffled() -> [Element] {
        var list = self
        list.shuffle()
        
        return list
    }
    
    /**
     Return a random element from the array.
     - returns: Returns a random element from the array or `nil` if the
     array is empty.
     */
    func random() -> Element? {
        return (count > 0) ? self.shuffled()[0] : nil
    }
    
    /**
     Return a random subset of `cnt` elements from the array.
     - returns: Returns a random subset of `cnt` elements from the array.
     */
    func random(_ count: Int = 1) -> [Element] {
        let result = shuffled()
        
        return (count > result.count) ? result : Array(result[0..<count])
    }
}
