import XCTest
@testable import TokamakBootstrap
import TokamakDOM
import TokamakStaticHTML


final class ColumnTests: XCTestCase {
    func testColumn() {
        struct testColumnView: View {
            var body: some View {
                Col {
                    
                }
            }
        }
        let dom = StaticHTMLRenderer(testColumnView())
        AssertEnds(body: dom.html, with: "<div class=\"col-sm-1 col-md-1\"></div>")
    }
}
