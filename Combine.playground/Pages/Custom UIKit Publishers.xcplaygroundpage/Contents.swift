import Foundation
import UIKit
import Combine
/*:
 [Previous](@previous)
 ## Custom UIKit Publishers
 Unfortunately, not all UIKit elements are ready to use with Combine. A UISwitch, for example, does not support KVO. Therefore, custom UIKit publishers.
 */

final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control

    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    func request(_ demand: Subscribers.Demand) {
        guard demand > 0 else { return }
        _ = subscriber?.receive(control)
    }

    func cancel() {
        subscriber = nil
    }

    @objc private func eventHandler() {
        _ = subscriber?.receive(control)
    }

    deinit {
        print("UIControlTarget deinit")
    }
}

struct UIControlPublisher<Control: UIControl>: Publisher {

    typealias Output = Control
    typealias Failure = Never

    let control: Control
    let controlEvents: UIControl.Event

    init(control: Control, events: UIControl.Event) {
        self.control = control
        self.controlEvents = events
    }

    /// This function is called to attach the specified `Subscriber` to this `Publisher` by `subscribe(_:)`
    ///
    /// - SeeAlso: `subscribe(_:)`
    /// - Parameters:
    ///     - subscriber: The subscriber to attach to this `Publisher`.
    ///                   once attached it can begin to receive values.
    func receive<S>(subscriber: S) where S : Subscriber, S.Failure == UIControlPublisher.Failure, S.Input == UIControlPublisher.Output {
        subscriber.receive(subscription: UIControlSubscription(subscriber: subscriber, control: control, event: controlEvents))
    }
}
protocol CombineCompatible { }
extension UIControl: CombineCompatible { }
extension CombineCompatible where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControlPublisher<Self> {
        return UIControlPublisher(control: self, events: events)
    }
}

extension CombineCompatible where Self: UISwitch {
    var isOnPublisher: AnyPublisher<Bool, Never> {
        return publisher(for: [.allEditingEvents, .valueChanged]).map { $0.isOn }.eraseToAnyPublisher()
    }
}

let buttonSwitch = UISwitch()
let submitButton = UIButton()
submitButton.isEnabled = false
buttonSwitch.isOn = false

buttonSwitch.isOnPublisher.assign(to: \.isEnabled, on: submitButton)

buttonSwitch.isOn = true
buttonSwitch.sendActions(for: .valueChanged)
print(submitButton.isEnabled)

//: [Next](@next)
