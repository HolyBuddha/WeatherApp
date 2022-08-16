//
//  UITableView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 12.08.2022.
//

import UIKit

class TableView: UITableView,UITableViewDataSource, UITableViewDelegate  {
    
    var weatherData: WeatherForecastData?
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        //Configure TableView
        register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseID)
        register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: TableViewHeader.reuseID)
        dataSource = self
        delegate = self
        isScrollEnabled = true
       
        drawShadow()
    }
    
    func setData(weatherData: WeatherForecastData) {
        self.weatherData = weatherData
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        weatherData?.takeDataFromArray().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Configure the Table
        tableView.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        tableView.layer.cornerRadius = 20
        tableView.layer.borderColor = CGColor(gray: 1, alpha: 0.5)
        tableView.layer.borderWidth = 1
        
        // Configure the Cell
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.reuseID, for: indexPath) as! TableViewCell
        cell.backgroundColor = UIColor.clear
        cell.weatherDay.text = weatherData?.takeDataFromArray()[indexPath.row]
        cell.weatherTempMinMax.text = checkTemp(weatherData?.list[indexPath.row].main.tempMin ?? 0) +
        " ... " + checkTemp(weatherData?.list[indexPath.row].main.tempMax ?? 0)
        cell.weatherImage.image = UIImage(named: weatherData?.list[indexPath.row].weather[0].icon ?? "ERROR")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewHeader.reuseID)
        return header
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

