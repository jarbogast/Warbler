//
//  URL+Search.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/8/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import Foundation

extension URL {
    
    init?(searchURLWithTerm term: String) {
        var components = URLComponents(string: "https://itunes.apple.com/search")
        let wwwFormURLEncodedTerm = term.replacingOccurrences(of: " ", with: "+")
        let termQueryItem = URLQueryItem(name: "term", value: wwwFormURLEncodedTerm)
        components?.queryItems = [termQueryItem]
        
        self.init(string: (components?.string!)!)
    }
}
