//
//  SongBySearchTermOperationTestCase.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/17/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Warbler

class SongBySearchTermOperationTestCase: XCTestCase {
    
    class TestDataDownloader: DataDownloader {
        func dataWithUrl(_ url: URL) -> Data? {
            XCTAssertTrue(url.absoluteString.contains("TestSearchTerm"))
            return Data()
        }
    }
    
    func testSearchData() {
        let dataDownloader = TestDataDownloader()
        let operation = SongBySearchTermOperation(searchTerm: "TestSearchTerm", dataDownloader: dataDownloader)
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(operation)
        operationQueue.waitUntilAllOperationsAreFinished()
        
        XCTAssertEqual(operation.data, Data())
    }
    
}
