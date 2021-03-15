import CombineShim
import JavaScriptKit
import TokamakCore
import TokamakDOM

public class Input: Dom, View {
    let label: String
    let placeholder: String
    @Binding var text: String

    public init(_ label: String,
                text: Binding<String>,
                placeholder: String = "")
    {
        self.label = label
        self._text = text
        self.placeholder = placeholder
    }

    public var body: some View {
        let listeners: [String: Listener] = [
            "input": { event in
                if let newValue = event.target.object?.value.string {
                    self.text = newValue
                }
            }
        ]

        return AnyView(DynamicHTML(
            "input",
            [
                "type": "search", "placeholder": placeholder, "class": "form-control", "style": self.getStyleText()
            ],
            listeners: listeners, content: label
        )
        )
    }
}

public extension Input {
    func style(_ style: Style) -> some View {
        return MyModifiedContent(content: self, style: style)
    }
}
