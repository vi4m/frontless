import JavaScriptKit
import TokamakDOM

import class OpenCombine.PassthroughSubject
import struct OpenCombine.Published

public typealias PickerItem = (value: String, content: String)

public struct ComboBox: View {
  var selection: Binding<String>
  var items: [PickerItem]
  var placeholder: String

  public init(selection: Binding<String>, items: [PickerItem], placeholder: String = "---") {
    self.selection = selection
    self.items = items
    self.items.insert(PickerItem("", placeholder), at: 0)
    self.placeholder = placeholder
  }

  public var body: some View {
    DynamicHTML(
      "select", ["class": "form-select"],
      listeners: [
        "change": {
          let valueString = $0.target.object!.value.string
          selection.wrappedValue = valueString!
        }
      ]
    ) {
      ForEach(0..<items.count) { index in
        let item = items[index]
        if item.value == selection.wrappedValue {
          HTML(
            "option", ["value": items[index].value, "selected": "true"],
            content: items[index].content)
        } else {
          HTML("option", ["value": items[index].value], content: items[index].content)
        }
      }
    }
  }
}
