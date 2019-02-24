//
//  ViewController.swift
//  iStore
//
//  Created by Nikita Skrypchenko  on 2/15/19.
//  Copyright © 2019 Nikita Skrypchenko . All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    struct TableView {
        struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
            static let nothingFoundCell = "NothingFoundCell"
            static let loadingCell = "LoadingCell"
        }
    }
    var searchResults = [SearchResult]()
    var hasSearched = false
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBarX.becomeFirstResponder()

        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        header.backgroundColor = .green
        tableViewX.tableHeaderView = header
        
      let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        footer.backgroundColor = .green
        tableViewX.tableFooterView = footer
        
        tableViewX.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableViewX.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableViewX.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)
        
        cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
        tableViewX.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
    }
    
    @IBOutlet weak var tableViewX: UITableView!
    @IBOutlet weak var searchBarX: UISearchBar!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if searchResults.count == 0{
            return nil
        }else{
            return indexPath
        }
    }
    
    func performStoreRequest(with url: URL) -> Data? {
        do{//returns a new string object with the data it receives from the server pointed to by the URL.
            return try Data(contentsOf: url)
        } catch {
            print("Download Error: \(error.localizedDescription)")
            showNetworkError()
            return nil
        }
    }
    
    func iTunesURL(_ searchString: String) -> URL{
        let encodedString = searchString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        let urlString = String(format: "https://itunes.apple.com/search?term=%@", encodedString)
        let url = URL(string: urlString)
        return url!
    }

    func parse(_ data: Data) -> [SearchResult]{
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(ResultArray.self, from: data)
            return result.results
        } catch {
            print(error)
            return []
        }
    }
    
    func showNetworkError(){
        let alert = UIAlertController(title: "Whoops...",
                                      message: "There was an error accessing the iTunes Store." +
            " Please try again.", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}


extension SearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBarX: UISearchBar) {
        if !searchBarX.text!.isEmpty{
            searchBarX.resignFirstResponder()
            isLoading = true
            tableViewX.reloadData()
            hasSearched = true
            searchResults = []
            let queue = DispatchQueue.global()
            let url = self.iTunesURL(searchBarX.text!)
            queue.async {
                if let data = self.performStoreRequest(with: url) {
                    self.searchResults = self.parse(data)
                    self.searchResults.sort(by: <)
                    DispatchQueue.main.async {
                        self.isLoading = false
                        self.tableViewX.reloadData()
                    }
                    return
                }
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isLoading || searchResults.count == 0{
            return 1
        }else if !hasSearched {
            return 0
        }else{
            return searchResults.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        searchBarX.resignFirstResponder()
        if isLoading{
            let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.loadingCell, for: indexPath)
            let spinner = cell.viewWithTag(100) as! UIActivityIndicatorView
            spinner.startAnimating()
            return cell
        }else{
            if searchResults.count == 0{
                return tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.nothingFoundCell, for: indexPath)
            }else{
                let cell = tableView.dequeueReusableCell(withIdentifier: TableView.CellIdentifiers.searchResultCell, for: indexPath) as! SearchResultCell
                let searchResult = searchResults[indexPath.row]
                if searchResult.artist.isEmpty{
                    cell.artistNameLabel.text = "Unknown"
                }else{
                    cell.artistNameLabel.text = String(format: "%@ (%@)",searchResult.artist, searchResult.type)
                }
                cell.artistNameLabel.text = searchResult.name
                cell.nameLabel.text = searchResult.artistName
                return cell
            }
        }
    }
    
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}


