import Foundation
import PlaygroundSupport
import Combine

/*:
 ##### Sink
 */

let sinkExample = Publishers.Just(28)
sinkExample.sink { (value) in
    print(value)
}

/*:
 ##### Future
 */
let futureExample = Publishers.Future { (subscriber: @escaping (Result<String, Error>) -> Void) in
    subscriber(.success("Success"))
}

futureExample.sink { (value) in
    print(value)
}
