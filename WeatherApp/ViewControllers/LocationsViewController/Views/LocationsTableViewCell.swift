//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 10.09.2022.
//

import UIKit

// MARK: - Class

class LocationsTableViewCell: UITableViewCell {
        
    // MARK: - Internal properties
    
        static let reuseID = "LocationsTableViewCell"
        
        // Create UIViews
        lazy var stackViewCell = UIStackView()
        lazy var locationName = UILabel()
        lazy var weatherImage = UIImageView()
        lazy var weatherTempMinMax = UILabel()
      
    // MARK: - Initializers
    
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            
            // StackView Properties
            stackViewCell.axis  = NSLayoutConstraint.Axis.horizontal
            stackViewCell.alignment = .center
            stackViewCell.distribution  = UIStackView.Distribution.equalCentering
            stackViewCell.translatesAutoresizingMaskIntoConstraints = false
            stackViewCell.sizeToFit()
            
            // weatherLabels Properties
            locationName.drawLabel(fontSize: 20, weight: .medium)
            weatherTempMinMax.drawLabel(fontSize: 20, weight: .medium)
            
            // weatherImage properties
            weatherImage.tintColor = .white
            weatherImage.contentMode = .scaleAspectFit
            
            
            // Added the UI components
            stackViewCell.addArrangedSubview(locationName)
            stackViewCell.addArrangedSubview(weatherImage)
            stackViewCell.addArrangedSubview(weatherTempMinMax)
            addSubview(stackViewCell)
            
            // StackView Constraits
            NSLayoutConstraint.activate([
                stackViewCell.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
                stackViewCell.topAnchor.constraint(equalTo: topAnchor),
                stackViewCell.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
                stackViewCell.bottomAnchor.constraint(equalTo: bottomAnchor),
                weatherImage.rightAnchor.constraint(equalTo: weatherTempMinMax.leftAnchor, constant: -20),
            ])
        }
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
