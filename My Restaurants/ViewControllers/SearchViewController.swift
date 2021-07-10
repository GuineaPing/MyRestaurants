//
//  ViewController.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 09.07.2021.
//

import UIKit
import Alamofire

class SearchViewController: UITableViewController {
    
    var data: [Displayable] = []
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        initControls()
    }
    
    // MARK: - inits
    
    func initControls() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Restaurants"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    // MARK: - data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath) as! SearchTableViewCell
        let item = data[indexPath.row]
        cell.labelTitle?.text = item.labelName
        cell.labelLocation?.text = item.labelAddress
        cell.oddCell(odd: indexPath.row % 2 == 0)
        return cell
    }
    
}

// MARK: - search

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    guard let shipName = searchBar.text else { return }
    searchRestaurants(for: shipName)
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {

  }
}

// MARK: - API calls

extension SearchViewController {
    func searchRestaurants(for mask: String) {
        let url = "https://developers.zomato.com/api/v2.1/search"
        let parameters: [String: String] = ["q": mask]
        let headers: HTTPHeaders = ["user-key":"2b3a8c2baa6d953047bc375668d2988a"]
        AF.request(url, method: .get, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).validate()
            .responseDecodable(of: Restaurants.self) { response in
                guard let restaurants = response.value else { return }
                self.data = restaurants.all
                self.tableView.reloadData()
            }
    }
}

