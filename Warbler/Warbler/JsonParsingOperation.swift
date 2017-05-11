//
//  JsonParsingOperation.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/9/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

class JsonParsingOperation: Operation {

    var input: Data
    var output: Dictionary<String, String>?
    
    init(input: Data) {
        self.input = input
        super.init()
    }
    
    override func main() {
        do {
            try output = JSONSerialization.jsonObject(with: input, options: .allowFragments) as? Dictionary<String, String>
        } catch {
            
        }
    }
}
