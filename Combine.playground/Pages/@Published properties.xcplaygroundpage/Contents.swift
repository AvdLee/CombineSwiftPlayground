import Foundation
import UIKit
import Combine
/*:
 [Previous](@previous)
 ## @Published properties
 A [Property Wrapper](https://www.avanderlee.com/swift/property-wrappers/) that adds a `Publisher` to any property.

 _Note: Xcode beta 2 does not support running this Playground page with the @Published property unfortunately._
 */
struct FormViewModel {
    @Published var isSubmitAllowed: Bool = false
}

final class FormViewController: UIViewController {

    var viewModel = FormViewModel()
    let submitButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.$isSubmitAllowed.receive(on: DispatchQueue.main).assign(to: \.isEnabled, on: submitButton)
    }
}

let formViewController = FormViewController(nibName: nil, bundle: nil)
print("Button enabled is \(formViewController.submitButton.isEnabled)")
formViewController.viewModel.isSubmitAllowed = true
print("Button enabled is \(formViewController.submitButton.isEnabled)")
//: [Next](@next)
