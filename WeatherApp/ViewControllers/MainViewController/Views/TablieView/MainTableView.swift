//
//  UITableView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 12.08.2022.
//

import UIKit

// MARK: - Class

class MainTableView: UITableView {
    
    // MARK: - Private properties
    
    private var weatherData: WeatherForecastData?
    
    // MARK: - Initializers
    
    init() {
        
        super.init(frame: .zero, style: .plain)
        
        //Configure TableView
        register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.reuseID)
        register(MainTableViewHeader.self, forHeaderFooterViewReuseIdentifier: MainTableViewHeader.reuseID)
        self.dataSource = self
        self.delegate = self
        self.isScrollEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Internal methods
    
    func setData(weatherData: WeatherForecastData) {
        self.weatherData = weatherData
    }
    
}

// MARK: - UITableViewDataSource

extension MainTableView: UITableViewDataSource {
    
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
            withIdentifier: MainTableViewCell.reuseID,
            for: indexPath) as? MainTableViewCell else {
            fatalError("DequeueReusableCell failed while casting")
        }
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        cell.weatherDay.text = indexPath.row != 0 ? DateFormatter.getDateString(from: weatherData?.daily[indexPath.row].dt ?? 0, dateFormat: "E, d.MM"): "Today"
        cell.weatherTempMinMax.text = Double(weatherData?.daily[indexPath.row].temp.min ?? 0).temperatureValue +
        "..." + Double(weatherData?.daily[indexPath.row].temp.max ?? 0).temperatureValue
        cell.weatherImage.image = UIImage(systemName: WeatherImages.iconIDs[(weatherData?.daily[indexPath.row].weather[0].icon) ?? "50d"] ?? "cloud.bolt.fill")?.withRenderingMode(.alwaysOriginal)
        return cell
    }

}

// MARK: - UITableViewDelegate

extension MainTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: MainTableViewHeader.reuseID)
        return header
    }
    
}
