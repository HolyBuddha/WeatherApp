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
    private var tableView = UITableView()
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
        stackView = UIStackView(arrangedSubviews: [locationLabel, tempLabel, weatherDescriptionLabel, weatherIcon, tableView])
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.fill
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 5
        stackView.setCustomSpacing(20, after: weatherIcon)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.setTableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        //tableView.rowHeight = 45
        tableView.tableFooterView = UIView()
        startLocationManager()
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
        //tableView.translatesAutoresizingMaskIntoConstraints = false
        
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
        //let urlWithCoordinates = url.apiForCurrentWeather(latitude: latitude, longitude: longitude, units: Units.metric)
        let urlWithCoordinates = url.apiForecastFor5Days(latitude: latitude, longitude: longitude, units: Units.metric)
        NetworkManager.shared.fetchData(from: urlWithCoordinates) { weatherData in
            print(latitude)
            print(longitude)
            self.weatherData = weatherData
            self.updateLabels()
            self.tableView.reloadData()
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

extension MainViewController {
    
    func dateFromUnix(date: Double, dateFormat: String) -> String {
        let date = NSDate(timeIntervalSince1970: date)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat
        let result = dayTimePeriodFormatter.string(from: date as Date)
        return result
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

extension MainViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData?.list.count ?? 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        tableView.backgroundColor = UIColor.clear
        tableView.layer.cornerRadius = 20
        //tableView.clipsToBounds = true
        tableView.layer.borderColor = CGColor(gray: 1, alpha: 0.5)
        tableView.layer.borderWidth = 1
        cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor(white: 0.7, alpha: 0.5)
        //cell.weatherTemp.text = weatherData?.list[indexPath.row].dt.description
        cell.weatherDay.text = dateFromUnix(date: weatherData?.list[indexPath.row].dt ?? 0, dateFormat: "E d MM")
        cell.weatherTempMinMax.text = checkTemp(weatherData?.list[indexPath.row].main.tempMin ?? 0) +
        " ... " + checkTemp(weatherData?.list[indexPath.row].main.tempMax ?? 0)
        cell.weatherImage.image = UIImage(named: weatherData?.list[indexPath.row].weather[0].icon ?? "ERROR")
//        var content = cell.defaultContentConfiguration()
//        content.textProperties.color = .white
//        content.text = weatherData?.list[indexPath.row].main.temp.description
//        content.secondaryText = weatherData?.list[indexPath.row].main.humidity.description
//        content.image = UIImage(systemName: "sun.min")
//        content.imageProperties.tintColor = .white
//        cell.contentConfiguration = content
        return cell
    }
}


