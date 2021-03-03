import Foundation
import TokamakDOM
import TokamakBootstrap


class ErrorsViewModel: ObservableObject {
    @Published var message: String = "error"
    @Published var show: Bool = false
}

struct Error: View {
    @Binding var error: String
    @Binding var show: Bool

    var body: some View {
        if show {
            HTML("div", ["class": "modal doc overlay"]) {
                HTML("div", ["class": "card  doc"]) {
                    HTML("label", ["class": "modal-close", "for": "modal-control"])
                    HTML("h3", ["class": "section"], content: "Modal")
                    HTML("p", ["class": "section"], content: "This is a modal dialog")

                    Text(error)
                    Button("OK") {
                        error = ""
                        show = false
                    }
                }
            }
        }
    }
}
