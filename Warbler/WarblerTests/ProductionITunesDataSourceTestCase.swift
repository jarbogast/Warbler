//
//  ProductionITunesDataSourceTestCase.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/18/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Warbler

class ProductionITunesDataSourceTestCase: XCTestCase {
    
    func testValidResponseData() {
        class TestDataDownloader: DataDownloader {
            func dataWithUrl(_ url: URL) -> Data? {
                let json = ["results": [["kind": "song", "trackName": "Better Together", "trackPrice": 0.99]]]
                let data = try! JSONSerialization.data(withJSONObject: json, options: .prettyPrinted)
                return data
            }
        }
        
        let operationQueue = OperationQueue()
        let dataSource = ProductionITunesDataSource(operationQueue: operationQueue, dataDownloader: TestDataDownloader())
        let fetchCompletionExpectation = expectation(description: "FetchCompleted")
        
        dataSource.fetchSongsMatchingSearchTerm("Jack Johnson") { songs in
            XCTAssertEqual(songs.count, 1)
            XCTAssertEqual(songs[0].name, "Better Together")
            XCTAssertEqualWithAccuracy(songs[0].trackPrice, 0.99, accuracy: 0.01)
            fetchCompletionExpectation.fulfill()
        }
        waitForExpectations(timeout: 2.0, handler: nil)
    }
    
}
