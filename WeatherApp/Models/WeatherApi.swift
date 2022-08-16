//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 30.07.2022.
//

import Foundation

class WeatherApi {
    
    func apiForCurrentWeather(latitude: Double, longitude: Double, units: Units) -> String {
        "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=\(units)&lang=ru&appid=edfe94b1ee9b1f9ceecd7596d2f66b06"
    }

    func apiForecastFor5Days(latitude: Double, longitude: Double, units: Units) -> String {
        "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&appid=edfe94b1ee9b1f9ceecd7596d2f66b06&units=\(units)&lang=ru&cnt=40"
    }
    
    }

enum Units: String {
    case metric = "metric"
    case imperial = "imperial"
}

