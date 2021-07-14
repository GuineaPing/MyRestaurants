//
//  ViewController.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 09.07.2021.
//

import UIKit
import Alamofire

class SearchViewController: BaseTableViewController, SearchTableViewCellProtocol, FavoritesProtocol {

    
    @IBOutlet weak var labelCounter: UILabel!
    
    // loaded restaurants
    var data: [RestaurantDisplayable] = []
    // favorites that keeps in UserDefaults
    var favorites: Favorites = Favorites()
    // pagination variables
    var counter: Int = 0
    var currentIndex: Int = 0
    var currentStart: Int = 0
    var step: Int = 0
    // request mask
    var mask: String = "--"
    // to avoid multiple call
    var isLoading: Bool = false;
    // selected restaurant for reviews call
    var selectedResId: String = ""
    var selectedResTitle: String = ""
    // search / favorites status
    var isFavorites: Bool = false

    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        initControls()
        initNavigationButtons()
        initFavorites()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        favorites.save()
    }
    
    // MARK: - inits
    
    func initControls() {
        initSearchBar()
        updateCounter()
        searchRestaurants(for: "")
    }
    
    func initSearchBar() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "Search Restaurants"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func initNavigationButtons() {
        showMapButton()
    }
    
    func initFavorites() {
        favorites.delegate = self;
        favorites.indicate()
    }
    
    // MARK: - navigation
    
    func showFavoritesButton() {
        let leftButton = UIButton.init(type: .custom)
        let imageName = isFavorites ? "magnifying-glass" : "checked-blue"
        leftButton.setImage(UIImage(named: imageName), for: UIControl.State.normal)
        leftButton.addTarget(self, action: #selector(actionFavorites), for: UIControl.Event.touchUpInside)
        leftButton.frame = CGRect(x: 0, y: 0, width: 22, height: 18)
        let leftBarButton = UIBarButtonItem(customView: leftButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
    }
    
    func showMapButton() {
        let rightButton = UIButton.init(type: .custom)
        rightButton.setImage(UIImage(named: "map"), for: UIControl.State.normal)
        rightButton.addTarget(self, action: #selector(actionMap), for: UIControl.Event.touchUpInside)
        rightButton.frame = CGRect(x: 0, y: 0, width: 22, height: 22)
        let rightBarButton = UIBarButtonItem(customView: rightButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func hideFavoritesButton() {
        self.navigationItem.leftBarButtonItem = nil
    }

    // MARK: - load indicator
    
    override func showIndicator() {
        super.showIndicator()
        labelCounter.text = "loading..."
    }
    
    override func hideIndicator() {
        super.hideIndicator()
        updateCounter()
    }
    
    // MARK: - data
    
    func resetData() {
        currentStart = 0
        currentIndex = 0
    }
    
    func updateCounter() {
        let counterTitle: String = isFavorites ? "Favorites" : "Search"
        self.labelCounter.text = (counter == 0) ? "no result" : "\(counterTitle): \(currentIndex) / \(counter)"
    }
    
    func loadData(mask: String, forced: Bool = false) {
        if(isLoading) {
            return
        }
        if (!forced && self.mask == mask) {
            return
        }
        self.mask = mask
        showIndicator()
        isLoading = true
        Api.search(q: mask, start: currentStart) { restaurants in
            // Dump.restaurant(start:self.currentStart, dataItems: restaurants.all)
            if (self.currentStart == 0) {
                self.data = restaurants.all
            } else {
                self.data.append(contentsOf: restaurants.all)
            }
            self.counter = restaurants.results_found
            self.step = restaurants.results_shown
            self.tableView.reloadData()
            self.hideIndicator()
            self.updateCounter()
            self.isLoading = false;
        }
    }
    
    func loadFavorites() {
        if(isLoading) {
            return
        }
        showIndicator()
        isLoading = true
        Api.restaurants(resIds: favorites.data) { restaurants in
            // Dump.restaurant(start:self.currentStart, dataItems: restaurants.all)
            self.data = restaurants.all
            self.counter = restaurants.results_found
            self.step = restaurants.results_shown
            self.tableView.reloadData()
            self.hideIndicator()
            self.updateCounter()
            self.isLoading = false;
        }
    }
    
    func loadMoreData() {
        if (isLoading) {
            return
        }
        if (currentStart  >= counter) {
            return
        }
        currentStart += step
        loadData(mask: mask, forced: true)
    }
    
    // MARK: - favorites events
    
    func favoritesChanged(resId: String, isFavorite: Bool) {
        if(isFavorite) {
            favorites.add(resId: resId)
        } else {
            favorites.remove(resId: resId)
            removeCell(resId: resId)
        }
    }
    
    func favoritesChanged(empty: Bool) {
        if(empty) {
            hideFavoritesButton()
        } else {
            showFavoritesButton()
        }
    }
    
    func removeCell(resId:String) {
        if(!isFavorites) {
            return;
        }
        // loadFavorites()
        var ind: Int = 0
        for item:RestaurantDisplayable in data {
            if (item.labelId == resId) {
                data.remove(at: ind)
                let indexPath = IndexPath(row: ind, section: 0)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                tableView.endUpdates()
                break
            }
            ind += 1
        }
    }

    // MARK: - actions
    
    @objc func actionFavorites() {
        resetData()
        isFavorites = !isFavorites
        hideFavoritesButton()
        showFavoritesButton()
        if(isFavorites) {
            loadFavorites()
        } else {
            resetData()
            loadData(mask: mask, forced: true)
        }
    }
    
    @objc func actionMap() {
        
    }
    
}


// MARK: - table data source

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell  = tableView.dequeueReusableCell(withIdentifier: "cellItem", for: indexPath) as! SearchTableViewCell
        let item = data[indexPath.row]
        cell.labelTitle?.text = item.labelName
        cell.labelLocation?.text = item.labelAddress
        cell.isFavorite = favorites.exists(resId: item.labelId)
        cell.resId = item.labelId
        cell.delegate = self;
        cell.oddCell(odd: indexPath.row % 2 == 0)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destinationVC = segue.destination as? ReviewsViewController else {
          return
        }
        destinationVC.resId = selectedResId
        destinationVC.resTitle = selectedResTitle
    }
     
}

// MARK: - table delegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
          let item: RestaurantDisplayable = data[indexPath.row]
          selectedResId = item.labelId
        selectedResTitle = item.labelName
          return indexPath
    }
    
}

// MARK: - search

extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    let searchBar = searchController.searchBar
    guard let shipName = searchBar.text else { return }
    if (isFavorites) {
        isFavorites = false
        hideFavoritesButton()
        showFavoritesButton()
        resetData()
        loadData(mask: mask, forced: true)
    }
    searchRestaurants(for: shipName)
  }
}

// MARK: - load more data on scroll

extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (data.count == 0) {
            return
        }
        let visibleRows: Array = tableView.indexPathsForVisibleRows!
        var maxRow: Int = 0;
        for indexPath:IndexPath in visibleRows {
            if (indexPath.row > maxRow) {
                maxRow = indexPath.row
            }
        }
        currentIndex = min(maxRow + 1, counter)
        updateCounter();
        if (maxRow >= data.count - step) {
            loadMoreData()
        }
        
    }
}

// MARK: - API calls

extension SearchViewController {
    func searchRestaurants(for mask: String) {
        resetData()
        loadData(mask:mask)
    }
}








