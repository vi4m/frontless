import CombineShim
import Foundation
import JavaScriptKit
import TokamakBootstrap
import TokamakCore
import TokamakDOM
import TokamakStaticHTML

struct AddTask: View {
    @State var title: String = ""
    @State var whyNow: String = ""
    @State var priority: String = "0"
    @State var description: String = ""
    @State var how: String = ""
    @State var assignee: String = ""
    @State var team: String = ""

    @State var project: String = ""
    @State var taskType: String = "1"
    @State var selection: String = ""
    @State var cancellable: AnyCancellable? = nil

    @State var editId: String? = nil

    @ObservedObject public var taskModel = TaskModel()
    @ObservedObject public var teamModel = TeamModel()
    @ObservedObject public var validationState = ValidationState()

    init(id: String? = nil) {
        if let id = id {
            taskModel.getBy(id: id)
        }
    }

    var body: some View {
        return Card {
            Form(title: "Add task") {
                Container {
                    FormField(label: "Title",
                              helpText: """
                              What's to do?
                              """, validation: Validations.required, state: validationState, text: $title) {
                        TextEditor(value: $title)
                    }

                    FormField(label: "❓Description",
                              helpText: """
                              """, validation: Validations.none, state: validationState, text: $description) { TextEditor(value: $description) }

                    FormField(label: "Team", validation: Validations.required, state: validationState, text: $team) {
                        ComboBox(selection: $team, items: teamModel.teams.map {
                            PickerItem(content: $0.value.name, value: $0.value.id)
                        })
                    }
                    FormField(label: "Piority", validation: Validations.required, state: validationState, text: $priority) {
                        ComboBox(selection: $priority, items: TaskPriority.allCases.map { prio in
                            PickerItem(content: String(describing: prio), value: String(prio.rawValue))
                        })
                    }
                    ShowIf({ priority == "2" }) {
                        FormField(label: "⌛Why so critical?",
                                  helpText: """
                                  Provide explanation why it has to be done before everything else.
                                  """, validation: Validations.none, state: validationState, text: $whyNow) { TextEditor(value: $whyNow) }
                    }

                    FormField(label: "Type", validation: Validations.required, state: validationState, text: $taskType) {
                        ComboBox(selection: $taskType, items: TaskType.allCases.map { taskType in
                            PickerItem(content: String(describing: taskType), value: String(taskType.rawValue))
                        })
                    }

                    FormField(label: "Assignee", validation: Validations.required, state: validationState, text: $assignee) {
                        TextField("Username", text: $assignee)
                    }
                }
                Row {
                    Col {
                        Button("Cancel") {
                            navigate(to: "ListTasks")
                        }
                    }
                    Col {
                        Button("OK") {
                            validationState.showHints = true
                            if validationState.ok {
                                taskModel.addTask(task: Task(
                                    title: title,
                                    why: description,
                                    id: self.editId ?? window.uuid!().string!,
                                    need: whyNow,
                                    project: project, team: team, type: TaskType(rawValue: Int(taskType)!)!,
                                    assignee: assignee, priority: TaskPriority(rawValue: Int(priority)!)!, description: description
                                )
                                )
                                navigate(to: "ListTasks")
                            }
                        }
                    }
                }
            }
            HTML("div", ["class": "no-flex"]) {}
        }._onMount {
            self.cancellable = taskModel.$task.sink { [self] task in
                guard let task = task else {
                    return
                }
                self.title = task.title
                self.description = task.description
                self.project = task.project
                self.taskType = String(task.type.rawValue)
                self.priority = String(task.priority.rawValue)
                self.assignee = task.assignee
                self.whyNow = task.why
                self.editId = task.id
                self.team = task.team
            }
        }
    }
}
