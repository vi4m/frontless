import XCTest
@testable import TokamakBootstrap
import TokamakDOM
import TokamakStaticHTML


final class ButtonTests: XCTestCase {
    func testButton() {
        struct testButtonView: View {
            @State var clicked: Bool = false
            var body: some View {
                TokamakBootstrap.Button("test") {
                   clicked = true 
                }
            }
        }
        let dom = StaticHTMLRenderer(testButtonView())
        AssertEnds(body: dom.html, with: "<a style=\"\" class=\"button\">test</a>")
    }
}
