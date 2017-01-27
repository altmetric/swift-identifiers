import XCTest
import Identifiers

class ORCIDTests: XCTestCase {
    func testInitWithLiteral() {
        let orcid = Identifier<ORCID>("0000-0002-0088-0058")
        
        XCTAssertEqual(orcid.value, "0000-0002-0088-0058")
    }
    
    func testOrcidValidity() {
        let orcidText = "0000-0002-0088-0058"
        
        XCTAssertTrue(ORCID.isValid(value: orcidText))
    }
    
    func testOrcidInvalidity() {
        let invalidOrcidText = "0000-0002-0088-005X"
        
        XCTAssertFalse(ORCID.isValid(value: invalidOrcidText))
    }
    
    func testCreationWithInvalidORCID() {
        let invalidOrcidText = "0000-0002-0088-005X"
        
        do {
            let _ = try Identifier<ORCID>(value: invalidOrcidText)
            XCTFail("Error should have been thrown when creating ORCID with invalid string '\(invalidOrcidText)'")
        } catch(let error as IdentifierErrors) {
            XCTAssert(error == .invalidIdentifier)
        } catch {
            XCTFail("Incorrect error \(error) thrown")
        }
    }
    
    static var allTests: [(String, (ORCIDTests) -> () throws -> Void)] {
        return [
            ("testInitWithLiteral", testInitWithLiteral),
            ("testOrcidValidity", testOrcidValidity),
            ("testOrcidInvalidity", testOrcidInvalidity),
            ("testCreationWithInvalidORCID", testCreationWithInvalidORCID)
        ]
    }
}
