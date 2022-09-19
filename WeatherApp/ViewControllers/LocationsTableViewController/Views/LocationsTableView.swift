//
//  LocationsTableView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 10.09.2022.
//

import UIKit

class LocationsTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    private var weatherData: WeatherForecastData?

    init() {
        
        super.init(frame: .zero, style: .plain)
        
        //Configure TableView
        
        register(LocationsTableViewCell.self, forCellReuseIdentifier: LocationsTableViewCell.reuseID)
        self.dataSource = self
        self.delegate = self
        self.isScrollEnabled = false
    }
    
    func setData(weatherData: WeatherForecastData) {
        self.weatherData = weatherData
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData?.daily.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the Table
        tableView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        tableView.layer.cornerRadius = 20
        tableView.layer.borderColor = CGColor(gray: 1, alpha: 0.5)
        tableView.layer.borderWidth = 1
        tableView.separatorColor = UIColor(white: 1, alpha: 0.5)
        
        // Configure the Cell
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LocationsTableViewCell.reuseID,
            for: indexPath) as? LocationsTableViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
