//
//  HeaderCollectionReusableView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 17.08.2022.
//

import UIKit

class MainHeaderCollectionReusableView: UICollectionReusableView {
    
    static let reuseId = "HeaderCollectionReusableView"
    
    // Create UIViews
    lazy var windImage = UIImageView()
    lazy var pressureImage = UIImageView()
    lazy var humidityImage = UIImageView()
    
    lazy var windSpeedLabel = UILabel()
    lazy var pressureLabel = UILabel()
    lazy var humidityLabel = UILabel()
    
    lazy var labelsStackView = UIStackView()
    lazy var imagesStackView = UIStackView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // Content Properties

        
        // StackViews Properties
        labelsStackView.axis  = NSLayoutConstraint.Axis.vertical
        labelsStackView.alignment = .center
        labelsStackView.distribution = UIStackView.Distribution.fillEqually
        labelsStackView.spacing = 5
        labelsStackView.translatesAutoresizingMaskIntoConstraints = false
        labelsStackView.sizeToFit()
     
        
        imagesStackView.axis  = NSLayoutConstraint.Axis.vertical
        imagesStackView.alignment = .center
        imagesStackView.distribution = UIStackView.Distribution.fillEqually
        imagesStackView.spacing = 5
        imagesStackView.translatesAutoresizingMaskIntoConstraints = false
        imagesStackView.sizeToFit()
        
        // Labels Properties
        windSpeedLabel.drawLabel(fontSize: 15, weight: .medium)
        pressureLabel.drawLabel(fontSize: 12, weight: .medium)
        humidityLabel.drawLabel(fontSize: 15, weight: .bold)
        
        // imageView Properties
        windImage.drawSystemImage(name: "wind")
        pressureImage.drawSystemImage(name: "speedometer")
        humidityImage.drawSystemImage(name: "drop")
        
        // Added the UI components
        labelsStackView.addArrangedSubview(windSpeedLabel)
        labelsStackView.addArrangedSubview(pressureLabel)
        labelsStackView.addArrangedSubview(humidityLabel)
        
        imagesStackView.addArrangedSubview(windImage)
        imagesStackView.addArrangedSubview(pressureImage)
        imagesStackView.addArrangedSubview(humidityImage)
        
        addSubview(labelsStackView)
        addSubview(imagesStackView)
        
        //Set the constraits
        NSLayoutConstraint.activate([
            imagesStackView.topAnchor.constraint(equalTo: topAnchor),
            imagesStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imagesStackView.rightAnchor.constraint(equalTo: labelsStackView.leftAnchor, constant: -5),
            imagesStackView.bottomAnchor.constraint(equalTo: bottomAnchor),

            labelsStackView.topAnchor.constraint(equalTo: topAnchor),
            labelsStackView.leftAnchor.constraint(equalTo: imagesStackView.rightAnchor, constant: 5),
            labelsStackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            labelsStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
