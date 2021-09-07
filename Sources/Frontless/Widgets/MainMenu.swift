import JavaScriptKit
import TokamakCore
import TokamakDOM

public struct SubMenu: View, Hashable {

  public init(label: String, href: String) {
    self.label = label
    self.href = href
  }

  var label: String
  var href: String

  public var body: some View {
    return AnyView(
      DynamicHTML(
        "a", ["class": "dropdown-item", "href": href], content: label)
    )
  }
}

public struct MainMenu: View {
  let label: String
  public let href: String
  let selected: Bool
  let logo: Bool
  let dropdown: Bool
  let submenus: [SubMenu]
  @State var showed: Bool

  public init(
    _ label: String,
    href: String,
    selected: Bool = false,
    logo: Bool = false,
    dropdown: Bool = false,
    submenus: [SubMenu] = []
  ) {
    self.href = href
    self.label = label
    self.selected = selected
    self.logo = logo
    self.dropdown = dropdown
    self.submenus = submenus
    _showed = .init(wrappedValue: false)
  }

  public var body: some View {
    if dropdown {
      return AnyView(
        DynamicHTML(
          "li", ["class": "nav-item dropdown"],
          listeners: [
            "mouseover": { _ in self.showed = true },
            "mouseout": { _ in self.showed = false },
            "click": { _ in self.showed = false },

          ]
        ) {
          HTML(
            "a",
            [
              "class": "nav-link dropdown-toggle \(self.showed ? "show": "")",
              "id": "navbarDropdown",
              "role": "button",
              "data-toggle": "dropdown",
              "aria-haspopup": "true",
              "aria-expanded": "false",
            ], content: label)

          DynamicHTML(
            "ul",
            [
              "class": "dropdown-menu \(self.showed ? "show": "")",
              "aria-labelledby": "navbarDropdown",
            ]
          ) {
            ForEach(self.submenus, id: \.self) { item in
              item
            }
          }
        })

    } else {
      return AnyView(
        DynamicHTML(
          "li", ["class": "nav-item"]
        ) {
          HTML(
            "a",
            [
              "href": href,
              "class": "nav-link \(self.selected ? "active" : "")",
            ],
            content: label)
        })
    }
  }
}
