import Foundation
import XCTest
@testable import TokamakBootstrap

final class NavigationTests: XCTestCase {
    func testParseHash() throws {
        let parsed = parseHash(i: "index.html#AddOKR")
        XCTAssertEqual(parsed.page, "AddOKR")
    }
}
