//
//  ITunesDataSource.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/13/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import Foundation

protocol ITunesDataSource {
    func fetchSongsMatchingSearchTerm(_ searchTerm: String, completionBlock: @escaping ([Song]) -> Void)
}

class ProductionITunesDataSource: ITunesDataSource {
    
    let operationQueue: OperationQueue
    let dataDownloader: DataDownloader
    
    init(operationQueue: OperationQueue = OperationQueue(), dataDownloader: DataDownloader = URLSessionDataDownloader()) {
        self.operationQueue = operationQueue
        self.dataDownloader = dataDownloader
    }
    
    func fetchSongsMatchingSearchTerm(_ searchTerm: String, completionBlock: @escaping ([Song]) -> Void) {
        let songOperation = SongBySearchTermOperation(searchTerm: searchTerm, dataDownloader: dataDownloader)
        let jsonOperation = JsonParsingOperation()
        let parseOperation = SongParsingOperation()
        
        let adapterOperation1 = BlockOperation {
            jsonOperation.input = songOperation.data
        }
        
        let adapterOperation2 = BlockOperation {
            let results = jsonOperation.output?["results"] as? [Dictionary<String, Any>]
            parseOperation.dictionaries = results
        }
        
        adapterOperation1.addDependency(songOperation)
        jsonOperation.addDependency(adapterOperation1)
        adapterOperation2.addDependency(jsonOperation)
        parseOperation.addDependency(adapterOperation2)
        
        parseOperation.completionBlock = {
            completionBlock(parseOperation.songs)
        }
        
        operationQueue.addOperations([songOperation, adapterOperation1, jsonOperation, adapterOperation2, parseOperation], waitUntilFinished: false)
    }
}
