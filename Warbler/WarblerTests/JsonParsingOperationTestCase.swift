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
    
    func testNilJSON() {
        assertData(nil, parsesTo: nil)
    }
    
    func assertData(_ data: Data?, parsesTo expectedDictionary: [String:String]?) {
        let operation = JsonParsingOperation()
        operation.input = data
        
        let operationQueue = OperationQueue()
        operationQueue.addOperation(operation)
        operationQueue.waitUntilAllOperationsAreFinished()
        
        if let expectedDictionary = expectedDictionary {
            let dictionary = operation.output as! [String:String]
            XCTAssertEqual(dictionary, expectedDictionary)
        } else {
            XCTAssertNil(operation.output)
        }
    }
}
