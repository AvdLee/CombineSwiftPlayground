import Foundation
import Combine
import UIKit

/*:
 [Previous](@previous)
 ## Foundation and Combine
 Foundation adds Combine publishers for many types, like:
 */
/*:
 ##### A URLSessionTask publisher and a JSON Decoding operator
 */
struct DecodableExample: Decodable { }

URLSession.shared.dataTaskPublisher(for: URL(string: "https://www.avanderlee.com/feed/")!)
    .map { $0.data }
    .decode(type: DecodableExample.self, decoder: JSONDecoder())

/*:
 ##### A Publisher for notifications
 */
NotificationCenter.default.publisher(for: .NSSystemClockDidChange)

/*:
 ##### KeyPath binding to NSObject instances
 */
let ageLabel = UILabel()
Just(28)
    .map { "Age is \($0)" }
    .assign(to: \.text, on: ageLabel)
//: [Next](@next)
