//
//  Location.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 10.07.2021.
//

struct Location: Decodable {
    let address: String
    let locality: String
    let city: String
    let city_id: Int
    let latitude: String
    let longitude: String
    let zipcode: String
    let country_id: Int
    
    enum CodingKeys: String, CodingKey {
        case address
        case locality
        case city
        case city_id
        case latitude
        case longitude
        case zipcode
        case country_id
    }
}
