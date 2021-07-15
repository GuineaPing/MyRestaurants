//
//  Displayable.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 09.07.2021.
//

protocol RestaurantDisplayable {
    var labelId: String { get }
    var labelTitle: String { get }
    var labelUrl: String { get }
    var labelAddress: String { get }
    var labelLatitude: Double { get }
    var labelLongitude: Double { get }
    var labelTotalReviews: Int { get }
    var labelCuisines: String { get }
    var labelTimings: String { get }
    var labelHighlights: [String] { get }
}
