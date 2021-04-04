import CombineShim
import Foundation
import TokamakCore
import TokamakDOM
import TokamakStaticHTML

public struct ShowIf<Content: View>: View {
  let expression: () -> Bool
  let content: Content

  public init(
    _ expression: @escaping () -> Bool,
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.expression = expression
  }

  public var body: some View {
    HTML("div", ["style": "display: \(self.expression() ? "block" : "none")"]) {
      content
    }
  }
}
