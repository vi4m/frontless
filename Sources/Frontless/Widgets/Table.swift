import CombineShim
import Foundation
import TokamakDOM
import TokamakStaticHTML

public struct Table: View {
  @Binding var items: [[String]]
  @State var columns: [String]

  public init(items: Binding<[[String]]>, columns: [String]) {
    _items = items
    _columns = .init(wrappedValue: columns)
  }

  public var body: some View {
    HTML("table", ["class": "table table-striped table-bordered"]) {
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
