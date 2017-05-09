//
//  URLSearchTestCase.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/8/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Warbler

class URLSearchTestCase: XCTestCase {
    
    func testSearchTermWithSpace() {
        assert(searchTerm: "Jack Johnson", resultsInURLWithString: "https://itunes.apple.com/search?term=Jack+Johnson")
    }
    
    func testSearchTermWithNoSpace() {
        assert(searchTerm: "Aerosmith", resultsInURLWithString: "https://itunes.apple.com/search?term=Aerosmith")
    }
    
    func assert(searchTerm: String, resultsInURLWithString urlString: String) {
        let searchURL = URL(searchURLWithTerm: searchTerm)
        XCTAssertEqual(searchURL?.absoluteString, urlString)
    }
}
