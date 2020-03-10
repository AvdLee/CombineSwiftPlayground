//: [Previous](@previous)

import Foundation
import UIKit
import Combine

/*:
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
		
		// subscribe to a @Published property using the $ wrapped accessor
        viewModel.$isSubmitAllowed
            .receive(on: DispatchQueue.main)
            .print()
            .assign(to: \.isEnabled, on: submitButton)
    }
}

print("* Demonstrating @Published")

let formViewController = FormViewController(nibName: nil, bundle: nil)
print("Button enabled is \(formViewController.submitButton.isEnabled)")
formViewController.viewModel.isSubmitAllowed = false
print("Button enabled is \(formViewController.submitButton.isEnabled)")

/*:
## ObservableObject
- a class inheriting from `ObservableObject` automagically synthesizes an observable
- ... which fires whenever any of the `@Published` properties of the class change

*/
print("\n* Demonstrating ObservableObject")

class ObservableFormViewModel: ObservableObject {
	@Published var isSubmitAllowed: Bool = true
	@Published var username: String = ""
	@Published var password: String = ""
	var somethingElse: Int = 10
}

var form = ObservableFormViewModel()

let formSubscription = form.objectWillChange.sink { _ in
	print("Form changed: \(form.isSubmitAllowed) \"\(form.username)\" \"\(form.password)\"")
}

form.isSubmitAllowed = false
form.username = "Florent"
form.password = "12345"
form.somethingElse = 0	// note that this doesn't output anything

//: [Next](@next)
