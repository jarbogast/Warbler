//
//  DataDownloader.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/17/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import Foundation

protocol DataDownloader {
    func dataWithUrl(_ url: URL) -> Data?
}

class URLSessionDataDownloader: DataDownloader {
    let urlSession = URLSession(configuration: .default)
    var data: Data?
    
    func dataWithUrl(_ url: URL) -> Data? {
        let semaphore = DispatchSemaphore(value: 0)
        
        _ = urlSession.dataTask(with: url) { (data, response, error) in
            self.data = data
            semaphore.signal()
            }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        return data
    }
}
