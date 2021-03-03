import CombineShim
import JavaScriptKit
import TokamakDOM
import TokamakStaticHTML
import TokamakBootstrap

struct ListTasks: View {
    @ObservedObject private var taskViewModel = TaskModel()
    @ObservedObject private var teamViewModel = TeamModel()    

    @State var text: String = ""
    @Binding var menuItems: [MenuItem]
    @State var choosenTeam: String = ""
    @State var choosenStatus: String = ""
    
    var teamName: String = ""
    
    func filter() -> [[String]]  {
        let items = taskViewModel.tasks.filter {
            (text.isEmpty ? true : $0.title.lowercased().contains(text)) &&
                (choosenTeam.isEmpty ? true : $0.project.lowercased() == choosenTeam) && 
                (choosenStatus.isEmpty ? true : $0.status.rawValue == Int(choosenStatus)) 
            
        }
        return items.map { self.tableRowFor(task: $0) }
    }
    
    func tableRowFor(task: Task) -> [String] {
       
        let teamName = teamViewModel.teams[task.team]?.name ?? "-"
         return [task.id, 
           task.title, 
           task.project, 
           "\(task.status)", 
           task.assignee, 
           teamName,            
           "<a href=\"?#AddTask?\(task.id)\">Edit <span class='icon-edit'></span></a>"
          ]
      }
    public var body: some View {
        
        let filtered = Binding<[[String]]>(
            get: {
                return self.filter()
            },
            set: { print($0) }
        )

        Container {
            
            Row {
                TextField("Search", text: $text,
                          onEditingChanged: { _ in
                          }).textFieldStyle(RoundedBorderTextFieldStyle())
                ComboBox(
                    selection: $choosenTeam, 
                    items: teamViewModel.teams.map { 
                        PickerItem(value: $0.value.id, content: $0.value.name)
                    }, placeholder: "Team"
                )
                ComboBox(
                    selection: $choosenStatus, items: taskViewModel.statuses, placeholder: "Task status"
                )
            }  

            
            Table(
                items: filtered,
                columns: [
                    "ID", "Title", "Project", "Status",  "Assignee", "Team", "Actions"
                ]
            )
            Small("Count: \(String(taskViewModel.tasks.count))").clipped()            

            .onAppear {
                menuItems = [MenuItem(label: "Add Task", url: "AddTask"),
                ]
            }
        }
    }
}
