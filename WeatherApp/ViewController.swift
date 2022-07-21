//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.06.2022.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    private var locationManager = CLLocationManager()
    private var weatherData: WeatherData?
    
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.textColor = .white
        locationLabel.font = locationLabel.font.withSize(40)
        locationLabel.drawShadow(offset: CGSize(width: 5, height: 5), opacity: 0.1)
        return locationLabel
    }()
    
    private lazy var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.textColor = .white
        tempLabel.font = tempLabel.font.withSize(80)
        tempLabel.drawShadow(offset: CGSize(width: 5, height: 5), opacity: 0.1)
        return tempLabel
    }()
    
    private lazy var weatherDescriptionLabel: UILabel  = {
        let weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.textColor = .white
        weatherDescriptionLabel.font = weatherDescriptionLabel.font.withSize(20)
        weatherDescriptionLabel.drawShadow(offset: CGSize(width: 5, height: 5), opacity: 0.1)
        return weatherDescriptionLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocationManager()
        assignbackground()
        setupSubviews(locationLabel, tempLabel, weatherDescriptionLabel)
        setConstraits()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
        
    }
    
    private func setConstraits() {
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tempLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weatherDescriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5)
        ])
    }
    
    private func updateLabels() {
        locationLabel.text = weatherData?.name ?? "ERROR"
        tempLabel.text = checkTemp(weatherData?.main.temp ?? 0)
        weatherDescriptionLabel.text = DataSource.weatherIDs[weatherData?.weather[0].id ?? 200]
        //String(Int(weatherData?.main.temp ?? 0))
    }
    
    private func checkTemp(_ temp: Double) -> String {
        if temp > 0 { return "+" + "\(Int(temp))" + "\u{00B0}"
        } else if temp == 0 {  return "0" + "\u{00B0}"
        } else { return "+" + "\(Int(temp))" + "\u{00B0}"
        }
    }
    
    func assignbackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = #imageLiteral(resourceName: "back_weather")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
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
            self.updateLabels()
            print(self.weatherData ?? "ERROR")
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

extension UIView {
    func drawShadow(offset: CGSize, opacity: Float = 0.25, color: UIColor = .black, radius: CGFloat = 1) {
           layer.masksToBounds = false
           layer.shadowColor = color.cgColor
           layer.shadowOffset = offset
           layer.shadowOpacity = opacity
           layer.shadowRadius = radius
       }
}
