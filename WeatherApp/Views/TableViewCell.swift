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
        stackViewCell.distribution  = UIStackView.Distribution.equalCentering
        stackViewCell.spacing = 5
        stackViewCell.translatesAutoresizingMaskIntoConstraints = false
        stackViewCell.sizeToFit()
        
        // weatherLabels Properties
        weatherDay.textColor = .white
        weatherDay.adjustsFontSizeToFitWidth = true
        weatherTempMinMax.textColor = .white
        weatherTempMinMax.adjustsFontSizeToFitWidth = true
        
        // weatherImage Properties
        weatherImage.tintColor = .white
        
        // Added the UI components
        stackViewCell.addArrangedSubview(weatherDay)
        stackViewCell.addArrangedSubview(weatherImage)
        stackViewCell.addArrangedSubview(weatherTempMinMax)
        contentView.addSubview(stackViewCell)
        
        // StackView Constraits
        NSLayoutConstraint.activate([
            stackViewCell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackViewCell.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackViewCell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackViewCell.heightAnchor.constraint(equalTo: contentView.heightAnchor),
        ])
        
        self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
