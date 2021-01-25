import JavaScriptKit
import TokamakCore
import TokamakDOM

struct MenuItem: Hashable {
    var label: String
    var url: String
}

struct Menu: View {
    @Binding var items: [MenuItem]

    var body: some View {
        HTML("nav", ["class": "col-md-4 col-lg-3", "style": "min-width: 220px"]) {
            ForEach(items, id: \.self, content: { e in
                HTML("a", ["href": "?#\(e.url)"], content: e.label)
            })
        }
    }
}
