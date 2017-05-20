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
        let dictionary = ["kind": "song", "trackName": "Better Together", "trackPrice": 0.99, "currency": "USD"] as [String : Any]
        let expectedSong = Song(name: "Better Together", trackPrice: 0.99, trackPriceCurrency: "USD")
        assert(dictionary: dictionary, resultsInSong: expectedSong)
    }
    
    func testWrongKind() {
        let dictionary = ["kind": "movie", "trackName": "Better Together", "trackPrice": 0.99, "currency": "USD"] as [String : Any]
        assert(dictionary: dictionary, resultsInSong: nil)
    }
    
    func testMissingName() {
        let dictionary = ["kind": "movie", "trackPrice": 0.99, "currency": "USD"] as [String : Any]
        assert(dictionary: dictionary, resultsInSong: nil)
    }
    
    func testMissingTrackPrice() {
        let dictionary = ["kind": "movie", "trackName": "Better Together", "trackPrice": 0.99] as [String : Any]
        assert(dictionary: dictionary, resultsInSong: nil)
    }
    
    func testMissingCurrency() {
        let dictionary = ["kind": "movie", "trackName": "Better Together", "trackPrice": 0.99] as [String : Any]
        assert(dictionary: dictionary, resultsInSong: nil)
    }
    
    func testWrongTypeForKindKey() {
        let dictionary = ["kind": 52, "trackName": "Better Together", "trackPrice": 0.99, "currency": "USD"] as [String : Any]
        assert(dictionary: dictionary, resultsInSong: nil)
    }
    
    func testNilDictionary() {
        assert(dictionary: nil, resultsInSong: nil)
    }
    
    func assert(dictionary: Dictionary<String, Any>?, resultsInSong song: Song?) {
        let operation = SongParsingOperation()
        if let dictionary = dictionary {
            operation.dictionaries = [dictionary]
        } else {
            operation.dictionaries = nil
        }
        
        let queue = OperationQueue()
        queue.addOperation(operation)
        queue.waitUntilAllOperationsAreFinished()
        
        let actualSong: Song? = operation.songs.count > 0 ? operation.songs[0] : nil
        XCTAssertEqual(actualSong?.name, song?.name)
        XCTAssertEqual(actualSong?.trackPrice, song?.trackPrice)
    }
}
