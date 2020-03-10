//: [Previous](@previous)

import Foundation
import Combine
/*:
# Simple operators
- Operators are functions defined on publisher instances...
- ... each operator returns a new publisher ...
- ... operators can be chained to add processing steps
*/

/*:
## Example: `map`
- works like Swift's `map`
- ... operates on values over time
*/
let publisher1 = PassthroughSubject<Int, Never>()

let publisher2 = publisher1.map { value in
	value + 100
}

let subscription1 = publisher1
	.sink { value in
		print("Subscription1 received integer: \(value)")
}

let subscription2 = publisher2
	.sink { value in
		print("Subscription2 received integer: \(value)")
}

print("* Demonstrating map operator")
print("Publisher1 emits 28")
publisher1.send(28)

print("Publisher1 emits 50")
publisher1.send(50)

subscription1.cancel()
subscription2.cancel()

/*:
## Example: `filter`
- works like Swift's `filter`
- ... operates on values over time
*/

let publisher3 = publisher1.filter {
	// only let even values pass through
	($0 % 2) == 0
}

let subscription3 = publisher3
	.sink { value in
		print("Subscription3 received integer: \(value)")
}

print("\n* Demonstrating filter operator")
print("Publisher1 emits 14")
publisher1.send(14)

print("Publisher1 emits 15")
publisher1.send(15)

print("Publisher1 emits 16")
publisher1.send(16)

//: [Next](@next)
