import CombineShim
import Foundation
import TokamakCore
import TokamakStaticHTML

internal struct Div<Content: View>: View {
    let id: String
    let `class`: String
    let style: String
    let content: Content

    init(
        id: String = "", class: String = "",
        style: String = "",
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.id = id
        self.style = style
        self.class = `class`
    }

    var body: some View {
        HTML("div", ["id": id, "class": `class`, "style": style]) {
            content
        }
    }
}
