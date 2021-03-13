import CombineShim
import Foundation
import JavaScriptKit
import TokamakBootstrap
import TokamakCore
import TokamakDOM
import TokamakStaticHTML

struct AddProject: View {
    @State var name: String = ""
    @State var cancellable: AnyCancellable? = nil

    @State var editId: String? = nil

    @ObservedObject public var projectModel = ProjectViewModel()
    @ObservedObject public var validationState = ValidationState()

    init(id: String? = nil) {
        if let id = id {
            projectModel.getBy(id: id)
        }
    }

    var body: some View {
        return Div {
            Form(title: "Add project") {
                Container {
                    FormField(label: "Name",
                              helpText: """
                              What's the project name?
                              """, validation: Validations.required, state: validationState, text: $name) {
                        TextEditor(value: $name)
                    }
                }
                Row {
                    Col {
                        Button("Cancel") {
                            navigate(to: "ListTeams")
                        }
                    }
                    Col {
                        Button("OK") {
                            validationState.showHints = true
                            if validationState.ok {
                                projectModel.addProject(project: Project(
                                    id: self.editId ?? window.uuid!().string!,
                                    name: name
                                )
                                )
                                navigate(to: "ListProjects")
                            }
                        }
                    }
                }
            }
            HTML("div", ["class": "no-flex"]) {}
        }._onMount {
            self.cancellable = projectModel.$project.sink { [self] project in
                guard let project = project else {
                    return
                }
                self.name = project.name
            }
        }
    }
}
