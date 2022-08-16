//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.06.2022.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController {
    
    private var locationManager = CLLocationManager()
    private var weatherData: WeatherForecastData?
    private var url = WeatherApi()
    private var tableView = TableView()
    private var coordinates = CLLocation()
    
    
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
        //weatherIcon.contentMode = .scaleAspectFill
        return weatherIcon
        
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [locationLabel, tempLabel, weatherDescriptionLabel, tableView])
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        stackView.setCustomSpacing(50, after: weatherDescriptionLabel)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startLocationManager()
//        setupSubviews(stackView)
//        setConstraits()
    }
    
    override func viewWillLayoutSubviews() {
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
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(lessThanOrEqualTo: view.topAnchor, constant: 100),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            tableView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            tableView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1/3)
        ])
    }
    
    private func updateLabels() {
        locationLabel.text = weatherData?.city.name ?? "ERROR"
        tempLabel.text = checkTemp(weatherData?.list.first?.main.temp ?? 0)
        weatherDescriptionLabel.text = weatherConditions.weatherIDs[weatherData?.list.first?.weather[0].id ?? 200]
        weatherIcon.image = UIImage(named: weatherData?.list.first?.weather[0].icon ?? "ERROR")
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
        backgroundImage.image = updateBackgroundImage(id: weatherData?.list.first?.weather[0].id ?? 200)
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
        let urlWithCoordinates = url.apiForecastFor5Days(latitude: latitude, longitude: longitude, units: Units.metric)
        NetworkManager.shared.fetchData(from: urlWithCoordinates) { weatherData in
            print(latitude)
            print(longitude)
            self.weatherData = weatherData
            self.tableView.setData(weatherData: weatherData)
            self.updateLabels()
            self.tableView.reloadData()
            //self.tableView.tableHeaderView = self.headerForTableView
            print(self.weatherData?.list ?? "ERROR")
        }
    }
    
    private func updateBackgroundImage(id: Int) -> UIImage {
        switch id {
        case 800 : return UIImage(#imageLiteral(resourceName: "back_weather"))
        case 801... : return UIImage(#imageLiteral(resourceName: "darkCloudy"))
        case ...300 : return UIImage(#imageLiteral(resourceName: "storm"))
        default:
            return UIImage(#imageLiteral(resourceName: "rainy"))
        }
    }
}

extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let lastLocation = locations.last {
            locationManager.stopUpdatingLocation()
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
            
        }
    }
}

