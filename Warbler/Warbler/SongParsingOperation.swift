//
//  SongParsingOperation.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/8/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

struct Song {
    let name: String
    let trackPrice: Double
    let trackPriceCurrency: String
}

class SongParsingOperation: Operation {
    
    var dictionaries: [Dictionary<String, Any>]?
    var songs = [Song]()
    
    override func main() {
        guard let dictionaries = dictionaries else { return }
        
        for dictionary in dictionaries {
            guard let kind = dictionary["kind"] as? String else { return }
            guard kind == "song" else { return }
        
            guard let name = dictionary["trackName"] as? String else { return }
            guard let trackPrice = dictionary["trackPrice"] as? Double else { return }
            guard let currency = dictionary["currency"] as? String else { return }
            
            songs.append(Song(name: name, trackPrice: trackPrice, trackPriceCurrency: currency))
        }
    }
}
