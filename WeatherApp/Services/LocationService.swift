//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 29.07.2022.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {

    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocation?
    
    func startLocationManager() {
   
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = true
            locationManager.startUpdatingLocation()
        }
        
    }
}
    
    
extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation], completion: (_ lat: String, _ lng: String) -> Void) {
        if let lastLocation = locations.last {
            let latitude = String(lastLocation.coordinate.latitude )
            let longitude = String(lastLocation.coordinate.longitude )
            completion(latitude, longitude)
        }
    }
}
