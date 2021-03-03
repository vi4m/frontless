import JavaScriptKit
import TokamakBootstrap

struct Team: Codable, ConvertibleToJSValue, Hashable {
    var name: String
    var id: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    func jsValue() -> JSValue {
        return [
            "name": name
        ].jsValue()
    }
}
