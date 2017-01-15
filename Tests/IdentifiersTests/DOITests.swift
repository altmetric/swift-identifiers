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
        let doiText = "978-1491908907"

        do {
            let _ = try DOI(string: doiText)
            XCTFail("Error should have been thrown with creating \(doiText)")
        } catch(let error as DOI.Errors) {
            XCTAssert(error == DOI.Errors.invalidDOI)
        } catch {
            XCTFail("Incorrect error \(error) thrown")
        }
    }

    func testExtractDOIsFromText() {
        let text = "10.1049/el.2013.3006 is a DOI. Can you extract a second DOI of 10.1097/01.asw.0000443266.17665.19?"
        let dois = DOI.extract(from: text)

        XCTAssertEqual(dois, [DOI("10.1049/el.2013.3006"), DOI("10.1097/01.asw.0000443266.17665.19")])
    }

    static var allTests : [(String, (DOITests) -> () throws -> Void)] {
        return [
            ("testInitWithStaticDOI", testInitWithStaticDOI),
            ("testDOIValidity", testDOIValidity),
            ("testDOIValidityFailure", testDOIValidityFailure),
            ("testDOICreationWithInvalidString", testDOICreationWithInvalidString)
        ]
    }
}
