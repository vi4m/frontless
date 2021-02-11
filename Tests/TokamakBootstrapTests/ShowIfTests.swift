import XCTest
@testable import TokamakBootstrap
import TokamakDOM
import TokamakStaticHTML



final class ShowIfTests: XCTestCase {
    
    func testHideDiv() {
        struct myView : View {
            
            @State var show: Bool = false
            var body: some View {
                ShowIf({ show }) {
                    Small("Hello world!")
                }                    
            }
        }
       
        let view = myView()
        let hideDom = StaticHTMLRenderer(view)
        AssertEnds(body: hideDom.html, with: """
        <div style="display: none"><small style="" id="" class="">Hello world!</small></div>
        """)
        let viewShow = myView(show: true)
        let showDom = StaticHTMLRenderer(viewShow)        
        AssertEnds(body: showDom.html, with: """
        <div style="display: block"><small style="" id="" class="">Hello world!</small></div>
        """)
        
    }
}
