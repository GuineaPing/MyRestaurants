//
//  ViewController.swift
//  My Restaurants Net
//
//  Created by Eugene Lysenko on 11.07.2021.
//

import Cocoa

class ViewController: NSViewController {
    
    var data: [RestaurantDisplayable] = []

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear() {
        self.view.window?.title = "My Restaurants API Testing"
        // testRestaurants()
        // testReviews()
        // testRestaurant()
        testRestaurantsArray()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
    // MARK: -
    
    func testRestaurants() {
        Api.search(q: "pizza", start: 0) { restaurants in
            Dump.restaurants(dataItems: restaurants.all)
        }
    }
    
    func testReviews() {
        Api.reviews(resId: "16534391") { reviews in
            print()
        }
    }
    
    func testRestaurant() {
        Api.restaurant(resId: "16534272") { restaurant in
            print(restaurant.id, restaurant.name)
        }
    }
    
    func testRestaurantsArray() {
        let resIds:Array = ["19532191", "19720974", "19424301", "19424499", "19756554"]
        Api.restaurants(resIds:resIds) { restaurants in
            Dump.restaurants(dataItems: restaurants.all)
        }
    }

}

