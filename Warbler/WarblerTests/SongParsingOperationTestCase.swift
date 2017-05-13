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
        let dictionary = ["kind": "song", "trackName": "Better Together", "trackPrice": 0.99] as [String : Any]
        let expectedSong = Song(name: "Better Together", trackPrice: 0.99)
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
        let operation = SongParsingOperation()
        operation.dictionaries = [dictionary]
        
        let queue = OperationQueue()
        queue.addOperation(operation)
        queue.waitUntilAllOperationsAreFinished()
        
        let actualSong: Song? = operation.songs.count > 0 ? operation.songs[0] : nil
        XCTAssertEqual(actualSong?.name, song?.name)
        XCTAssertEqual(actualSong?.trackPrice, song?.trackPrice)
    }
}
