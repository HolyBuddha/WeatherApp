//
//  UILabel.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.08.2022.
//

import Foundation
import UIKit

extension UILabel {
    func drawLabel(
        fontSize: CGFloat,
        weight: UIFont.Weight,
        textAligment: NSTextAlignment = .center,
        numberOfLines: Int = 1
    ) {
        textColor = .white
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        adjustsFontSizeToFitWidth = true
        self.numberOfLines = numberOfLines
        minimumScaleFactor = 0.3
        self.textAlignment = textAligment
}
}
