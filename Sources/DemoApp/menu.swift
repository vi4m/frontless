import Frontless
import TokamakCore

extension ContentView {
    func getMenuItem(label: String, id: String, logo: Bool = false) -> MainMenu {
        let prefix = "?"
        let selected = (hashState.currentPage == "#\(id)") && !logo

        return MainMenu(label, href: "\(prefix)#\(id)", selected: selected, logo: logo)
    }

    public func getMenu() -> [MainMenu] {
        return [
            MainMenu("Tasks", href: "#", selected: false, logo: false, dropdown: true, submenus: [
                SubMenu(label: "List tasks", href: "#ListTasks"),
                SubMenu(label: "Add task", href: "#AddTask")
            ]),
            MainMenu("Teams", href: "#", selected: false, logo: false, dropdown: true, submenus: [
                SubMenu(label: "List teams", href: "#ListTeams"),
                SubMenu(label: "Add team", href: "#AddTeam")
            ]),
            MainMenu("Projects", href: "#", selected: false, logo: false, dropdown: true, submenus: [
                SubMenu(label: "List projects", href: "#ListProjects"),
                SubMenu(label: "Add project", href: "#AddProject")
            ])
        ]
    }

    func dispatchMenu(page: String) -> AnyView {
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
