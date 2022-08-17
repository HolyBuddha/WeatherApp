//
//  CollectionViewCell.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 16.08.2022.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    static let reuseId = "CollectionViewCell"
    
    lazy var stackView = UIStackView()
    lazy var timeLabel = UILabel()
    lazy var weatherImage = UIImageView()
    lazy var tempLabel = UILabel()
    
//    lazy var timeLabel: UILabel = {
//        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 10, weight: .bold)
//        label.textColor = .white
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private lazy var stackView: UIStackView = {
//        var stackView = UIStackView()
//        stackView = UIStackView(arrangedSubviews: [timeLabel])
//        stackView.axis  = NSLayoutConstraint.Axis.vertical
//        stackView.distribution  = UIStackView.Distribution.fill
//        stackView.alignment = UIStackView.Alignment.center
//        stackView.spacing = 0
//        //stackView.setCustomSpacing(50, after: weatherDescriptionLabel)
//        return stackView
//    }()
    
override init(frame: CGRect) {
    super.init(frame: frame)
    
    // StackView Properties
    stackView.axis  = NSLayoutConstraint.Axis.vertical
    stackView.alignment = .center
    stackView.distribution = UIStackView.Distribution.fillEqually
    stackView.spacing = 5
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.sizeToFit()
    
    // Labels Properties
    //timeLabel.font = UIFont.systemFont(ofSize: 10, weight: .bold)
    timeLabel.textColor = .white
    timeLabel.textAlignment = .center
    timeLabel.translatesAutoresizingMaskIntoConstraints = false
    timeLabel.adjustsFontSizeToFitWidth = true
    tempLabel.textColor = .white
    tempLabel.textAlignment = .center
    tempLabel.adjustsFontSizeToFitWidth = true
    
    // weatherImage Properties
    weatherImage.tintColor = .white
    weatherImage.contentMode = .scaleAspectFit

    
    // Added the UI components
    stackView.addArrangedSubview(timeLabel)
    stackView.addArrangedSubview(weatherImage)
    stackView.addArrangedSubview(tempLabel)
    contentView.addSubview(stackView)
    
    backgroundColor = UIColor(white: 0.5, alpha: 0.5)
    
    // stackView constraints
    stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
    stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    //stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
    //stackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1/3).isActive = true
    
}
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
//let mainImageView: UIImageView = {
//   let imageView = UIImageView()
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    imageView.contentMode = .scaleAspectFit
//    return imageView
//}()
//
//let nameLabel: UILabel = {
//    let label = UILabel()
//    label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
//    label.textColor = #colorLiteral(red: 0.007841579616, green: 0.007844132371, blue: 0.007841020823, alpha: 1)
//    label.translatesAutoresizingMaskIntoConstraints = false
//    return label
//}()
//
//let smallDescriptionLabel: UILabel = {
//    let label = UILabel()
//    label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
//    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
//    label.numberOfLines = 0
//    label.translatesAutoresizingMaskIntoConstraints = false
//    return label
//}()
//
//let likeImageView: UIImageView = {
//    let imageView = UIImageView()
//    imageView.image = UIImage(named: "like")
//    imageView.translatesAutoresizingMaskIntoConstraints = false
//    return imageView
//}()
