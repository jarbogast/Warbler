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
            
            let song = Song(name: name)
            songs.append(song)
            print(song)
        }
    }
}
