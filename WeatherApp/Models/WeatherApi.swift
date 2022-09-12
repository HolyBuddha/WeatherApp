//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Vladimir Izmaylov on 30.07.2022.
//

import Foundation

class WeatherApi {
    
    static let shared = WeatherApi()
    
    var units: Units = .metric
    
    private init() {}
    
    func apiForCurrentWeather(latitude: Double, longitude: Double) -> String {
        "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&lang=ru&appid=edfe94b1ee9b1f9ceecd7596d2f66b06"
    }
    
    func apiForecastDaily(latitude: Double, longitude: Double) -> String {
            "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=edfe94b1ee9b1f9ceecd7596d2f66b06&units=\(units)&lang=ru&exclude=alerts,minutely"
        }
    
//    func apiForecastDaily(latitude: Double, longitude: Double, units: Units) -> String {
//        "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=edfe94b1ee9b1f9ceecd7596d2f66b06&units=\(units)&lang=ru&exclude=alerts,minutely"
//    }
    
    enum Units: String {
        case metric = "metric"
        case imperial = "imperial"
    }
    
}
