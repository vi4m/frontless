import JavaScriptKit
import TokamakBootstrap

struct Task: Codable, ConvertibleToJSValue, Hashable {
    public var title: String = ""
    var why: String = ""
    var id: String
    var need: String = ""
    var project: String
    var team: String
    var type: TaskType = .bug
    var assignee: String
    var status: TaskStatus = .open
    var reviews: [TaskAction] = []
    var priority: TaskPriority = .high
    var description: String

    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }

    func jsValue() -> JSValue {
        return [
            "title": title,
            "why": why,
            "need": need,
            "project": project,
            "description": description,

        ].jsValue()
    }
}

enum TaskStatus: Int, Codable, CaseIterable {
    case open = 0
    case in_progress = 1
    case closed = 2
    case reopened = 3
}

enum TaskType: Int, Codable, CaseIterable {
    case bug = 0
    case feature
    case epic
}

enum TaskPriority: Int, Codable, CaseIterable {
    case low = 0
    case high
    case critical
}

struct TaskAction: Codable, ConvertibleToJSValue, Hashable {
    public var assignee: String = ""
    var comment: String = ""
    var status: TaskStatus

    func hash(into hasher: inout Hasher) {
        hasher.combine(assignee)
        hasher.combine(comment)
    }

    func jsValue() -> JSValue {
        return [
        ].jsValue()
    }
}
