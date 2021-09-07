import Foundation
import TokamakDOM
import TokamakStaticHTML

public struct Container<Content: View>: View {
  let content: Content

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    HTML("div", ["class": "container"]) {
      content
    }
  }
}
