import Foundation
import Combine
/*:
 [Previous](@previous)
 ## Publishers and Subscribers
 - A Publisher _publishes_ values ...
 - .. a subscriber _subscribes_ to receive publisher's values

 */
let publisher = Just(28)

// We want to receive values from this publisher
let subscription = publisher
	// A sink subscribes to a publisher
    .sink { value in
        print("Received value: \(value)")
    }
//: [Next](@next)
