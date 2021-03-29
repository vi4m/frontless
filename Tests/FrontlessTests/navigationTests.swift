import Foundation
import XCTest
@testable import Frontless

final class NavigationTests: XCTestCase {
    func testParseHash() throws {
        let parsed = parseHash(i: "#AddTask?383c08b4-44a3-464e-a701-26165dc2a1c1")
        XCTAssertEqual(parsed.page, "#AddTask")
        XCTAssertEqual(parsed.args, ["383c08b4-44a3-464e-a701-26165dc2a1c1"])        
    }
}
