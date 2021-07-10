//
//  Restaurants.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 09.07.2021.
//

struct Restaurants: Decodable {
    let results_found: Int
    let results_start: Int
    let results_shown: Int
    let all: [RestaurantElement]
    
    enum CodingKeys: String, CodingKey {
      case results_found
      case results_start
      case results_shown
      case all = "restaurants"
    }
}
