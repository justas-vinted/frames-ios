import Foundation

class AddressLine1Validator: Validator {
    func validate(value: Any?) -> Bool {
        !isEmpty(text: value as? String)
    }

    private func isEmpty(text: String?) -> Bool {
        text?.isEmpty ?? false
    }

}
