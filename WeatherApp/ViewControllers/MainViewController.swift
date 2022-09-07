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
    private let geocoder = CLGeocoder()
    private var locationName = ""
    
    private var weatherForecastData: WeatherForecastData?
    private var weatherCurrentData: WeatherCurrentData?
    
    private let coordinates = CLLocation()
    private let url = WeatherApi()
    
    private lazy var tableView = TableView()
    private lazy var collectionView = CollectionView()
    
    
    private lazy var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.delegate = self
        scroll.showsVerticalScrollIndicator = false
        scroll.contentSize = CGSize(
            width: stackView.frame.size.width,
            height: scroll.getHeightFromDisplay(displayHeight: view.frame.size.height))
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
        setupNavigationBar()
        scrollView.addSubview(collectionView)
        scrollView.addSubview(tableView)
        setupSubviews(stackView, scrollView)
        setConstraits()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setupNavigationBar()
    }
    
        private func setupNavigationBar() {
            
            rightBarButtonItem(iconNameButton: "gearshape", selector: #selector(updateLabels))
            leftBarButtonItem(iconNameButton: "line.horizontal.3", selector: #selector(updateLabels))
            //title = "Task List"
            //navigationController?.navigationBar.prefersLargeTitles = false
    
            //let navBarAppearance = UINavigationBarAppearance()
    
//            navBarAppearance.backgroundColor = .clear
//            navBarAppearance.configureWithOpaqueBackground()
//            navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.blue]
//            navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.blue]
    
//            navigationItem.rightBarButtonItem = UIBarButtonItem(
//                barButtonSystemItem: .edit,
//                target: self,
//                action: #selector(updateLabels)
//            )
            //navigationItem.rightBarButtonItem?.image = UIImage(systemName: "pencil")
            navigationController?.view.backgroundColor = .clear
            navigationController?.navigationBar.tintColor = .white
//            navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//            navigationController?.navigationBar.shadowImage = UIImage()
//            navigationController?.navigationBar.isTranslucent = true
            //navigationController?.navigationBar.standardAppearance = navBarAppearance
            //navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
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

            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: scrollView.topAnchor, constant: 40),
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
    
   @objc private func updateLabels() {
        locationLabel.text = locationName
        //locationLabel.text = weatherCurrentData?.name ?? "ERROR"
        tempLabel.text = checkTemp(weatherForecastData?.current.temp ?? 0)
        weatherDescriptionLabel.text = weatherConditions.weatherIDs[weatherForecastData?.current.weather[0].id ?? 200]
        weatherFeelsLike.text = "Ощущается как: " + checkTemp(weatherForecastData?.current.feelsLike ?? 0)
        print(weatherForecastData?.current.weather[0].id ?? "no id")
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
        backgroundImage.image = updateBackgroundImage(id: weatherForecastData?.current.weather[0].id ?? 200)
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
        let urlForecastDaily = url.apiForecastDaily(latitude: latitude, longitude: longitude, units: .metric)
        let urlCurrentWeather = url.apiForCurrentWeather(latitude: latitude, longitude: longitude)
        
        NetworkManager.shared.fetchData(from: urlCurrentWeather) { (weatherData: WeatherCurrentData) in
            self.weatherCurrentData = weatherData
        }
        NetworkManager.shared.fetchData(from: urlForecastDaily) { (weatherData: WeatherForecastData) in
            self.weatherForecastData = weatherData
            self.tableView.setData(weatherData: weatherData)
            self.collectionView.setData(weatherData: weatherData)
            self.updateLabels()
            self.tableView.reloadData()
            self.collectionView.reloadData()
        }
        print(urlForecastDaily)
        print(urlCurrentWeather)
        print("latitude: " + latitude.description)
        print("longitude: " + longitude.description)
    }
    
    private func updateBackgroundImage(id: Int) -> UIImage {
        switch id {
        case 800 : return UIImage(#imageLiteral(resourceName: "cleanSky"))
        case 801...802: return UIImage(#imageLiteral(resourceName: "littleCloudy"))
        case 803...804 : return UIImage(#imageLiteral(resourceName: "darkCloudy"))
        case ...232 : return UIImage(#imageLiteral(resourceName: "storm"))
        default:
            return UIImage(#imageLiteral(resourceName: "rainy"))
        }
    }
    
    private func rightBarButtonItem(iconNameButton: String, selector: Selector) {
        let button = UIButton()
        button.frame = CGRect(x: -20, y: 0, width: 50, height: 50)
        //button.backgroundColor = .orange
        button.setImage(UIImage(systemName: iconNameButton), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        //button.backgroundColor = .orange
        
        let buttonBarButton = UIBarButtonItem(customView: button)
        //let buttonBarButton = UIBarButtonItem(customView: UIView(frame: CGRect(x: -20, y: -20, width: 30, height: 30)))
        //buttonBarButton.customView?.addSubview(button)
        //buttonBarButton.customView?.frame = button.frame

        self.navigationItem.rightBarButtonItem = buttonBarButton
    }
    
    private func leftBarButtonItem(iconNameButton: String, selector: Selector) {
        let button = UIButton()
        button.frame = CGRect(x: -20, y: 0, width: 50, height: 50)
        //button.backgroundColor = .orange
        button.setImage(UIImage(systemName: iconNameButton), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        let buttonBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = buttonBarButton
    }
}


extension MainViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //get coordinates
        if let lastLocation = locations.last {
            locationManager.stopUpdatingLocation()
            updateWeatherInfo(latitude: lastLocation.coordinate.latitude, longitude: lastLocation.coordinate.longitude)
            //get location name
            geocoder.reverseGeocodeLocation(lastLocation, preferredLocale: Locale.init(identifier: "ru_RU")) { placemarks, error in
                let locality = placemarks?[0].locality ?? (placemarks?[0].name ?? "Ошибка")
                self.locationName = locality
            }
        }
        
    }
}
extension MainViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        
        if scrollView.contentOffset.y > 20 {
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.weatherFeelsLike.text = ""
                self.tempLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
                self.stackView.spacing = 0
            }
        } else if scrollView.contentOffset.y < 20 && scrollView.contentOffset.y > -200 {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.stackView.spacing = 5
                self.updateLabels()
                self.tempLabel.font = UIFont.systemFont(ofSize: 80, weight: .medium)
                print("back")
            }
        } else {
            startLocationManager()
            print("update")
            }
        }
        //print(scrollView.contentOffset.y)
    }


