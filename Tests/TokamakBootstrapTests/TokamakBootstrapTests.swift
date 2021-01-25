import XCTest
@testable import tokamak_bootstrap

final class tokamak_bootstrapTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(tokamak_bootstrap().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
