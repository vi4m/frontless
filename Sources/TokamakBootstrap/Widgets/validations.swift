import CombineShim
import JavaScriptKit
import TokamakDOM

typealias ValidationFunc = (String) -> String?

class Validations {
    static func required(i: String) -> String? {
        if i.isEmpty {
            return "Is required"
        }
        return nil
    }

    static func none(i _: String) -> String? {
        return nil
    }
}

class ValidationState: ObservableObject {
    @Published var showHints: Bool = false
    var validations: [String: Bool] = [:]

    var ok: Bool {
        validations.allSatisfy { (_, value) -> Bool in
            value == true
        }
    }

    func validate(id: String, input: String, validationFun: (String) -> String?) -> String? {
        if let result = validationFun(input) {
            validations[id] = false
            return result
        } else {
            validations[id] = true
        }
        return nil
    }

    deinit {
        print("DEINIT validationstate")
    }
}
