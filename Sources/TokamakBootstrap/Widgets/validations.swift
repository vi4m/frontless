import CombineShim
import JavaScriptKit
import TokamakDOM

public typealias ValidationFunc = (String) -> String?

public class Validations {
    public static func required(i: String) -> String? {
        if i.isEmpty {
            return "Is required"
        }
        return nil
    }

    public static func none(i _: String) -> String? {
        return nil
    }
}

public class ValidationState: ObservableObject {
    @Published public var showHints: Bool = false
    var validations: [String: Bool] = [:]

    public var ok: Bool {
        validations.allSatisfy { (_, value) -> Bool in
            value == true
        }
    }
    
    public init() {
        
    }
    
    public func validate(id: String, input: String, validationFun: (String) -> String?) -> String? {
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
