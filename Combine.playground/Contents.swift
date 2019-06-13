import UIKit
import Combine

/*:
 ##### Sink
 */

let sinkExample = Publishers.Just(28)
sinkExample.sink { (value) in
    print(value)
}
