import Foundation

final class NavigationTests: XCTestCase {
    func testParseHash() throws {
        let parsed = parseHash(i: "index.html#AddOKR")
        XCTAssertEqual(parsed.page, "AddOKR")
    }
}
