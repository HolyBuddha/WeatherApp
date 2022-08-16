//
//  Extensions.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 12.08.2022.
//

import UIKit
import CoreLocation


extension TableView {
    
//    func dateFromUnix(date: Double, dateFormat: String) -> String {
//        let date = NSDate(timeIntervalSince1970: date)
//        let dayTimePeriodFormatter = DateFormatter()
////        let dayTimeNeeded = DateFormatter()
////        dayTimeNeeded.dateFormat = "HH:mm"
////        if dayTimeNeeded.string(from: date as Date) == "06:00" {
//        dayTimePeriodFormatter.dateFormat = dateFormat
//        let result = dayTimePeriodFormatter.string(from: date as Date)
//        return result
////        } else {
////            return "No data"
////        }
//        // доделай функцию чтобы возвращала массив
//    }
    
    func checkTemp(_ temp: Double) -> String {
        if temp > 0 {
            return "+" + "\(Int(temp))" + "\u{00B0}"
        } else if temp == 0 {
            return "0" + "\u{00B0}"
        } else {
            return "\(Int(temp))" + "\u{00B0}"
        }
    }
}

extension UIView {
    func drawShadow(offset: CGSize = CGSize(width: 5, height: 5), opacity: Float = 0.1, color: UIColor = .black, radius: CGFloat = 1) {
        layer.shadowColor = color.cgColor
        layer.shadowOffset = offset
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
    }
}

extension UILabel {
    func drawLabel(textColor: UIColor = .white, fontSize: CGFloat, adjustsFontSizeToFitWidth: Bool = true, numberOfLines: Int = 0, minimumScaleFactor: CGFloat = 0.5, baselineAdjustment: UIBaselineAdjustment = .alignCenters, textAlignment: NSTextAlignment = .center) {
        self.textColor = textColor
        self.font = self.font.withSize(fontSize)
        self.adjustsFontSizeToFitWidth = adjustsFontSizeToFitWidth
        self.numberOfLines = numberOfLines
        self.minimumScaleFactor = minimumScaleFactor
        self.baselineAdjustment = baselineAdjustment
        self.textAlignment = textAlignment}
}
