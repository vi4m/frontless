import XCTest
@testable import Frontless
import TokamakDOM
import TokamakStaticHTML


final class ComboBoxTests: XCTestCase {
    func testComboBox() {
        struct testComboBoxView: View {
            @State var selection: String = "raz"             
            var body: some View {
                ComboBox(selection: $selection, items: [(value: "raz", content: "raz")])
            }
        }
        let dom = StaticHTMLRenderer(testComboBoxView())
        AssertEnds(body: dom.html, with: """
<label><span style="" id="" class=""> </span><select class="_tokamak-formcontrol"><option value="">---</option><option value="raz" selected="true">raz</option></select></label>
""")
    }
}
