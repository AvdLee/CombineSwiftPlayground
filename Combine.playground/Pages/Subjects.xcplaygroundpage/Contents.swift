//: [Previous](@previous)
import Foundation
import Combine

/*:
# Subjects
- A subject is a publisher ...
- ... relays values it receives from other publishers ...
- ... can be manually fed with new values
- ... subjects as also subscribers, and can be used with `subscribe(_:)`
*/

/*:
## Example 1
Using a subject to relay values to subscribers
*/
let relay = PassthroughSubject<String, Never>()

let subscription = relay
	.sink { value in
		print("subscription1 received value: \(value)")
}

relay.send("Hello")
relay.send("World!")

//: What happens if you send "hello" before setting up the subscription?

/*:
## Example 2
Subscribing a subject to a publisher
*/

let publisher = ["Here","we","go!"].publisher

publisher.subscribe(relay)

/*:
## Example 3
Using a `CurrentValueSubject` to hold and relay the latest value to new subscribers
*/

let variable = CurrentValueSubject<String, Never>("")

variable.send("Initial text")

let subscription2 = variable.sink { value in
	print("subscription2 received value: \(value)")
}

variable.send("More text")
//: [Next](@next)
