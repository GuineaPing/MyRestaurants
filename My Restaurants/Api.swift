//
//  Api.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 12.07.2021.
//

import Alamofire

class Api {
    
    static func search(q: String, start:Int, completionHandler: @escaping(Restaurants) -> Void) {
        let url = "\(Settings.baseUrl)search"
        let parameters: [String: String] = ["q": q, "start": "\(start)"]
        let headers: HTTPHeaders = Settings.userKey
        AF.request(url, method: .get, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).validate()
            .responseDecodable(of: Restaurants.self) { response in
                guard let restaurants = response.value else { return }
                completionHandler(restaurants)
            }
    }
    
    static func reviews(resId: String, completionHandler: @escaping(Reviews) -> Void) {
        let url = "\(Settings.baseUrl)reviews"
        let parameters: [String: String] = ["res_id": resId]
        let headers: HTTPHeaders = Settings.userKey
        AF.request(url, method: .get, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).validate()
            .responseDecodable(of: Reviews.self) { response in
                guard let reviews = response.value else { return }
                completionHandler(reviews)
            }
    }
    
    static func restaurant(resId:String, completionHandler: @escaping(Restaurant) -> Void) {
        let url = "\(Settings.baseUrl)restaurant"
        let parameters: [String: String] = ["res_id": "\(resId)"]
        let headers: HTTPHeaders = Settings.userKey
        AF.request(url, method: .get, parameters: parameters, encoding:  URLEncoding.queryString, headers: headers).validate()
            .responseDecodable(of: Restaurant.self) { response in
                guard let restaurant = response.value else { return }
                completionHandler(restaurant)
            }
    }
    
    static func restaurants(resIds:[String], completionHandler: @escaping(Restaurants) -> Void) {
        var count = resIds.count
        var restaurants:[RestaurantElement] = []
        for resId: String in resIds {
            restaurant(resId: resId) { restaurant in
                let element:RestaurantElement  = RestaurantElement(element: restaurant)
                restaurants.append(element)
                count -= 1
                if (count == 0) {
                    let result: Restaurants = Restaurants(results_found: resIds.count, results_start: 0, results_shown: 0, all: restaurants)
                    completionHandler(result)
                }
            }
        }
    }
    
}
