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
    var latitude: Double = 0
    var longitude: Double = 0
    
    
    private let appId = "edfe94b1ee9b1f9ceecd7596d2f66b06"
    
    private init() {}
    
    func apiForCurrentWeather(latitude: Double, longitude: Double) -> String {
        "http://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&units=metric&lang=ru&appid=\(appId)"
    }
    func apiForecastDaily() -> String {
            "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(appId)&units=\(units)&lang=en&exclude=alerts,minutely"
            }
//    func apiForecastDaily(latitude: Double, longitude: Double) -> String {
//        "https://api.openweathermap.org/data/2.5/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(appId)&units=\(units)&lang=ru&exclude=alerts,minutely"
//        }
    func apiGeocodingByCity(city: String) -> String {
    "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&appid=\(appId)"
    }
    
    enum Units: String {
        case metric
        case imperial
    }
}
