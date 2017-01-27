//
//  ISBN13Tests.swift
//  Identifiers
//
//  Created by Scott Matthewman on 27/01/2017.
//
//

import XCTest
@testable import Identifiers

class ISBN13Tests: XCTestCase {
    func testExtractsNormalizedISBNs() {
        let text = "978-0-80-506909-9\n978-0-67-187919-8"
        
        XCTAssertEqual(
            Identifier<ISBN13>.extract(from: text),
            [
                Identifier<ISBN13>("9780805069099"),
                Identifier<ISBN13>("9780671879198")
            ]
        )
    }
    
    func testISBN13Validity() {
        XCTAssertTrue(ISBN13.isValid(value: "9780671879198"))
    }
    
    func testISBN13CheckDigitValidity() {
        XCTAssertFalse(ISBN13.isValid(value: "9783319217280"))
    }
}
