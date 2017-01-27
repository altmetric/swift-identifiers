import XCTest
import Identifiers

class HandleTests: XCTestCase {
    func testCreateWithStaticString() {
        let handle = Handle("10149/596901")

        XCTAssertEqual(handle.value, "10149/596901")
    }
    
    func testHandleValidity() {
        let handleText = "10149/596901"
        
        XCTAssertTrue(Handle.isValid(handleText))
    }
    
    func testHandleValidityFailure() {
        let handleText = "978-1491908907"
        
        XCTAssertFalse(Handle.isValid(handleText))
    }
    
    func testHandleCreationWithInvalidString() {
        let invalidHandleText = "978-1491908907"
        
        do {
            let _ = try Handle(string: invalidHandleText)
            XCTFail("Error should have been thrown while creating \(invalidHandleText)")
        } catch (let error as IdentifierErrors) {
            XCTAssert(error == .invalidIdentifier)
        } catch {
            XCTFail("Incorrect error \(error) thrown")
        }
    }
    
    func testExtractsHandleFromURL() {
        let handleText = "http://hdl.handle.net/10149/596901"
        
        XCTAssertEqual(Handle.extract(from: handleText), [Handle("10149/596901")])
    }
    
    static var allTests: [(String, (HandleTests) -> () throws -> Void)] {
        return [
            ("testCreateWithStaticString", testCreateWithStaticString),
            ("testHandleValidity", testHandleValidity),
            ("testHandleValidityFailure", testHandleValidityFailure),
            ("testHandleCreationWithInvalidString", testHandleCreationWithInvalidString),
            ("testExtractsHandleFromURL", testExtractsHandleFromURL)
        ]
    }
}
