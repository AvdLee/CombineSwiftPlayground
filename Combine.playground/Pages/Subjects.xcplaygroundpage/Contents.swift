import Foundation
import Combine
/*:
 [Previous](@previous)
 ## Subjects
 - A subject is both a subscriber and a publisher ...
- ... relays values it receives from other publishers ...
- ... can be manually fed with new values
 */
let subject = PassthroughSubject<String, Never>()

let subscription = subject
	.sink { value in
		print("Received value: \(value)")
}

// Manually send a value through the subject
subject.send("Hello!")

// Subscribe the subject to a publisher, it relays the values
let publisher = Just("Here we go")
publisher.subscribe(subject)

//: [Next](@next)
