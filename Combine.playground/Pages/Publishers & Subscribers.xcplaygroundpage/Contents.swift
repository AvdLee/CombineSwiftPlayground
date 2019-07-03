import Foundation
import Combine
/*:
 [Previous](@previous)
 ## Publishers, Operators, and Subscribers
 - A Publisher exposes values that can change on which..
 - .. change through operators and ..
 - ..a subscriber subscribes to receive all those updates

 */
let publisher = Just(28)

// This creates a `Subscriber` on the `Just a 28` Publisher
publisher
    // We change the value
    .map { number in
        return "Antoine's age is \(number)"
    }
    // We subscribe using `sink`
    .sink { (value) in
        print(value)
    }
//: [Next](@next)
