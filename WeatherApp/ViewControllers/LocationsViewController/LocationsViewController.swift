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
    var locationName: String = ""
    
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
        setupSubviews(searchBar, tableView)
        setConstraits()
        setupNavigationBar()
        view.backgroundColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.setData(weatherData: weatherData!.current) // исправь
        tableView.setLocationName(locationName: locationName)
        self.tableView.reloadData()
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
    
    private func moveToMainVC() {
        let mainVC = MainViewController()
        mainVC.loadingLocation = false
        mainVC.locationName = geoData?[0].name ?? "no data"
        self.navigationController?.pushViewController(mainVC, animated: true)
    }
}

extension LocationsViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let urlGeocodingByCity = WeatherApi.shared.apiGeocodingByCity(city: searchBar.text ?? "")
        print(urlGeocodingByCity)
        
        NetworkManager.shared.fetchData(from: urlGeocodingByCity) { [weak self] (result: Result<Geocoding, Error>) in
            switch result {
            case .success(let geoData):
                self?.geoData = geoData
                WeatherApi.shared.longitude = geoData[0].longitude
                WeatherApi.shared.latitude = geoData[0].latitude
                self?.moveToMainVC()
                print("\(geoData[0].name) " + "lat: \(geoData[0].latitude)  " + "lon: \(geoData[0].longitude)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


