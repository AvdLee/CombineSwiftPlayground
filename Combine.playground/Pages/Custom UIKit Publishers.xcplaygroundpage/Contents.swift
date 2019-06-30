import Foundation
import UIKit
import Combine
/*:
 [Previous](@previous)
 ## Custom UIKit Publishers
 Unfortunately, not all UIKit elements are ready to use with Combine. A UISwitch, for example, does not support KVO. Therefore, custom UIKit publishers.
 */
/// A custom subscription to capture UIControl target events.
final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
    private var subscriber: SubscriberType?
    private let control: Control

    init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
        self.subscriber = subscriber
        self.control = control
        control.addTarget(self, action: #selector(eventHandler), for: event)
    }

    func request(_ demand: Subscribers.Demand) {
        // We do nothing here as we only want to send events when they occur.
        // See, for more info: https://developer.apple.com/documentation/combine/subscribers/demand
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

/// A custom `Publisher` to work with our custom `UIControlSubscription`.
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

/// Extending the `UIControl` types to be able to produce a `UIControl.Event` publisher.
protocol CombineCompatible { }
extension UIControl: CombineCompatible { }
extension CombineCompatible where Self: UIControl {
    func publisher(for events: UIControl.Event) -> UIControlPublisher<Self> {
        return UIControlPublisher(control: self, events: events)
    }
}

/*:
 ## Responding to UITouch events
 #### With the above, we can easily create a publisher to listen for `UIButton` events as an example.
 */
/// With the above, we can easily create a publisher to listen for `UIButton` events as an example.
let button = UIButton()
let subscription = button.publisher(for: .touchUpInside).sink { button in
    print("Button is pressed!")
}
button.sendActions(for: .touchUpInside)
subscription.cancel()

/*:
 ## Solving the UISwitch KVO problem
 #### As the `UISwitch.isOn` property does not support KVO this extension can become handy.
 */
extension CombineCompatible where Self: UISwitch {
    /// As the `UISwitch.isOn` property does not support KVO this publisher can become handy.
    /// The only downside is that it does not work with programmatically changing `isOn`, but it only responds to UI changes.
    var isOnPublisher: AnyPublisher<Bool, Never> {
        return publisher(for: [.allEditingEvents, .valueChanged]).map { $0.isOn }.eraseToAnyPublisher()
    }
}

let switcher = UISwitch()
switcher.isOn = false
let submitButton = UIButton()
submitButton.isEnabled = false

switcher.isOnPublisher.assign(to: \.isEnabled, on: submitButton)

/// As the `isOn` property is not sending out `valueChanged` events itself, we need to do this manually here.
/// This is the same behavior as it would be if the user switches the `UISwitch` in-app.
switcher.isOn = true
switcher.sendActions(for: .valueChanged)
print(submitButton.isEnabled)
//: [Next](@next)
