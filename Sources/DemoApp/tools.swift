import Foundation
import JavaScriptKit
import TokamakDOM
import CombineShim
import TokamakBootstrap
import Logging

public func measure(_ f: () -> ()) -> Double {
    let t0 = window.performance.now().number!
    f()
    let t1 = window.performance.now().number!
    return t1 - t0
}

