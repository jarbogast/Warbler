//
//  ViewController.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/8/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    var iTunesDataSource = ProductionITunesDataSource()
    var songList = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iTunesDataSource.fetchSongsMatchingSearchTerm("Jack Johnson", completionBlock: { (songs) in
            DispatchQueue.main.async {
                self.songList = songs
                self.tableView.reloadData()
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell")!
        cell.textLabel?.text = songList[indexPath.row].name
        cell.detailTextLabel?.text = String(songList[indexPath.row].trackPrice)
        return cell
    }
}

