import CombineShim
import Foundation
import JavaScriptKit
import TokamakCore
import TokamakDOM
import TokamakStaticHTML

public struct NavBar<Content: View>: View {
  let content: Content
  let title: String
  let color: String

  public init(
    title: String,
    color: String = "#2f83c1",
    @ViewBuilder content: () -> Content
  ) {
    self.content = content()
    self.color = color
    self.title = title
  }

  public var body: some View {
    HTML(
      "navbar",
      ["class": "navbar navbar-expand-lg navbar-dark", "style": "background-color: \(color)"]
    ) {
      HTML("div", ["class": "container-fluid"]) {
        HTML("a", ["class": "navbar-brand", "href": "#"], content: title)
        HTML(
          "button",
          [
            "class": "navbar-toggler",
            "type": "button",
            "data-bs-toggle": "collapse",
            "data-bs-target": "#navbarText",
            "aria-controls": "navbarText",
            "aria-expanded": "false",
            "aria-label": "Toggle navigation",
          ]
        ) {
          HTML("span", ["class": "navbar-toggler-icon"], content: "")
        }
        HTML("div", ["class": "collapse navbar-collapse", "id": "navbarText"]) {
          HTML("ul", ["class": "navbar-nav me-auto mb-2 mb-lg-0"]) {
            content
          }
        }
      }
    }
  }
}
