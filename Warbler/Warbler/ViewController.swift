//
//  ViewController.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/8/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var iTunesDataSource = ProductionITunesDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iTunesDataSource.fetchSongsMatchingSearchTerm("Jack Johnson", completionBlock: { (songs) in
            print("Fetched \(songs.count) songs")
        })
        
    }
}

