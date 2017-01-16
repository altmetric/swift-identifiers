import XCTest
import Identifiers

class ArxivIdTests: XCTestCase {
    func testInitWithPre2007ArxivId() {
        let arxivId = ArxivId("math.GT/0309136")
        
        XCTAssertEqual(arxivId.value, "math.GT/0309136")
    }
    
    func testInitWithPost2007UnversionedArxivId() {
        let arxivId = ArxivId("0706.0001")
        
        XCTAssertEqual(arxivId.value, "0706.0001")
    }

    func testInitWithPost2007VersionedArxivId() {
        let arxivId = ArxivId("1501.00001v2")
        
        XCTAssertEqual(arxivId.value, "1501.00001v2")
    }
    
    func testArxivIdCreationWithPre2007ArxivId() {
        do {
            let arxivId = try ArxivId(string: "math.GT/0309136")
            XCTAssertEqual(arxivId.value, "math.GT/0309136")
        } catch {
            XCTFail("Should not have thrown an error")
        }
    }

    func testArxivIdCreationWithPost2007UnversionedArxivId() {
        do {
            let arxivId = try ArxivId(string: "0706.0001")
            XCTAssertEqual(arxivId.value, "0706.0001")
        } catch {
            XCTFail("Should not have thrown an error")
        }
    }
    
    func testArxivIdCreationWithPost2007VersionedArxivId() {
        do {
            let arxivId = try ArxivId(string: "1501.00001v2")
            XCTAssertEqual(arxivId.value, "1501.00001v2")
        } catch {
            XCTFail("Should not have thrown an error")
        }
    }
    
    func testArxivIdCreationStripsArxivPrefix() {
        let arxivId = ArxivId("arXiv:1501.00001v2")
        
        XCTAssertEqual(arxivId.value, "1501.00001v2")
    }
    
    func testArxivIdCreationWithInvalidString() {
        let invalidArxivId = "10.1049/el.2013.3006"
        
        do {
            let _ = try ArxivId(string: invalidArxivId)
            XCTFail("Should have thrown an error")
        } catch(let error as ArxivId.Errors) {
            XCTAssert(error == .invalidArxivId)
        } catch {
            XCTFail("Incorrect error \(error) throws")
        }
    }
    
    func testExtractArxivIdsFromText() {
        let text = "math.GT/0309136 is an ArXiv ID, as is arxiv:math.ST/1007121. 0706.0001 is an unversioned post-2007 ID, while an unversioned one is arXiv:1501.00001v2."
        let arxivIds = ArxivId.extract(from: text)
        
        XCTAssertEqual(arxivIds, [ArxivId("math.GT/0309136"), ArxivId("math.ST/1007121"), ArxivId("0706.0001"), ArxivId("1501.00001v2")])
    }
}
