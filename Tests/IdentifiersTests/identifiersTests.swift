import XCTest
@testable import Identifiers

class IdentifiersTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Identifiers().text, "Hello, World!")
    }

    static var allTests : [(String, (IdentifiersTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
