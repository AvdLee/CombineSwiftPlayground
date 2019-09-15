import Foundation
import UIKit
import Combine
/*:
 [Previous](@previous)
 ## @Published properties
 A [Property Wrapper](https://www.avanderlee.com/swift/property-wrappers/) that adds a `Publisher` to any property.

 _Note: Xcode Playgrounds don't support running this Playground page with the @Published property unfortunately._
 */
final class FormViewModel {
    @Published var isSubmitAllowed: Bool = true
}

final class FormViewController: UIViewController {

    var viewModel = FormViewModel()
    let submitButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.$isSubmitAllowed
            .receive(on: DispatchQueue.main)
            .print()
            .assign(to: \.isEnabled, on: submitButton)
    }
}

let formViewController = FormViewController(nibName: nil, bundle: nil)
print("Button enabled is \(formViewController.submitButton.isEnabled)")
formViewController.viewModel.isSubmitAllowed = false
print("Button enabled is \(formViewController.submitButton.isEnabled)")

//: [Next](@next)
