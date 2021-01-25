import CombineShim
import Foundation
import TokamakCore
import TokamakDOM
import TokamakStaticHTML

internal struct ShowIf<Content: View>: View {
    let expression: () -> Bool
    let content: Content

    init(
        _ expression: @escaping () -> Bool,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.expression = expression
    }

    var body: some View {
        HTML("div", ["style": "display: \(self.expression() ? "block" : "none")"]) {
            content
        }
    }
}
