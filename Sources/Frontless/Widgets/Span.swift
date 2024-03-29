import Foundation
import TokamakDOM
import TokamakStaticHTML

public struct Span: View {
  let id: String
  let `class`: String
  var style: String
  let content: String

  public init(
    _ content: String, id: String = "", class: String = "",
    style: String = ""
  ) {
    self.content = content
    self.id = id
    self.style = style
    self.class = `class`
  }

  public var body: some View {
    HTML("span", ["id": id, "class": `class`, "style": style], content: content)
  }
}
