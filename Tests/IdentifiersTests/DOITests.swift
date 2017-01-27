import XCTest
import Identifiers

class DOITests: XCTestCase {
    func testInitWithStaticDOI() {
        let doi = DOI("10.2345/sfgjhweefghej")

        XCTAssertEqual(doi.value, "10.2345/sfgjhweefghej")
    }

    func testDOIValidity() {
        let doiText = "10.2134/sgksjfg3.2134214oy"

        XCTAssertTrue(DOI.isValid(doiText))
    }

    func testDOIValidityFailure() {
        let doiText = "978-1491908907"

        XCTAssertFalse(DOI.isValid(doiText))
    }

    func testDOICreationWithInvalidString() {
        let invalidDoiText = "978-1491908907"

        do {
            let _ = try DOI(string: invalidDoiText)
            XCTFail("Error should have been thrown with creating \(invalidDoiText)")
        } catch(let error as IdentifierErrors) {
            XCTAssert(error == .invalidIdentifier)
        } catch {
            XCTFail("Incorrect error \(error) thrown")
        }
    }
    
    func testStoresNormalisedDOIs() {
        let doi = DOI("10.1039/EL.2013.3006")
        
        XCTAssertEqual(doi.value, "10.1039/el.2013.3006")
    }

    func testExtractDOIsFromText() {
        let text = "10.1049/el.2013.3006 is a DOI. Can you extract a second DOI of 10.1097/01.asw.0000443266.17665.19?"
        let dois = DOI.extract(from: text)

        XCTAssertEqual(dois, [DOI("10.1049/el.2013.3006"), DOI("10.1097/01.asw.0000443266.17665.19")])
    }
    
    func testExtractISBN_A() {
        let text = "This is an ISBN-A: 10.978.8898392/315"
        let dois = DOI.extract(from: text)
        
        XCTAssertEqual(dois, [DOI("10.978.8898392/315")])
    }

    static var allTests : [(String, (DOITests) -> () throws -> Void)] {
        return [
            ("testInitWithStaticDOI", testInitWithStaticDOI),
            ("testDOIValidity", testDOIValidity),
            ("testDOIValidityFailure", testDOIValidityFailure),
            ("testDOICreationWithInvalidString", testDOICreationWithInvalidString),
            ("testStoresNormalisedDOIs", testStoresNormalisedDOIs),
            ("testExtractDOIsFromText", testExtractDOIsFromText)
        ]
    }
}
