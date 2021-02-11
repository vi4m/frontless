import CombineShim
import Foundation
import TokamakDOM
import TokamakStaticHTML

struct Container<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        HTML("div.container", [:]) {
            content
        }
    }
}
