import CombineShim
import JavaScriptKit
import TokamakBootstrap
import TokamakDOM
import TokamakStaticHTML

struct ListProjects: View {
    @ObservedObject private var projectModel = ProjectViewModel()

    @State var text: String = ""
    @Binding var menuItems: [MenuItem]
    @State var choosenTeam: String = ""
    @State var choosenStatus: String = ""

    var teamName: String = ""

    func filter() -> [[String]] {
        let items = projectModel.projects.filter {
            (text.isEmpty ? true : $0.name.lowercased().contains(text))
        }
        return items.map { self.tableRowFor(project: $0) }
    }

    func tableRowFor(project: Project) -> [String] {
        return [
                project.name,
                "<a href=\"?#AddProject?\(project.id)\">Edit <span class='icon-edit'></span></a>"]
    }

    public var body: some View {
        let filtered = Binding<[[String]]>(
            get: {
                self.filter()
            },
            set: { print($0) }
        )

        Container {
            Row {
                TextField("Search", text: $text,
                          onEditingChanged: { _ in
                          }).textFieldStyle(RoundedBorderTextFieldStyle())
            }

            Table(
                items: filtered,
                columns: [
                    "Name"
                ]
            )
            Small("Count: \(String(projectModel.projects.count))").clipped()

                .onAppear {
                    menuItems = [MenuItem(label: "Add Project", url: "AddProject")]
                }
        }
    }
}
