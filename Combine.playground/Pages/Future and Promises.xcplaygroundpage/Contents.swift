import Foundation
import UIKit
import Combine
/*:
 [Previous](@previous)
 ## Future and Promises
 A `Publishers.Future` creates a new `Publisher` that eventually produces one value and then finishes or fails.
 - Allows you to call custom methods and return a Result.success or Result.failure
 */
enum ValidationError: Error { }

func isWinningLotteryNumber(_ number: Int, completion: (_ winning: Bool) -> Void) {
    let winningLotteryNumbers = [0, 3, 5, 8]
    completion(winningLotteryNumbers.contains(number))
}

let lotteryPublisher = PassthroughSubject<Int, ValidationError>()

lotteryPublisher.flatMap { number  in
    return Publishers.Future { promise in
        isWinningLotteryNumber(number) { (winning) in
            promise(.success(winning))
        }
    }
}.sink { winning in
    print("Did someone win? \(winning)")
}

lotteryPublisher.send((0..<10).randomElement()!)
//: [Next](@next)
