//
//  UITableVIew.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.08.2022.
//

import Foundation

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
