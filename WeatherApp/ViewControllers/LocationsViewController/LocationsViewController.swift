//
//  LocationsTableViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 10.09.2022.
//

import UIKit

// MARK: - Class

class LocationsViewController: UIViewController {
    
    // MARK: - Internal properties
    
    var weatherData: WeatherForecastData?
    var geoData: Geocoding?
    //var geoCodingData: WeatherGeocodingData?
    var locationName = ""
    
    // MARK: - Private  properties
    
    private lazy var tableView = LocationsTableView()
    private lazy var tableViewWithCities = UITableView()
    private lazy var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.placeholder = "City"
        searchBar.searchTextField.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        searchBar.barTintColor = .black
        let image = UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        UISearchBar.appearance().setImage(image, for: .search, state: .normal)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        return searchBar
    }()
    
    // MARK: - Life Cycles Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.setData(weatherData: weatherData!.current)
        tableView.setLocationName(locationName: locationName)
        setupSubviews(searchBar, tableView)
        setConstraits()
        setupNavigationBar()
        view.backgroundColor = .black
    }
    
    // MARK: - Private  methods
    
    private func setConstraits() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchBar.leftAnchor.constraint(equalTo: view.leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupNavigationBar() {
        title = "Избранное"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController?.view.backgroundColor = .clear
    }
}

extension LocationsViewController: UISearchBarDelegate {

func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
    //let urlGeocodingByCity = WeatherApi.shared.apiForecastDaily(latitude: 55, longitude: 37)
    let urlGeocodingByCity = WeatherApi.shared.apiGeocodingByCity(city: searchBar.text!)
    print(urlGeocodingByCity)
        
    NetworkManager.shared.fetchData(from: urlGeocodingByCity) { (result: Result<Geocoding, Error>) in
        switch result {
        case .success(let geoData):
            self.geoData = geoData
            print("\(geoData[0].name) " + "lat: \(geoData[0].latitude)  " + "lon: \(geoData[0].longitude)")
            let mainVC = MainViewController()
            mainVC.loadingLocation = false
            mainVC.latitude = geoData[0].latitude
            mainVC.longitude = geoData[0].longitude
            self.navigationController?.pushViewController(mainVC, animated: true)
        case .failure(let error):
            print(error.localizedDescription)
        }
        
//        let urlForecastDaily = WeatherApi.shared.apiForecastDaily(latitude: self.geoData?[0].latitude ?? 0, longitude: self.geoData?[0].longitude ?? 0)
//
//        NetworkManager.shared.fetchData(from: urlForecastDaily) { (result: Result<WeatherForecastData, Error>) in
//            switch result {
//            case .success(let weatherData):
//                //self.tableView.setData(weatherData: weatherData.current)
//                //self.tableView.reloadData()
//                let mainVC = MainViewController()
//                mainVC.weatherForecastData = weatherData
//                self.navigationController?.pushViewController(mainVC, animated: true)
//            case .failure(let error):
//                print(error.localizedDescription)
            }
        }
}


