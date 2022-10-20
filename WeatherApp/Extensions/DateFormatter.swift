//
//  DateFormatter.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 03.10.2022.
//

import Foundation

extension DateFormatter {
    static let myOwnDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
    }()
    
    static func getDateString(from date: Double, dateFormat: String) -> String? {
        myOwnDateFormatter.dateFormat = dateFormat
        let dateFromDT = NSDate(timeIntervalSince1970: date)
        return myOwnDateFormatter.string(from: dateFromDT as Date)
    }
}
