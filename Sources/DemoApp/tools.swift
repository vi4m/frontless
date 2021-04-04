import CombineShim
import Foundation
import Frontless
import JavaScriptKit
import Logging
import TokamakDOM

public func measure(_ f: () -> Void) -> Double {
  let t0 = window.performance.now().number!
  f()
  let t1 = window.performance.now().number!
  return t1 - t0
}
