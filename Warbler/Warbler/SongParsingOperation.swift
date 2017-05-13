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
    
    var dictionary: Dictionary<String, Any>?
    var song: Song?
    
    override func main() {
        guard let dictionary = dictionary else { return }
        guard let kind = dictionary["kind"] as? String else { return }
        guard kind == "song" else { return }
        
        guard let name = dictionary["trackName"] as? String else { return }
        
        song = Song(name: name)
    }
}
