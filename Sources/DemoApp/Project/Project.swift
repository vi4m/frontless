import JavaScriptKit
import TokamakBootstrap

struct Project: Codable, ConvertibleToJSValue, Hashable {
    public var id: String
    public var name: String = ""

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

    func jsValue() -> JSValue {
        return [
            "name": name,
        ].jsValue()
    }
}
