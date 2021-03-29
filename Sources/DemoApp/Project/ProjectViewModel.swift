import CombineShim
import Foundation
import JavaScriptKit
import Frontless
import TokamakCore
import TokamakDOM

class ProjectViewModel: ObservableObject {
    @Published var projects = [Project]()
    @Published var project: Project? = nil

    let localStorage = JSObject.global.localStorage.object!

    var listClosure: JSClosure?
    var getClosure: JSClosure?
    var addClosure: JSClosure?

    public func getBy(id: String) {
//        _ = window.xfetch!("http://localhost:8080/tasks/\(id)", getClosure)
        project = projects.filter { (project) -> Bool in
            project.id == id
        }.first
    }

    public func addProject(project: Project) {
        do {
            var writableProjects = projects.filter { $0.id != project.id }
            writableProjects.append(project)
            let bytesToSave = try JSONEncoder().encode(writableProjects)
            _ = localStorage.setItem!("projects", String(bytes: bytesToSave, encoding: .utf8)!)
        } catch {
            logger.error("Error saving to local storage: \(error)")
        }
//        _ = window.xpost!("http://localhost:8080/okrs", task.jsValue(), addClosure)
    }

    func loadFromLocalStorage() {
        let decoder = JSONDecoder()
        logger.debug("Loading data from local storage")
        guard let value = localStorage.getItem!("projects").string else {
            logger.error("Cannot read projects!")
            return
        }
        let json = value.data(using: .utf8)!
        logger.debug("Loaded")

        do {
            let decoded: [Project] = try decoder.decode([Project].self, from: json)
            projects = decoded
        } catch {
            logger.error("Error: \(error)")
        }
    }

    init() {
        logger.debug("Initialize DataViewModel")
        listClosure = JSClosure { [weak self] arguments -> Void in
            let projects: [Project] = try! JSValueDecoder().decode(from: arguments[0])
            self?.projects = projects
        }
        loadFromLocalStorage()
    }

    deinit {
        logger.debug("Deinit DataViewModel")
        listClosure?.release()
    }
}
