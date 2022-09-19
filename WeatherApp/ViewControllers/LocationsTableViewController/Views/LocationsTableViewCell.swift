//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 10.09.2022.
//

import UIKit

class LocationsTableViewCell: UITableViewCell {
        
        static let reuseID = "LocationsTableViewCell"
        
        // Create UIViews
        lazy var stackViewCell = UIStackView()
        lazy var weatherDay = UILabel()
        lazy var weatherImage = UIImageView()
        lazy var weatherTempMinMax = UILabel()
      
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            // StackView Properties
            stackViewCell.axis  = NSLayoutConstraint.Axis.horizontal
            stackViewCell.alignment = .center
            stackViewCell.distribution  = UIStackView.Distribution.equalCentering
            stackViewCell.spacing = 5
            stackViewCell.translatesAutoresizingMaskIntoConstraints = false
            stackViewCell.sizeToFit()
            
            // weatherLabels Properties
            weatherDay.drawLabel(fontSize: 16, weight: .medium)
            weatherTempMinMax.drawLabel(fontSize: 16, weight: .medium)
            
            // weatherImage properties
            weatherImage.tintColor = .white
            weatherImage.contentMode = .scaleAspectFit
            
            // Added the UI components
            stackViewCell.addArrangedSubview(weatherDay)
            stackViewCell.addArrangedSubview(weatherImage)
            stackViewCell.addArrangedSubview(weatherTempMinMax)
            addSubview(stackViewCell)
            
            // StackView Constraits
            NSLayoutConstraint.activate([
                stackViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                stackViewCell.topAnchor.constraint(equalTo: topAnchor),
                stackViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                stackViewCell.bottomAnchor.constraint(equalTo: bottomAnchor),
                weatherImage.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
