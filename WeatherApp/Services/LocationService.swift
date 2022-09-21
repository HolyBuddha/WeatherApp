//
//  LocationManager.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 29.07.2022.
//

import CoreLocation

// MARK: - LocationManagerProtocol

protocol LocationManagerProtocol: AnyObject {
    func newLocationReceived(location: CLLocation)
}

// MARK: - Class

class LocationService: NSObject {
    
    // MARK: - Internal properties
    
    weak var delegate: LocationManagerProtocol?
    
    // MARK: - Private properties
    
    private let locationManager = CLLocationManager()
    private var currentCoordinate: CLLocation?
    
    // MARK: - Internal methods
    
    @objc func startLocationManager() {
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = true
            locationManager.startUpdatingLocation()
        }
    }
}
// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            delegate?.newLocationReceived(location: lastLocation)
            print("loading location")
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed find location")
    }
}
