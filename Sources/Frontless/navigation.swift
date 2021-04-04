import CombineShim
import JavaScriptKit
import TokamakCore
import TokamakDOM

public func navigate(to: String) {
  location.hash = JSValue(stringLiteral: to)
}

public func parseHash(i: String) -> (page: String, args: [String]) {
  var page: String = ""
  var arguments: [String] = []

  logger.debug(#function)
  let a = Array(i)
  if let position: Int = a.firstIndex(of: "?") {
    page = String(a[..<position])
  } else {
    page = String(a)
  }
  if a.firstIndex(of: "?") != nil {
    let joints = String(i.split(separator: "?")[1])
    arguments = joints.split(separator: ",").map { String($0) }
  }
  return (page, arguments)
}

public final class HashState: ObservableObject {
  var onHashChange: JSClosure!

  @Published public var currentHash = location.hash.string!
  @Published public var currentPage = ""
  @Published public var currentArguments: [String] = []

  public init() {
    logger.debug(#function)

    let onHashChange = JSClosure { [weak self] _ -> JSValue in
      logger.debug("onHashChange")
      self?.currentHash = location.hash.string!
      let (page, args) = parseHash(i: self!.currentHash)
      self?.currentArguments = args
      self?.currentPage = page
      return .undefined
    }
    currentHash = location.hash.string!
    let (page, args) = parseHash(i: currentHash)
    currentPage = page
    currentArguments = args

    window.onhashchange = .function(onHashChange)
    self.onHashChange = onHashChange
  }

  deinit {
    window.onhashchange = .undefined
    onHashChange.release()
  }
}
