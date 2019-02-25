//
//  ViewController.swift
//  iStore
//
//  Created by Nikita Skrypchenko  on 2/15/19.
//  Copyright © 2019 Nikita Skrypchenko . All rights reserved.
//

import UIKit
import ARKit

class SearchViewController: UIViewController {
    
    struct TableView {
        struct CellIdentifiers {
            static let searchResultCell = "SearchResultCell"
            static let nothingFoundCell = "NothingFoundCell"
            static let loadingCell = "LoadingCell"
        }
    }
    let defaultHeight: CGFloat = 90
    var searchResults = [SearchResult]()
    var hasSearched = false
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewX.backgroundColor = .white
        searchBarX.becomeFirstResponder()

        let header = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let headerIcon = UIImageView(image: UIImage(named: "searchBar-camera"))
        headerIcon.translatesAutoresizingMaskIntoConstraints = false
        
        let searchWithPhotoButton = UIButton()
        searchWithPhotoButton.setTitle("Add photo of product", for: .normal)
        searchWithPhotoButton.titleLabel?.textAlignment = .center
        searchWithPhotoButton.tintColor = .black
        searchWithPhotoButton.translatesAutoresizingMaskIntoConstraints = false
        
        
       header.addSubview(searchWithPhotoButton)
        
        searchWithPhotoButton.topAnchor.constraint(equalTo: header.topAnchor).isActive = true
        searchWithPhotoButton.bottomAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        searchWithPhotoButton.leftAnchor.constraint(equalTo: header.leftAnchor).isActive = true
        searchWithPhotoButton.rightAnchor.constraint(equalTo: header.rightAnchor).isActive = true
        searchWithPhotoButton.addTarget(self, action: #selector(handleSearchWithPhoto), for: .touchUpInside)
        
        searchWithPhotoButton.addSubview(headerIcon)
        headerIcon.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 10).isActive = true
        headerIcon.centerYAnchor.constraint(equalTo: header.centerYAnchor).isActive = true
        headerIcon.widthAnchor.constraint(equalToConstant: 25).isActive = true
        headerIcon.heightAnchor.constraint(equalToConstant: 25).isActive = true

        header.backgroundColor = #colorLiteral(red: 0.3792193532, green: 0.6708514094, blue: 0, alpha: 1)
        
        tableViewX.tableHeaderView = header
        
      let footer = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        
        let addButton = UIButton()
        addButton.translatesAutoresizingMaskIntoConstraints = false
        addButton.setTitle("Add custom product", for: .normal)
        addButton.titleLabel?.textColor = .white
        addButton.titleLabel?.textAlignment = .center
        
        footer.addSubview(addButton)
        
        addButton.leftAnchor.constraint(equalTo: footer.leftAnchor).isActive = true
        addButton.topAnchor.constraint(equalTo: footer.topAnchor).isActive = true
        addButton.bottomAnchor.constraint(equalTo: footer.bottomAnchor).isActive = true
        addButton.rightAnchor.constraint(equalTo: footer.rightAnchor).isActive = true
        addButton.addTarget(self, action: #selector(handleAddButton), for: .touchUpInside)
        
        footer.backgroundColor = #colorLiteral(red: 0.3792193532, green: 0.6708514094, blue: 0, alpha: 1)
        tableViewX.tableFooterView = footer
        searchBarX.becomeFirstResponder()

        var cellNib = UINib(nibName: TableView.CellIdentifiers.searchResultCell, bundle: nil)
        tableViewX.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.searchResultCell)
        cellNib = UINib(nibName: TableView.CellIdentifiers.nothingFoundCell, bundle: nil)
        tableViewX.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.nothingFoundCell)

        cellNib = UINib(nibName: TableView.CellIdentifiers.loadingCell, bundle: nil)
        tableViewX.register(cellNib, forCellReuseIdentifier: TableView.CellIdentifiers.loadingCell)
    }
    
    
    @objc func handleAddButton(){
        
    }
    
   

    @objc func handleSearchWithPhoto(){
        let vc = CameraViewController()
        present(vc,
                animated: true,
            completion: nil)
    }
    @IBOutlet weak var tableViewX: UITableView!
    @IBOutlet weak var searchBarX: UISearchBar!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = descViewController()
        
        present(vc, animated: true, completion: nil)
        
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    class descViewController: UIViewController{
        let descriptionImageView: UIImageView={
            let iv = UIImageView(image: UIImage(named: "apple"))
            iv.translatesAutoresizingMaskIntoConstraints = false
            iv.contentMode = .scaleAspectFill
            
            return iv
        }()
        
        let name: UILabel={
           let n = UILabel()
            n.text = "Яблоко"
            n.font = UIFont.systemFont(ofSize: 30)
            n.translatesAutoresizingMaskIntoConstraints = false
            return n
        }()
        
        let descTextView:UITextView={
           let tv = UITextView()
            tv.text = "Яблоко — їстивний плід яблуні, соковитий, багатий на вітаміни та мікроелементи.Фрукт вагою 70—200 грам, що вживається в їжу в свіжому, квашеному, печеному вигляді, є сировиною в кулінарії, у виробництві дитячого харчування, джемів, повидла, безалкогольних та алкогольних напоїв тощо"
            tv.font = UIFont.systemFont(ofSize: 15)
            tv.textAlignment = .justified
            tv.translatesAutoresizingMaskIntoConstraints = false
            tv.isEditable = false
            tv.isSelectable = false
            return tv
        }()
        
        let kcal: UILabel = {
            let l = UILabel()
            l.text = "К-кал: 60"
            l.translatesAutoresizingMaskIntoConstraints = false
            return l
        }()
        
        let protein: UILabel = {
            let l = UILabel()
            l.text = "Білкі  в: 5"
            l.translatesAutoresizingMaskIntoConstraints = false
            return l
        }()
        
        
        let uglevodi: UILabel={
            let l = UILabel()
            l.text = "Вуглеводів: 5"
            l.translatesAutoresizingMaskIntoConstraints = false
            return l
        }()
        
        let word: UILabel = {
           let l = UILabel()
            l.text = "Дозволено вживати"
            l.font = UIFont.systemFont(ofSize: 20)
            l.textColor = #colorLiteral(red: 0.3792193532, green: 0.6708514094, blue: 0, alpha: 1)
            l.translatesAutoresizingMaskIntoConstraints = false
            return l
        }()
        
        let dismissButton: UIButton={
           let b = UIButton()
            b.titleLabel?.text = "Назад"
            b.translatesAutoresizingMaskIntoConstraints = false
            return b
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            view.addSubview(descriptionImageView)
            view.addSubview(name)
            view.addSubview(descTextView)
            view.addSubview(word)
            view.addSubview(dismissButton)
            view.addSubview(kcal)
            view.addSubview(protein)
            view.addSubview(uglevodi)
            
            descriptionImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            descriptionImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            descriptionImageView.widthAnchor.constraint(equalToConstant: 200).isActive = true
            descriptionImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            
            name.topAnchor.constraint(equalTo: descriptionImageView.bottomAnchor, constant: 12).isActive = true
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            descTextView.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 3).isActive = true
            descTextView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            descTextView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
            descTextView.heightAnchor.constraint(equalToConstant: 150).isActive = true
            
            word.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            word.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30).isActive = true
           
            kcal.topAnchor.constraint(equalTo: descTextView.bottomAnchor, constant: 3).isActive = true
            kcal.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            protein.topAnchor.constraint(equalTo: kcal.bottomAnchor, constant: 3).isActive = true
            protein.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
            uglevodi.topAnchor.constraint(equalTo: protein.bottomAnchor, constant: 3).isActive = true
            uglevodi.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        }
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
        return defaultHeight
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


