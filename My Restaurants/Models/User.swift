//
//  User.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 12.07.2021.
//

struct User: Decodable {
    let name: String
    // let foodie_level: String?
    // let foodie_level_num: Int
    let foodie_color: String
    
    enum CodingKeys: String, CodingKey {
        case name
        // case foodie_level
        // case foodie_level_num
        case foodie_color
    }
}
