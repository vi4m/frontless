import CombineShim
import JavaScriptKit
import TokamakDOM
import TokamakStaticHTML
import TokamakBootstrap

struct ListTasks: View {
    @ObservedObject private var dataViewModel = TaskModel()

    @State var text: String = ""
    @Binding var menuItems: [MenuItem]
    @State var choosenProject: String = ""
    @State var choosenStatus: String = ""
    
    func filter() -> [[String]]  {
        let items = dataViewModel.tasks.filter {
            (text.isEmpty ? true : $0.title.lowercased().contains(text)) &&
                (choosenProject.isEmpty ? true : $0.project.lowercased() == choosenProject) && 
                (choosenStatus.isEmpty ? true : $0.status.rawValue == Int(choosenStatus)) 
            
        }
        return items.map { self.tableRowFor(task: $0) }
    }
    
    func tableRowFor(task: Task) -> [String] {
          [task.id, 
           task.title, 
           task.project, 
           "\(task.status)", 
           task.assignee, 
           "<a href=\"?#AddTask?id=\(task.id)\">Edit <span class='icon-edit'></span></a>"
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
                              print("Changed!")
                          }).textFieldStyle(RoundedBorderTextFieldStyle())
                ComboBox(
                    selection: $choosenProject, items: dataViewModel.teams, placeholder: "Project"
                )
                ComboBox(
                    selection: $choosenStatus, items: dataViewModel.statuses, placeholder: "Status"
                )
            }  

            
            Table(
                items: filtered,
                columns: [
                    "ID", "Title", "Project", "Status",  "Assignee", "Actions", "Actions"
                ]
            )
            Small("Count: \(String(dataViewModel.tasks.count))").clipped()            

            .onAppear {
                menuItems = [MenuItem(label: "Q12021", url: ""),
                MenuItem(label: "Moje zespoły", url: ""),
                MenuItem(label: "Dodaj OKR", url: ""),
                MenuItem(label: "Dodaj OKR", url: "")]
                
            }
        }
    }
}
