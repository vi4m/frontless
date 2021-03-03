import CombineShim
import JavaScriptKit
import TokamakCore
import TokamakStaticHTML
import TokamakDOM
import TokamakBootstrap
import Foundation


struct AddTeam: View {
    
    @State var name: String = ""
    @State var cancellable: AnyCancellable? = nil
    
    @State var editId: String? 
    
    @ObservedObject public var dataViewModel = TeamModel()
    @ObservedObject public var validationState = ValidationState()
    
    init(id: String? = nil) {
        if let id = id {
            logger.debug("ID: \(id)")
            self.editId = id
            dataViewModel.getBy(id: id)
        }
    }
    
    var body: some View {
       
        return Div {
            Form(title: "Add team") {
                Container {
                    FormField(label: "Name",
                              helpText: """
                              Team's name
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
                                dataViewModel.addTeam(team: Team(
                                                        name: name, id: self.editId ?? String(UUID().hashValue))
                                )
                                navigate(to: "ListTeams")
                            }
                        }
                    }
                }
            }
            HTML("div", ["class": "no-flex"]) {}
        }._onMount {
            self.cancellable = dataViewModel.$team.sink { [ self] (team) in
                guard let team = team else {
                    return
                }
                self.name = team.name
                self.editId = team.id
            }
        }
    }
}
