import TokamakBootstrap
import TokamakCore

extension ContentView {
    public func getMenu() -> [MainMenu] {
        return [
            getMenuItem(label: " ⛢ uJira", id: "ListTasks", logo: true),
            getMenuItem(label: "Tasks", id: "ListTasks"),
            getMenuItem(label: "Teams", id: "ListTeams"),
            getMenuItem(label: "Projects", id: "ListProjects"),            
        ]
    }

    func dispatchMenu(page: String) -> AnyView {
        print(hashState.currentArguments)
        switch page {
        case "#ListTasks": return AnyView(ListTasks(menuItems: $menuItems))
        case "#AddTask": return AnyView(AddTask(id: hashState.currentArguments.first))

        case "#ListTeams": return AnyView(ListTeams(menuItems: $menuItems))
        case "#AddTeam": return AnyView(AddTeam(id: hashState.currentArguments.first))

        case "#ListProjects": return AnyView(ListProjects(menuItems: $menuItems))
        case "#AddProject": return AnyView(AddProject(id: hashState.currentArguments.first))            
            
        default: return AnyView(ListTasks(menuItems: $menuItems))
        }
    }
}
