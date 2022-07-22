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
        locationLabel.drawLabel(fontSize: 40)
        locationLabel.drawShadow()
        return locationLabel
    }()
    
    private lazy var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.drawLabel(fontSize: 80)
        tempLabel.drawShadow()
        return tempLabel
    }()
    
    private lazy var weatherDescriptionLabel: UILabel  = {
        let weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.drawLabel(fontSize: 20)
        weatherDescriptionLabel.drawShadow()
        return weatherDescriptionLabel
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let weatherIcon = UIImageView()
        weatherIcon.drawShadow()
        return weatherIcon
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalSpacing
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        
        stackView.addArrangedSubview(locationLabel)
        stackView.addArrangedSubview(tempLabel)
        stackView.addArrangedSubview(weatherDescriptionLabel)
        stackView.addArrangedSubview(weatherIcon)
        
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLocationManager()
        //assignbackground()
        setupSubviews(stackView)
        setConstraits()
    }
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraits() {
            stackView.translatesAutoresizingMaskIntoConstraints = false
//        locationLabel.translatesAutoresizingMaskIntoConstraints = false
//        tempLabel.translatesAutoresizingMaskIntoConstraints = false
//        weatherDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
//        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 100),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //stackView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
//            locationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            locationLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
//            locationLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10),
//
//            tempLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            tempLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 5),
//            //tempLabel.heightAnchor.constraint(equalTo: locationLabel.heightAnchor),
//
//            weatherDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            weatherDescriptionLabel.topAnchor.constraint(equalTo: tempLabel.bottomAnchor, constant: 5),
//            //weatherDescriptionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10),
//
//            weatherIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            weatherIcon.topAnchor.constraint(equalTo: weatherDescriptionLabel.bottomAnchor, constant: 5),
//            //weatherIcon.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/10)
        ])
    }
    
    private func updateLabels() {
        locationLabel.text = weatherData?.name ?? "ERROR"
        tempLabel.text = checkTemp(weatherData?.main.temp ?? 0)
        weatherDescriptionLabel.text = weatherConditions.weatherIDs[weatherData?.weather[0].id ?? 200]
        weatherIcon.image = UIImage(named: weatherData?.weather[0].icon ?? "ERROR")
        assignbackground()
    }
    
    private func checkTemp(_ temp: Double) -> String {
        if temp > 0 {
            return "+" + "\(Int(temp))" + "\u{00B0}"
        } else if temp == 0 {
            return "0" + "\u{00B0}"
        } else {
            return "\(Int(temp))" + "\u{00B0}"
        }
    }
    
    private func assignbackground() {
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = updateBackgroundImage(id: weatherData?.weather[0].id ?? 200)
        //#imageLiteral(resourceName: "darkCloudy")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    
    private func startLocationManager() {
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
            locationManager.pausesLocationUpdatesAutomatically = true
            locationManager.startUpdatingLocation()
        }
    }
    
    private func updateWeatherInfo(latitude: Double, longitude: Double) {
        let urlWithCoordinates = "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude.description)&lon=\(longitude.description)&units=metric&lang=ru&appid=edfe94b1ee9b1f9ceecd7596d2f66b06"
        
        NetworkManager.shared.fetchData(from: urlWithCoordinates) { weatherData in
            self.weatherData = weatherData
            self.updateLabels()
            print(self.weatherData ?? "ERROR")
        }
    }
    private func updateBackgroundImage(id: Int) -> UIImage {
        var backgroundImage = UIImage(#imageLiteral(resourceName: "back_weather"))
        if id >= 800 {
            backgroundImage = UIImage(#imageLiteral(resourceName: "darkCloudy"))
        } else if id < 300 {
            backgroundImage = UIImage(#imageLiteral(resourceName: "storm"))
        } else if id > 300 && id <= 531 {
            backgroundImage = UIImage(#imageLiteral(resourceName: "rainy"))
        }
        return backgroundImage
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
    func drawShadow(offset: CGSize = CGSize(width: 5, height: 5), opacity: Float = 0.1, color: UIColor = .black, radius: CGFloat = 1) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}
extension UILabel {
    func drawLabel(textColor: UIColor = .white, fontSize: CGFloat, adjustsFontSizeToFitWidth: Bool = true, numberOfLines: Int = 0, minimumScaleFactor: CGFloat = 0.5, baselineAdjustment: UIBaselineAdjustment = .alignCenters, textAlignment: NSTextAlignment = .center) {
        self.textColor = textColor
        self.font = self.font.withSize(fontSize)
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.numberOfLines = numberOfLines
        self.minimumScaleFactor = minimumScaleFactor
        self.baselineAdjustment = baselineAdjustment
        self.textAlignment = textAlignment}
}
