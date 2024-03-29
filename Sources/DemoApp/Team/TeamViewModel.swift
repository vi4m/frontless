import CombineShim
import Foundation
import Frontless
import JavaScriptKit
import TokamakCore
import TokamakDOM

class TeamModel: ObservableObject {
  @Published var teams = [String: Team]()
  @Published var team: Team? = nil

  let localStorage = JSObject.global.localStorage.object!

  var listClosure: JSClosure?
  var getClosure: JSClosure?
  var addClosure: JSClosure?

  public func getBy(id: String) {
    //        _ = window.xfetch!("http://localhost:8080/teams/\(id)", getClosure)
    team = teams[id]
  }

  public func addTeam(team: Team) {
    do {
      var writableTeams = teams
      print(writableTeams)
      writableTeams[team.id] = team
      let bytesToSave = try JSONEncoder().encode(writableTeams)
      _ = localStorage.setItem!("teams", String(bytes: bytesToSave, encoding: .utf8)!)
      teams = writableTeams
    } catch {
      logger.error("Error saving to local storage: \(error)")
    }
    //        _ = window.xpost!("http://localhost:8080/okrs", task.jsValue(), addClosure)
  }

  func loadFromLocalStorage() {
    let decoder = JSONDecoder()
    logger.debug("Loading data from local storage")
    guard let value = localStorage.getItem!("teams").string else {
      logger.error("Cannot read tasks!")
      return
    }
    let json = value.data(using: .utf8)!
    logger.debug("Loaded")

    do {
      let decoded: [String: Team] = try decoder.decode([String: Team].self, from: json)
      teams = decoded
    } catch {
      logger.error("Error: \(error)")
    }
  }

  init() {
    logger.debug("Initialize DataViewModel")
    listClosure = JSClosure { [weak self] arguments -> Void in
      let teams: [String: Team] = try! JSValueDecoder().decode(from: arguments[0])
      self?.teams = teams
    }
    loadFromLocalStorage()
  }

  deinit {
    logger.debug("Deinit DataViewModel")
    listClosure?.release()
  }
}
