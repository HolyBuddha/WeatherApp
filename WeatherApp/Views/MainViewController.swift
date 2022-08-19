//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.06.2022.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, UIScrollViewDelegate {
    
    private let locationManager = CLLocationManager()
    private var weatherData: WeatherForecastData?
    private let url = WeatherApi()
    private let tableView = TableView()
    private let collectionView = CollectionView()
    private let coordinates = CLLocation()
    
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        func getHeightFromDisplay(displayHeight: Double) -> Double {
            var height: Double = 0
            print(displayHeight)
            if displayHeight < 560 {
                height = 950 - displayHeight
            } else if displayHeight < 850 {
                height = 950 - displayHeight
            } else {
                height = 950 - displayHeight
            }
            return displayHeight + height
        }
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = false
        scroll.contentSize = CGSize(
            width: stackView.frame.size.width,
            height: getHeightFromDisplay(displayHeight: view.frame.size.height))
        scroll.bounces = true
        return scroll
    }()
    
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.drawLabel(fontSize: 40, weight: .medium)
        locationLabel.drawShadow()
        return locationLabel
    }()
    
    private lazy var tempLabel: UILabel = {
        let tempLabel = UILabel()
        tempLabel.drawLabel(fontSize: 80, weight: .medium)
        tempLabel.drawShadow()
        return tempLabel
    }()
    
    private lazy var weatherDescriptionLabel: UILabel  = {
        let weatherDescriptionLabel = UILabel()
        weatherDescriptionLabel.drawLabel(fontSize: 20, weight: .medium)
        weatherDescriptionLabel.drawShadow()
        return weatherDescriptionLabel
    }()
    
    private lazy var weatherIcon: UIImageView = {
        let weatherIcon = UIImageView()
        weatherIcon.drawShadow()
        return weatherIcon
    }()
    
    private lazy var weatherFeelsLike: UILabel = {
        let weatherFeelsLike = UILabel()
        weatherFeelsLike.drawLabel(fontSize: 16, weight: .medium)
        weatherFeelsLike.drawShadow()
        return weatherFeelsLike
    }()
    
    private lazy var stackView: UIStackView = {
        var stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [
            locationLabel,
            tempLabel,
            weatherDescriptionLabel,
            weatherFeelsLike
    ])
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        //stackView.backgroundColor = .green
        //stackView.setCustomSpacing(view.frame.height / 20, after: weatherFeelsLike)
        //stackView.setCustomSpacing(view.frame.height / 20, after: collectionView)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startLocationManager()
        scrollView.addSubview(collectionView)
        scrollView.addSubview(tableView)
        setupSubviews(stackView, scrollView)
        setConstraits()
    }
    
    
    private func setupSubviews(_ subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func setConstraits() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
//            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//            stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
//            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
//            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 20),
            
            stackView.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.bottomAnchor, constant: 40),
            //stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
           
            
            scrollView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20),
            scrollView.heightAnchor.constraint(equalTo: view.heightAnchor),
            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scrollView.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            
            tableView.heightAnchor.constraint(equalToConstant: 480),
            tableView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20),
            
            collectionView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            collectionView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            collectionView.heightAnchor.constraint(equalTo: tableView.heightAnchor, multiplier: 1/3)
        ])
    }
    
    private func updateLabels() {
        locationLabel.text = weatherData?.timezone ?? "ERROR"
        tempLabel.text = checkTemp(weatherData?.current.temp ?? 0)
        weatherDescriptionLabel.text = weatherConditions.weatherIDs[weatherData?.current.weather[0].id ?? 200]
        //weatherIcon.image = UIImage(named: weatherData?.list.first?.weather[0].icon ?? "ERROR")
        weatherFeelsLike.text = "Ощущается как: " + checkTemp(weatherData?.current.feelsLike ?? 0)
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
        backgroundImage.image = updateBackgroundImage(id: weatherData?.current.weather[0].id ?? 200)
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
        let urlWithCoordinates = url.apiForecastDaily(latitude: latitude, longitude: longitude, units: .metric)
        NetworkManager.shared.fetchData(from: urlWithCoordinates) { weatherData in
            print(urlWithCoordinates)
            print("latitude: " + latitude.description)
            print("longitude: " + longitude.description)
            self.weatherData = weatherData
            self.tableView.setData(weatherData: weatherData)
            self.collectionView.setData(weatherData: weatherData)
            self.updateLabels()
            self.tableView.reloadData()
            //self.tableView.layoutIfNeeded()
            //self.tableView.heightAnchor.constraint(equalToConstant: self.tableView.contentSize.height).isActive = true
            self.collectionView.reloadData()
            //print(self.weatherData?.list.first ?? "ERROR")
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

