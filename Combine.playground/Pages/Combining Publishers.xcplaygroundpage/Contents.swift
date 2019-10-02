import Foundation
import UIKit
import Combine
/*:
 [Previous](@previous)
 ## Combining Publishers
 Combining allows to
 - Merge multiple streams into one
 - Listen to multiple publishers
 */

// Subjects simulate input from text fields
let usernamePublisher = PassthroughSubject<String, Never>()
let passwordPublisher = PassthroughSubject<String, Never>()

let validatedCredentials = Publishers.CombineLatest(usernamePublisher, passwordPublisher)
    .map { (username, password) -> Bool in
        !username.isEmpty && !password.isEmpty && password.count > 12
    }
    .replaceError(with: false)
    .sink { (valid) in
        print("CombineLatest: Are the credentials valid: \(valid)")
    }

// Nothing will be printed yet as `CombineLatest` requires both publishers to have send at least one value.
usernamePublisher.send("avanderlee")
passwordPublisher.send("weakpass")
passwordPublisher.send("verystrongpassword")

//: [Next](@next)
