//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.06.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var weatherData: WeatherData?
    private var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocationManager()
    }
    
    func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = true
            locationManager.startUpdatingLocation()
        }
    }
    
    func updateWeatherInfo(latitude: Double, longitude: Double) {
        let urlWithCoordinates = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longitude.description)&units=metric&lang=ru&appid=edfe94b1ee9b1f9ceecd7596d2f66b06"
        
        NetworkManager.shared.fetchData(from: urlWithCoordinates) { weatherData in
            self.weatherData = weatherData
            print(self.weatherData ?? "Error")
        }
}
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
        }
    }
}
