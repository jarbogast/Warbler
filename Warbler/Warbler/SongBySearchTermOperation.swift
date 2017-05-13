//
//  SongBySearchTermOperation.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/10/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

class SongBySearchTermOperation: Operation {
    var searchTerm: String
    var data: Data?
    
    init(searchTerm: String) {
        self.searchTerm = searchTerm
        super.init()
    }
    
    override func main() {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        let semaphore = DispatchSemaphore(value: 0)
        
        _ = urlSession.dataTask(with: URL(searchURLWithTerm: searchTerm)!) { (data, response, error) in
            self.data = data
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
    }
}
