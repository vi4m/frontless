import TokamakBootstrap
import TokamakCore

extension ContentView {
    public func getMenu() -> [MainMenu] {
        return [
            getMenuItem(label: " ⛢ uJira", id: "ListTasks", logo: true),
            getMenuItem(label: "Tasks", id: "ListTasks"),
            getMenuItem(label: "Teams", id: "ListTeams"),
        ]
    }

    func dispatchMenu(page: String) -> AnyView {
        print(hashState.currentArguments)
        switch page {
        case "#ListTasks": return AnyView(ListTasks(menuItems: $menuItems))
        case "#AddTask": return AnyView(AddTask(id: hashState.currentArguments.first))

        case "#ListTeams": return AnyView(ListTeams(menuItems: $menuItems))
        case "#AddTeam": return AnyView(AddTeam(id: hashState.currentArguments.first))

        default: return AnyView(ListTasks(menuItems: $menuItems))
        }
    }
}
