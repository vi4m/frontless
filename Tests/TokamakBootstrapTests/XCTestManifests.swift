import XCTest


#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(tokamak_bootstrapTests.allTests),
    ]
}
#endif
