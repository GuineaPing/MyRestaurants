//
//  RestaurantViewController.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 14.07.2021.
//

import UIKit
import MapKit

class RestaurantViewController: BaseTableViewController {

    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelLocation: UILabel!
    @IBOutlet weak var labelCuisines: UILabel!
    @IBOutlet weak var labelTimings: UILabel!
    @IBOutlet weak var labelHighlights: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var restaurants: [RestaurantDisplayable] = []
    var resId = ""
    var resTitle = ""
    var resUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBackButton()
        initControls()
        initSwipe()
        initData()
        
    }
    
    // MARK: - inits
    
    func initControls() {
        title = "Restauraunt details"
    }

    func initData() {
        guard (restaurants.count == 1) else {
            return
        }
        let restaurant: RestaurantDisplayable = restaurants[0]
        
        resId = restaurant.labelId
        resTitle = restaurant.labelTitle
        resUrl = restaurant.labelUrl
        
        labelTitle.text = restaurant.labelTitle
        labelLocation.text = restaurant.labelAddress
        labelCuisines.text = restaurant.labelCuisines
        labelTimings.text = restaurant.labelTimings
        labelHighlights.text = restaurant.labelHighlights.joined(separator:"\n")
        
        initMap(latitude: restaurant.labelLatitude, longitude: restaurant.labelLongitude)
    }
    
    func initMap(latitude: Double, longitude: Double) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapView.setRegion(region, animated: true)
        let annotation = MKPointAnnotation();
        annotation.coordinate = CLLocationCoordinate2DMake(latitude, longitude);
        mapView.addAnnotation(annotation);
    }
    
    // MARK: - navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            case Settings.segueReviews: do {
                guard let vc = segue.destination as? ReviewsViewController else {
                  return
                }
                vc.resId = resId
                vc.resTitle = resTitle
            }
            case Settings.segueMap: do {
                guard let vc = segue.destination as? MapViewController else {
                  return
                }
                vc.data = restaurants
                if let resId: String  = sender as? String {
                    vc.resId = resId
                }
            }
            case .none: do {
                }
            case .some(_): do {
                }
            }
    }
    
    
    // MARK: - actions
    
    @IBAction func actionReviews(_ sender: Any) {
        performSegue(withIdentifier: Settings.segueReviews, sender: nil)
    }
    
    @IBAction func actionUrl(_ sender: Any) {
        let url: URL = URL(string: resUrl)!
        print(resUrl)
        UIApplication.shared.open(url , options: [:], completionHandler: nil)
    }
    
}

