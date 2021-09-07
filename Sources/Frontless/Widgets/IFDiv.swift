import Foundation
import TokamakCore
import TokamakStaticHTML

public struct Div<Content: View>: View {
  let id: String
  let `class`: String
  let style: String
  let content: Content

  public init(
    id: String = "", class: String = "",
    style: String = "",
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.id = id
    self.style = style
    self.class = `class`
  }

  public var body: some View {
    HTML("div", ["id": id, "class": `class`, "style": style]) {
      content
    }
  }
}
