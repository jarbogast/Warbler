//
//  SongListViewControllerTestCase.swift
//  Warbler
//
//  Created by Jonathan Arbogast on 5/17/17.
//  Copyright © 2017 Jonathan Arbogast. All rights reserved.
//

import XCTest
@testable import Warbler

class SongListViewControllerTestCase: XCTestCase {
    
    func testNumberOfSections() {
        let viewController = createSongListViewController()
        XCTAssertEqual(viewController.numberOfSections(in: viewController.tableView), 1)
    }
    
    func testNumberOfRowsInSection() {
        let viewController = createSongListViewController()
        let song = Song(name: "Test Song", trackPrice: 3.53, trackPriceCurrency: "USD")
        viewController.songList = [song]
        
        XCTAssertEqual(viewController.tableView(viewController.tableView, numberOfRowsInSection: 0), 1)
    }
    
    func testCellConfiguration() {
        let viewController = createSongListViewController()
        let song = Song(name: "Test Song", trackPrice: 3.53, trackPriceCurrency: "USD")
        viewController.songList = [song]
        
        let cell = viewController.tableView(viewController.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, "Test Song")
        XCTAssertEqual(cell.detailTextLabel?.text, "$3.53")
    }
    
    func testSearchInvocation() {
        let searchExpectation = expectation(description: "SearchBegan")
        
        class TestiTunesDataSource: ITunesDataSource {
            let expectation: XCTestExpectation
            
            init(expectation: XCTestExpectation) {
                self.expectation = expectation
            }
            
            func fetchSongsMatchingSearchTerm(_ searchTerm: String, completionBlock: @escaping ([Song]) -> Void) {
                XCTAssertEqual(searchTerm, "Jack Johnson")
                expectation.fulfill()
            }
        }
        
        let viewController = createSongListViewController()
        viewController.iTunesDataSource = TestiTunesDataSource(expectation: searchExpectation)
        _ = viewController.view
        viewController.searchBar(viewController.searchBar, textDidChange: "Jack Johnson")

        waitForExpectations(timeout: 3.0, handler: nil)
    }
    
    func createSongListViewController() -> SongListViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: "SongListViewController") as! SongListViewController
    }
}
