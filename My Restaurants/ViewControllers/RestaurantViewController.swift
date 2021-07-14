//
//  RestaurantViewController.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 14.07.2021.
//

import UIKit

class RestaurantViewController: BaseTableViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    
    var restaurants: [RestaurantDisplayable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackButton()
        initSwipe()
        initData()
    }
    
    // MARK: - inits

    func initData() {
        guard (restaurants.count == 1) else {
            return
        }
        let restaurant: RestaurantDisplayable = restaurants[0]
        
        labelTitle.text = restaurant.labelName
        labelLocation.text = restaurant.labelAddress
    }
    
    // MARK: - actions


}
