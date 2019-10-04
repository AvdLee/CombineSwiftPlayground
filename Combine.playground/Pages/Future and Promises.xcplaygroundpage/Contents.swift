import Foundation
import UIKit
import Combine
/*:
 [Previous](@previous)
 ## Future and Promises
 A `Publishers.Future` creates a new `Publisher` that eventually produces one value and then finishes, or fails.
 - Allows you to call custom methods and return a Result.success or Result.failure
 */
struct User {
    let id: Int
    let name: String
}
let users = [User(id: 0, name: "Antoine"), User(id: 1, name: "Henk"), User(id: 2, name: "Bart")]

enum FetchError: Error {
    case userNotFound
}

func fetchUser(for userId: Int, completion: (_ result: Result<User, FetchError>) -> Void) {
    if let user = users.first(where: { $0.id == userId }) {
        completion(Result.success(user))
    } else {
        completion(Result.failure(FetchError.userNotFound))
    }
}

let fetchUserPublisher = PassthroughSubject<Int, FetchError>()

fetchUserPublisher
    .flatMap { userId -> Future<User, FetchError> in
        return Future { promise in
            fetchUser(for: userId) { (result) in
                switch result {
                case .success(let user):
                    promise(.success(user))
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }
    .map { user in user.name }
    .catch { (error) -> Just<String> in
        print("Error occurred: \(error)")
        return Just("Not found")
    }
    .sink { result in
        print("User is \(result)")
    }

fetchUserPublisher.send(0)
fetchUserPublisher.send(5)
//: [Next](@next)
