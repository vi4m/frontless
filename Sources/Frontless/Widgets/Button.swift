import CombineShim
import JavaScriptKit
import TokamakCore
import TokamakDOM

public enum ButtonType: String {
  case primary = "primary"
  case secondary = "secondary"
}

public class Button: Dom, View {
  let label: String

  @State var isPressed: Bool = false
  var action: () -> Void
  var type: ButtonType

  public init(
    _ label: String,
    type: ButtonType = .primary,
    action: @escaping () -> Void
  ) {
    self.action = action
    self.label = label
    self.type = type
  }

  public var body: some View {
    let listeners: [String: Listener] = [
      "pointerdown": { _ in self.isPressed = true },
      "pointerup": { [self] _ in
        self.isPressed = false
        action()
      },
    ]

    return AnyView(
      DynamicHTML(
        "a",
        [
          "class": "btn btn-\(type.rawValue) \(self.getClassesText())",
          "style": self.getStyleText(),
        ],
        listeners: listeners, content: label
      )
    )
  }
}

extension Button {
  public func style(_ style: Style) -> some View {
    return MyModifiedContent(content: self, style: style)
  }

  public func klass(_ klasses: String...) -> some View {
    return MyModifiedContent(content: self, klasses: klasses)
  }
}
