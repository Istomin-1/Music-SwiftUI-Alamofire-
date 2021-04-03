//
//  SearchViewController.swift
//  Music(SwiftUI + Alamofire)
//
//  Created by Mikhail on 03.04.2021.
//

import UIKit

struct TrackModel {
    var trackName: String
    var artistName: String
}

class SearchViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    let tracks = [TrackModel(trackName: "Good", artistName: "Hren"), TrackModel(trackName: "Bred", artistName: "Fuuu")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupSearchhBar()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    }
    
    private func setupSearchhBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        let track = tracks[indexPath.row]
        
        cell.textLabel?.text = "index: \(track.trackName)\n\(track.artistName)"
        cell.textLabel?.numberOfLines = 2
        cell.imageView?.image = #imageLiteral(resourceName: "200x200bb")
        return cell
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
