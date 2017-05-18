//
//  SongListViewController.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/8/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import UIKit

class SongListViewController: UITableViewController, WarblerViewController {

    var iTunesDataSource: ITunesDataSource?
    var songList = [Song]()
    
    @IBOutlet weak var searchBar: UISearchBar! {
        didSet {
            searchBar.delegate = self
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let cell = sender as? UITableViewCell else { return }
        guard let destination = segue.destination as? SongDetailViewController else { return }
        
        if let indexPath = tableView.indexPath(for: cell) {
            let song = songList[indexPath.row]
            destination.song = song
            destination.iTunesDataSource = iTunesDataSource
        }
    }
}

extension SongListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard searchText.characters.count > 0 else { return }
        
        iTunesDataSource?.fetchSongsMatchingSearchTerm(searchText, completionBlock: { (songs) in
            DispatchQueue.main.async {
                self.songList = songs
                self.tableView.reloadData()
            }
        })
    }
}

extension SongListViewController {
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

