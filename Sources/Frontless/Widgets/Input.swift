import JavaScriptKit
import TokamakCore
import TokamakDOM
import TokamakStaticHTML

public class Input: Dom, View {
  let label: String
  let placeholder: String
  @Binding var text: String

  public init(
    _ label: String,
    text: Binding<String>,
    placeholder: String = ""
  ) {
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

    return AnyView(
      DynamicHTML(
        "input",
        [
          HTMLAttribute("value", isUpdatedAsProperty: true): self.text,
          HTMLAttribute("type", isUpdatedAsProperty: true): "text",
          HTMLAttribute("placeholder", isUpdatedAsProperty: true): placeholder,
          HTMLAttribute("class", isUpdatedAsProperty: true): "form-control",
          HTMLAttribute("style", isUpdatedAsProperty: true): self.getStyleText(),
        ],
        listeners: listeners, content: label
      )
    )
  }
}

extension Input {
  public func style(_ style: Style) -> some View {
    return MyModifiedContent(content: self, style: style)
  }
}
