import JavaScriptKit
import TokamakDOM

import class OpenCombine.PassthroughSubject
import struct OpenCombine.Published

public struct TextEditor: View {
  var value: Binding<String>

  public init(value: Binding<String>) {
    self.value = value
  }

  public var body: some View {
    return AnyView(
      DynamicHTML(
        "textarea",
        [
          "style": "width: 100%"
        ],
        listeners: [
          "input": { event in
            if let newValue = event.target.object?.value.string {
              self.value.wrappedValue = newValue
            }
          }
        ], content: self.value.wrappedValue))
  }
}
