//
//  Settings.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 10.07.2021.
//

import Alamofire

struct Settings {
    static let baseUrl: String = "https://developers.zomato.com/api/v2.1/"
    static let userKeyVal: String = "2b3a8c2baa6d953047bc375668d2988a"
    static let userKey: HTTPHeaders = ["user-key":userKeyVal]
    static let favoritesName: String = "FavoritesStringArray"
 }
