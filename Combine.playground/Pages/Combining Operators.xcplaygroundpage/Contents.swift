//: [Previous](@previous)

import Foundation
import Combine

/*:
# Combining publishers
Several operators let you _combine_ multiple publishers together
*/

/*:
## `CombineLatest`
- combines values from multiple publishers
- ... waits for each to have delivered at least one value
- ... then calls your closure to produce a combined value
- ... and calls it again every time any of the publishers emits a value
*/

print("* Demonstrating CombineLatest")

//: **simulate** input from text fields with subjects
let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

//: **combine** the latest value of each input to compute a validation
let validatedCredentialsSubscription = Publishers
	.CombineLatest(usernamePublisher, passwordPublisher)
    .map { (username, password) -> Bool in
        !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .sink { valid in
        print("CombineLatest: are the credentials valid? \(valid)")
    }

//: Example: simulate typing a username and the password twice
usernamePublisher.send("avanderlee")
passwordPublisher.send("weakpass")
passwordPublisher.send("verystrongpassword")

/*:
## `Merge`
- merges multiple publishers value streams into one
- ... values order depends on the absolute order of emission amongs all merged publishers
- ... all publishers must be of the same type.
*/
print("\n* Demonstrating Merge")
let publisher1 = [1,2,3,4,5].publisher
let publisher2 = [300,400,500].publisher

let mergedPublishersSubscription = Publishers
	.Merge(publisher1, publisher2)
	.sink { value in
		print("Merge: subscription received value \(value)")
}
//: [Next](@next)
