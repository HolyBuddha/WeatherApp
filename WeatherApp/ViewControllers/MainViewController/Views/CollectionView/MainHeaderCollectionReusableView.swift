//
//  HeaderCollectionReusableView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 17.08.2022.
//

import UIKit

// MARK: - Class

class MainHeaderCollectionReusableView: UICollectionReusableView {
    
    // MARK: - Internal properties
    
    static let reuseId = "HeaderCollectionReusableView"
    
    lazy var windSpeedLabel = UILabel()
    lazy var pressureLabel = UILabel()
    lazy var humidityLabel = UILabel()
    
    // MARK: - Private properties
    
    private lazy var windImage = UIImageView()
    private lazy var pressureImage = UIImageView()
    private lazy var humidityImage = UIImageView()
    private lazy var labelsStackView = UIStackView()
    private lazy var imagesStackView = UIStackView()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
        
        // Set the constraits
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
