import JavaScriptKit
import TokamakCore
import TokamakDOM

public struct MenuItem: Hashable {
    var label: String
    var url: String

    public init(label: String, url: String) {
        self.label = label
        self.url = url
    }
}

public struct Menu: View {
    @Binding var items: [MenuItem]

    public init(items: Binding<[MenuItem]>) {
        _items = items
    }

    public var body: some View {
        HTML("nav", ["class": "col-md-4 col-lg-3", "style": "min-width: 220px"]) {
            ForEach(items, id: \.self, content: { e in
                HTML("a", ["href": "?#\(e.url)"], content: e.label)
            })
        }
    }
}
