//
//  JsonParsingOperationTestCase.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/10/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Warbler

class JsonParsingOperationTestCase: XCTestCase {
    
    func testValidJSON() {
        let jsonData = try! JSONSerialization.data(withJSONObject: ["test": "data"] as Any, options: .prettyPrinted)
        assertData(jsonData, parsesTo: ["test": "data"])
    }
    
    func testInvalidJSON() {
        let data = Data(count: 20)
        assertData(data, parsesTo: nil)
    }
    
    func assertData(_ data: Data, parsesTo expectedDictionary: [String:String]?) {
        let operation = JsonParsingOperation(input: data)
        let operationQueue = OperationQueue()
        operationQueue.addOperation(operation)
        operationQueue.waitUntilAllOperationsAreFinished()
        
        if let expectedDictionary = expectedDictionary {
            XCTAssertEqual(operation.output!, expectedDictionary)
        } else {
            XCTAssertNil(operation.output)
        }
    }
}
