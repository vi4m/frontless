
import CombineShim
import JavaScriptKit
import TokamakCore
import TokamakDOM

func navigate(to: String) {
    location.hash = JSValue(stringLiteral: to)
}

func parseHash(i: String) -> (page: String, args: [String]) {
    var page: String = ""
    var arguments: [String] = []

    debugPrint(#function)
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

    @Published var currentHash = location.hash.string!
    @Published var currentPage = ""
    @Published var currentArguments: [String] = []

    init() {
        debugPrint(#function)

        let onHashChange = JSClosure { [weak self] _ -> JSValue in
            debugPrint("onHashChange")
            self?.currentHash = location.hash.string!
            let (page, args) = parseHash(i: self!.currentHash)
            self?.currentPage = page
            self?.currentArguments = args
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
