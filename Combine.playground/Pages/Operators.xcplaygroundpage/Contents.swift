//: [Previous](@previous)

import Foundation
import Combine
/*:
[Previous](@previous)
## Operators
- Operators are functions defined on publisher instances...
- ... each operator returns a new publisher ...
- ... operators can be chained to add processing steps
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

print("Publisher1 emits 28")
publisher1.send(28)

print("Publisher1 emits 50")
publisher1.send(50)

//: [Next](@next)
