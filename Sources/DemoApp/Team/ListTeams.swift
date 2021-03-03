import CombineShim
import JavaScriptKit
import TokamakBootstrap
import TokamakDOM
import TokamakStaticHTML

struct ListTeams: View {
    @ObservedObject private var teamViewModel = TeamModel()

    @State var text: String = ""
    @Binding var menuItems: [MenuItem]

    func filter() -> [[String]] {
        let items = teamViewModel.teams.filter {
            (text.isEmpty ? true : $0.value.name.lowercased().contains(text))
        }
        print(items)
        return items.map { self.tableRowFor(team: $0.value) }
    }

    func tableRowFor(team: Team) -> [String] {
        [team.id,
         team.name,
         "<a href=\"?#AddTeam?\(team.id)\">Edit <span class='icon-edit'></span></a>"]
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
                    "ID", "Name", "Actions",
                ]
            )
            Small("Count: \(String(teamViewModel.teams.count))").clipped()

                .onAppear {
                    menuItems = [MenuItem(label: "Add Team", url: "AddTeam")]
                }
        }
    }
}
