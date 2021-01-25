import CombineShim
import JavaScriptKit
import TokamakCore
import TokamakDOM

struct MainMenu: View, Hashable {
    let label: String
    let href: String
    let selected: Bool
    let logo: Bool

    init(_ label: String,
         href: String,
         selected: Bool = false,
         logo: Bool = false)
    {
        self.href = href
        self.label = label
        self.selected = selected
        self.logo = logo
    }

    var body: some View {
        var style = ""
        if selected {
            style = "background-color: var(--header-hover-back-color)"
        }

        return AnyView(DynamicHTML(
            "a",
            ["class": "col-md button \(logo ? "logo" : "")", "href": href, "style": style], content: label
        ))
    }
}
