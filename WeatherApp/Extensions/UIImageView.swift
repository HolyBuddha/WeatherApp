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
}
