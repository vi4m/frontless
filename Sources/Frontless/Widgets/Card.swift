import CombineShim
import Foundation
import TokamakDOM
import TokamakStaticHTML

public struct Card<Content: View>: View {
    let content: Content

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    public var body: some View {
        Div(class: "card") {
            Div(class: "card-body") {
                Container {        
                    content
                }
            }
        }
    }
}
