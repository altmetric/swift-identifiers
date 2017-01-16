import XCTest
import Identifiers

class HandleTests: XCTestCase {
    func testCreateHandle() {
        let handle = Handle("10149/596901")

        XCTAssertEqual(handle.value, "10149/596901")
    }
}
