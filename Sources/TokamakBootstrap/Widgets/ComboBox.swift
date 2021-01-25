import JavaScriptKit
import class OpenCombine.PassthroughSubject
import struct OpenCombine.Published
import TokamakDOM

struct ComboBox: View {
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
        AnyView(HTML("label") {
            Text(" ")
            DynamicHTML("select", ["class": "_tokamak-formcontrol"], listeners: ["change": {
                let valueString = $0.target.object!.value.string
                selection.wrappedValue = valueString!
            }]) {
                ForEach(0 ..< items.count) { index in
                    let item = items[index]
                    if item.value == selection.wrappedValue {
                        HTML("option", ["value": items[index].value, "selected": "true"], content: items[index].content)    
                    } else {
                        HTML("option", ["value": items[index].value, ], content: items[index].content)
                    }
                }
            }
        })
    }
}
