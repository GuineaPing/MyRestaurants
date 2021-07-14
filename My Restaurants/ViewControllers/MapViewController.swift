//
//  MapViewController.swift
//  My Restaurants
//
//  Created by Eugene Lysenko on 14.07.2021.
//

import UIKit
import MapKit


class MapViewController: BaseViewController, MKMapViewDelegate {
    
    @IBOutlet var mapView: MKMapView!
    
    var data: [RestaurantDisplayable] = []
    var resId: String? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        initBackButton()
        initMap()
        
    }
    
    // MARK: - init
    
    func initMap() {
        
        guard data.count > 0 else {
            return
        }
        mapView.delegate = self
        
        if (resId == nil) {
            initAnnotations()
        } else {
            initForLocation()
        }
        
    }
    
    func initForLocation() {
        
        for item: RestaurantDisplayable in data {
            if (item.labelId == resId) {
                title = item.labelName
                initCenter(latitude: item.labelLatitude, longitude: item.labelLongitude)
            }
            let annotation = MKPointAnnotation();
            annotation.coordinate = CLLocationCoordinate2DMake(item.labelLatitude, item.labelLongitude);
            annotation.title = item.labelName
            mapView.addAnnotation(annotation);
        }
    }
    
    func initCenter(latitude: Double, longitude: Double) {
        let center = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        self.mapView.setRegion(region, animated: true)
    }
    
    func initAnnotations() {
        title = "Loaded \(data.count) locations"
        var annotations:[MKAnnotation] = []
        for item: RestaurantDisplayable in data {
            let annotation = MKPointAnnotation();
            annotation.coordinate = CLLocationCoordinate2DMake(item.labelLatitude, item.labelLongitude);
            annotation.title = item.labelName
            mapView.addAnnotation(annotation);
            annotations.append(annotation)
        }
        mapView.showAnnotations(annotations, animated: true)

    }
    
    
    
}
