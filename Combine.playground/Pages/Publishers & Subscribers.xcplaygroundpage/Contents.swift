import Foundation
import Combine
/*:
 [Previous](@previous)
 ## Publishers and Subscribers
 - A Publisher exposes values that can change on which..
 - ..a subscriber subscribes to receive all those updates

 */
let publisher = Publishers.Just(28)
publisher.sink { (value) in
    print("Subscriber received value: \(value)")
}
//: [Next](@next)
