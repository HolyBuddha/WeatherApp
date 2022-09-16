//
//  Double.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 15.09.2022.
//

import Foundation

extension Double {
    var temperatureValue: String {
        if self > 0 {
            return "+" + "\(Int(self))" + "\u{00B0}"
        } else if self == 0 {
            return "0" + "\u{00B0}"
        } else {
            return "\(Int(self))" + "\u{00B0}"
        }
    }
}
