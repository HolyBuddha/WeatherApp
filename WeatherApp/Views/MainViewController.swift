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
        
        //Configure TableView
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: "header")
        tableView.dataSource = self
        tableView.delegate = self
        //tableView.isScrollEnabled = false
        tableView.drawShadow()

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
        let urlWithCoordinates = url.apiForecastFor5Days(latitude: latitude, longitude: longitude, units: Units.metric)
        NetworkManager.shared.fetchData(from: urlWithCoordinates) { weatherData in
            print(latitude)
            print(longitude)
            self.weatherData = weatherData
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

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData?.list.count ?? 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        tableView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        tableView.layer.cornerRadius = 20
        //tableView.clipsToBounds = true
        tableView.layer.borderColor = CGColor(gray: 1, alpha: 0.5)
        tableView.layer.borderWidth = 1
        //cell.contentView.backgroundColor = UIColor.clear
        cell.backgroundColor = UIColor.clear
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header")
        return header
    }
   
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        "Прогноз на 5 дней"
//    }
//    }
////
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 20
        }
////
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//         let headerView = UIView.init(frame: CGRect(x: 0, y: 0, width: 90, height: 90))
//         let headerCell = tableView.dequeueReusableCell(withIdentifier: "cell")
//                    let label = UILabel()
//                    label.frame = CGRect.init(x: 5, y: 5, width: 50, height: 50)
//                    label.text = "Notification Times"
//                    label.font = .systemFont(ofSize: 16)
//                    label.textColor = .yellow
//         headerCell?.frame = headerView.bounds
//         headerView.addSubview(label)
//         return headerView
//}


}
