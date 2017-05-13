//
//  ViewController.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/8/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let songOperation = SongBySearchTermOperation(searchTerm: "Jack Johnson")
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
        
        let operationQueue = OperationQueue()
        operationQueue.addOperations([songOperation, adapterOperation1, jsonOperation, adapterOperation2, parseOperation], waitUntilFinished: false)
        
    }
}

