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
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case url
        case location
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
    
    var lableLatitude: String {
        element.location.latitude
    }
    
    var lablelongitude: String {
        element.location.longitude
    }
    
}
