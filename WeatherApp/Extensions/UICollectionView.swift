//
//  UICollectionView.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 22.08.2022.
//

import Foundation

extension MainCollectionView {
    
    func convertDateToString(unixDate: Double, dateFormat: String) -> String {
        
        let dateFromDT = NSDate(timeIntervalSince1970: unixDate)
        let dayTimePeriodFormatter = DateFormatter()
        dayTimePeriodFormatter.dateFormat = dateFormat
        let result = dayTimePeriodFormatter.string(from: dateFromDT as Date)
        return result
    }
}
