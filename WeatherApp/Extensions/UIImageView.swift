//
//  UIImageView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.08.2022.
//

import UIKit

extension UIImageView {
    
    func drawSystemImage(name: String) {
        image = UIImage(systemName: name)
        tintColor = .white
        contentMode = .scaleAspectFit
    }
    
    func updateBackgroundImage(id: Int) {
        switch id {
        case 800:  image = UIImage(#imageLiteral(resourceName: "cleanSky"))
        case 801...802: image = UIImage(#imageLiteral(resourceName: "littleCloudy"))
        case 803...804: image = UIImage(#imageLiteral(resourceName: "darkCloudy"))
        case ...232: image = UIImage(#imageLiteral(resourceName: "storm"))
        default:
            image = UIImage(#imageLiteral(resourceName: "rainy"))
        }
    }
}
