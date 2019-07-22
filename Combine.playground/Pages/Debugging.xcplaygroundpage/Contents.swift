import Foundation
import UIKit
import Combine
/*:
 [Previous](@previous)
 ## Debugging
 Operators which help to debug Combine streams and implementations.

 More info: [https://www.avanderlee.com/debugging/combine-swift/‎](https://www.avanderlee.com/debugging/combine-swift/‎)
 */

enum ExampleError: Swift.Error {
    case somethingWentWrong
}

/*:
 #### Handling events
 Can be used combined with breakpoints for further insights.
 */
let subject = PassthroughSubject<String, ExampleError>()
let subscription = subject.handleEvents(receiveSubscription: { (subscription) in
    print("Receive subscription")
}, receiveOutput: { output in
    print("Received output: \(output)")
}, receiveCompletion: { _ in
    print("Receive completion")
}, receiveCancel: {
    print("Receive cancel")
}, receiveRequest: { demand in
    print("Receive request: \(demand)")
}).replaceError(with: "Error occurred").sink { _ in }

subject.send("Hello!")
subscription.cancel()

// Prints out:
// Receive request: unlimited
// Receive subscription
// Received output: Hello!
// Receive cancel

//subject.send(completion: .finished)

/*:
 #### Print
 Using the print operator to log messages for all publishing events.
 */

let printSubscription = subject.print("Print example").replaceError(with: "Error occurred").sink { _ in }

subject.send("Hello!")
printSubscription.cancel()

// Prints out:
// Print example: receive subscription: (PassthroughSubject)
// Print example: request unlimited
// Print example: receive value: (Hello!)
// Print example: receive cancel

//: [Next](@next)
