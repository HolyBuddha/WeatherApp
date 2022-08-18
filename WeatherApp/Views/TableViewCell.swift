//
//  TableViewController.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 02.08.2022.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    static let reuseID = "TableViewCell"
    
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
        
        //self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
