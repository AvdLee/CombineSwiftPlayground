import Foundation
import Combine
import UIKit
/*:
 [Previous](@previous)
 ## Memory Management
 Correct memory management using `Cancellable` makes sure you're not retaining any references.
 */
final class HomeViewController: UIViewController {

    private let tableView = UITableView()
    private let timeLabel = UILabel()

    private var foregroundSubscriber: AnyCancellable?

    private let dateFormatter : DateFormatter = DateFormatter()

    deinit {
        print("HomeViewController deinit called")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        foregroundSubscriber = NotificationCenter.default
			.publisher(for: .NSExtensionHostWillEnterForeground)
			.print("foregroundSubscriber")
            .sink { [unowned self] _ in
                print("Reloading tableview!")
                self.tableView.reloadData()
            }
    }
}

var homeViewController: HomeViewController? = HomeViewController(nibName: nil, bundle: nil)
homeViewController!.viewDidLoad()
NotificationCenter.default.post(name: .NSExtensionHostWillEnterForeground, object: nil)
homeViewController = nil

// This notification will no longer trigger a reload data as the subscriber has been cancelled automatically.
NotificationCenter.default.post(name: .NSExtensionHostWillEnterForeground, object: nil)
//: [Next](@next)
