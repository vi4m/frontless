
import Foundation
import TokamakCore
import TokamakDOM

public protocol FormFieldProtocol {}
extension FormField: FormFieldProtocol {}

public struct Form<Content: View>: View {
    let content: Content
    let title: String

    public init(
        title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }

    public var body: some View {
        HTML("div", ["class": "section"]) {
            HTML("form", [:]) {
                HTML("fieldset", ["class": "doc md-12"]) {
                    HTML("legend", ["class": "doc"], content: title)
                    content
                }
            }
        }
    }
}

extension Form: ParentView {
    public var children: [AnyView] {
        (content as? ParentView)?.children ?? [AnyView(content)]
    }
}

public struct FormField<Content: View>: View {
    var label: String
    @Binding var text: String
    var validation: ValidationFunc = Validations.none
    @ObservedObject var state: ValidationState
    var helpText: String?
    let content: Content

    public init(
        label: String,
        helpText: String? = nil,
        validation: @escaping ValidationFunc = Validations.none,
        state: ValidationState,
        text: Binding<String>,
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
        self.label = label
        _state = ObservedObject(wrappedValue: state)
        _text = text
        self.validation = validation
        self.helpText = helpText
    }

    public var body: some View {
        HTML("div", ["class": "row"]) {
            HTML("div", ["style": "text-align: right; white-space: normal; word-wrap: none; padding-bottom: 30px", "class": "col-sm-12 col-md-3"]) {
                HTML("div", [:], content: label)
                HTML("small", [:], content: helpText ?? "")
            }

            HTML("div", ["class": "col-sm-12 col-md", "style": "margin-bottom: 30px"]) {
                Container {
                    content

                    let result = state.validate(id: label, input: text, validationFun: validation)
                    if let validationError = result {
                        if state.showHints {
                            Text(validationError).foregroundColor(Color.red)
                        }
                    } else {}
                }
            }
        }
    }
}
