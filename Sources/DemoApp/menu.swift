import TokamakCore
import TokamakBootstrap

extension ContentView {
    public func getMenu() -> [MainMenu] {
        return [
            getMenuItem(label: " ⛢ Tasks", id: "ListNotes", logo: true),
            getMenuItem(label: "List", id: "ListNotes"),
            getMenuItem(label: "Add", id: "AddTask")
        ]
    }

    func dispatchMenu(page: String) -> AnyView {
        switch page {
        case "#ListTasks": return AnyView(ListTasks(menuItems: $menuItems))
        case "#AddTask": return AnyView(AddTask())
//        case "#Review": return AnyView(Review(id: hashState.currentArguments.first ?? ""))
            
        default: return AnyView(ListTasks(menuItems: $menuItems))
        }
    }
}
