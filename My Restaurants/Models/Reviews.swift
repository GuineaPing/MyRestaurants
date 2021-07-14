//
//  Reviews.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 12.07.2021.
//

struct Reviews: Decodable {
    
    let reviews_count: Int
    let reviews_start: Int
    let reviews_shown: Int
    let all:[ReviewElement]
    
    enum CodingKeys: String, CodingKey {
        case reviews_count
        case reviews_start
        case reviews_shown
        case all = "user_reviews"
    }
}
