import CombineShim
import Foundation
import TokamakDOM
import TokamakStaticHTML

struct Col<Content: View>: View {
    let width: Int
    let content: Content

    init(width: Int = 1,
         @ViewBuilder content: () -> Content)
    {
        self.content = content()
        self.width = width
    }

    var body: some View {
        HTML("div", ["class": "col-sm-\(width) col-md-\(width)"]) {
            content
        }
    }
}

struct Row<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        HTML("div", ["class": "row"]) {
            content
        }
    }
}
