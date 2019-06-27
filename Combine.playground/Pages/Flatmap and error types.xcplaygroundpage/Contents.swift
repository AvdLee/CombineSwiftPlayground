import Foundation
import UIKit
import Combine
/*:
 [Previous](@previous)
 ## Flatmap and matching error types
 Flatmapping into a new `Publisher` type requires to match the original streams types.
 */
/*:
 ##### Matching error types
 Using `mapError` to change the `DataTaskPublisher.URLError` to our own `RequestError` type
 */
enum RequestError: Error {
    case sessionError(error: Error)
}

let URLPublisher = PassthroughSubject<URL, RequestError>()
URLPublisher.flatMap { requestURL in
    return URLSession.shared.dataTaskPublisher(for: requestURL)
        .mapError { error -> RequestError in
            return RequestError.sessionError(error: error)
        }
    }.sink { result in
        print("Request finished!")
        let image = UIImage(data: result.data)
    }
URLPublisher.send(URL(string: "https://httpbin.org/image/jpeg")!)
//: [Next](@next)
