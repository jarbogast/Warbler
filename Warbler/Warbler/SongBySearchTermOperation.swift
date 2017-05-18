//
//  SongBySearchTermOperation.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/10/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

class SongBySearchTermOperation: Operation {
    let searchTerm: String
    let dataDownloader: DataDownloader
    var data: Data?
    
    init(searchTerm: String, dataDownloader: DataDownloader) {
        self.searchTerm = searchTerm
        self.dataDownloader = dataDownloader
        super.init()
    }
    
    override func main() {
        self.data = dataDownloader.dataWithUrl(URL(searchURLWithTerm: searchTerm)!)
    }
}
