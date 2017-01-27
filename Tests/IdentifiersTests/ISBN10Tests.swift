//
//  ISBN10Tests.swift
//  Identifiers
//
//  Created by Scott Matthewman on 27/01/2017.
//
//

import XCTest
@testable import Identifiers

class ISBN10Tests: XCTestCase {
    func testExtractsNormalisedISBN10() {
        let text = "0-8050-6909-7 \n 2-7594-0269-X"
        
        XCTAssertEqual(
            Identifier<ISBN10>.extract(from: text),
            [Identifier<ISBN10>("0805069097"), Identifier<ISBN10>("275940269X")]
        )
    }
    
    func testISBN10Validity() {
        XCTAssertTrue(ISBN10.isValid(value: "2-7594-0269-X"))
    }
    
    func testISBN10CheckDigitValidity() {
        XCTAssertFalse(ISBN10.isValid(value: "3319217280"))
    }
}
