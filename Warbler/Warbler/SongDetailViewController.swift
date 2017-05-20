//
//  SongDetailViewController.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/18/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

class SongDetailViewController: UIViewController, WarblerViewController {

    var iTunesDataSource: ITunesDataSource?
    var song: Song? {
        didSet {
            title = song?.name
        }
    }
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let song = song {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            priceLabel.text = numberFormatter.string(from: NSNumber(value: song.trackPrice))
        }
    }

}
