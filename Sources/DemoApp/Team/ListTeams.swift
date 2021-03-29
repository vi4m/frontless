import CombineShim
import JavaScriptKit
import Frontless
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
        [
            team.name,
            "<a href=\"?#AddTeam?\(team.id)\">Edit <span class='icon-edit'></span></a>",
        ]
    }

    public var body: some View {
        let filtered = Binding<[[String]]>(
            get: {
                self.filter()
            },
            set: { print($0) }
        )

        Card {
            Div(class: "input-group") {
                HTML("span", ["class": "input-group-text"], content: "Search")
                Input("", text: $text).style([.width: "100"])
            }

            Table(
                items: filtered,
                columns: [
                    "Name", "Actions"
                ]
            )
            Small("Count: \(String(teamViewModel.teams.count))").clipped()
        }
    }
}
