//
//  Extensions.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 12.08.2022.
//

import UIKit
import CoreLocation

extension CollectionView {
    
    func convertDateToString(unixDate: Double, dateFormat: String) -> String {
        
        let dateFromDT = NSDate(timeIntervalSince1970: unixDate)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat
        let result = dayTimePeriodFormatter.string(from: dateFromDT as Date)
        return result
    }
    
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

extension TableView {
    
    func convertDateToString(unixDate: Double, dateFormat: String) -> String {
        
        let dateFromDT = NSDate(timeIntervalSince1970: unixDate)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat
        let result = dayTimePeriodFormatter.string(from: dateFromDT as Date)
        return result
        
    }
    
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
    func drawShadow() {
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 3
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        //layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
}

extension UILabel {
    func drawLabel(fontSize: CGFloat, weight: UIFont.Weight, textAligment: NSTextAlignment = .center) {
        textColor = .white
        font = UIFont.systemFont(ofSize: fontSize, weight: weight)
        adjustsFontSizeToFitWidth = true
        numberOfLines = 1
        minimumScaleFactor = 0.3
        self.textAlignment = textAligment
}
}
