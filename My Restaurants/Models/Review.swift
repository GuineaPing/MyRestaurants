//
//  File.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 12.07.2021.
//

struct ReviewElement: Decodable {
    let element: Review
    
    enum CodingKeys: String, CodingKey {
        case element = "review"
    }
}

struct Review: Decodable {
    let rating: Float
    let review_text: String
    let id: Int
    let rating_color: String
    let review_time_friendly: String
    let likes: Int
    let user: User
    
    enum CodingKeys: String, CodingKey {
        case rating
        case review_text
        case id
        case rating_color
        case review_time_friendly
        case likes
        case user
    }
}

extension ReviewElement: ReviewDisplayable {
    var labelUserName: String {
        element.user.name
    }
    
    var labelText: String {
        element.review_text
    }
    
    var labelRating: String {
        "\(element.rating)"
    }
}
