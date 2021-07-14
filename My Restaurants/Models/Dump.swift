//
//  Dumper.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 11.07.2021.
//

import Foundation

class Dump {

    static func restaurants(start:Int = 0, dataItems:[RestaurantDisplayable]) {
        var ind:Int = start
        for item in dataItems {
            print ("\(ind): \(item.labelId)")
            ind += 1
        }
    }

}
