//
//  NationalClinicalTrialIdTests.swift
//  Identifiers
//
//  Created by Scott Matthewman on 27/01/2017.
//
//

import XCTest
import Identifiers

class NationalClinicalTrialIdTests: XCTestCase {
    func testNCTExtraction() {
        let text = "NCT00000106\nNCT00000107"
        
        XCTAssertEqual(Identifier<NationalClinicalTrialId>.extract(from: text), [Identifier<NationalClinicalTrialId>("NCT00000106"), Identifier<NationalClinicalTrialId>("NCT00000107")])
    }
    
    func testNCTNormalization() {
        let text = "nct00000106\nnCt00000107"
        
        XCTAssertEqual(Identifier<NationalClinicalTrialId>.extract(from: text), [Identifier<NationalClinicalTrialId>("NCT00000106"), Identifier<NationalClinicalTrialId>("NCT00000107")])
    }
}
