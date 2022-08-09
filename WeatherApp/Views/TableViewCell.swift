//
//  TableViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 02.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {

    let weatherTemp = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        // Set any attributes of your UI components here.
        weatherTemp.translatesAutoresizingMaskIntoConstraints = false
        weatherTemp.textColor = .white
        
        // Add the UI components
        contentView.addSubview(weatherTemp)
        
        NSLayoutConstraint.activate([
            weatherTemp.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            weatherTemp.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            weatherTemp.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            //weatherTemp.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
