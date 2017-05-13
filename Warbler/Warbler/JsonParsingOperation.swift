//
//  JsonParsingOperation.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/9/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

class JsonParsingOperation: Operation {

    var input: Data?
    var output: Dictionary<String, Any>?
    
    override func main() {
        guard let input = input else { return }
        
        do {
            output = try JSONSerialization.jsonObject(with: input, options: .allowFragments) as? Dictionary<String, Any>
        } catch {
            print(error)
        }
    }
}
