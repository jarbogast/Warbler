//
//  SongParsingOperationTestCase.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/8/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Warbler

class SongParsingOperationTestCase: XCTestCase {
    
    func testValidDictionary() {
        let dictionary = ["kind": "song", "trackName": "Better Together"]
        let expectedSong = Song(name: "Better Together")
        assert(dictionary: dictionary, resultsInSong: expectedSong)
    }
    
    func testWrongKind() {
        let dictionary = ["kind": "movie", "trackName": "Better Together"]
        assert(dictionary: dictionary, resultsInSong: nil)
    }
    
    func testMissingName() {
        let dictionary = ["kind": "song"]
        assert(dictionary: dictionary, resultsInSong: nil)
    }
    
    func testWrongTypeForKindKey() {
        let dictionary = ["kind": 52]
        assert(dictionary: dictionary, resultsInSong: nil)
    }
    
    func assert(dictionary: Dictionary<String, Any>, resultsInSong song: Song?) {
        let operation = SongParsingOperation(dictionary: dictionary)
        
        let queue = OperationQueue()
        queue.addOperation(operation)
        queue.waitUntilAllOperationsAreFinished()
        
        XCTAssertEqual(operation.song?.name, song?.name)
    }
}
