import Foundation
import UIKit
import Combine
import PlaygroundSupport
/*:
 [Previous](@previous)
 ## Threading
 Threading is important to make sure we perform operators on the right thread.

 */
PlaygroundPage.current.needsIndefiniteExecution = true
let backgroundQueue = DispatchQueue.global(qos: .background)

struct Slideshow: Decodable {
    let title: String
}
struct Presentation: Decodable {
    let slideshow: Slideshow
}

let slideshowTitleLabel = UILabel()

URLSession.shared.dataTaskPublisher(for: URL(string: "http://httpbin.org/json")!)
    /// We first receive on the background queue so decoding happens on the background queue
    .receive(on: backgroundQueue)
    .handleEvents(receiveSubscription: { _ in
        print("Thread on receiving a subscription is \(Thread.current)")
    }, receiveOutput: { _ in
        print("Thread on receiving output is \(Thread.current)")
    }, receiveCompletion: { _ in
        print("slideshowTitleLabel.text is: \(slideshowTitleLabel.text ?? "")")
    })
    .map { $0.data }
    .decode(type: Presentation.self, decoder: JSONDecoder())
    .map { $0.slideshow.title }
    .catch { _ in
        Just("slideshow not found")
    }
    /// We receive on the main queue, as we're assinging on a UILabel which requires the mainthread.
    .receive(on: DispatchQueue.main)
    .sink { (title) in
        slideshowTitleLabel.text = title
    }
//: [Next](@next)
