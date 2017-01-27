import XCTest
import Identifiers

class ArxivIdTests: XCTestCase {
    func testInitWithPre2007ArxivId() {
        let arxivId = Identifier<ArxivId>("math.GT/0309136")

        XCTAssertEqual(arxivId.value, "math.GT/0309136")
    }

    func testInitWithPost2007UnversionedArxivId() {
        let arxivId = Identifier<ArxivId>("0706.0001")

        XCTAssertEqual(arxivId.value, "0706.0001")
    }

    func testInitWithPost2007VersionedArxivId() {
        let arxivId = Identifier<ArxivId>("1501.00001v2")

        XCTAssertEqual(arxivId.value, "1501.00001v2")
    }

    func testArxivIdCreationWithPre2007ArxivId() {
        do {
            let arxivId = try Identifier<ArxivId>(value: "math.GT/0309136")
            XCTAssertEqual(arxivId.value, "math.GT/0309136")
        } catch {
            XCTFail("Should not have thrown an error")
        }
    }

    func testArxivIdCreationWithPost2007UnversionedArxivId() {
        do {
            let arxivId = try Identifier<ArxivId>(value: "0706.0001")
            XCTAssertEqual(arxivId.value, "0706.0001")
        } catch {
            XCTFail("Should not have thrown an error")
        }
    }

    func testArxivIdCreationWithPost2007VersionedArxivId() {
        do {
            let arxivId = try Identifier<ArxivId>(value: "1501.00001v2")
            XCTAssertEqual(arxivId.value, "1501.00001v2")
        } catch {
            XCTFail("Should not have thrown an error")
        }
    }

    func testArxivIdCreationStripsArxivPrefix() {
        let arxivId = Identifier<ArxivId>("arXiv:1501.00001v2")

        XCTAssertEqual(arxivId.value, "1501.00001v2")
    }

    func testArxivIdCreationWithInvalidString() {
        let invalidArxivId = "10.1049/el.2013.3006"

        do {
            let _ = try Identifier<ArxivId>(value: invalidArxivId)
            XCTFail("Should have thrown an error")
        } catch(let error as IdentifierErrors) {
            XCTAssert(error == .invalidIdentifier)
        } catch {
            XCTFail("Incorrect error \(error) throws")
        }
    }

    func testExtractArxivIdsFromText() {
        let text = "math.GT/0309136 is an ArXiv ID, as is arxiv:math.ST/1007121. 0706.0001 is an unversioned post-2007 ID, while an unversioned one is arXiv:1501.00001v2."
        let arxivIds = Identifier<ArxivId>.extract(from: text)

        XCTAssertEqual(arxivIds, [Identifier<ArxivId>("math.GT/0309136"), Identifier<ArxivId>("math.ST/1007121"), Identifier<ArxivId>("0706.0001"), Identifier<ArxivId>("1501.00001v2")])
    }

    static var allTests: [(String, (ArxivIdTests) -> () throws -> Void)] {
        return [
            ("testInitWithPre2007ArxivId", testInitWithPre2007ArxivId),
            ("testInitWithPost2007UnversionedArxivId", testInitWithPost2007UnversionedArxivId),
            ("testInitWithPost2007VersionedArxivId", testInitWithPost2007VersionedArxivId),
            ("testArxivIdCreationWithPre2007ArxivId", testArxivIdCreationWithPre2007ArxivId),
            ("testArxivIdCreationWithPost2007UnversionedArxivId", testArxivIdCreationWithPost2007UnversionedArxivId),
            ("testArxivIdCreationWithPost2007VersionedArxivId", testArxivIdCreationWithPost2007VersionedArxivId),
            ("testArxivIdCreationStripsArxivPrefix", testArxivIdCreationStripsArxivPrefix),
            ("testArxivIdCreationWithInvalidString", testArxivIdCreationWithInvalidString),
            ("testExtractArxivIdsFromText", testExtractArxivIdsFromText)
        ]
    }
}
