//
//  LocationsTableView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 10.09.2022.
//

import UIKit

class LocationsTableView: UITableView, UITableViewDataSource, UITableViewDelegate {
    
    private var weatherData: [CurrentWeatherData] = []
    private var locationName = ""
    
    init() {
        
        super.init(frame: .zero, style: .plain)
        
        //Configure TableView
        
        register(LocationsTableViewCell.self, forCellReuseIdentifier: LocationsTableViewCell.reuseID)
        self.dataSource = self
        self.delegate = self
        self.isScrollEnabled = false
    }
    
    func setData(weatherData: CurrentWeatherData, locationName: String) {
        self.weatherData.append(weatherData)
        self.locationName = locationName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the Table
        tableView.backgroundColor = .black
        tableView.separatorColor = UIColor(white: 1, alpha: 0.5)
        
        // Configure the Cell
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: LocationsTableViewCell.reuseID,
            for: indexPath) as? LocationsTableViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        
        assignBackgroundImage(view: cell, indexPath: indexPath)
        cell.backgroundColor = UIColor.clear
        cell.locationName.text = locationName
        cell.weatherTempMinMax.text = Double(weatherData[indexPath.row].temp).temperatureValue
        cell.weatherImage.image = UIImage(systemName: WeatherImages.iconIDs[
            (weatherData[indexPath.row].weather[0].icon)
        ] ?? "pencil")?.withRenderingMode(.alwaysOriginal)
        return cell
    }
    
    private func assignBackgroundImage(view: UIView, indexPath: IndexPath) {
        let backgroundImage = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        backgroundImage.alpha = 0.5
        backgroundImage.clipsToBounds = true
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.updateBackgroundImage(id: weatherData[indexPath.row].weather[0].id)
        view.addSubview(backgroundImage)
        view.sendSubviewToBack(backgroundImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
