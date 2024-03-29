//
//  ViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.06.2022.
//

import UIKit
import CoreLocation

enum TemperatureType {
    case celsius
    case fahrenheit
}

// MARK: - Class

class MainViewController: UIViewController {
    
    // MARK: - Private properties
    
    private let locationService = LocationService()
    //let languageDevice = Locale.preferredLanguages[0]
    var locationName = "" //вынеси в отдельный класс
    private var firstLoading: Bool = true
    var loadingLocation: Bool = true
    
    private let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
    private var temperatureType = TemperatureType.celsius
    
    private var weatherForecastData: WeatherForecastData?
    private var weatherCurrentData: WeatherCurrentData?
    
    private lazy var tableView = MainTableView()
    private lazy var collectionView = MainCollectionView()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .white
        return refreshControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.refreshControl = refreshControl
        //        scrollView.refreshControl?.addTarget(self.locationService, action: #selector(locationService.startLocationManager), for: .valueChanged)
        scrollView.refreshControl?.addTarget(self, action: #selector(updateWeatherInfo), for: .valueChanged)
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.contentSize = CGSize(
            width: stackView.frame.size.width,
            height: scrollView.getHeightFromDisplay(displayHeight: view.frame.size.height))
        scrollView.bounces = true
        return scrollView
    }()
    
    private lazy var locationLabel: UILabel = {
        let locationLabel = UILabel()
        locationLabel.drawLabel(fontSize: 35, weight: .medium)
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
        return stackView
    }()
    
    private lazy var stackViewForLogo: UIStackView = {
        var stackView = UIStackView()
        stackView = UIStackView(arrangedSubviews: [
            openWeatherLabel,
            openWeatherLogo
        ])
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fillEqually
        stackView.alignment = UIStackView.Alignment.center
        return stackView
    }()
    
    private lazy var openWeatherLogo: UIImageView = {
        let openWeatherLogo = UIImageView()
        openWeatherLogo.image = UIImage(named: "logo")
        openWeatherLogo.contentMode = .scaleAspectFit
        return openWeatherLogo
    }()
    
    private lazy var openWeatherLabel: UILabel = {
        let openWeatherLabel = UILabel()
        openWeatherLabel.text = "Powered by OpenWeatherMap.org"
        openWeatherLabel.textColor = .white
        openWeatherLabel.drawLabel(fontSize: 15, weight: .light)
        return openWeatherLabel
    }()
    
    // MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if loadingLocation { locationService.startLocationManager() }
        hideViewsWhenLoading(getWeatherData: false)
        locationService.delegate = self
        setupNavigationBar()
        scrollView.addSubview(collectionView)
        scrollView.addSubview(tableView)
        scrollView.addSubview(stackViewForLogo)
        setupSubviews(stackView, scrollView)
        setConstraits()
        assignbackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !firstLoading || !loadingLocation { updateWeatherInfo() } //getLoactionName()
    }
    
    // MARK: - Private methods
    
    private func setupNavigationBar() {
        rightBarButtonItem(iconNameButton: "gearshape", selector: #selector(moveToSettingsVC))
        leftBarButtonItem(iconNameButton: "line.horizontal.3", selector: #selector(moveToLocationsVC))
        let backButton = UIBarButtonItem()
        backButton.title = ""
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.tintColor = .white
        
    }
    
    private func setConstraits() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        stackViewForLogo.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
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
            collectionView.heightAnchor.constraint(equalTo: tableView.heightAnchor, multiplier: 1/4),
            
            stackViewForLogo.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 5),
            stackViewForLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackViewForLogo.widthAnchor.constraint(equalTo: tableView.widthAnchor),
            stackViewForLogo.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    @objc private func moveToSettingsVC() {
        let settingsVC = SettingsViewController()
        settingsVC.onClose = { returnValue in
            print(returnValue)
            self.temperatureType = returnValue
        }
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    
    @objc private func moveToLocationsVC() {
        let locationsVC = LocationsViewController()
        locationsVC.weatherData = weatherForecastData
        locationsVC.locationName = self.locationName
        self.navigationController?.pushViewController(locationsVC, animated: true)
        //self.transitionVc(vc: locationsVC, duration: 0.5, type: .fromLeft)
    }
    
    func updateLabels() {
        locationLabel.text = locationName
        //locationLabel.text = weatherCurrentData?.name ?? "ERROR"
        tempLabel.text = Double(weatherForecastData?.current.temp ?? 0).temperatureValue
        weatherDescriptionLabel.text = weatherForecastData?.current.weather[0].description.capitalizedSentence
        //weatherDescriptionLabel.text = WeatherConditions.weatherIDs[weatherForecastData?.current.weather[0].id ?? 200]
        weatherFeelsLike.text = "Feels like: " + (weatherForecastData?.current.feelsLike ?? 0).temperatureValue
        backgroundImage.updateBackgroundImage(id: weatherForecastData?.current.weather[0].id ?? 200)
    }
    
    private func assignbackground() {
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    }
    
    //@objc private func updateWeatherInfo(latitude: Double, longitude: Double) {
    @objc private func updateWeatherInfo() {
        let urlForecastDaily = WeatherApi.shared.apiForecastDaily()
        
        NetworkManager.shared.fetchData(from: urlForecastDaily) { [weak self] (result: Result<WeatherForecastData, Error>) in
            switch result {
            case .success(let weatherData):
                self?.weatherForecastData = weatherData
                self?.tableView.setData(weatherData: weatherData)
                self?.collectionView.setData(weatherData: weatherData)
                self?.updateLabels()
                self?.tableView.reloadData()
                self?.collectionView.reloadData()
                self?.hideViewsWhenLoading(getWeatherData: true)
                self?.firstLoading = false
                print(urlForecastDaily)
                print(self?.weatherForecastData?.current.weather[0].id ?? "no id")
            case .failure(let error): print(error.localizedDescription)
            }
        }
        refreshControl.endRefreshing()
        print("latitude: " + WeatherApi.shared.latitude.description)
        print("longitude: " + WeatherApi.shared.longitude.description)
    }
    
    private func rightBarButtonItem(iconNameButton: String, selector: Selector) {
        let button = UIButton()
        button.frame = CGRect(x: -20, y: 0, width: 50, height: 50)
        button.setImage(UIImage(systemName: iconNameButton), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        let buttonBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = buttonBarButton
    }
    
    private func leftBarButtonItem(iconNameButton: String, selector: Selector) {
        let button = UIButton()
        button.frame = CGRect(x: -20, y: 0, width: 50, height: 50)
        button.setImage(UIImage(systemName: iconNameButton), for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.imageView?.contentMode = .scaleAspectFit
        let buttonBarButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItem = buttonBarButton
    }
    
    private func hideViewsWhenLoading(getWeatherData: Bool) {
        if getWeatherData {
            tableView.isHidden = false
            collectionView.isHidden = false
            openWeatherLogo.isHidden = false
            openWeatherLabel.isHidden = false
        } else {
            UIView.animate(withDuration: 0.2) {
                self.tableView.isHidden = true
                self.collectionView.isHidden = true
                self.openWeatherLogo.isHidden = true
                self.openWeatherLabel.isHidden = true
            }
        }
    }
    
    private func getLoactionName() {
        let currentLocation = CLLocation(latitude: WeatherApi.shared.latitude, longitude: WeatherApi.shared.longitude)
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(currentLocation, preferredLocale: Locale.current) {
            (placemarks, error) in
            if let error = error {
                print("Unable to Reverse Geocode Location (\(error))")
            } else {
                if let placemarks = placemarks {
                    let locality = placemarks[0].locality
                    self.locationName = locality ?? "No Data"
                }
            }
        }
    }
}

// MARK: - UIScrollViewDelegate

extension MainViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if scrollView.contentOffset.y > 20 {
            
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.weatherFeelsLike.text = ""
                self.tempLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
                self.stackView.spacing = 0
                self.locationLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            }
        } else {
            UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
                self.stackView.spacing = 5
                self.updateLabels()
                self.tempLabel.font = UIFont.systemFont(ofSize: 80, weight: .medium)
                self.locationLabel.font = UIFont.systemFont(ofSize: 35, weight: .medium)
            }
        }
    }
}

// MARK: - LocationManagerProtocol

extension MainViewController: LocationManagerProtocol {
    func newLocationReceived(location: CLLocation) {
        WeatherApi.shared.latitude = location.coordinate.latitude
        WeatherApi.shared.longitude = location.coordinate.longitude
//        latitude = location.coordinate.latitude
//        longitude = location.coordinate.longitude
        updateWeatherInfo()
        getLoactionName()
        }
    }

