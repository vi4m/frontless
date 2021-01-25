import CombineShim
import Foundation
import TokamakDOM
import TokamakStaticHTML

struct Table: View {
    @Binding var items: [[String]]
    @State var columns: [String]

    var body: some View {
        HTML("div", ["class": "s"]) {
            HTML("table", ["class": "table table-striped"]) {
                HTML("thead") {
                    HTML("tr") {
                        ForEach(columns, id: \.self) { column in
                            HTML("th", [:], content: column)
                        }
                    }
                }
                HTML("tbody") {
                    ForEach(items, id: \.self) { item in
                        HTML("tr") {
                            ForEach(item, id: \.self) { cell in
                                HTML("td", [:], content: cell)
                            }
                        }
                    }
                }
            }
        }
    }
}
