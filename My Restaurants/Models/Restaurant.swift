//
//  Restaurant.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 09.07.2021.
//

struct RestaurantElement: Decodable {
    let element: Restaurant
    
    enum CodingKeys: String, CodingKey {
        case element = "restaurant"
    }
}

struct Restaurant: Decodable {
    let id: String
    let name: String
    let url: String
    let location: Location
    let all_reviews_count: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case location
        case all_reviews_count
    }
}

extension RestaurantElement: RestaurantDisplayable {
    var labelId: String {
        element.id
    }
    var labelName: String {
        element.name
    }
    var labelUrl: String {
        element.url
    }
    
    var labelAddress: String {
        element.location.address
    }
    
    var labelLatitude: Double {
        Double(element.location.latitude) ?? 0
    }
    
    var labelLongitude: Double {
        Double(element.location.longitude) ?? 0
    }
    
    var labelTotalReviews: Int {
        element.all_reviews_count
    }
    
}
