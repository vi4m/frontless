import CombineShim
import Foundation
import TokamakDOM
import TokamakStaticHTML

public struct Col<Content: View>: View {
    let width: Int
    let content: Content

    public init(width: Int = 1,
         @ViewBuilder content: () -> Content)
    {
        self.content = content()
        self.width = width
    }

    public var body: some View {
        HTML("div", ["class": "col-sm-\(width) col-md-\(width)"]) {
            content
        }
    }
}

public struct Row<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        HTML("div", ["class": "row"]) {
            content
        }
    }
}
