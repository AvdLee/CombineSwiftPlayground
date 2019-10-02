/*:
 [Previous](@previous)
 ## The rules of a subscription
 - A subscriber will receive a _single_ subscription
 - _Zero_ or _more_ values can be published
 - At most _one_ completion will be called
 - After completion, nothing more is received
 */
import Combine
import UIKit

enum ExampleError: Swift.Error {
    case somethingWentWrong
}

let subject = PassthroughSubject<String, ExampleError>()

// the handleEvents operator lets you intercept
// all stages of a subscription lifecycle
subject.handleEvents(receiveSubscription: { (subscription) in
        print("New subscription!")
    }, receiveOutput: { _ in
        print("Received new value!")
    }, receiveCompletion: { _ in
        print("A subscription completed")
    }, receiveCancel: {
        print("A subscription cancelled")
    })
    .replaceError(with: "Failure")
    .sink { (value) in
        print("Subscriber received value: \(value)")
    }

subject.send("Hello!")
subject.send("Hello again!")
subject.send("Hello for the last time!")
subject.send(completion: Subscribers.Completion<ExampleError>.failure(ExampleError.somethingWentWrong))
subject.send("Hello?? :(")

//: [Next](@next)
