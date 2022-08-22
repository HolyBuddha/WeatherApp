//
//  CollectionViewCell.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 16.08.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CollectionViewCell"
    
    // Create UIViews
    lazy var stackView = UIStackView()
    lazy var timeLabel = UILabel()
    lazy var weatherImage = UIImageView()
    lazy var tempLabel = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        layer.cornerRadius = 20
//        layer.borderColor = CGColor(gray: 1, alpha: 0.5)
//        layer.borderWidth = 1
        
        // StackView Properties
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.alignment = .center
        stackView.distribution = UIStackView.Distribution.fillEqually
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.sizeToFit()
        
        // Labels Properties
        timeLabel.drawLabel(fontSize: 15, weight: .medium)
        tempLabel.drawLabel(fontSize: 18, weight: .semibold)
        
        // weatherImage Properties
        //weatherImage.tintColor = .white
        //weatherImage.contentMode = .scaleAspectFit
        
        
        // Added the UI components
        stackView.addArrangedSubview(timeLabel)
        stackView.addArrangedSubview(weatherImage)
        stackView.addArrangedSubview(tempLabel)
        contentView.addSubview(stackView)
        
        
        //Set the constraits
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

