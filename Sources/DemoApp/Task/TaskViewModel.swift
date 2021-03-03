import CombineShim
import JavaScriptKit
import TokamakCore
import TokamakDOM
import TokamakBootstrap
import Foundation


class TaskModel: ObservableObject {
    @Published var tasks = [Task]()
    @Published var task: Task? = nil
    
    let localStorage = JSObject.global.localStorage.object!    
    
    public var statuses: [PickerItem] = TaskStatus.allCases.map { 
        PickerItem(String($0.rawValue), "\($0)")
    }
    
    public var assignees: [PickerItem] = [
          PickerItem("0", "me"),
          PickerItem("1", "you")
      ]
    
    var listClosure: JSClosure?
    var getClosure: JSClosure?
    var addClosure: JSClosure?
    
    public func getBy(id: String) {
//        _ = window.xfetch!("http://localhost:8080/tasks/\(id)", getClosure)
        task = tasks.filter({ (task) -> Bool in
            task.id == id
        }).first
    }
    
    public func addTask(task: Task) {
        do {
            var writableTasks = tasks.filter { $0.id != task.id}            
            writableTasks.append(task)
            let bytesToSave = try JSONEncoder().encode(writableTasks)
            _ = localStorage.setItem!("tasks", String(bytes: bytesToSave, encoding: .utf8)!)
        }            
        catch {
            logger.error("Error saving to local storage: \(error)")
        }
//        _ = window.xpost!("http://localhost:8080/okrs", task.jsValue(), addClosure)
    }
    
    func loadFromLocalStorage() {
        let decoder = JSONDecoder()
        logger.debug("Loading data from local storage")
        guard let value = localStorage.getItem!("tasks").string else  {
            logger.error("Cannot read tasks!")
            return
        }
        let json = value.data(using: .utf8)!
        logger.debug("Loaded")        
        
        do {
            let decoded: [Task] = try decoder.decode([Task].self, from: json)
            tasks = decoded
        }
        catch {
            logger.error("Error: \(error)")
        }
    }
    
    
    init() {
        logger.debug("Initialize DataViewModel")
        listClosure = JSClosure { [weak self] arguments -> Void in
            let tasks: [Task] = try! JSValueDecoder().decode(from: arguments[0])
            self?.tasks = tasks
        }
        loadFromLocalStorage()
    }
    
    deinit {
        logger.debug("Deinit DataViewModel")        
        listClosure?.release()
    }
}
