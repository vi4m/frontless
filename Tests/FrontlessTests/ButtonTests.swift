import XCTest
@testable import Frontless
import TokamakDOM
import TokamakStaticHTML


final class ButtonTests: XCTestCase {
    func testButton() {
        struct testButtonView: View {
            @State var clicked: Bool = false
            var body: some View {
                Frontless.Button("test") {
                   clicked = true 
                }
            }
        }
        let dom = StaticHTMLRenderer(testButtonView())
        AssertEnds(body: dom.html, with: "<a style=\"\" class=\"button\">test</a>")
    }
}
